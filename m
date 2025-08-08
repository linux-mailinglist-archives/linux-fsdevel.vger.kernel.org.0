Return-Path: <linux-fsdevel+bounces-57118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A59B1EDF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C1B1C27C8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E1288517;
	Fri,  8 Aug 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdR31kP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AB1F3FC8;
	Fri,  8 Aug 2025 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674909; cv=none; b=mcdcIm0fAZOJm61OhJ4xUFsWfYwNDhT66knfFN4rxsU6oe5K2Rd6U7tnI4UfdCQgzj6CyYZRZqIG7TFv4XqJkEhsCkFv85ruM2gedC6xFgQB8xUhgsETMIRO8ahZORgmb2TBOaSfoNDAZ9eSeWhE2nnlEx8i8SbCayA51NaimLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674909; c=relaxed/simple;
	bh=7KZi11aOcWzah1MMGc2QhuWnuga7pRdJlsHIWcTdCls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Iwt5UlO0WT8fe4N57v7mODaDPjxL6D3uUoYbA1e9aMVnkstWAaUxoEXsZel9rQU9Qlv1VxFCNRB69sC+P2G+ElXuDfxrfD7HgWsX51a0okVxhFIr5PELub/1X2E5oIiI4bJZwe0YBHU3j6go6YVv1K+SyWDK5rqCf+uJ7WvlqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdR31kP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFDFC4CEF0;
	Fri,  8 Aug 2025 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754674909;
	bh=7KZi11aOcWzah1MMGc2QhuWnuga7pRdJlsHIWcTdCls=;
	h=From:To:Cc:Subject:Date:From;
	b=pdR31kP5xLcFhX0sGDC4pSFPyGm1hcosbtCYCO+pOl1R5q5nrEkf51LYZtJA01Vym
	 2q6m7qvzhq1MTRmMrpRCQYJ8ZrtkoGPRbXyrJfAl6EugkOthUSIF7+ceYHSNvsMC/V
	 UY1LcJlRmZKwN4AnNIdoQg/TuXaJJv5zlxE+Ty+L3l0pMVSe9No0oWndGW5uYAkvLz
	 flWFpHMHTL/wPJ9n/F0/RBFU5S/rz/bYA0Ol3xkCwVFwzedNSGiyITDay/bViE5nHL
	 2qEPRvlAWyyXA0rc5guhWVJcuPpCfpcf0ETECAZgz/hClxKBdbTq32+zAfIG1pbzmF
	 QQCZuSJMUa2Sw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.6] exfat: add cluster chain loop check for dir
Date: Fri,  8 Aug 2025 13:41:41 -0400
Message-Id: <20250808174146.1272242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit 99f9a97dce39ad413c39b92c90393bbd6778f3fd ]

An infinite loop may occur if the following conditions occur due to
file system corruption.

(1) Condition for exfat_count_dir_entries() to loop infinitely.
    - The cluster chain includes a loop.
    - There is no UNUSED entry in the cluster chain.

(2) Condition for exfat_create_upcase_table() to loop infinitely.
    - The cluster chain of the root directory includes a loop.
    - There are no UNUSED entry and up-case table entry in the cluster
      chain of the root directory.

(3) Condition for exfat_load_bitmap() to loop infinitely.
    - The cluster chain of the root directory includes a loop.
    - There are no UNUSED entry and bitmap entry in the cluster chain
      of the root directory.

(4) Condition for exfat_find_dir_entry() to loop infinitely.
    - The cluster chain includes a loop.
    - The unused directory entries were exhausted by some operation.

(5) Condition for exfat_check_dir_empty() to loop infinitely.
    - The cluster chain includes a loop.
    - The unused directory entries were exhausted by some operation.
    - All files and sub-directories under the directory are deleted.

This commit adds checks to break the above infinite loop.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees for the
following critical reasons:

## Security Impact - Prevents Multiple Infinite Loop Vulnerabilities

The commit fixes **five distinct infinite loop conditions** that can
occur due to filesystem corruption, each representing a potential
denial-of-service vulnerability:

1. **exfat_count_dir_entries()** - Adds loop detection using
   `sbi->used_clusters` as a bound
