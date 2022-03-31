Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97C4EDD30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiCaPgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbiCaPft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:35:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641C2274ED;
        Thu, 31 Mar 2022 08:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DBBCB82171;
        Thu, 31 Mar 2022 15:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FBFC340ED;
        Thu, 31 Mar 2022 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740727;
        bh=1hs7K2TSbBa2JdAMZ4YRuydsGUoVBj3BZkkngz/AjGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObFP/hF9JuT2zeJXRJBFpD9sZZnLesSH7gifLwMx9n6I4E4YFJZEsW22wBCVx7kUF
         fgj2shSv+qWehJu3UmYCTwf2EJaNXRvmPA8ui47gjfP0qFLe5VxHv+2RKRjKXP5Hw5
         IM7AVF0XxM3+JvcWDbX004V5SunmXKhtuuMxYaq0MLjgoHXAUQqvaZ0Sx5honB1V1c
         dKoaQlv1F5aBTBAwjK0BHEPpNLrxGj/396atoN9ZW6PmyHru/jw7RtcT3aa+nb6v+N
         Jlh51Gv+My57F0jJ7XG30BA05yRUAQXBB3B7Uoe3RJCOWLVRDE4MnstRPND09y5VQk
         r+zERWKGEWRUQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 38/54] ceph: handle fscrypt fields in cap messages from MDS
Date:   Thu, 31 Mar 2022 11:31:14 -0400
Message-Id: <20220331153130.41287-39-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle the new fscrypt_file and fscrypt_auth fields in cap messages. Use
them to populate new fields in cap_extra_info and update the inode with
those values.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 867bb7d654b4..0e15d150ef67 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3364,6 +3364,9 @@ struct cap_extra_info {
 	/* currently issued */
 	int issued;
 	struct timespec64 btime;
+	u8 *fscrypt_auth;
+	u32 fscrypt_auth_len;
+	u64 fscrypt_file_size;
 };
 
 /*
@@ -3396,6 +3399,14 @@ static void handle_cap_grant(struct inode *inode,
 	bool deleted_inode = false;
 	bool fill_inline = false;
 
+	/*
+	 * If there is at least one crypto block then we'll trust fscrypt_file_size.
+	 * If the real length of the file is 0, then ignore it (it has probably been
+	 * truncated down to 0 by the MDS).
+	 */
+	if (IS_ENCRYPTED(inode) && size)
+		size = extra_info->fscrypt_file_size;
+
 	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
 	     inode, cap, session->s_mds, seq, ceph_cap_string(newcaps));
 	dout(" size %llu max_size %llu, i_size %llu\n", size, max_size,
@@ -3462,6 +3473,10 @@ static void handle_cap_grant(struct inode *inode,
 		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kgid(&init_user_ns, inode->i_gid));
+
+		WARN_ON_ONCE(ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
+			     memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
+				     ci->fscrypt_auth_len));
 	}
 
 	if ((newcaps & CEPH_CAP_LINK_SHARED) &&
@@ -3873,7 +3888,8 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
  */
 static bool handle_cap_trunc(struct inode *inode,
 			     struct ceph_mds_caps *trunc,
-			     struct ceph_mds_session *session)
+			     struct ceph_mds_session *session,
+			     struct cap_extra_info *extra_info)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int mds = session->s_mds;
@@ -3890,6 +3906,14 @@ static bool handle_cap_trunc(struct inode *inode,
 
 	issued |= implemented | dirty;
 
+	/*
+	 * If there is at least one crypto block then we'll trust fscrypt_file_size.
+	 * If the real length of the file is 0, then ignore it (it has probably been
+	 * truncated down to 0 by the MDS).
+	 */
+	if (IS_ENCRYPTED(inode) && size)
+		size = extra_info->fscrypt_file_size;
+
 	dout("handle_cap_trunc inode %p mds%d seq %d to %lld seq %d\n",
 	     inode, mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
@@ -4111,6 +4135,49 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 	*target_cap = cap;
 }
 
+#ifdef CONFIG_FS_ENCRYPTION
+static int parse_fscrypt_fields(void **p, void *end, struct cap_extra_info *extra)
+{
+	u32 len;
+
+	ceph_decode_32_safe(p, end, extra->fscrypt_auth_len, bad);
+	if (extra->fscrypt_auth_len) {
+		ceph_decode_need(p, end, extra->fscrypt_auth_len, bad);
+		extra->fscrypt_auth = kmalloc(extra->fscrypt_auth_len, GFP_KERNEL);
+		if (!extra->fscrypt_auth)
+			return -ENOMEM;
+		ceph_decode_copy_safe(p, end, extra->fscrypt_auth,
+					extra->fscrypt_auth_len, bad);
+	}
+
+	ceph_decode_32_safe(p, end, len, bad);
+	if (len >= sizeof(u64)) {
+		ceph_decode_64_safe(p, end, extra->fscrypt_file_size, bad);
+		len -= sizeof(u64);
+	}
+	ceph_decode_skip_n(p, end, len, bad);
+	return 0;
+bad:
+	return -EIO;
+}
+#else
+static int parse_fscrypt_fields(void **p, void *end, struct cap_extra_info *extra)
+{
+	u32 len;
+
+	/* Don't care about these fields unless we're encryption-capable */
+	ceph_decode_32_safe(p, end, len, bad);
+	if (len)
+		ceph_decode_skip_n(p, end, len, bad);
+	ceph_decode_32_safe(p, end, len, bad);
+	if (len)
+		ceph_decode_skip_n(p, end, len, bad);
+	return 0;
+bad:
+	return -EIO;
+}
+#endif
+
 /*
  * Handle a caps message from the MDS.
  *
@@ -4229,6 +4296,11 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		ceph_decode_64_safe(&p, end, extra_info.nsubdirs, bad);
 	}
 
+	if (msg_version >= 12) {
+		if (parse_fscrypt_fields(&p, end, &extra_info))
+			goto bad;
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
 	dout(" op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op), vino.ino,
@@ -4325,7 +4397,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_CAP_OP_TRUNC:
-		queue_trunc = handle_cap_trunc(inode, h, session);
+		queue_trunc = handle_cap_trunc(inode, h, session,
+						&extra_info);
 		spin_unlock(&ci->i_ceph_lock);
 		if (queue_trunc)
 			ceph_queue_vmtruncate(inode);
@@ -4343,6 +4416,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	iput(inode);
 out:
 	ceph_put_string(extra_info.pool_ns);
+	kfree(extra_info.fscrypt_auth);
 	return;
 
 flush_cap_releases:
-- 
2.35.1

