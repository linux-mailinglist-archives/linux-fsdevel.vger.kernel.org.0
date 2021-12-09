Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2027246EBD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhLIPlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbhLIPkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B026C0698CF;
        Thu,  9 Dec 2021 07:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96B16CE268E;
        Thu,  9 Dec 2021 15:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3AEC341C3;
        Thu,  9 Dec 2021 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064231;
        bh=STILXtHzWDcz+Rf7t743jr4/wgA5fwtguyYHBG0wUQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usoXAHnshDmcGVphue0OZDzfDOtetoF6rHgn1KHmZJiePYfJeGrQR1vPUCTuszli9
         jPF2rQUh1P5Nt052aSdBKxD8ZGlcwDCC/HsPTCftYitPBwN+F/07It6McK8QAgftRT
         oLQUFIoRGJqRtJEdyEf/WjrTx03GB7w9He3oNc/MV0qK4TltkwpkZpYFtakC5PkLQN
         CO1zfahmzOYOsUcr4NDljQO4Eu36JS/HIBifjW1s+iaxaVd41KTje+8NJ4UExKYaqS
         ccfU8b0qr1eFhHvQho0vMFcoecGO0wJLqCDxA6ApDcOKMoNgXK30B05E0G+MbbY/mV
         M9bxZLj7ikGdQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/36] ceph: get file size from fscrypt_file when present in inode traces
Date:   Thu,  9 Dec 2021 10:36:42 -0500
Message-Id: <20211209153647.58953-32-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b3ea678af5f1..7fb3af552bb8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -978,6 +978,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		     from_kgid(&init_user_ns, inode->i_gid));
 		ceph_decode_timespec64(&ci->i_btime, &iinfo->btime);
 		ceph_decode_timespec64(&ci->i_snap_btime, &iinfo->snap_btime);
+
+#ifdef CONFIG_FS_ENCRYPTION
+		if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
+			ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
+			ci->fscrypt_auth = iinfo->fscrypt_auth;
+			iinfo->fscrypt_auth = NULL;
+			iinfo->fscrypt_auth_len = 0;
+			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+		}
+#endif
 	}
 
 	if ((new_version || (new_issued & CEPH_CAP_LINK_SHARED)) &&
@@ -1001,6 +1011,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
+		u64 size = info->size;
 		s64 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
@@ -1014,10 +1025,17 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 		pool_ns = old_ns;
 
+		if (IS_ENCRYPTED(inode) && size &&
+		    (iinfo->fscrypt_file_len == sizeof(__le64))) {
+			size = __le64_to_cpu(*(__le64 *)iinfo->fscrypt_file);
+			if (info->size != round_up(size, CEPH_FSCRYPT_BLOCK_SIZE))
+				pr_warn("size=%llu fscrypt_file=%llu\n", info->size, size);
+		}
+
 		queue_trunc = ceph_fill_file_size(inode, issued,
 					le32_to_cpu(info->truncate_seq),
 					le64_to_cpu(info->truncate_size),
-					le64_to_cpu(info->size));
+					le64_to_cpu(size));
 		/* only update max_size on auth cap */
 		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 		    ci->i_max_size != le64_to_cpu(info->max_size)) {
@@ -1057,16 +1075,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		xattr_blob = NULL;
 	}
 
-#ifdef CONFIG_FS_ENCRYPTION
-	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
-		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
-		ci->fscrypt_auth = iinfo->fscrypt_auth;
-		iinfo->fscrypt_auth = NULL;
-		iinfo->fscrypt_auth_len = 0;
-		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
-	}
-#endif
-
 	/* finally update i_version */
 	if (le64_to_cpu(info->version) > ci->i_version)
 		ci->i_version = le64_to_cpu(info->version);
-- 
2.33.1

