Return-Path: <linux-fsdevel+bounces-31879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC099C7E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5251C2324F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1801A3A9A;
	Mon, 14 Oct 2024 10:59:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7019CC3A;
	Mon, 14 Oct 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903591; cv=none; b=iRNWXLQFs9MNj+1xwv6IFqUz1Et3imNzgwP1Q+jJJG4HiE69EjcCv8todM3PRO5c7CmQx25Kqnnx+CdEtK5wlCZvCGYhzNPWwQIh26xAIdt5ydNiBQIEgmBr39kQlGaowDiLtw2QIsHD/kpWYEDi4q5Q94QAmJos5+ZX8sn1lOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903591; c=relaxed/simple;
	bh=qcw7gwKfkemGiCBFt3H0lPkxjBXG/J4WpLGVGwUe6T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evbrpKNrrw8iEd5sR+a5q/dxnGdo0e12WOQ0H3OevZGXZO7dP2JpOEuiMndNRBR/A/K24d3LSoaM2JxDFLke/N9R56ua9k+CNq1hpqsLxKfYf21/8yvsczLJPnPqYtcdH0fkJvJqAELhRo3mwzbGuelGSAj8UUyxBK/g1EX4lvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 130DB1684;
	Mon, 14 Oct 2024 04:00:19 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FB0B3F51B;
	Mon, 14 Oct 2024 03:59:46 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 07/57] fs: Introduce MAX_BUF_PER_PAGE_SIZE_MAX for array sizing
Date: Mon, 14 Oct 2024 11:58:14 +0100
Message-ID: <20241014105912.3207374-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Code that previously defined arrays with MAX_BUF_PER_PAGE will no longer
work with boot-time page selection because PAGE_SIZE is not known at
compile-time. Introduce MAX_BUF_PER_PAGE_SIZE_MAX for this purpose,
which is the requirement in the limit when PAGE_SIZE_MAX is the selected
page size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 fs/buffer.c                 | 2 +-
 fs/ext4/move_extent.c       | 2 +-
 fs/ext4/readpage.c          | 2 +-
 fs/fat/dir.c                | 4 ++--
 fs/fat/fatent.c             | 4 ++--
 include/linux/buffer_head.h | 1 +
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c5306..f00542ad43a5c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2371,7 +2371,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE_SIZE_MAX];
 	size_t blocksize;
 	int nr, i;
 	int fully_mapped = 1;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 204f53b236229..68304426c6f45 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -172,7 +172,7 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t block;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE_SIZE_MAX];
 	unsigned int blocksize, block_start, block_end;
 	int i, err,  nr = 0, partial = 0;
 	BUG_ON(!folio_test_locked(folio));
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 8494492582abe..5808d85096aeb 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -221,7 +221,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
-	sector_t blocks[MAX_BUF_PER_PAGE];
+	sector_t blocks[MAX_BUF_PER_PAGE_SIZE_MAX];
 	unsigned page_block;
 	struct block_device *bdev = inode->i_sb->s_bdev;
 	int length;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd5210..f3e96ecf21c92 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1146,7 +1146,7 @@ int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts)
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE_SIZE_MAX];
 	struct msdos_dir_entry *de;
 	sector_t blknr;
 	__le16 date, time;
@@ -1213,7 +1213,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 {
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE_SIZE_MAX];
 	sector_t blknr, start_blknr, last_blknr;
 	unsigned long size, copy;
 	int err, i, n, offset, cluster[2];
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 1db348f8f887a..322cf5b8e5590 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -469,7 +469,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent, prev_ent;
-	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE_SIZE_MAX];
 	int i, count, err, nr_bhs, idx_clus;
 
 	BUG_ON(nr_cluster > (MAX_BUF_PER_PAGE / 2));	/* fixed limit */
@@ -557,7 +557,7 @@ int fat_free_clusters(struct inode *inode, int cluster)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent;
-	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
+	struct buffer_head *bhs[MAX_BUF_PER_PAGE_SIZE_MAX];
 	int i, err, nr_bhs;
 	int first_cl = cluster, dirty_fsinfo = 0;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 14acf1bbe0ce6..5dff4837b76cd 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -41,6 +41,7 @@ enum bh_state_bits {
 };
 
 #define MAX_BUF_PER_PAGE (PAGE_SIZE / 512)
+#define MAX_BUF_PER_PAGE_SIZE_MAX (PAGE_SIZE_MAX / 512)
 
 struct page;
 struct buffer_head;
-- 
2.43.0


