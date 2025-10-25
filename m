Return-Path: <linux-fsdevel+bounces-65635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9BAC09B9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D34734EA44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9260319615;
	Sat, 25 Oct 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao47nZRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66B3191C4
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410484; cv=none; b=cPPckDLKfgroY3Imq+ptKuLqEDxnfakGcAu4a0jL2UsOiOId7lyWZzotkNBC3Tqi9Cs3wG0DKekSyjE5+NT2cg87UFB4WZjXudjw4VhP8c0cPkfnvnCmuRhwM5nGdrZBp4KYcnrLxDqlc7vrDF12T/3bRq7AsZTIxTkkGKw7EcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410484; c=relaxed/simple;
	bh=M6vYwiDXFrwliwHjWTkr6oRqx2KgbMTp+xr1SyvsQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkhnkZL5Gyhw2EBKExJs6JlgPO406nOZ0+MTnCzoMQ/UqFgI+zT4UBQs3okCUJrT0DvX6L8LBhJx1qFHphAIW+mqUOtkDc3SQ/KiHr/TFoWPVnDf9TtgC4CdpbJsQZEo4z46wkHgzBxB4dZgwcI0lIgXgmdy0Wz1hwgps8KP8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao47nZRp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89f54569415so73559985a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410481; x=1762015281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=ao47nZRpcW2eXLIVAQJTziNI7xHxLdffM/OF8QltmHhwe8KAkjLBY6zR5qLij43lv/
         PKI+QP3pla1Yq7f8CZ7RVGuWQFLliJPYqkvV/b0Ib2jUBRyEiYzV6orh3eBuOBVfUKh/
         jzh40TVdZZ8umoloAWbtHGzKxtZLufdEcrnrOB3bbo1NTyh0jzK7qc3vEwugiSsPYzSJ
         PBtm8JmwKiPm1U8vlRxiaDpkN5Qu+qpBzKDZxdVw36Vbuq3Z+h08+4pf+iHrKQZK5+US
         Ln9qgbZkBjMA5vb07ROKrDW2CltDrhf4TsvqsWoJBiY8dNT3d70duChqB0aiiRnBJ6Px
         eT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410481; x=1762015281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=OmXoD5EwMZqUvxsEGLXWL9c0p6etdotbi6cxcYRVkjVJqWoXdSvdwRxUWVUhoKispd
         V+C84wC3pfQkXSEVxiHTPYs4uRNC73vdh50QPV84zjZu1YIbXMU4plr1TnIpJuIE42KX
         28zOOWBkxgs1XSR/d14EqxETC7XxyEp46DSDAhEuJWONfykI3/rErA8bD1k3C8fT4Vhb
         Q6zO4B2pQtwu7iklsUUUKZ5mYs/QNA8i1DOj61EEpJvMOxfnL3EFHWEVsq+G4DSlZ/kq
         TGnuAedmgUNM9Ohz2SXkOcZ1vI2pk9Km/CrX35z8xx0Wpy9lfMjuF+ScORouXU9wvvA2
         zTMg==
X-Forwarded-Encrypted: i=1; AJvYcCV6xOKAVmlvVoBHq9dZcWaOuFG8472EZ9w6LcnmCXq2ybN+yV3zZQoF577XtmeQ/U+vUqW8a/TsStzjqDux@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JkpjWrcWDkrateJWG82EEKOmBbu/XTI/FWNS6V6iFGOSy8IK
	h5CgcA8p558H6FtbAoKbnBQvKeoHKzKD2D/UzpnFSPFpOuUEHclAO4zh
X-Gm-Gg: ASbGnct1hJ6m71kgyKBShVfpNpd6Ce3tkg3rFO7rQJffe7X4rzpR/bMD/PrsBkeq9CF
	dMf7Rr8HZIz6Rsh3e3J92qu0NmHFXYSUnykx3mwA4dvoiteAvUzJA/EWEKiIMpockK+7AgfFkcB
	Yu9EFmBCRVxIzIM1zB/bNmwDzHBQZ5bFv7a/6V2awD5AHEr8cHP4QJVLQB9myJ0NVyaZ5EI9QIg
	osknAHsDeon2D2NgQdYHjRVVKhpskqf4GdCATXPgfxueCnSPAFfJ5xq6L4nPtYvJqFVQPpGBKOD
	vsZk+gmnRihOz6KZxIZIDNPtlzMyxBaVz5nk3a3KugHL23fpZQhMuOnEp9vXTaau/il0FquHsnP
	pkb/XU7UOtSNXCQ41S7wPVf8wJJKvQM1TxL8LvijWPIlvvUTUwt+KPW7BMg5E9DxmJ7u137qt
X-Google-Smtp-Source: AGHT+IEbSTHOPYn/ssbsalfndo2SE/aquOPMKCRUcU70dpCWt75EhJinxXayNqNWEpmv6XMRvXc8Dg==
X-Received: by 2002:a05:622a:48f:b0:4e8:aad2:391c with SMTP id d75a77b69052e-4e8aad23e00mr349567941cf.1.1761410481317;
        Sat, 25 Oct 2025 09:41:21 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3858f1esm15257191cf.29.2025.10.25.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:20 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
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
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 19/21] fs: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:18 -0400
Message-ID: <20251025164023.308884-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
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


