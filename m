Return-Path: <linux-fsdevel+bounces-18062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9728B50B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C51C2154B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACC1DDD2;
	Mon, 29 Apr 2024 05:23:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3DD530;
	Mon, 29 Apr 2024 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368201; cv=none; b=YkpBRWW6b2gfRCWSKFJLCtkjyWfIUlj6B7jH6BoRoVSnLonJLbLb9Gm0rAOj1Iv2EH87Qpp4uJ+r/w9waZTukmRJ3WYzcacYNFgQ9tsls1N80HgJvdcRjbdoUYbTKwfV1RhC+9aWrOz0BQWaLhKKzDBQLEFzUzAY/3+vrjBaCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368201; c=relaxed/simple;
	bh=BXgMnmnmV5l/kEn/ajQwVdxYpA/e8EPOFxKIkJQ0ebs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I41nH3s4JB4vyirngKLtyypxyAVplz+1U1rd9jXAN2R4iQ7bfxsoIB6hBeCEpgDZ+lwW7wlN9DRSwSwbwjNVWhKj51ynQiVMylYCvMSe0ALnRzQJTB6P8MctyPyR3q/nY3i2dd/Gz34/tMiBMFT7L6DzY8l6tv5UruryJ1OsIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2ACD227A87; Mon, 29 Apr 2024 07:23:15 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:23:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240429052315.GB32688@lst.de>
References: <20240428051232.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428051232.GU2118490@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 28, 2024 at 06:12:32AM +0100, Al Viro wrote:
> 	We have several bool members in struct block_device.
> It would be nice to pack that stuff, preferably without
> blowing the cacheline boundaries.
> 
> 	That had been suggested a while ago, and initial
> implementation by Yu Kuai <yukuai1@huaweicloud.com> ran into
> objections re atomicity, along with the obvious suggestion to
> use unsigned long and test_bit/set_bit/clear_bit for access.
> Unfortunately, that *does* blow the cacheline boundaries.
> 
> 	However, it's not hard to do that without bitops;
> we have an 8-bit assign-once partition number nearby, and
> folding it into a 32-bit member leaves us up to 24 bits for
> flags.  Using cmpxchg for setting/clearing flags is not
> hard, and 32bit cmpxchg is supported everywhere.

To me this looks pretty complicated and arcane.  How about we just
reclaim a little space in the block device and just keep bd_partno
and add an unsigned long base flags?

E.g. bd_meta_info is only used in slow path early boot and sysfs code
and just set for a few partitions.

Just turn it into a hash/xrray/whatever indexed by bd_dev and we've
already reclaimed enough space.


