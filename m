Return-Path: <linux-fsdevel+bounces-18071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D718B525F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817EF1F21E29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC314A83;
	Mon, 29 Apr 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l9BvLWjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5213AC5;
	Mon, 29 Apr 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375874; cv=none; b=g+TUG+3Phljeaw7n7IX8YYgRziXFhvcqOWxKTPgxo+m1uJimZ2ovJ7ASYIkKAWfpR00iiSh/wQKBlKbBgArNFNB+mPbo0RYYTiw+3+n6ANcq2aGOr+uHXyC46nIaSy1e6Lfbfzc9eaA6sJUX2ECGFW0fGravCHuu92vQSLC6mUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375874; c=relaxed/simple;
	bh=Rn229G1MrAFSOW7jk1YKb/eSOR4GeySma2G223farvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/b6MtnXrC2fpCYdGHXsIhT/HYzOo/wFh3hic3pJfmsvfBYtqvzR+YH2qrR/oY+Dui119ZcnzTdxFq1IfJQbCH16+aoPWiDvAYIgsPW4UO9rzLJ9asJRvGUIWKBBb0S6lQIPQA5oK8enIC1DmHI17MsOhjzKXX3WCzieONBvjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l9BvLWjf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WjWH/DEh5Ad+FnR7wUY6bk0viEmvMG0F/8p5Zq3qc/Q=; b=l9BvLWjf8X7yPFoutvd+5bybSE
	QrvxGEJMXJ2TT0148FLHbGzU9jXqp1PO0XqnBw6kdelCM63iiTq1a0nNwXssFfdQ49pvL8h2U7Kp9
	avtfP0iqD40QzT7x+Gf9fKiDnX4cO8cW87u3r5Uwnr3eIxk+SKYF96nPU7kfBX+h1RTgSEQ/ovjsk
	FjuQH5E/fimWfOizGlcPiyFCUfhoNFT3qNwbGS4WYX4x0aacT+m8rucl0aWoopqJDyrHSK1MBKN9l
	gZgkWBtGgnguN34eycuR6k/aNsknUIQEwzQZ0Zb0m7eWS/LFjw3SdKy+ICRnu5TDnZ6M6bWaQ5EXj
	UuG9QrIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1LTf-0076pI-1V;
	Mon, 29 Apr 2024 07:31:07 +0000
Date: Mon, 29 Apr 2024 08:31:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240429073107.GZ2118490@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429052315.GB32688@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 07:23:15AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 28, 2024 at 06:12:32AM +0100, Al Viro wrote:
> > 	We have several bool members in struct block_device.
> > It would be nice to pack that stuff, preferably without
> > blowing the cacheline boundaries.
> > 
> > 	That had been suggested a while ago, and initial
> > implementation by Yu Kuai <yukuai1@huaweicloud.com> ran into
> > objections re atomicity, along with the obvious suggestion to
> > use unsigned long and test_bit/set_bit/clear_bit for access.
> > Unfortunately, that *does* blow the cacheline boundaries.
> > 
> > 	However, it's not hard to do that without bitops;
> > we have an 8-bit assign-once partition number nearby, and
> > folding it into a 32-bit member leaves us up to 24 bits for
> > flags.  Using cmpxchg for setting/clearing flags is not
> > hard, and 32bit cmpxchg is supported everywhere.
> 
> To me this looks pretty complicated and arcane.

cmpxchg for setting/clearing a bit in u32 is hardly arcane,
especially since these bits are rarely modified.  _Reading_
is done on hot paths, but that's cheap.

For more familiar form,
static inline void bdev_set_flag(struct block_device *bdev, int flag)
{
	u32 *p = &bdev->__bd_flags;
        u32 c, old;

	c = *p;
	while ((old = cmpxchg(p, c, c | (1 << (flag + 8)))) != c)
		c = old;
}

to keep it closer to e.g. generic_atomic_or() and its ilk (asm-generic/atomic.h)
or any number of similar places.

FWIW, we could go for atomic_t there and use
	atomic_read() & 0xff
for partno, with atomic_or()/atomic_and() for set/clear and
atomic_read() & constant for test.  That might slightly optimize
set/clear on some architectures, but setting/clearing flags is
nowhere near hot enough for that to make a difference.

> How about we just
> reclaim a little space in the block device and just keep bd_partno
> and add an unsigned long base flags?
> 
> E.g. bd_meta_info is only used in slow path early boot and sysfs code
> and just set for a few partitions.
> 
> Just turn it into a hash/xrray/whatever indexed by bd_dev and we've
> already reclaimed enough space.

The problem is not the total size, though - it's blowing the first
cacheline.  With struct device shoved into that thing, a word or two
in total size is noise; keeping the fields read on the hot paths within
the first 64 bytes is not.

