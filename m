Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B5148B6F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350630AbiAKTRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350628AbiAKTRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CFCC028C3D;
        Tue, 11 Jan 2022 11:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DA68B81D26;
        Tue, 11 Jan 2022 19:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A160AC36AEF;
        Tue, 11 Jan 2022 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928592;
        bh=6NfoaVkfyx1x+GTF9BZ/buOsIdvyPaIfklhqmXmqJio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jj3lVqJNvTf/Sqp5WartQ62hP5j8XVDj4G6XS5wkDm8dWpu1mQR5WRub2ZtiUR47y
         WydQajhWV+TsVr77b1rdf7l0Q1vPshNrdSjyz71OPA+CQdUK2wO9baFwGKqHTfkWZy
         Swk2A8+B+st7Lrkd70Q3st8wC4LRsUCR9OPKfxf75u6PaSAVPDCTuTgNAjo3aKVvR2
         5k93ClfG5NfMgH5/VUtbhVRAVmqbQAZePPpfTib0rL+79woqKUbV9VxudLt8f8X10O
         2hpHlZmjhLv1ifgtwGO767OVCgHExDLC3Sq6Si3C99vmO5+ROuzrzCb+zgc4eq2Nh4
         fQ3gKVUJtYcOg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 30/48] ceph: get file size from fscrypt_file when present in inode traces
Date:   Tue, 11 Jan 2022 14:15:50 -0500
Message-Id: <20220111191608.88762-31-jlayton@kernel.org>
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
 fs/ceph/inode.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4dd84b629850..2497306eef58 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -982,6 +982,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
@@ -1005,6 +1015,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
+		u64 size = info->size;
 		s64 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
@@ -1018,10 +1029,17 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
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
@@ -1061,16 +1079,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
2.34.1

