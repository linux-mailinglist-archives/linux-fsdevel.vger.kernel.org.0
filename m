Return-Path: <linux-fsdevel+bounces-3283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF347F24E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA5AB21B16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 04:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EAD12B9C;
	Tue, 21 Nov 2023 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUhQ808i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55892BD;
	Mon, 20 Nov 2023 20:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ew2km67eAiikun7xkP35RhIFrsku7QzUiSyeUEeOQZ0=; b=TUhQ808izwWLTqqqk5RRp4WQhd
	OHodLXsU7fEBZyNUI18FGrS1h6du8gsJ84fHRzJV5h5s01XN20N+mVrAwCa5IxRprXkWmkTCyJjlR
	gJJak+Lwyf6Tb+aX79gSpvgtAcOLNfFKnDgmAp5JfTKMHT+TP3avKlVTy24xWVVqZWBAVmZSMrPim
	lNeKGjkO9ZNyPBk78CjX0rC0QzrHDlbDG3hhd1rlugPuaCKCUfj/AfJ6u/om1rv3poe7bgzJerLva
	uFi29uC+JaiA4epbyJx+A1U3tmQDdXGNEggDMmGi5aZCi7SmSPpOauNDbei8EcrlQnUqOec4KZlc9
	hXc/rVRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Id5-00Fc8E-1p;
	Tue, 21 Nov 2023 04:44:55 +0000
Date: Mon, 20 Nov 2023 20:44:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZVw1xxNYQuHimSmx@infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 21, 2023 at 12:35:20AM +0530, Ritesh Harjani (IBM) wrote:
> - mmap path of ext2 continues to use generic_file_vm_ops

So this means there are not space reservations taken at write fault
time.  While iomap was written with the assumption those exist, I can't
instantly spot anything that relies on them - you are just a lot more
likely to hit an -ENOSPC from ->map_blocks now.  Maybe we should add
an xfstests that covers the case where we use up more then the existing
free space through writable mmaps to ensure it fully works (where works
means at least as good as the old behavior)?

> +static ssize_t ext2_buffered_write_iter(struct kiocb *iocb,
> +					struct iov_iter *from)
> +{
> +	ssize_t ret = 0;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret > 0)
> +		ret = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
> +	inode_unlock(inode);
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +	return ret;
> +}

Not for now, but if we end up doing a bunch of conversation of trivial
file systems, it might be worth to eventually add a wrapper for the
above code with just the iomap_ops passed in.  Only once we see a few
duplicates, though.

> +static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
> +				 struct inode *inode, loff_t offset)
> +{
> +	if (offset >= wpc->iomap.offset &&
> +	    offset < wpc->iomap.offset + wpc->iomap.length)
> +		return 0;
> +
> +	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> +				IOMAP_WRITE, &wpc->iomap, NULL);
> +}

Looking at gfs2 this also might become a pattern.  But I'm fine with
waiting for now.

> @@ -1372,7 +1428,7 @@ void ext2_set_file_ops(struct inode *inode)
>  	if (IS_DAX(inode))
>  		inode->i_mapping->a_ops = &ext2_dax_aops;
>  	else
> -		inode->i_mapping->a_ops = &ext2_aops;
> +		inode->i_mapping->a_ops = &ext2_file_aops;
>  }

Did yo run into issues in using the iomap based aops for the other uses
of ext2_aops, or are just trying to address the users one at a time?


