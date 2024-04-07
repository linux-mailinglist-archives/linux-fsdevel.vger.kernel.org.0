Return-Path: <linux-fsdevel+bounces-16312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4989AE28
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 05:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7608CB22726
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D21C32;
	Sun,  7 Apr 2024 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cqNtUitt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E01C0DC3;
	Sun,  7 Apr 2024 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459186; cv=none; b=u3olQdGEI0DmLBxhgwiSHyjj8yqCiiYSJbWXnwkWKI+BKws4uMPApQWP1nhlrM3qwTzp5GP0sCI4jsYC2OdwCG7MkHa0DSpx06t4CuTFPPIdxV4lKkPfLlcrxDFOQsSLrhUWMjF6i4jJof/IvO3PZ0fhWngpmUPBUtpZWgc/11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459186; c=relaxed/simple;
	bh=LxMxC0gWWe8OZQXnt8cp5I2UaKMknVyUH+bEJYGi4n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFw4HQfKWH6LxcAU71oQjGNWax7va5VvhwAf4J31zTxVIEA3NExpRuxrl9MvOfNsgHDP5RXQQPne119prcJ2cZRT7vEScHizbv+aGu9ru0+oxchkrVWh/DdoV+u1bP+lk+y8a0kjbo38cOndDnUDk0i65KV3zHr3gLha0wQGkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cqNtUitt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2g944MBeo/tBWBRCgWeQA9CcS0zs1LmcvuY+A1PoLRM=; b=cqNtUitterRF1F2a6OkPucbBwQ
	Ke5h7qSn6fNHqnXTc/eh8mGrLvCaccuMq+P7aLrAEd2Q6T/YXZe5VhpD4X+42ZYqO3O2UZyhRCciT
	uRk2Gut9VDAk8PZJrsM557+vUZ+kt588pcKCNngwhk8Xm6LnmBYW8zfNs9kNOI75RpYBTUaxLgxXq
	KFYj9gFuwqAka+hbGLSBE8O/iL0SN+lYibxps3nPOoAe16LibTrAlmnfJK242WQSjcRNEQL+yHpMc
	uOhj9AyZnOjdFwXZ9jnM8brT61VvjpLUgLYYmweIg+jvtG2AfJu7eLr3qO/ApmXhcoJac08hi9NMA
	FJfwyW9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtIrC-007Z3c-2Z;
	Sun, 07 Apr 2024 03:06:10 +0000
Date: Sun, 7 Apr 2024 04:06:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240407030610.GI538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:

> Other than raw block_device fops, other filesystems can use the opened
> bdev_file directly for iomap and buffer_head, and they actually don't
> need to reference block_device anymore. The point here is that whether

What do you mean, "reference"?  The counting reference is to opened
file; ->s_bdev is a cached pointer to associated struct block_device,
and neither it nor pointers in buffer_head are valid past the moment
when you close the file.  Storing (non-counting) pointers to struct
file in struct buffer_head is not different in that respect - they
are *still* only valid while the "master" reference is held.

Again, what's the point of storing struct file * in struct buffer_head
or struct iomap?  In any instances of those structures?

There is a good reason to have it in places that keep a reference to
opened block device - the kind that _keeps_ the device opened.  Namely,
there's state that need to be carried from the place where we'd opened
the sucker to the place where we close it, and that state is better
carried by opened file.

But neither iomap nor buffer_head contain anything of that sort -
the lifetime management of the opened device is not in their
competence.  As the matter of fact, the logics around closing
those opened devices (bdev_release()) makes sure that no
instances of buffer_head (or iomap) will outlive them.
And they don't care about any extra state - everything
they use is in block_device and coallocated inode.

I could've easily missed something in one of the threads around
the earlier iterations of the patchset; if that's the case,
could somebody restate the rationale for that part and/or
post relevant lore.kernel.org links?  Christian?  hch?
What am I missing here?

