Return-Path: <linux-fsdevel+bounces-16299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B289ACE4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 22:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09ECB22821
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D714EB2C;
	Sat,  6 Apr 2024 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uCieu2YL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E83032A;
	Sat,  6 Apr 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435403; cv=none; b=TqEHAmCexcRryy1kD4MihwE+WtrUmqiay7Ak8lCvBiq8TtN8XCNzE+iyLjqe0l5VRtNbVoeWD/yeMJMlccjtn9zjl1pJZ7vrvMgvb/lriyunNN9uHDgCcFXW2rAhF6f/1/aTBU5mxrtgUwVsvXGyIlOtwZ64+Rx0D2DuICbZlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435403; c=relaxed/simple;
	bh=2BQmG4KvgAy76c2YSrZe2D4OuetRg/85hZRf1vxAJ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4gQyltbDndAaRcn1+CkBaED8WZX12R1pbMmHlHteTLFy1jIcwb3b6G7O+Kl9U5zunUCaYYC1IcNPrDzqLZuVM0mkKYLI3alJP44R/E/0YqlNn04wmov4KDnHAFBMiH//u5xYxKe+OVlymUWS2v9tpR74GAoZaZQJG49J640sEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uCieu2YL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u3IfDifdplkI2ZJfWb0SgdVLmEl7jnLBJ5yyynRXfbU=; b=uCieu2YLp7IHcJB/N9KhsFoJcW
	4L0fTM3QTNxypXRuBaFkCI0vqZVAD8YZOzIZAVqWkeFrRMVqYADHna0hBrLvLqCWN0Gzz2laHm2m6
	0H62dRtcdd27KRQnmknDaHMGnHAnid74Q5znh664cbMXDVdfc0GObsC2SerfBRaXSb+zPHP76HWzj
	Qr1fW3/3d3Y5nMO/bBBIKKg3vjJYbC8TCjG5BCAbpFkInOYTmomUgHQ6xl5AHPjooplGNsj1fqsnO
	icoYDpSsViPP0e4UgmxrTFd5CvX91Nxfe6iMgBWUGdEUok2O5+IqDYBRaJPjjB1PDDDpS96oUkP7t
	6MUlPRFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtCfb-007OA0-1j;
	Sat, 06 Apr 2024 20:29:47 +0000
Date: Sat, 6 Apr 2024 21:29:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240406202947.GD538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406194206.GC538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 08:42:06PM +0100, Al Viro wrote:
> On Sat, Apr 06, 2024 at 05:09:26PM +0800, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > So that iomap and bffer_head can convert to use bdev_file in following
> > patches.
> 
> Let me see if I got it straight.  You introduce dummy struct file instances
> (no methods, nothing).  The *ONLY* purpose they serve is to correspond to
> opened instances of struct bdev.  No other use is possible.
> 
> You shove them into ->i_private of bdevfs inodes.  Lifetime rules are...
> odd.
> 
> In bdev_open() you arrange for such beast to be present.  You never
> return it anywhere, they only get accessed via ->i_private, exposing
> it at least to fs/buffer.c.  Reference to those suckers get stored
> (without grabbing refcount) into buffer_head instances.
> 
> And all of that is for... what, exactly?

Put another way, what's the endgame here?  Are you going to try and
propagate those beasts down into bio_alloc()?  Because if you do not,
you need to keep struct block_device * around anyway.

We use ->b_bdev for several things:
	* passing to bio_alloc() (quite a few places)
	* %pg in debugging printks
	* (rare) passing to write_boundary_block().
	* (twice) passing to clean_bdev_aliases().
	* (once) passing to __find_get_block().
	* one irregular use as a key in lookup_bh_lru()

IDGI...

