Return-Path: <linux-fsdevel+bounces-30031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9E98522E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 07:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B461C233EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 05:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19BB153573;
	Wed, 25 Sep 2024 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vTuQLCA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FB126F0A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727241117; cv=none; b=CT/MdbLu3hA5uFJ341j6lRblxezI2DbR28A5gpWNl/0nccrfsOTf09+gNdD/Z7GOv5ZGTBTx+0b03iTCnNYHlw+dTlwIydH6SSVnRVHRa7StU/M74W2nKWB1J+9jeoY1HyfT93oO1vHRsxbX8qykwJWIKUKGjTeWWnpy1sQU61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727241117; c=relaxed/simple;
	bh=y+ChMX0+rleZkB63xenF9trLvyQPrAmQQdMlNP+BCIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QntBBpoCu0pviVenjhpdsVmDZXDt47NGyAzj1yHDD9NIFE8pX7d7prbiPnu9pNbWUIwajWfnvU+0R7AmmQozMwGqYfY7QbZ1DpzxPuL6pfbz+La4rJi9QY3oi8SOZEpKfOdR2C8w+MiSwg9P6/8S8C/NhQFv9ly92G3YNRet74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vTuQLCA4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Sep 2024 01:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727241112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSPD4PAbZR3fJsUYh9z+aPUrs1JDoadE4IQRwhWQLNc=;
	b=vTuQLCA4Xxy9QL2g2wMJsTnCuEwsoB2NT/xx2vYgrv6AMJfcDk2ecmx7G8MquuafaWSrk6
	GjdFuYHM13El0ymGUKyNu44GokFrrpE8iUnFPaKwbaefJcwhuQnscF12grQbEG8BwfX79k
	odkA5ApYyR0eVEr/TPRBrJukMYXVGLE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <txlsptovy5x44urwd6vd2zey677m7fiqdykoalqosy3qkhbaji@p33zze2l3okt>
References: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>
 <ZvIzNlIPX4Dt8t6L@dread.disaster.area>
 <dia6l34faugmuwmgpyvpeeppqjwmv2qhhvu57nrerc34qknwlo@ltwkoy7pstrm>
 <ZvNgmoKgWF0TBXP8@dread.disaster.area>
 <v5lvhjauvcx27fcsyhyugzexdk7sik7an2soyxtx5dxj3oxjqa@gbvyu2kc7vpy>
 <ZvOU4+3IIn48g43v@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvOU4+3IIn48g43v@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 25, 2024 at 02:43:15PM GMT, Dave Chinner wrote:
> On Tue, Sep 24, 2024 at 10:13:01PM -0400, Kent Overstreet wrote:
> > On Wed, Sep 25, 2024 at 11:00:10AM GMT, Dave Chinner wrote:
> > > > Eh? Of course it'd have to be coherent, but just checking if an inode is
> > > > present in the VFS cache is what, 1-2 cache misses? Depending on hash
> > > > table fill factor...
> > > 
> > > Sure, when there is no contention and you have CPU to spare. But the
> > > moment the lookup hits contention problems (i.e. we are exceeding
> > > the cache lookup scalability capability), we are straight back to
> > > running a VFS cache speed instead of uncached speed.
> > 
> > The cache lookups are just reads; they don't introduce scalability
> > issues, unless they're contending with other cores writing to those
> > cachelines - checking if an item is present in a hash table is trivial
> > to do locklessly.
> 
> Which was not something the VFS inode cache did until a couple of
> months ago. Just because something is possible/easy today, it
> doesn't mean it was possible or viable 15-20 years ago.

We've been doing lockless hash table lookups for a lot longer than that.

> > But pulling an inode into and then evicting it from the inode cache
> > entails a lot more work - just initializing a struct inode is
> > nontrivial, and then there's the (multiple) shared data structures you
> > have to manipulate.
> 
> Yes, but to avoid this we'd need to come up with a mechanism that is
> generally safe for most filesystems, not just bcachefs.
> 
> I mean, if you can come up with a stat() mechanism that is safe
> enough for us read straight out the XFS buffer cache for inode cache
> misses, then we'll switch over to using it ASAP.

So add a per buffer lock to your buffer cache, and check for vfs cache
residency under the lock.

Whether bulkstat is worth adding that lock, for a filesystem that
doesn't need it? That I can't say, it's a tradeoff.

> That's your challenge - if you want bcachefs to be able to do this,
> then you have to make sure the infrastructure required works for
> other filesystems just as safely, too.

So... you think bcachefs should be limited to the capabilities of what
other filesystems can do? Interesting position...

