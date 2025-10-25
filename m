Return-Path: <linux-fsdevel+bounces-65633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F14C09CFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449C24238F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4931354D;
	Sat, 25 Oct 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoyZHVbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAC30F532
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410018; cv=none; b=n6j5FDOd64dsJ+4npgKt3bNeLwuvsEIbGu1HFMVilN+rEAErUtrQi4yEE9RBV6A/a5ERNageH1HARVznWxLSx3yE/f9VCz9jEQ+tnPI6gDSwibcyLlqNvdQXoSUPtUCjMZDlXNefV9d2Rg8JqxUiDHYAcjocksDqtT47t2rfQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410018; c=relaxed/simple;
	bh=M6vYwiDXFrwliwHjWTkr6oRqx2KgbMTp+xr1SyvsQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lnxwzv10a/i37+sn0TJU3A8bqlI22P+Haziu+sJZgEEiv5PYtbuYSqYa0eq9lM1kTrxmkSHFYWnFj5FqoHm7x2zP90EMFuAtloNHBEqeU9rAAxtJxFLBEguXydtOAm/ZnePVf0yo9Gl5CLTN9Dx647Qt95qHLtSmiBpMDHoPdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoyZHVbb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-79a7d439efbso26159666d6.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410016; x=1762014816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=AoyZHVbbRAvOaJGXPLjkMkTctIl63Ov23pOWONsZDBYQ/jhUFeCcIgaouH7PufBH+I
         92EIaf12QJgGdkwSGz70I9OL/XMJzqyFKP0ZGKndgJtFRZTcM1aiwjGly+stXZ+FLFOO
         X1MlfSbOTl2L6SPmRRaoJK0MeMy15jLII6kb00JsCwhhVX5RqVawIp/3E7pNfbWCY23h
         ET/KX94ZG27Ptsg3zkHet/sZ1KYTU0xbIoBi7iRkB8Q1VWTNTlj0OFjtreE3rwr/uh1L
         WSgBMayHJAagyDFo4rbHBj6qni4LCE2md66wLRbiunDSHHPf/5ZckIM+/+mV3bg8Gdj1
         TfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410016; x=1762014816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=ee9Kmx6bXUPES6msIiVBY/XcG4mH1pFqXoBSpQFb8EoL/+Qn5uG4V2tXOQRMNMXl5Q
         h0iTT9827+ICfCvzwJ0/mJ56EEwgLVYojlvwmZGHJpOxvs3diLB7GBqThfrYD5piV3n1
         advsRyB3JECYY08W4mO1bBwleY2Ky1NKeV+BLJShxtSGcYLwEH6mHb3CI8Dpn5gVDmln
         CTVuR2gb3LOKsj+0pcOUoDFmI3oWAufXCQWPe/pWSuCdHwbkSEdKZb3RJi95zDJA5G8L
         deVlXt2HyGc0MrEfhLFD8khUvFB+f0ozoYONcv9VyBqT/DRN6T5kwNrjW/ckD5qmQqV/
         bP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrNXMe+xW0Rbvve/gY5vE6jN84s3XzSv8U4Gb1jR9XuABaOh3mN9LopgoT1w1pAh/yehEltAH8bbXp81wD@vger.kernel.org
X-Gm-Message-State: AOJu0YwZp6D57lL/SvCLcFdCXshVwoMwSvIq7vlgAkDmTHu1lDBRnTOL
	vQRouA7Gn6FdmVxujDqsbS4OJySUNxb0tsCCIlOYO04quApUhvN+Ii8p
X-Gm-Gg: ASbGncsmhl1riXHVfpV5/eiZnXRWITH9KEuPfeJAWp/IfL6a/lgmBsE/ThpBrCOu8W9
	mUmxGo6rguOzx3J2oHxvBhTjzuMbWzzP1O46Sm50xreCzbKnrpQFETHdZ57hzNbDWdmT4aLGG7Y
	3log0Q3LqwYb/5k7VZmJ26ESYrScbCMYRIXNrLORov0KHpxWrVGjuhgCuyTXasVZZ/CzU13dSY2
	zxyAD37CdtKG/7uhWJKio7H+LOBQlMmZYwPyN/NVk5lilHcBXQ0TSw43dKy3RbP1KeMoUtFZPmd
	p23kFwu4qf5q83kbXCp80EBQeJ3wAOKjlrBSZwP3ZlvHBVolH8Z8XSM+LdKu5qaYmrHlaViXDLF
	erozXoGo8if+4NiVZ2jHdHDDupv7wLtGlokIWGvjI7ScQImI+39JBWSHM6aike/qjeVrbr+al
