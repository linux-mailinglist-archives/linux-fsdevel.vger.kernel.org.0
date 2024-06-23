Return-Path: <linux-fsdevel+bounces-22198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0A9137C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 07:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866E31F226DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 05:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2D745E2;
	Sun, 23 Jun 2024 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEMsJt+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69F54903;
	Sun, 23 Jun 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119515; cv=none; b=f9CdbylR0Y2rzAGrLaAqJtyaVqTh6zZ90IMW88bxp6WXRCxh6UB3y2DUuzRkOzO7do1XFsjIRWJT4aD+ot26UAAGJ6mDb0Ew06cY1viMZkiK4B9GBse/2O91XkdbjcARAe7SsXFcFIkrcD89xi1HanFcV1sNBgy2t/py/AqPY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119515; c=relaxed/simple;
	bh=xYJG8i+fuWApHBDCTAWc1UwRChxNBZW/laCKRJyFaE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VprCeaaZt1um5RWp9ebSGfMEpiX2SpZp/pov9FL6eb14EoT4WA96lsry9Ocl6WOWZHdh3Me5CF5KxdYkOD1+s5CcyXGdljoNqtrWk3xf1+ghIDxvFZE5YoAKsugZ85L+zZcmE2o07/v/ovOAr/04mP3IvNcmbbKPZ1Ev/pmFJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEMsJt+n; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706642b4403so669859b3a.1;
        Sat, 22 Jun 2024 22:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719119513; x=1719724313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjnjBeEg2Eh+rau6hPT05sZEODPu6+al+eM3tFMwTLA=;
        b=fEMsJt+nhWzmUJYVeriWYf5aGs5a1mrTWSBmQLCLymtjM7ud/VnFGme7OIOvE8Y4vg
         MVjrYhGom2LPtSIbuU2uQp/0OYQjtiJu2nCGNg5rSPW9jvQ/5jwkPyBCzMpCpQncwwXk
         wjsOrKPjswfE4lpfONAMOHhkc48VzKXGe8Cg7iYg9gxAkRK/5Nu22Mil2Y7zEdt/lubN
         oV6PjgtUVi0/qM5rIhoebOUduASNkzMXBBlsSWD9OGzXZ4ou6+Pisi5Hnm6BGAs+IcXc
         FAIazh6T1UsjjDShZ3TLmuqdSa2hTcAYugdxaunPA5Ef9Gmrd4c9l3WlsmPJ/P1U1prW
         LyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719119513; x=1719724313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjnjBeEg2Eh+rau6hPT05sZEODPu6+al+eM3tFMwTLA=;
        b=UqRNUvnpwfnYCqlHeCwMfoiIMDJFk2w5rWsTvIRj/AqZg11KrcvSgGnedUL0hpcHa8
         Nb0E4xnDa1PWksf32RXd7N955ieJTrXDmaC18NcRr/Iqje2ljpdRxnNIbddDMvwawoLh
         Pn/vuagxRuUTNGSmudo1Mcl/gngdjUhY8HJsKOV2Zz3N4lWANx/T6IBKpy79keU5yC6x
         XVkVjuUx5siIceD8sFcuPbDxhuep9bB+63RaMPf92Z807DymsGcpXC3R206VWa8pTtaf
         SXbXVVi+v7iXGFemXeRRarZghyLGft+lgEvsOE167ATVJQhzfl2iDxHNht82KNGj87jH
         kanQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5lPvLWU/FgKcGoJIL5c/UphOX+vbHrIKBiDdY3HCMax9vTJ//NfQagmEX4o3YIN8oD26XrjN5LfT53Dnf24e0BmlhLdrilvp92gaEr/SIi92Jy3JL7vn0WXzA39tEptPaVT32bWD6bCC9gw==
X-Gm-Message-State: AOJu0YyGl0b5DG61EMxBdayhNkFo9+sihYzCv/VtonJLoMqeXuVJ7Y+6
	M0yii8ADKsbGQcWETGd2yRVsnEtZukFzlpwmw9+qx5FaOLWNkw6I
X-Google-Smtp-Source: AGHT+IG3/AWgYvkNCTocWy0yKRiTkrWq4RAWHBWsaSthWvnc8UEYp3Uaz/6jmm/Mhwe2GTmaqkLPWg==
X-Received: by 2002:aa7:824b:0:b0:706:3f17:ca2 with SMTP id d2e1a72fcca58-70669ecae02mr3320340b3a.0.1719119513305;
        Sat, 22 Jun 2024 22:11:53 -0700 (PDT)
