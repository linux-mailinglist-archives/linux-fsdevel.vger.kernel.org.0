Return-Path: <linux-fsdevel+bounces-16318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5989AEA0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 07:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38F9B219E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 05:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107010A22;
	Sun,  7 Apr 2024 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OQoOiPFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F610795;
	Sun,  7 Apr 2024 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712466691; cv=none; b=EZkONgVxRZ/a3TvrfdPufGrtn4HkQ2O3Iy3fTVHzeLEZs29jywrQoaLVFhGCw7mCCbd2PsKdcvBiEcJGSBBTHevfyPUGCrLNphaaRWcFYRNjpfLrjZHl/MGEid1+Y/tOB77u1rGEA4vk2AaYr7du9N5FvOlb6P6m5hIHc4U/wQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712466691; c=relaxed/simple;
	bh=3Roj5F6z8RWZZzGYYmUdoA18hIYipOGJEobJkO3rBK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlhdgE8EbRQJaNTMvXeizUxdrh7Gq9b1utPbYQqJi7Yspqk/o37OGyOeBYBHjcnpTVGwgUY5Mf5ZEV4bR+bsN1vNpnhxo4Q/+KF44EE/D5G1VvYkhN/7+To66bQ/Vdobvt3/lmuGMfgmU/ISI4bNFUHdJ7jC71RMVgjQIUTzzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OQoOiPFG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zp1cKIilvWlXGuXBFY98ITzfX3vswqo1RvDkacebwSE=; b=OQoOiPFGJhw7OkHtucAKKdWMA4
	puoP/y+tjDEcut2nH4CzPu9H1hrXba2vC6IjAAWEF73Fj8haouu/x884r/bHH5FoIATfU1sspqh2n
	VpKCDEgT4LnIWUV52Ec+VfeAp7DgCQTljAJ9uhkh1rxIsIKCywSIH8avWnySllVCazzDd+BWQHaZZ
	v3jqa6Y4ZBBuY4Fu/zNPY4W/fHewoSRJnRlY1vtNUfuot/WxJ5fIAmKbG0rmBYIIBICBPjaBn90Hr
	0a5PDU/+sTyGzzY+T3LYbbOw/RmV2h2g2borR+L/8G6pHO7x7J6bqZPqVQ9waoe8jKe6hfwLwXaeu
	P+iRs5hg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtKoJ-007cNA-1i;
	Sun, 07 Apr 2024 05:11:19 +0000
Date: Sun, 7 Apr 2024 06:11:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240407051119.GL538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240407045758.GK538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407045758.GK538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 05:57:58AM +0100, Al Viro wrote:

> PS: in grow_dev_folio() we probably want
> 	struct address_space *mapping = bdev->bd_inode->i_mapping;
> instead of
> 	struct inode *inode = bdev->bd_inode;
> as one of the preliminary chunks.
> FWIW, it really looks like address_space (== page cache of block device,
> not an unreasonably candidate for primitive) and block size (well,
> logarithm thereof) cover the majority of what remains, with device
> size possibly being (remote) third...

Incidentally, how painful would it be to switch __bread_gfp() and __bread()
to passing *logarithm* of block size instead of block size?  And possibly
supply the same to clean_bdev_aliases()...

That would reduce fs/buffer.c uses to just "give me the address_space of
that block device"...