X-Google-Smtp-Source: AGHT+IFUNq9E9F5tkFvF4iIGRPUJo2bGn0CXF3o3/vXLG4KH0hAs0g3n//wSNOK/rhmKbOn3qmKqqg==
X-Received: by 2002:a05:6214:f6d:b0:87c:1032:e849 with SMTP id 6a1803df08f44-87f9edc81b9mr140672916d6.30.1761410016037;
        Sat, 25 Oct 2025 09:33:36 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8bc4sm16252346d6.7.2025.10.25.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:35 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrei Vagin <avagin@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 19/21] fs: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:33:01 -0400
Message-ID: <20251025163305.306787-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST/LAST_BITS() are
more appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 fs/erofs/internal.h      | 2 +-
 fs/f2fs/data.c           | 2 +-
 fs/f2fs/inode.c          | 2 +-
 fs/f2fs/segment.c        | 2 +-
 fs/f2fs/super.c          | 2 +-
 fs/proc/task_mmu.c       | 2 +-
 fs/resctrl/pseudo_lock.c | 2 +-
 include/linux/f2fs_fs.h  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f7f622836198..6e0f03092c52 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -250,7 +250,7 @@ static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 	 * Note: on-disk NIDs remain unchanged as they are primarily used for
 	 * compatibility with non-LFS 32-bit applications.
 	 */
-	return ((nid << 1) & GENMASK_ULL(63, 32)) | (nid & GENMASK(30, 0)) |
+	return ((nid << 1) & LAST_BITS_ULL(32)) | (nid & FIRST_BITS(31)) |
 		((nid >> EROFS_DIRENT_NID_METABOX_BIT) << 31);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 775aa4f63aa3..ef08464e003f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -416,7 +416,7 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 static blk_opf_t f2fs_io_flags(struct f2fs_io_info *fio)
 {
-	unsigned int temp_mask = GENMASK(NR_TEMP_TYPE - 1, 0);
+	unsigned int temp_mask = FIRST_BITS(NR_TEMP_TYPE);
 	unsigned int fua_flag, meta_flag, io_flag;
 	blk_opf_t op_flags = 0;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..42a43f558136 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -524,7 +524,7 @@ static int do_read_inode(struct inode *inode)
 			fi->i_compress_level = compress_flag >>
 						COMPRESS_LEVEL_OFFSET;
 			fi->i_compress_flag = compress_flag &
-					GENMASK(COMPRESS_LEVEL_OFFSET - 1, 0);
+						FIRST_BITS(COMPRESS_LEVEL_OFFSET);
 			fi->i_cluster_size = BIT(fi->i_log_cluster_size);
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..64433d3b67d4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5425,7 +5425,7 @@ static int do_fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 		wp_block = zbd->start_blk + (zone.wp >> log_sectors_per_block);
 		wp_segno = GET_SEGNO(sbi, wp_block);
 		wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-		wp_sector_off = zone.wp & GENMASK(log_sectors_per_block - 1, 0);
+		wp_sector_off = zone.wp & FIRST_BITS(log_sectors_per_block);
 
 		if (cs->segno == wp_segno && cs->next_blkoff == wp_blkoff &&
 				wp_sector_off == 0)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index db7afb806411..96621fd45cdc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4501,7 +4501,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sbi->error_lock, flags);
-	if (sbi->stop_reason[reason] < GENMASK(BITS_PER_BYTE - 1, 0))
+	if (sbi->stop_reason[reason] < FIRST_BITS(BITS_PER_BYTE))
 		sbi->stop_reason[reason]++;
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 }
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..71de487b244c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1845,7 +1845,7 @@ struct pagemapread {
 
 #define PM_ENTRY_BYTES		sizeof(pagemap_entry_t)
 #define PM_PFRAME_BITS		55
-#define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
+#define PM_PFRAME_MASK		FIRST_BITS_ULL(PM_PFRAME_BITS)
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 87bbc2605de1..45703bbd3bca 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -30,7 +30,7 @@
  */
 static unsigned int pseudo_lock_major;
 
-static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
+static unsigned long pseudo_lock_minor_avail = FIRST_BITS(MINORBITS + 1);
 
 static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
 {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6afb4a13b81d..9996356b79e0 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -356,7 +356,7 @@ enum {
 	OFFSET_BIT_SHIFT
 };
 
-#define OFFSET_BIT_MASK		GENMASK(OFFSET_BIT_SHIFT - 1, 0)
+#define OFFSET_BIT_MASK		FIRST_BITS(OFFSET_BIT_SHIFT)
 
 struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
-- 
2.43.0


