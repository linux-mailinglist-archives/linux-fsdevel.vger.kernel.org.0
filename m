Return-Path: <linux-fsdevel+bounces-2273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5C7E4480
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD91E280FC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C48631A78;
	Tue,  7 Nov 2023 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCJYp3ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2C315AB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 15:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C5C433C9;
	Tue,  7 Nov 2023 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699372409;
	bh=anaqLde6XpseD/Q55oLTl7JeTv0p7RjRbfN7Ws6xtpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCJYp3ayvkVsHEi5p8X74hryXBOtfLKRYxOgR79PFfnMyY30WTMdSdViP9frDrB1Y
	 DUQqJTGr4fzpp5zhwjs0wzabzqVX0iBOMTd5gQbZRWQNWABEKwikx1U7O0W8h82/kz
	 Ilxs6r23vvSPvRdJCzFFqrzZghaU5QS3ghHX1YucYOBiWKmE2H7jWdKXISfqra0CbI
	 mOaBmcp0gmLKPdPpZTwtMzWxYNStHKJ46bGQRUgBXFoY7Enj2AJcwfTBF3uXb3CsPG
	 gP+iZ9bEWvfU2RaYYqWxRylDVyg5v8vZRUPiJwhSdQnVFu4xMQ3bf+z+NiOQTOjbyi
	 Ev8BSAVH5QJbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/16] exfat: support handle zero-size directory
Date: Tue,  7 Nov 2023 10:52:35 -0500
Message-ID: <20231107155249.3768098-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit dab48b8f2fe7264d51ec9eed0adea0fe3c78830a ]

After repairing a corrupted file system with exfatprogs' fsck.exfat,
zero-size directories may result. It is also possible to create
zero-size directories in other exFAT implementation, such as Paragon
ufsd dirver.

As described in the specification, the lower directory size limits
is 0 bytes.

Without this commit, sub-directories and files cannot be created
under a zero-size directory, and it cannot be removed.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/namei.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index bd00afc5e4c16..d62d961e278d9 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -330,14 +330,20 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;
 
-		/* we trust p_dir->size regardless of FAT type */
-		if (exfat_find_last_cluster(sb, p_dir, &last_clu))
-			return -EIO;
-
 		/*
 		 * Allocate new cluster to this directory
 		 */
-		exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		if (ei->start_clu != EXFAT_EOF_CLUSTER) {
+			/* we trust p_dir->size regardless of FAT type */
+			if (exfat_find_last_cluster(sb, p_dir, &last_clu))
+				return -EIO;
+
+			exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		} else {
+			/* This directory is empty */
+			exfat_chain_set(&clu, EXFAT_EOF_CLUSTER, 0,
+					ALLOC_NO_FAT_CHAIN);
+		}
 
 		/* allocate a cluster */
 		ret = exfat_alloc_cluster(inode, 1, &clu);
@@ -347,6 +353,11 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_zeroed_cluster(inode, clu.dir))
 			return -EIO;
 
+		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
+			ei->start_clu = clu.dir;
+			p_dir->dir = clu.dir;
+		}
+
 		/* append to the FAT chain */
 		if (clu.flags != p_dir->flags) {
 			/* no-fat-chain bit is disabled,
@@ -644,7 +655,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->type = exfat_get_entry_type(ep);
 	info->attr = le16_to_cpu(ep->dentry.file.attr);
 	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+	if (info->size == 0) {
 		info->flags = ALLOC_NO_FAT_CHAIN;
 		info->start_clu = EXFAT_EOF_CLUSTER;
 	} else {
@@ -890,6 +901,9 @@ static int exfat_check_dir_empty(struct super_block *sb,
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
+	if (p_dir->dir == EXFAT_EOF_CLUSTER)
+		return 0;
+
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -1296,7 +1310,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR) {
+		if (new_entry_type == TYPE_DIR &&
+		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
 
-- 
2.42.0


