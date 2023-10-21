Return-Path: <linux-fsdevel+bounces-866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A07D1ACE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 07:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F66DB21596
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95D1383;
	Sat, 21 Oct 2023 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vy9fRtEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B95808
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 05:08:51 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED231BF;
	Fri, 20 Oct 2023 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z8f9uaKwD9ppL0C1CqjKBJdH1gJN+2UHJiY2wGmwdxA=; b=Vy9fRtEKCTjI8FDUW5pt/h3hbe
	NhaaVm6bQmr6DXy+p81klmEehmrI35qJ7hxpaIt5/jEHYZ6b1pXPBZ/bsp2h6VvyVr861ZOV3ePas
	B1zk1Ho42Kue7H7KhuAkoNKrHZcQXTOrmpa0z+9hLsu2LaDUYmwMqBGWItieLEvVKLJ7DOj+yvx78
	LiPoXYyuw83dGgyxDZXnMGQW4Aj0Y1hT2KflGs7MPM4RXDAkoIboGQ2G81yttk3KhIQF+4iMe3Dp3
	BE/mmXWZyoOeRHiCuUnTjmxg9Tx+Tj7uf0+uvW80odS6yZ+dZ86ylW83eWDM+bjAtQXhM+u9UUxpH
	K9utjqJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qu4E1-00HIF4-NU; Sat, 21 Oct 2023 05:08:37 +0000
Date: Sat, 21 Oct 2023 06:08:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fs/buffer.c: use accessor function to translate
 page index to sectors
Message-ID: <ZTNc1SIMOkU+CCvX@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-5-hare@suse.de>
 <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>

On Fri, Oct 20, 2023 at 08:37:26PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:04:56PM +0200, Hannes Reinecke wrote:
> > Use accessor functions block_index_to_sector() and block_sector_to_index()
> > to translate the page index into the block sector and vice versa.
> 
> You missed two in grow_dev_page() (which I just happened upon):

I have fixes here.  The key part of the first patch is:

 static sector_t folio_init_buffers(struct folio *folio,
-               struct block_device *bdev, sector_t block, int size)
+               struct block_device *bdev, int size)
 {
        struct buffer_head *head = folio_buffers(folio);
        struct buffer_head *bh = head;
        bool uptodate = folio_test_uptodate(folio);
+       sector_t block = folio_pos(folio) / size;
        sector_t end_block = blkdev_max_block(bdev, size);

(and then there's the cruft of removing the arguments from
folio_init_buffers)

The second patch is:

 static bool grow_buffers(struct block_device *bdev, sector_t block,
                unsigned size, gfp_t gfp)
 {
-       pgoff_t index;
-       int sizebits;
-
-       sizebits = PAGE_SHIFT - __ffs(size);
-       index = block >> sizebits;
+       loff_t pos;
[...]
-       if (unlikely(index != block >> sizebits)) {
+       if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {

I'll send a proper patch series tomorrow once the fstests are done
running.

