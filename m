Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73748B6F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbiAKTRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbiAKTRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78109C028C3B;
        Tue, 11 Jan 2022 11:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A90A61785;
        Tue, 11 Jan 2022 19:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5679DC36AF2;
        Tue, 11 Jan 2022 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928592;
        bh=CZfbAox7ZzudE9b20D3bXNJp4mTfC+b48AzqgI2CKzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9ydXmsazMr+ZIv2Vpow6GtYpQX33o2e+yhS0TFjM1w9VCVVe8o3rDwMVxGZfZ3L3
         IP1AtzPFbYy9qnruYJZzemj1aI4YeI1COHWcUgd05Jv8uLP37wQnANEtsp8I2rW2Mj
         VZJmXMc4ayCkhh+j2QOlhr3dMPuPxabA2zcRqNyb7CAJH+5og6Ao59h1ivZOXqfb27
         93Lq7D28vNQVpXEYCs4HUigdk746USB5Rf8ardQpZaRouAgnJB9hnL8dmnnNoKaYvC
         JmkB3x326dLpiZQT+/L2m+Pb09yC0j67jmoz2hyd7hO+GwaiLgoPcmEbtMls1twudf
         fxGUU8P+GtLcQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 31/48] ceph: handle fscrypt fields in cap messages from MDS
Date:   Tue, 11 Jan 2022 14:15:51 -0500
Message-Id: <20220111191608.88762-32-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 8a4f0157854e..9106340c9c0a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3331,6 +3331,9 @@ struct cap_extra_info {
 	/* currently issued */
 	int issued;
 	struct timespec64 btime;
+	u8 *fscrypt_auth;
+	u32 fscrypt_auth_len;
+	u64 fscrypt_file_size;
 };
 
 /*
@@ -3363,6 +3366,14 @@ static void handle_cap_grant(struct inode *inode,
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
@@ -3841,7 +3852,8 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
  */
 static bool handle_cap_trunc(struct inode *inode,
 			     struct ceph_mds_caps *trunc,
-			     struct ceph_mds_session *session)
+			     struct ceph_mds_session *session,
+			     struct cap_extra_info *extra_info)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int mds = session->s_mds;
@@ -3858,6 +3870,14 @@ static bool handle_cap_trunc(struct inode *inode,
 
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
@@ -4076,6 +4096,48 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
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
+	if (len == sizeof(u64))
+		ceph_decode_64_safe(p, end, extra->fscrypt_file_size, bad);
+	else
+		ceph_decode_skip_n(p, end, len, bad);
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
@@ -4194,6 +4256,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		ceph_decode_64_safe(&p, end, extra_info.nsubdirs, bad);
 	}
 
+	if (msg_version >= 12) {
+		int ret = parse_fscrypt_fields(&p, end, &extra_info);
+		if (ret)
+			goto bad;
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
 	ci = ceph_inode(inode);
@@ -4290,7 +4358,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_CAP_OP_TRUNC:
-		queue_trunc = handle_cap_trunc(inode, h, session);
+		queue_trunc = handle_cap_trunc(inode, h, session,
+						&extra_info);
 		spin_unlock(&ci->i_ceph_lock);
 		if (queue_trunc)
 			ceph_queue_vmtruncate(inode);
@@ -4308,6 +4377,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	iput(inode);
 out:
 	ceph_put_string(extra_info.pool_ns);
+	kfree(extra_info.fscrypt_auth);
 	return;
 
 flush_cap_releases:
-- 
2.34.1

