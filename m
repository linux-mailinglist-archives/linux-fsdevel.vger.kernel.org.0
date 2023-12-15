Return-Path: <linux-fsdevel+bounces-6166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969481416C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 06:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFFA1C224EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 05:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98926CA70;
	Fri, 15 Dec 2023 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NlgVj3lZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FECA67
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JXzQxLHevH68dO42XdUVB5vYL5Qg5ydIHQ224ZEZRa8=; b=NlgVj3lZLo4fGqFX2idshvNdPv
	gEBDePwrM9aMUBan8DzxZcp6L7XHbjOrF1bbxqdCI4XvEDtKoc3vLyJnRmJ8PRe1lsUnVvRvVU7w/
	USt7+UvDkkuJXUcn94BqW38kugORVMDbEhhW1LyvUNxb320wL2GRdxttYrio1SA+pivCPCkjx3fnG
	HTO+7+ixqtgMqH92Yj+bMHuk2LZSGk4tj5S9jyOdC4/NSVUkGZwg2Jal2uHGDXeCPCCSVjtXZCP8Z
	zpXzmFE/LXmXc5cNEHp/EJbzrqSKIjjkAVnjk9aEVNaFbW4sjZibS13KadBIMnQRyRiMTC0j0H/GU
	LzYI5gYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE0zJ-00Dz1O-Oj; Fri, 15 Dec 2023 05:43:53 +0000
Date: Fri, 15 Dec 2023 05:43:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Why does mpage_writepage() not handle locked buffers?
Message-ID: <ZXvnmfXG4xN8BQxI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I tried this:

-static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
+static int blkdev_writepages(struct address_space *mapping,
+               struct writeback_control *wbc)
 {
-       return block_write_full_page(page, blkdev_get_block, wbc);
+       return mpage_writepages(mapping, wbc, blkdev_get_block);
 }

and I hit the BUG_ON(buffer_locked(bh)); in __mpage_writepage() which
has been there since you added it in 2002.

block_write_full_page() handles this fine, so why isn't this

	if (buffer_locked(bh))
		goto confused;

Is the thought that we hold the folio locked, therefore no buffers
should be locked at this time?  I don't know the rules.

In case it's relevant, I hit this while running xfstests generic/013
with ext4 and the stack backtrace is:

__mpage_writepage+0x18d/0x7c0
 write_cache_pages+0x17e/0x480
 mpage_writepages+0x44/0x80
 blkdev_writepages+0x10/0x20
 do_writepages+0xa9/0x150
 filemap_fdatawrite+0x70/0x80
 sync_bdevs+0x151/0x160
 ksys_sync+0x55/0x80


