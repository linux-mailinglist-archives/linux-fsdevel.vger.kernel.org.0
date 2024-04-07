Return-Path: <linux-fsdevel+bounces-16320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAF89AEAA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 07:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065ABB219ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9436AB9;
	Sun,  7 Apr 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mqutEJmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B921876;
	Sun,  7 Apr 2024 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712467303; cv=none; b=jdKBzPH0V3aOw2nfRJRdAldImXn48ZGp0i0Nf2jJ998umPCAmx4BseUMM7xR9SGhR+TxcVqYqQubtNbddgra13nXxbBKj7PEX6/UdBP6smSpadmvE4QzWQEKDSSqsL6ZLfKKiO+WP4BGfKgF7NPguq5jBDaYsq79YHOOGIMVJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712467303; c=relaxed/simple;
	bh=ujk7DSuKVcPRG2wlyqBMd8YB/i8MCyZkjnXuAJsWi4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OszcucS6MBb2Ks8DP21jtVLdy5j73Gh7zxsux+//QkygRv/PdLTEu3/ydrpJqSGYrE84IRFtnEBiDWKVGUe7q9sO2Sw0uK308oeZx4+RDM5JP8GJjvy+DNj0oYBVfXbNqDr2zIrP4WBOZzgVuGtlsfsrtzg/lP3iPp4vAHVuQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mqutEJmN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=huWoGSBEymltKqBrtCrxk2uX4uO2jpl6CW0VFMMyyOc=; b=mqutEJmNFIr2v7gBSjVCMUqcDV
	xsPe04ijls8Ap0J5IcmyYdK8EZ1tvK2jR/PYBcoBlBgnexAtUkoUTi0T8xZim0fu+LOWPFnV88A+Z
	CBPgjtnddrY5sTXr7PpFNwL8j7TbJcCt9JvYbCIejzL9+ymRxyYjDywSxZlhbzFtPwuWjVRRn1WAs
	UVH854MWKDSgR0F+E0hc6+qw4TxQ5Y716cCBeG9M1uQlzNAmK3g3ZZDycn7mIyfBaNy1xOLVb3OIH
	w8pvQDEs1HG28rdIW6WT8JuhxAktTe/Afy9MaYI3ZRcR882rRrP/Ooq1zVUaHYBmikI9HTxKEVv4O
	UAoqcHEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtKyC-007cdB-33;
	Sun, 07 Apr 2024 05:21:33 +0000
Date: Sun, 7 Apr 2024 06:21:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240407052132.GM538574@ZenIV>
References: <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240407045758.GK538574@ZenIV>
 <20240407051119.GL538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407051119.GL538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 06:11:19AM +0100, Al Viro wrote:
> On Sun, Apr 07, 2024 at 05:57:58AM +0100, Al Viro wrote:
> 
> > PS: in grow_dev_folio() we probably want
> > 	struct address_space *mapping = bdev->bd_inode->i_mapping;
> > instead of
> > 	struct inode *inode = bdev->bd_inode;
> > as one of the preliminary chunks.
> > FWIW, it really looks like address_space (== page cache of block device,
> > not an unreasonably candidate for primitive) and block size (well,
> > logarithm thereof) cover the majority of what remains, with device
> > size possibly being (remote) third...
> 
> Incidentally, how painful would it be to switch __bread_gfp() and __bread()
> to passing *logarithm* of block size instead of block size?  And possibly
> supply the same to clean_bdev_aliases()...
> 
> That would reduce fs/buffer.c uses to just "give me the address_space of
> that block device"...

... and from what I've seen in your series, it very much looks like after
that we could replace ->bd_inode with ->bd_mapping, turning your bdev_mapping()
into an inline and (hopefully) leaving the few remaining uses of bdev_inode()
outside of block/bdev.c _not_ on hot paths.  If nothing else, it would
make it much easier to grep for remaining odd stuff.

Might trim the btrfs parts of the series, at that - a lot of that seems to
be "how do we propagate opened file instead of just bdev, so that we could
get to its ->f_mapping deep in call chain"...

Again, all of that is only if __bread...() conversion to log(size) is feasible
without a massive PITA - there might be dragons...

