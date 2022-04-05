Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695D14F4D50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581889AbiDEXlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573590AbiDETXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A608E4B842;
        Tue,  5 Apr 2022 12:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41453616C5;
        Tue,  5 Apr 2022 19:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F6FC385A1;
        Tue,  5 Apr 2022 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186470;
        bh=Zg3zMWSG6TvHZGGBtCLfiftQlhpR76ntlCWktCjM/rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r75syTBou8Z4Hpkp1mjTt3Zb/e6dtZS5ttMdnxnJhie0jKOGCDuge3ZxVSfoBOsMc
         +gKS+1NFp+FiiSYHDBQ1i6MWknoPjnydDRMD6g/zSnBrD/8232h2sqkZ9NGYdGaw+R
         IL7f9tgOku4IbdByviN8/DQHHycj3UIXqrfeiGG9+pL8Q6fhnOx/2u/vPSeg+hrDKx
         lTHljOLnjx8L4AZ2B8hH22tp84lnuDK8n9G6XRXhWg6WLYXyL8Sndrhe5zWq9E6BWz
         6D6H6/5+N6Yb2brGnTvWtleWj2DejPFMZHihMz65HD78XkOpUZOr+aess+q9AojYln
         czMgCmam9EC4g==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 42/59] ceph: handle fscrypt fields in cap messages from MDS
Date:   Tue,  5 Apr 2022 15:20:13 -0400
Message-Id: <20220405192030.178326-43-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
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
index cb5cdf2260ad..1f3a2135214c 100644
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
@@ -3872,7 +3887,8 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
  */
 static bool handle_cap_trunc(struct inode *inode,
 			     struct ceph_mds_caps *trunc,
-			     struct ceph_mds_session *session)
+			     struct ceph_mds_session *session,
+			     struct cap_extra_info *extra_info)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int mds = session->s_mds;
@@ -3889,6 +3905,14 @@ static bool handle_cap_trunc(struct inode *inode,
 
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
@@ -4110,6 +4134,49 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
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
@@ -4228,6 +4295,11 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
@@ -4324,7 +4396,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_CAP_OP_TRUNC:
-		queue_trunc = handle_cap_trunc(inode, h, session);
+		queue_trunc = handle_cap_trunc(inode, h, session,
+						&extra_info);
 		spin_unlock(&ci->i_ceph_lock);
 		if (queue_trunc)
 			ceph_queue_vmtruncate(inode);
@@ -4342,6 +4415,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	iput(inode);
 out:
 	ceph_put_string(extra_info.pool_ns);
+	kfree(extra_info.fscrypt_auth);
 	return;
 
 flush_cap_releases:
-- 
2.35.1