2. **exfat_create_upcase_table()** - Addressed through root directory
   chain validation
3. **exfat_load_bitmap()** - Addressed through root directory chain
   validation
4. **exfat_find_dir_entry()** - Adds loop detection using
   `EXFAT_DATA_CLUSTER_COUNT(sbi)`
5. **exfat_check_dir_empty()** - Adds loop detection using
   `EXFAT_DATA_CLUSTER_COUNT(sbi)`

## Critical Bug Fix Characteristics

1. **Fixes Real Security Issues**: The infinite loops can cause system
   hangs and DoS conditions when mounting corrupted/malicious exFAT
   filesystems
2. **Small, Contained Changes**: The fix adds simple counter checks (4-5
   lines per location) without architectural changes
3. **Clear Root Cause**: Addresses missing validation of cluster chain
   loops in directory traversal
4. **Pattern of Similar Fixes**: This follows three previous infinite
   loop fixes in the same subsystem (commits b0522303f672, a5324b3a488d,
   fee873761bd9), all of which fix similar issues dating back to the
   original exfat implementation

## Code Analysis Shows Low Risk

The changes are minimal and safe:
- Adds `unsigned int clu_count = 0` declarations
- Increments counter when following cluster chains
- Breaks traversal if counter exceeds valid cluster count
- In `exfat_count_num_clusters()`: adds explicit loop detection with
  error message

## Follows Stable Kernel Rules

✓ Fixes critical bugs (infinite loops/DoS)
✓ Minimal code changes (~50 lines total)
✓ No new features or API changes
✓ Similar fixes already backported (the three previous infinite loop
fixes)
✓ Clear error conditions with proper error returns (-EIO)

The commit message explicitly states these are corruption-triggered
infinite loops, and the pattern matches previous fixes that have
"Fixes:" tags pointing to the original exfat implementation. This is a
critical reliability and security fix that prevents system hangs when
handling corrupted exFAT filesystems.

 fs/exfat/dir.c    | 12 ++++++++++++
 fs/exfat/fatent.c | 10 ++++++++++
 fs/exfat/namei.c  |  5 +++++
 fs/exfat/super.c  | 32 +++++++++++++++++++++-----------
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3103b932b674..ee060e26f51d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -996,6 +996,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	struct exfat_hint_femp candi_empty;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int num_entries = exfat_calc_num_entries(p_uniname);
+	unsigned int clu_count = 0;
 
 	if (num_entries < 0)
 		return num_entries;
@@ -1133,6 +1134,10 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		} else {
 			if (exfat_get_next_cluster(sb, &clu.dir))
 				return -EIO;
+
+			/* break if the cluster chain includes a loop */
+			if (unlikely(++clu_count > EXFAT_DATA_CLUSTER_COUNT(sbi)))
+				goto not_found;
 		}
 	}
 
@@ -1195,6 +1200,7 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 	int i, count = 0;
 	int dentries_per_clu;
 	unsigned int entry_type;
+	unsigned int clu_count = 0;
 	struct exfat_chain clu;
 	struct exfat_dentry *ep;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1227,6 +1233,12 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 		} else {
 			if (exfat_get_next_cluster(sb, &(clu.dir)))
 				return -EIO;
+
+			if (unlikely(++clu_count > sbi->used_clusters)) {
+				exfat_fs_error(sb, "FAT or bitmap is corrupted");
+				return -EIO;
+			}
+
 		}
 	}
 
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 23065f948ae7..232cc7f8ab92 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -490,5 +490,15 @@ int exfat_count_num_clusters(struct super_block *sb,
 	}
 
 	*ret_count = count;
