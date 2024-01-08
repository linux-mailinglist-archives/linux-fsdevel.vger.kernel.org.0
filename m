Return-Path: <linux-fsdevel+bounces-7557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40DA8274A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3A283C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F9524AC;
	Mon,  8 Jan 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LdiwUq8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3781D524A7;
	Mon,  8 Jan 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/cpDn+ySfxlQPGGDlxhV/W8mRwKw5N/zUe55+TIbUnE=; b=LdiwUq8jg92CpSX4y/k9CaNugO
	yx6B6exjW4bG8lcy4suuh/Utl4Ok17Ge/anthY3W/oW4KHwfmM5a8CjkH2l9aiZwMzIR4aIw6V6lc
	cmJrNB0Cfp/UrA5zbGfBqVF25RCtXG376Xy9Y5ujJ6uhI4uzfRmibr4UmTz6xH7w9wK6Y+tqI1F3N
	42naVNnlxKEmKYVk4ePc2PNn9haTssNderpOo669QCACjHnrH1Q1P6HlxlCYR/x/YXVtm69AhflFr
	V3Fi3at6PsJ4VbKST5GC3ACVDDPAui13407SXDjwjilmgXtehyntF7rPIeUV3zBAPwJC2qboFyUeF
	TinYbfAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMsBR-007rZC-Vk; Mon, 08 Jan 2024 16:09:02 +0000
Date: Mon, 8 Jan 2024 16:09:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] buffer: Fix __bread() kernel-doc
Message-ID: <ZZweHfmMWnlBFKdV@casper.infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-5-willy@infradead.org>
 <20240108145808.2k4rob3ntdknrkp3@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108145808.2k4rob3ntdknrkp3@localhost>

On Mon, Jan 08, 2024 at 03:58:08PM +0100, Pankaj Raghav (Samsung) wrote:
> On Thu, Jan 04, 2024 at 04:36:51PM +0000, Matthew Wilcox (Oracle) wrote:
> > The extra indentation confused the kernel-doc parser, so remove it.
> > Fix some other wording while I'm here, and advise the user they need to
> > call brelse() on this buffer.
> > 
> It looks like __bread_gfp has the same problem:

I'm happy to incorporate this patch, but I'll need your S-o-B on it.

> diff --git a/fs/buffer.c b/fs/buffer.c
> index 967f34b70aa8..cfdf45cc290a 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1446,16 +1446,18 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
>  EXPORT_SYMBOL(__breadahead);
>  
>  /**
> - *  __bread_gfp() - reads a specified block and returns the bh
> - *  @bdev: the block_device to read from
> - *  @block: number of block
> - *  @size: size (in bytes) to read
> - *  @gfp: page allocation flag
> + * __bread_gfp() - Read a block.
> + * @bdev: The block device to read from.
> + * @block: Block number in units of block size.
> + * @size: Block size in bytes.
>   *
> - *  Reads a specified block, and returns buffer head that contains it.
> - *  The page cache can be allocated from non-movable area
> - *  not to prevent page migration if you set gfp to zero.
> - *  It returns NULL if the block was unreadable.
> + * Read a specified block, and return the buffer head that refers to it.
> + * The memory can be allocated from a non-movable area to not to prevent
> + * page migration if you set gfp to zero. The buffer head has its
> + * refcount elevated and the caller should call brelse() when it has
> + * finished with the buffer.
> + *
> + * Return: NULL if the block was unreadable.
>   */
>  struct buffer_head *
>  __bread_gfp(struct block_device *bdev, sector_t block,
> (END)
> 
> Another option is to just change this in __bread_gfp() and add a See
> __bread_gfp() in __bread()?

