Return-Path: <linux-fsdevel+bounces-37410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165529F1C51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6C161FBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895315B54C;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QyQwMKci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5718052;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145861; cv=none; b=Je6gU6e6BZicQhQ3FaWEy56Pach+QS6A7lWQZSihbmcGUJQPdlAvB7BJt74JPaZAM5Ft8nnhY2Zt8HQOB80USOvhDog6gIZbVqCRMqH7baTGhwl2bG++uFRuok/67GqcbK/8PXAzZUoHHfixanlLBM7xWTz4SPspBikXtXMed/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145861; c=relaxed/simple;
	bh=BgjdvO26G8eQuOo3VdDz0/aZlJjB533efwx99NspO9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxs+9Qk0XkZXmOg1RQJk6dPQkfoRTtavrpoEjoIex0fMI7mLC6OCkdE78shDThmId92bbuiL1l6rnuV8Vfz1EotBfClNFEpsb7fK1qBV1fmphEuJ5EVTitRf6hRenyGTtZRDIyEpiRX20m2RPZqGDGr3JsGpf7aPTXsLoRsMxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QyQwMKci; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sbicKkEIU1GP8SA/RwQPAcQQ45CmcRGRebxtvNHMUlw=; b=QyQwMKci1SqqFVKwrphSBzYf7/
	Kpt9D/juXjczuPs656dIQuZkABPk6iOh6ydyQfGcB5HaXY2bllFf74fF0ENUyoB2UlRvo3XSz0KEz
	mxuqbJyUulQ5iwka2He1evk8XYb4OsjtZJXxyiBYzHqFBcLMrPHH3yi2xLBo3cR2aEmq+hISCQM91
	dhM6+dSdz+2+MMZXeGS1uRFB+JO0vyRAwGA2jWCWZExWukPikTyRnjV38M32dXiAuPD/YxikEzEfQ
	ECcMOBlpHDPO9S7qSoYieXOOvRSx5o9fQ+doAZwsSFn7gbseriWxxJgXbzDRPGPhKQ+3fk4VzrNdi
	htcjBV+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3j-42bm;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
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
	mcgrof@kernel.org
Subject: [RFC v2 07/11] fs/buffer fs/mpage: remove large folio restriction
Date: Fri, 13 Dec 2024 19:10:45 -0800
Message-ID: <20241214031050.1337920-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Now that buffer-heads has been converted over to support large folios
we can remove the built-in VM_BUG_ON_FOLIO() checks which prevents
their use.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 2 --
 fs/mpage.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b4994c48e6ee..4296bfb06fb1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2523,8 +2523,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
 		limit = inode->i_sb->s_maxbytes;
 
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 
diff --git a/fs/mpage.c b/fs/mpage.c
index c6bb2a9706a1..c1b85be8df64 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -170,9 +170,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 
-	/* MAX_BUF_PER_PAGE, for example */
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	if (args->is_readahead) {
 		opf |= REQ_RAHEAD;
 		gfp |= __GFP_NORETRY | __GFP_NOWARN;
-- 
2.43.0


