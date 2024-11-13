Return-Path: <linux-fsdevel+bounces-34604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E89C6BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301BC2859F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F91F8930;
	Wed, 13 Nov 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MrW0mugs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F518A6DC;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491254; cv=none; b=agoa+o5xhk3CtvjZXqpgNWamK2G4LNtdNMhYSzgwvV9bybcx7aXdbXUWvcAfrvjP4K/rQK3lp1N8L0PS4fZIxVRSgKWVM/+mzva8kTO+UnGawgfcbc0lilg534/RdV+ryh69ELPX8gcC+sO1ToJNag+D0Ezvr2EQ4aWNz1uGN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491254; c=relaxed/simple;
	bh=7gNOp8kyh5T+81mF3lM5KXe7+OjbZnxwz395yuSGkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crweu9Jh2JNkDXV66gqiLB3Y2AjXYrZ3iKdfhBHnot0DFIZ3k6e6cFgC0VXblz8vgvkOW881LKR3fR3zN+7Mp+U+VxlEhX6nsgNqcdVtkaWGGF44nzk+Ojojkwh4D3HX+qPUbSmnhRnjvZ7i7AhijzEZQ78PuW8PltjdSAO7A9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MrW0mugs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7+8+iZm+tjxOB43GQOsTAsoBbae92Ry/J8rdhLVaHLE=; b=MrW0mugsJonnAulp8nZ/Goql0i
	dlieZ5TByws+pcxXO9uzei7XrUnTJIaPGtXcmT7M28XbIRQNf8WfjJyrEBMnLUb18awyz5G+zOp3o
	zasJqs8/WFw10/x/u9WEXX8tgHRVMwegKqXwPlbK0yGoR10GXWRzKSH8YzezgZ1p6SyBdZmc0f1+d
	zvkmwdLq4VgNTo8RnuoLrYc1EMhcJZRZ+vfG5n0WOPSGNTGK4zwf4CKDI426pbHRYyeJnPc3SuWqG
	i+VtckgYCCV1qo5rIAcAcGq0g5Y5cgCEP9SSSI7Q9MEPDLApZpyGJGXy+WfxgWOsPRkqxVneAc5ET
	J4oaxmZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yC-00000006Hd2-44oO;
	Wed, 13 Nov 2024 09:47:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [RFC 2/8] fs/mpage: avoid negative shift for large blocksize
Date: Wed, 13 Nov 2024 01:47:21 -0800
Message-ID: <20241113094727.1497722-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094727.1497722-1-mcgrof@kernel.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@kernel.org>

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so use shift to calculate the sector number from the page cache index.

With this in place we can now enable large folios on with buffer-heads.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 5b5989c7c2a0..ff76600380ca 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -181,7 +181,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
 	last_block = block_in_file + args->nr_pages * blocks_per_folio;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -527,7 +527,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.43.0


