Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0034E405C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiCVOQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiCVOP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816A27EA0C;
        Tue, 22 Mar 2022 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AAE615D4;
        Tue, 22 Mar 2022 14:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96640C340EE;
        Tue, 22 Mar 2022 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958432;
        bh=fN+iUJhve1y7uwMf8jMynJJUgkMtG4HPJ7PSPf9U1D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSWu1MXgcMH6We91kuAWTufaQbzytcZ0U5knJ6kYL3zrJQlaBaSAYCOTitoMgTfMd
         OMy3YrCfTuFdCrDzz7VcReaCwxGQS38WFGK4kCD1Iv1VhqDvVosfz9luC/uDIXUFkO
         3K0j1jgJtVyuTBptMoWy7LwgxE93+mWTB7gYmA+j3DC8zWs+BxdUEzDilLF9HkZ5e7
         pW5/qYyZKwlMAcM9XwVTxGp1oNEdnpUgeKELduyXFJ2r2LqMInxk4Q/ve/grljPV3N
         c0MN9dngszfFvI4tYTugMYNeSHOYlsP1Y0SClTE/NDsGi+cr0Qz62Kd/SvUUcxaspi
         UIBdtNOx+LjPA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 35/51] ceph: handle fscrypt fields in cap messages from MDS
Date:   Tue, 22 Mar 2022 10:13:00 -0400
Message-Id: <20220322141316.41325-36-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/ceph/caps.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 65af0dcf12ec..fbf120a6aa96 100644
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
@@ -3873,7 +3884,8 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
  */
 static bool handle_cap_trunc(struct inode *inode,
 			     struct ceph_mds_caps *trunc,
-			     struct ceph_mds_session *session)
+			     struct ceph_mds_session *session,
+			     struct cap_extra_info *extra_info)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int mds = session->s_mds;
@@ -3890,6 +3902,14 @@ static bool handle_cap_trunc(struct inode *inode,
 
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
@@ -4111,6 +4131,49 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
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
@@ -4229,6 +4292,11 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
@@ -4325,7 +4393,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_CAP_OP_TRUNC:
-		queue_trunc = handle_cap_trunc(inode, h, session);
+		queue_trunc = handle_cap_trunc(inode, h, session,
+						&extra_info);
 		spin_unlock(&ci->i_ceph_lock);
 		if (queue_trunc)
 			ceph_queue_vmtruncate(inode);
@@ -4343,6 +4412,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	iput(inode);
 out:
 	ceph_put_string(extra_info.pool_ns);
+	kfree(extra_info.fscrypt_auth);
 	return;
 
 flush_cap_releases:
-- 
2.35.1

