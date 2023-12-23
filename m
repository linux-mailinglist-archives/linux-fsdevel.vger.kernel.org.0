Return-Path: <linux-fsdevel+bounces-6855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DE81D611
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C0B2834E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202816411;
	Sat, 23 Dec 2023 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mLUUfEd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607212E4C
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Dec 2023 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Dec 2023 13:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703356772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nl8KqWKpD6wWjbvJJznLUba3EPd6rpJb9056eV80EZI=;
	b=mLUUfEd7gfPYDe3oleQ9tbdyTO5xnWBH1tZ17cgI4qqbATl0NNgyxkk9s86/LqjribMhXF
	icSGv6krf/Bb8nP/Rk+sLamzbNdocnFQ0i9s/yQOF2bzXjM3YAZVaDOCpBwjSIvilLWEoR
	/klCC3TPr9UUNblk28yYvK2TJLs04lQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, 
	roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com, joern@lazybastard.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, 
	hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org, nico@fluxnic.net, 
	xiang@kernel.org, chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.com, konishi.ryusuke@gmail.com, akpm@linux-foundation.org, 
	hare@suse.de, p.raghav@samsung.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 09/17] btrfs: use bdev apis
Message-ID: <j52xmye4qmjqv4mq524ppvqr7naicobnwn2qfcvftbj4zoowga@t6klttrjtq2d>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-10-yukuai1@huaweicloud.com>
 <ZYcZi5YYvt5QHrG9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYcZi5YYvt5QHrG9@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 23, 2023 at 05:31:55PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 21, 2023 at 04:57:04PM +0800, Yu Kuai wrote:
> > @@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> >  		 * Drop the page of the primary superblock, so later read will
> >  		 * always read from the device.
> >  		 */
> > -		invalidate_inode_pages2_range(mapping,
> > -				bytenr >> PAGE_SHIFT,
> > +		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
> >  				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> >  	}
> >  
> > -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> > -	if (IS_ERR(page))
> > -		return ERR_CAST(page);
> > +	nofs_flag = memalloc_nofs_save();
> > +	folio = bdev_read_folio(bdev, bytenr);
> > +	memalloc_nofs_restore(nofs_flag);
> 
> This is the wrong way to use memalloc_nofs_save/restore.  They should be
> used at the point that the filesystem takes/releases whatever lock is
> also used during reclaim.  I don't know btrfs well enough to suggest
> what lock is missing these annotations.

Yes, but considering this is a cross-filesystem cleanup I wouldn't want
to address that in this patchset. And the easier, more incremental
approach for the conversion would be to first convert every GFP_NOFS
usage  to memalloc_nofs_save() like this patch does, as small local
changes, and then let the btrfs people combine them and move them to the
approproate location in a separate patchstet.