Received: from carrot.. (i114-180-52-104.s42.a014.ap.plala.or.jp. [114.180.52.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512d3034sm4042844b3a.170.2024.06.22.22.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:11:52 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>,
	hdanton@sina.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 3/3] nilfs2: fix incorrect inode allocation from reserved inodes
Date: Sun, 23 Jun 2024 14:11:35 +0900
Message-Id: <20240623051135.4180-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623051135.4180-1-konishi.ryusuke@gmail.com>
References: <000000000000fe2d22061af9206f@google.com>
 <20240623051135.4180-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the bitmap block that manages the inode allocation status is
corrupted, nilfs_ifile_create_inode() may allocate a new inode from
the reserved inode area where it should not be allocated.

Previous fix commit d325dc6eb763 ("nilfs2: fix use-after-free bug of
struct nilfs_root"), fixed the problem that reserved inodes with inode
numbers less than NILFS_USER_INO (=11) were incorrectly reallocated
due to bitmap corruption, but since the start number of non-reserved
inodes is read from the super block and may change, in which case
inode allocation may occur from the extended reserved inode area.

If that happens, access to that inode will cause an IO error, causing
the file system to degrade to an error state.

Fix this potential issue by adding a wraparound option to the common
metadata object allocation routine and by modifying
nilfs_ifile_create_inode() to disable the option so that it only
allocates inodes with inode numbers greater than or equal to the inode
number read in "nilfs->ns_first_ino", regardless of the bitmap status
of reserved inodes.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/alloc.c | 19 +++++++++++++++----
 fs/nilfs2/alloc.h |  4 ++--
 fs/nilfs2/dat.c   |  2 +-
 fs/nilfs2/ifile.c |  7 ++-----
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 89caef7513db..ba50388ee4bf 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -377,11 +377,12 @@ void *nilfs_palloc_block_get_entry(const struct inode *inode, __u64 nr,
  * @target: offset number of an entry in the group (start point)
  * @bsize: size in bits
  * @lock: spin lock protecting @bitmap
+ * @wrap: whether to wrap around
  */
 static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 					    unsigned long target,
 					    unsigned int bsize,
-					    spinlock_t *lock)
+					    spinlock_t *lock, bool wrap)
 {
 	int pos, end = bsize;
 
@@ -397,6 +398,8 @@ static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 
 		end = target;
 	}
+	if (!wrap)
+		return -ENOSPC;
 
 	/* wrap around */
 	for (pos = 0; pos < end; pos++) {
@@ -495,9 +498,10 @@ int nilfs_palloc_count_max_entries(struct inode *inode, u64 nused, u64 *nmaxp)
  * nilfs_palloc_prepare_alloc_entry - prepare to allocate a persistent object
  * @inode: inode of metadata file using this allocator
  * @req: nilfs_palloc_req structure exchanged for the allocation
+ * @wrap: whether to wrap around
  */
 int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
-				     struct nilfs_palloc_req *req)
+				     struct nilfs_palloc_req *req, bool wrap)
 {
 	struct buffer_head *desc_bh, *bitmap_bh;
 	struct nilfs_palloc_group_desc *desc;
@@ -516,7 +520,7 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 	entries_per_group = nilfs_palloc_entries_per_group(inode);
 
 	for (i = 0; i < ngroups; i += n) {
-		if (group >= ngroups) {
+		if (group >= ngroups && wrap) {
 			/* wrap around */
 			group = 0;
 			maxgroup = nilfs_palloc_group(inode, req->pr_entry_nr,
@@ -550,7 +554,14 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 			bitmap_kaddr = kmap_local_page(bitmap_bh->b_page);
 			bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
 			pos = nilfs_palloc_find_available_slot(
-				bitmap, group_offset, entries_per_group, lock);
+				bitmap, group_offset, entries_per_group, lock,
+				wrap);
+			/*
+			 * Since the search for a free slot in the second and
+			 * subsequent bitmap blocks always starts from the
+			 * beginning, the wrap flag only has an effect on the
+			 * first search.
+			 */
 			kunmap_local(bitmap_kaddr);
 			if (pos >= 0)
 				goto found;
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index b667e869ac07..d825a9faca6d 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -50,8 +50,8 @@ struct nilfs_palloc_req {
 	struct buffer_head *pr_entry_bh;
 };
 
-int nilfs_palloc_prepare_alloc_entry(struct inode *,
-				     struct nilfs_palloc_req *);
+int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
+				     struct nilfs_palloc_req *req, bool wrap);
 void nilfs_palloc_commit_alloc_entry(struct inode *,
 				     struct nilfs_palloc_req *);
 void nilfs_palloc_abort_alloc_entry(struct inode *, struct nilfs_palloc_req *);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 180fc8d36213..fc1caf63a42a 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -75,7 +75,7 @@ int nilfs_dat_prepare_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 {
 	int ret;
 
-	ret = nilfs_palloc_prepare_alloc_entry(dat, req);
+	ret = nilfs_palloc_prepare_alloc_entry(dat, req, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index 612e609158b5..1e86b9303b7c 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -56,13 +56,10 @@ int nilfs_ifile_create_inode(struct inode *ifile, ino_t *out_ino,
 	struct nilfs_palloc_req req;
 	int ret;
 
-	req.pr_entry_nr = 0;  /*
-			       * 0 says find free inode from beginning
-			       * of a group. dull code!!
-			       */
+	req.pr_entry_nr = NILFS_FIRST_INO(ifile->i_sb);
 	req.pr_entry_bh = NULL;
 
-	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req);
+	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req, false);
 	if (!ret) {
 		ret = nilfs_palloc_get_entry_block(ifile, req.pr_entry_nr, 1,
 						   &req.pr_entry_bh);
-- 
2.34.1