+
+	/*
+	 * since exfat_count_used_clusters() is not called, sbi->used_clusters
+	 * cannot be used here.
+	 */
+	if (unlikely(i == sbi->num_clusters && clu != EXFAT_EOF_CLUSTER)) {
+		exfat_fs_error(sb, "The cluster chain has a loop");
+		return -EIO;
+	}
+
 	return 0;
 }
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index fede0283d6e2..f5f1c4e8a29f 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -890,6 +890,7 @@ static int exfat_check_dir_empty(struct super_block *sb,
 {
 	int i, dentries_per_clu;
 	unsigned int type;
+	unsigned int clu_count = 0;
 	struct exfat_chain clu;
 	struct exfat_dentry *ep;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -926,6 +927,10 @@ static int exfat_check_dir_empty(struct super_block *sb,
 		} else {
 			if (exfat_get_next_cluster(sb, &(clu.dir)))
 				return -EIO;
+
+			/* break if the cluster chain includes a loop */
+			if (unlikely(++clu_count > EXFAT_DATA_CLUSTER_COUNT(sbi)))
+				break;
 		}
 	}
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7ed858937d45..3a9ec75ab452 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -341,13 +341,12 @@ static void exfat_hash_init(struct super_block *sb)
 		INIT_HLIST_HEAD(&sbi->inode_hashtable[i]);
 }
 
-static int exfat_read_root(struct inode *inode)
+static int exfat_read_root(struct inode *inode, struct exfat_chain *root_clu)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct exfat_chain cdir;
-	int num_subdirs, num_clu = 0;
+	int num_subdirs;
 
 	exfat_chain_set(&ei->dir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
 	ei->entry = -1;
@@ -360,12 +359,9 @@ static int exfat_read_root(struct inode *inode)
 	ei->hint_stat.clu = sbi->root_dir;
 	ei->hint_femp.eidx = EXFAT_HINT_NONE;
 
-	exfat_chain_set(&cdir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
-	if (exfat_count_num_clusters(sb, &cdir, &num_clu))
-		return -EIO;
-	i_size_write(inode, num_clu << sbi->cluster_size_bits);
+	i_size_write(inode, EXFAT_CLU_TO_B(root_clu->size, sbi));
 
-	num_subdirs = exfat_count_dir_entries(sb, &cdir);
+	num_subdirs = exfat_count_dir_entries(sb, root_clu);
 	if (num_subdirs < 0)
 		return -EIO;
 	set_nlink(inode, num_subdirs + EXFAT_MIN_SUBDIR);
@@ -578,7 +574,8 @@ static int exfat_verify_boot_region(struct super_block *sb)
 }
 
 /* mount the file system volume */
-static int __exfat_fill_super(struct super_block *sb)
+static int __exfat_fill_super(struct super_block *sb,
+		struct exfat_chain *root_clu)
 {
 	int ret;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -595,6 +592,18 @@ static int __exfat_fill_super(struct super_block *sb)
 		goto free_bh;
 	}
 
+	/*
+	 * Call exfat_count_num_cluster() before searching for up-case and
+	 * bitmap directory entries to avoid infinite loop if they are missing
+	 * and the cluster chain includes a loop.
+	 */
+	exfat_chain_set(root_clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+	ret = exfat_count_num_clusters(sb, root_clu, &root_clu->size);
+	if (ret) {
+		exfat_err(sb, "failed to count the number of clusters in root");
+		goto free_bh;
+	}
+
 	ret = exfat_create_upcase_table(sb);
 	if (ret) {
 		exfat_err(sb, "failed to load upcase table");
@@ -627,6 +636,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct exfat_sb_info *sbi = sb->s_fs_info;
 	struct exfat_mount_options *opts = &sbi->options;
 	struct inode *root_inode;
+	struct exfat_chain root_clu;
 	int err;
 
 	if (opts->allow_utime == (unsigned short)-1)
@@ -645,7 +655,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
 	sb->s_time_max = EXFAT_MAX_TIMESTAMP_SECS;
 
-	err = __exfat_fill_super(sb);
+	err = __exfat_fill_super(sb, &root_clu);
 	if (err) {
 		exfat_err(sb, "failed to recognize exfat type");
 		goto check_nls_io;
@@ -680,7 +690,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	root_inode->i_ino = EXFAT_ROOT_INO;
 	inode_set_iversion(root_inode, 1);
-	err = exfat_read_root(root_inode);
+	err = exfat_read_root(root_inode, &root_clu);
 	if (err) {
 		exfat_err(sb, "failed to initialize root inode");
 		goto put_inode;
-- 
2.39.5


