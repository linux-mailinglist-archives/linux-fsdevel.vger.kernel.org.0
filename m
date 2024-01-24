Return-Path: <linux-fsdevel+bounces-8808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A168683B27C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26821C22D4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BE13340C;
	Wed, 24 Jan 2024 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jgRtZ6pC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928E132C20
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125767; cv=none; b=BsHeiKpW7ULFPxzYbQCEleY2ot7xibu1nEtwmMCIpSd9UCEEdFrx5M3T+JnATpRCIYQEYlaF8T6XaK8F/hmz/qH7HgWteHnJB17j2jgRGIBjGkwsR0grupqjsqe+VaXZxR4LNmBJrlWxXKw2pAS9Q1JYXAjFVTDUnviehw/222o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125767; c=relaxed/simple;
	bh=CJU2Hl52ARq0CPgIV2SfUxZLEv2pHIQMrNTpWq8GCbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXNzhskOZgtlHagL5b1Ivhcv3U2h/3GVqOlBl41bBhu0RouUdiQpK/jmTLbrlIr/rxnMuaH69Kv53YViHVs1B2FBC4NMmGhdkX9TOo0AZa+5uWvf4spbuWomQdFScNHqPI876r+baGPLF65KdaeQDGy1jLAw/vNijsBuBMHBhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jgRtZ6pC; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jan 2024 14:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706125762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90tx2JOK6zp8F9uDeHo0W3wTSrKFobNnyX2HRm8aTdQ=;
	b=jgRtZ6pCS3VvbJOc46YOiQ1lmfDMrTEnxp7URywB/r5uaSApjbOCykBeR0kIhynpjApksJ
	xzTcHDydnqv8DFLG12urRRGthHiXoM3Vi3Y3N9CKtQmBygRn+ztiN9yWIpMKxR/hvV3xsa
	ltTTa6Npp0ewZrzE3pcDMkQX9Vq1Uq0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: david@fromorbit.com, willy@infradead.org, wedsonaf@gmail.com, 
	viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, brauner@kernel.org, 
	kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	walmeida@microsoft.com
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <6hk53ozdm474tft2sewuxo6vlgeb3cbafzfl6gex4ogufkvped@bgzciwbgncsf>
References: <ZZ2dsiK77Se65wFY@casper.infradead.org>
 <ZZ3GeehAw/78gZJk@dread.disaster.area>
 <zdc66q6svna4t5zwa5hkxc72evxqplqpra5j47wq33hidspnjb@r4k7dewzjm7e>
 <20240124.220835.478444598271791659.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124.220835.478444598271791659.fujita.tomonori@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 24, 2024 at 10:08:35PM +0900, FUJITA Tomonori wrote:
> On Wed, 10 Jan 2024 14:19:41 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Wed, Jan 10, 2024 at 09:19:37AM +1100, Dave Chinner wrote:
> >> On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
> >> > On Tue, Jan 09, 2024 at 04:13:15PM -0300, Wedson Almeida Filho wrote:
> >> > > On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> > > > No.  This "cleaner version on the Rust side" is nothing of that sort;
> >> > > > this "readdir doesn't need any state that might be different for different
> >> > > > file instances beyond the current position, because none of our examples
> >> > > > have needed that so far" is a good example of the garbage we really do
> >> > > > not need to deal with.
> >> > > 
> >> > > What you're calling garbage is what Greg KH asked us to do, namely,
> >> > > not introduce anything for which there are no users. See a couple of
> >> > > quotes below.
> >> > > 
> >> > > https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
> >> > > The best feedback is "who will use these new interfaces?"  Without that,
> >> > > it's really hard to review a patchset as it's difficult to see how the
> >> > > bindings will be used, right?
> >> > > 
> >> > > https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
> >> > > And I'd recommend that we not take any more bindings without real users,
> >> > > as there seems to be just a collection of these and it's hard to
> >> > > actually review them to see how they are used...
> >> > 
> >> > You've misunderstood Greg.  He's saying (effectively) "No fs bindings
> >> > without a filesystem to use them".  And Al, myself and others are saying
> >> > "Your filesystem interfaces are wrong because they're not usable for real
> >> > filesystems".
> >> 
> >> And that's why I've been saying that the first Rust filesystem that
> >> should be implemented is an ext2 clone. That's our "reference
> >> filesystem" for people who want to learn how filesystems should be
> >> implemented in Linux - it's relatively simple but fully featured and
> >> uses much of the generic abstractions and infrastructure.
> >> 
> >> At minimum, we need a filesystem implementation that is fully
> >> read-write, supports truncate and rename, and has a fully functional
> >> userspace and test infrastructure so that we can actually verify
> >> that the Rust code does what it says on the label. ext2 ticks all of
> >> these boxes....
> > 
> > I think someone was working on that? But I'd prefer that not to be a
> > condition of merging the VFS interfaces; we've got multiple new Rust
> > filesystems being implemented and I'm also planning on merging Rust
> > bcachefs code next merge window.
> 
> It's very far from a fully functional clone of ext2 but the following
> can do simple read-write to/from files and directories:
> 
> https://github.com/fujita/linux/tree/ext2-rust/fs/ext2rust
> 
> For now, all of the code is unsafe Rust, using C structures directly
> but I could update the code to see how well Rust VFS abstractions for
> real file systems work.

I think that would be well received. I think the biggest hurdle for a
lot of people is going to be figuring out the patterns for expressing
old idioms in safe rust - a version of ext2 in safe Rust would be the
perfect gentle introduction for filesystem people.

And if it achieved feature parity with fs/ext2, there'd be a strong
argument for it eventually replacing fs/ext2 so that we can more safely
mount untrusted filesystem images.

