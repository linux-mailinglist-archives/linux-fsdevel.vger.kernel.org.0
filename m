Return-Path: <linux-fsdevel+bounces-57430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A937EB216B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 22:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE65D4E39DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C32E2EF9;
	Mon, 11 Aug 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLTBLd4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC12E2DFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945018; cv=none; b=cwIf94yvWY9YEiIBhXrz2G11ejmwO4SNBdIlXeh5hXBYRJrkDh0gWePWhxWITWMdneI33okKkuXZ8Sd2atc7Pg2Jw5VC7KK3+7T0ORwzBOEzOVxF5RE8QyxKHcWbucwgSFGJdJXUUJMReF25BzbXTyqMYn5v4Q7lNqG3lkLvRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945018; c=relaxed/simple;
	bh=GOtym20jpNWgPjFWrqHZ0YuLQDo9ICs9CZXp75umkrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfyAcqHWmimRL6kgKv1TTUjfst0p58YmvmImh9/bZAea21mJ2N3SMWgXpIwZHwVqCIUsZg7FYw/5WkBTaPHf360cQfi/Fvb9p9qMDDq5+lR48f2wGISgFGkSv4USnH1kzRLe7bIN8c4xPKfLqO83lG6Gmh+90msWC0JAMByALIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLTBLd4C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-242ff06b130so85395ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754945016; x=1755549816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWicoF01GWC9VUfZ/CNzz82pf35qpl9B0qyYYGYdUZA=;
        b=hLTBLd4Cx2yEykIf67OV2CR+J5CtnZ8kj73UQ0b6VS0gcZJ5YvvHr2E3BkQpdGQUYB
         yagwWnhfUegGpmmZ3gzWLUdP+LfYrTM+3tvvJsqq0HVtCOOWBLj6gMLfdhSXTSCejyqI
         74M1q5/t/uD3ZcomQ+u+HITWb3820z+kVs3uxieeWisp7qPfsHytnuL0JHfljy1stQ4W
         f+FVB/oQNswhAf6lrA7FvKUnQQ/1fU5fZnSloXH5oAHNwu5fw7UZRmdgfvV8yI9LwnPZ
         UowgpFJZdGg1rw/DzMBWefDjSaIrK1kO2qChH8sdySNQXJeorUw0CTnwAdUnKLmsBs2z
         FV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945016; x=1755549816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWicoF01GWC9VUfZ/CNzz82pf35qpl9B0qyYYGYdUZA=;
        b=tO4V6W9VxY5JMIaOUM4p3X7hng6eZ5gImwHI6DHISBGcnesJyOfL1szYw2dDCHWTfw
         N8b4iIfUwzEJOffPuSgxOUDSlRMX5o2waYSYx8I1lYbS8QFL8/qSaiNGnDngmODZELzk
         iZw486r6ttgtA1mgr66an51eU5pcyI9EGPjFm+BADwYL2ufH8b+qjy2E3rM54g86SO8w
         ql1urIxS25FaEH/cVtVwyWB0GPcmOEe4oPbGnxFy7E+gPCVcoWBZaUmUN6qz8mS4BCmD
         KrZDScKpsKGMYGBllT31Yv5c0CK4VmOYW2d1koCghqPQ4IdB77bD5be4+m1etNNqQcM5
         Mk6w==
X-Gm-Message-State: AOJu0YyambvD8vrkb4Ydse36rCOOnsO5bdneyoLn6Ru4sx8moVI4SDWi
	GZBlwxViOkrE/Oz+xaaaUrI/ojW5Ot9/hxqkD2oUD58h+cyP0i4p75kX
X-Gm-Gg: ASbGncvsatelTZgYmxZscudHKAUFkqGcgTxSDhH2+yXjYYGcIz0CAzjZqJrN31/3Q1m
	waw8nUuXsOcFex+fCGIhbjyTyeCKLKXkd+IHCrw4kr03aSIaqp7bzkIwcZOCmd06vK/Mr3fv2Hq
	o9H3Q+wtQfMyPqKw7ugzwYryzoXRaoUosJvU5R51PxF2F+m9AiOXcE306/6np+jK2dbOWeAgGOw
	rq6O7ttUy3NxrntJjMaB+1R51qlhMF+gFAqYbwihUQ9887/dqgWLgikH5f+gjQzuTd+1aHfswWl
	OdB50uUnNdJultHaXrgLwWriqst/gCrGoZ4Kbs2dXvUsqtHM0UEbV+PV8CKzq42TLDn+ojNEXme
	L1dtKssNcN0G4QgVm
X-Google-Smtp-Source: AGHT+IHI3KUYz7eRrldoY5UMU/RfdLnxIsyGxdvpI/fXYybFR5o5Czg7NHwAIrFHqnq9pMyn3Q4GPA==
X-Received: by 2002:a17:902:ef48:b0:240:640a:c560 with SMTP id d9443c01a7336-242c206b2d2mr223309665ad.24.1754945016347;
        Mon, 11 Aug 2025 13:43:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaa829sm280190415ad.149.2025.08.11.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:43:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH] fuse: enable large folios (if writeback cache is unused)
Date: Mon, 11 Aug 2025 13:40:08 -0700
Message-ID: <20250811204008.3269665-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Large folios are only enabled if the writeback cache isn't on.
(Strictlimiting needs to be turned off if the writeback cache is used in
conjunction with large folios, else this tanks performance.)

Benchmarks showed noticeable improvements for writes (both sequential
and random). There were no performance differences seen for random reads
or direct IO. For sequential reads, there was no performance difference
seen for the first read (which populates the page cache) but subsequent
sequential reads showed a huge speedup.

Benchmarks were run using fio on the passthrough_hp fuse server:
~/libfuse/build/example/passthrough_hp ~/libfuse ~/fuse_mnt --nopassthrough --nocache

run fio in ~/fuse_mnt:
fio --name=test --ioengine=sync --rw=write --bs=1M --size=5G --numjobs=2 --ramp_time=30 --group_reporting=1

Results (tested on bs=256K, 1M, 5M) showed roughly a 15-20% increase in
write throughput and for sequential reads after the page cache has
already been populated, there was a ~800% speedup seen.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index adc4aa6810f5..2e7aae294c9e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1167,9 +1167,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		pgoff_t index = pos >> PAGE_SHIFT;
 		unsigned int bytes;
 		unsigned int folio_offset;
+		fgf_t fgp = FGP_WRITEBEGIN | fgf_set_order(num);
 
  again:
-		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+		folio = __filemap_get_folio(mapping, index, fgp,
 					    mapping_gfp_mask(mapping));
 		if (IS_ERR(folio)) {
 			err = PTR_ERR(folio);
@@ -3155,11 +3156,24 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int max_pages, max_order;
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
-	if (fc->writeback_cache)
+	if (fc->writeback_cache) {
 		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
+	} else {
+		/*
+		 * Large folios are only enabled if the writeback cache isn't on.
+		 * If the writeback cache is on, large folios should only be
+		 * enabled in conjunction with strictlimiting turned off, else
+		 * performance tanks.
+		 */
+		max_pages = min(min(fc->max_write, fc->max_read) >> PAGE_SHIFT,
+				fc->max_pages);
+		max_order = ilog2(max_pages);
+		mapping_set_folio_order_range(inode->i_mapping, 0, max_order);
+	}
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
-- 
2.47.3


