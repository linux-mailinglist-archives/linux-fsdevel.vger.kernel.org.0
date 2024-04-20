Return-Path: <linux-fsdevel+bounces-17328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300318AB8E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C761F217BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6964DF44;
	Sat, 20 Apr 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KuIBbNf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D70524A;
	Sat, 20 Apr 2024 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581452; cv=none; b=oR2J0iBvp0LqRCtGdCtvsjJY2TnR+oHLRMiN45XjVQCg0WTr8tqkKB6ihPasc1LvDwGPL1Y8afoJ1txhjwVg0OkNXq5CLUpWUFZhaGA3VpPzBPcfcHx49AjrwRCVR9OuNYsyMt1P/TATz5FInUFzNRlVVyhJ/jEzcBYhswFlZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581452; c=relaxed/simple;
	bh=bdWKf8RrIw6HShlQnEwTvVodOrlgX9LZsrXV0XBYPAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWTZzfl00zXlM0kQ+uS3+70MrQ/XjfXQZRZXQsFjsfxccZldMGuUnDdUe7lJ8QO1Ll6kJBEGT+SKvlSZW+dqnJqWBTGgKdK9ywmXAPuBjUVh/R/dwrnk+eMBw9fgYmtAZVs76FgaAAAC/Zt/lgwPdfXCDdn05celggpU1WlLx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KuIBbNf1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CpH16iYJrVZdrm6jz8AltnYLIb1as/vR4g26ErGz18c=; b=KuIBbNf1Q4CtYflEarqHZjLhTC
	Ig4lVttPNqmzWeOzJ+ejNByH9RpRor1t6QmL82jZwLbIyMsN1Qm/RiqPYnk635tsNUOC34jWV6oH4
	nqQm/2vTmJJ5mrOIG2TOYf+SqLJv4SymOrmrMBLXO0AHanghfej1q9FmiJFUhOIaziD3HysJvXDkI
	IRg0GsKtbRt/cm82RANuGgj1aWReqBXGMdwOj8IHFv3ntxSBkx9pAb5FpZiCGIVyOE7azwlAtplCW
	z4phKDW9D+tBIcG1d8esWjQy4oz5exzZ8fa9BTv/g1gTAufLBCbFOM5auYGErkwBSGbqG3vRf6SCs
	87DB+oDw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oO-000000095e3-3SyE;
	Sat, 20 Apr 2024 02:50:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 02/30] btrfs: Use a folio in write_dev_supers()
Date: Sat, 20 Apr 2024 03:49:57 +0100
Message-ID: <20240420025029.2166544-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove some calls to obsolete APIs and some hidden calls to
compound_head().

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 32cf64ccd761..8fa7c526093c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3760,9 +3760,10 @@ static int write_dev_supers(struct btrfs_device *device,
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
+		size_t offset;
 
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
@@ -3785,9 +3786,9 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
 
-		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
-					   GFP_NOFS);
-		if (!page) {
+		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_NOFS);
+		if (IS_ERR(folio)) {
 			btrfs_err(device->fs_info,
 			    "couldn't get super block page for bytenr %llu",
 			    bytenr);
@@ -3796,9 +3797,10 @@ static int write_dev_supers(struct btrfs_device *device,
 		}
 
 		/* Bump the refcount for wait_dev_supers() */
-		get_page(page);
+		folio_get(folio);
 
-		disk_super = page_address(page);
+		offset = offset_in_folio(folio, bytenr);
+		disk_super = folio_address(folio) + offset;
 		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
@@ -3812,8 +3814,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
 		bio->bi_private = device;
 		bio->bi_end_io = btrfs_end_super_write;
-		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
-			       offset_in_page(bytenr));
+		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE, offset);
 
 		/*
 		 * We FUA only the first super block.  The others we allow to
-- 
2.43.0


