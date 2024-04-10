Return-Path: <linux-fsdevel+bounces-16622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8218C8A0374
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E701F2198A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57131C132;
	Wed, 10 Apr 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nf5BVEZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60B138E;
	Wed, 10 Apr 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788497; cv=none; b=Qq5AKk02Z0jqhBmTHCG8R9bCKIACgD94snvGbY+4Wq3LA8eBjFSMp+a8+0ydeOCyByi8h/taM3a2kRMg2TtmSvXl2+eZzaeMLrjXRNFibjy9p6G6oHqc+dEVYT25Gr5+UZyDrwxFVBMlttM133NWk6ukdERGHJnFaLri5a2vn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788497; c=relaxed/simple;
	bh=YwjSIF6uNkmERIG6wemPayCWKzdumqsoRdlNbYrNtq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/YSzHt3j8aB1CvpXgm5kGBPs9Alp/8ENKIwKNsevxRcDVCfP2gDnjKFgMiVG4VDKTi/u40bWFGViP3e3cTQ5DrJIOx/psGk4ljUVVWNMyxIy9zq1ty86kG56Go1MCNBrpXrUOUqBbPNFP4tr+gIo7T1aR0w3jtVg0v08Ln+YSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nf5BVEZo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kj+przKbqCXrTRwHHIpeY1LGxOoNJlbD1H09dWLhQzE=; b=nf5BVEZoTRCF+PO83UAnMi3dGl
	WFuTpaRHmPeAjby4OWjDvW3H1OZIZ8VCwX4xhGq7Tl1gSimArLH5a0oB4uRZRB7ufXOYdXyG8Tth0
	gMvjlCpKocwtYPts0JDSBGSk4yKdWRjit/PJiWtjVrYnM4rdYgXxHhmkV2FYm89gaACBv4mV1W1Mz
	ZZav6kQ49A3YGvFyY0wN0MQXe2fgliRb6UBAhG0Eju7mgBmb5vEKbRKttSJU41ZI169V708rUDik5
	P6XMmOfJMI43nH3Qx3q++Gh6q6vVY7DbXYpWTOuSJQn+0AbRUy4+L/WJ7LWbDjGQoO7SjWA+h/58x
	pops+QUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rugWh-00A87p-1r;
	Wed, 10 Apr 2024 22:34:43 +0000
Date: Wed, 10 Apr 2024 23:34:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, brauner@kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240410223443.GG2118490@ZenIV>
References: <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410105911.hfxz4qh3n5ekrpqg@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 10, 2024 at 12:59:11PM +0200, Jan Kara wrote:

> I agree with Christian and Al - and I think I've expressed that already in
> the previous version of the series [1] but I guess I was not explicit
> enough :). I think the initial part of the series (upto patch 21, perhaps
> excluding patch 20) is a nice cleanup but the latter part playing with
> stashing struct file is not an improvement and seems pointless to me. So
> I'd separate the initial part cleaning up the obvious places and let
> Christian merge it and then we can figure out what (if anything) to do with
> remaining bd_inode uses in fs/buffer.c etc. E.g. what Al suggests with
> bd_mapping makes sense to me but I didn't check what's left after your
> initial patches...

FWIW, experimental on top of -next:
Al Viro (7):
      block_device: add a pointer to struct address_space (page cache of bdev)
      use ->bd_mapping instead of ->bd_inode->i_mapping
      grow_dev_folio(): we only want ->bd_inode->i_mapping there
      gfs2: more obvious initializations of mapping->host
      blkdev_write_iter(): saner way to get inode and bdev
      blk_ioctl_{discard,zeroout}(): we only want ->bd_inode->i_mapping here...
      dm-vdo: use bdev_nr_bytes(bdev) instead of i_size_read(bdev->bd_inode)

Yu Kuai (4):
      ext4: remove block_device_ejected()
      block: move two helpers into bdev.c
      bcachefs: remove dead function bdev_sectors()
      block2mtd: prevent direct access of bd_inode	[slightly modified]

leaves only this:
block/bdev.c:60:        struct inode *inode = bdev->bd_inode;
block/bdev.c:137:       loff_t size = i_size_read(bdev->bd_inode);
block/bdev.c:144:       bdev->bd_inode->i_blkbits = blksize_bits(bsize);
block/bdev.c:158:       if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
block/bdev.c:160:               bdev->bd_inode->i_blkbits = blksize_bits(size);
block/bdev.c:415:       bdev->bd_inode = inode;
block/bdev.c:434:       i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
block/bdev.c:444:       bdev->bd_inode->i_rdev = dev;
block/bdev.c:445:       bdev->bd_inode->i_ino = dev;
block/bdev.c:446:       insert_inode_hash(bdev->bd_inode);
block/bdev.c:974:       bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
block/bdev.c:980:       ihold(bdev->bd_inode);
block/bdev.c:1257:      return !inode_unhashed(disk->part0->bd_inode);
block/bdev.c:1263:      return 1 << bdev->bd_inode->i_blkbits;
block/genhd.c:659:              remove_inode_hash(part->bd_inode);
block/genhd.c:1194:     iput(disk->part0->bd_inode);    /* frees the disk */
block/genhd.c:1384:     iput(disk->part0->bd_inode);
block/partitions/core.c:246:    iput(dev_to_bdev(dev)->bd_inode);
block/partitions/core.c:472:    remove_inode_hash(part->bd_inode);
block/partitions/core.c:658:            remove_inode_hash(part->bd_inode);
drivers/s390/block/dasd_ioctl.c:218:            block->gdp->part0->bd_inode->i_blkbits =
fs/buffer.c:192:        struct inode *bd_inode = bdev->bd_inode;
fs/buffer.c:1699:       struct inode *bd_inode = bdev->bd_inode;
fs/erofs/data.c:73:             buf->inode = sb->s_bdev->bd_inode;
fs/nilfs2/segment.c:2793:       inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);

I've got erofs patches that get rid of that instance; bdev.c is obviously priveleged
since it sees coallocated inode directly.  Other than those we have
	* 3 callers of remove_inode_hash()
	* 3 callers of iput()
	* one caller of inode_attach_wb() (nilfs2)
	* weird shit in DASD (redundant, that; incidentally, I don't see anything
	  that might prevent DASD format requested with mounted partitions on that
	  disk - and won't that be fun and joy for an admin to step into...)
	* two places in fs/buffer.c that want to convert block numbers to positions
	  in bytes.  Either the function itself or its caller has the block size
	  as argument; replacing that to passing block _shift_ instead of size
	  would reduce those two to ->bd_mapping.
And that's it.  iput() and remove_inode_hash() are obvious candidates for
helpers (internal to block/*; no exporting those, it's private to bdev.c,
genhd.c and paritions/core.c).

fs/buffer.c ones need a bit more code audit (not quite done with that), but
it looks at least plausible.  Which would leave us with whatever nilfs2 is
doing and that weirdness in dasd_format() (why set ->i_blkbits but not
->i_blocksize?  why not use set_blocksize(), for that matter?  where the
hell is check for exclusive open?)

