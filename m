Return-Path: <linux-fsdevel+bounces-46400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E04EA88842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93941647CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE027F73F;
	Mon, 14 Apr 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="moGcroy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D21AAC9
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647280; cv=none; b=KzKD/Zy5kdNlzo/WJwSEQehOE6xD536vU59Df8pxlkiFgyseUcO6J8nm60aAGu6SQji4TDg9P9zyMOJ6JVxGPwjK2gA/DjlOeWKKM3JJD+oDEoQi4PYELTrBGaEbiYhhT33HqS2Y/aCufSvKILyjm8D0+2hPdHGQ/nM5DI47nqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647280; c=relaxed/simple;
	bh=HYX44cAlUGzz06XcvpeBhoArLNi5ITgcDrl75RRaVDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAvML/dJO8zT1YBKoqAXkZQ8uDIqvmG6ML7ColxttYqb5gOCNhSWrEHWyxUAHgN6ay0IM0rVbAMrA9zOSeSLJ+LMH20eXvjZx7Ok0T9JnwhoqBsx1j5FP+J4t5UNX6LSN2UxDWiIA4XQM6uxOQWj1HkkLV5v39Y2QVs2qaBdzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=moGcroy4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=l3fsDK/SgDcv/8e9T9UGtpM8KqCUafg3BsX/jJbq+Ro=; b=moGcroy4VlDdJnf4fJKzGuExKs
	G/14o0wLh5/tpW/4RJHnU5Zw1lD0Kyl8tHUHVeOMJHVq69atSwMkHxXi6TmKogHUVvxlkalLNj6jT
	QhgDdYlOE+MmIrLLoZSkhz4LnbUAEBJFfKngnldUChErdOugIkNLAJQ9lFFo8tNpzD7OvlaUBVIvX
	hskvqt3t/MTbx1gzUDIX4pZYI6W+cPEDqWi9NyHtFMZhHOF3vfxe2vvVRTnGy2OobegkmISMTugYU
	g6g+IxMx9EN2SQtvxV5ixzwGaClO+G3vnnqFAeQDEoY7ABec5tUoz2b7BLzw/w7Mp49Z7nwETTQor
	aKp38cKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4MSA-000000092u9-16ic;
	Mon, 14 Apr 2025 16:14:34 +0000
Date: Mon, 14 Apr 2025 17:14:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <Z_00ahyvcMpbKXoj@casper.infradead.org>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org>
 <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
 <Z_0cDYDi4unWYveL@casper.infradead.org>
 <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>

On Mon, Apr 14, 2025 at 11:40:36AM -0400, James Bottomley wrote:
> On Mon, 2025-04-14 at 15:30 +0100, Matthew Wilcox wrote:
> > > If an application does an A:B:C directory search pattern it's
> > > usually because it doesn't directly own the file location and hence
> > > suggests that other applications would also be looking for it,
> > > which would seem to indicate, if the search pattern gets repeated,
> > > that the two negative dentries do serve a purpose.
> > 
> > Not in this case.  It's doing something like looking in /etc/app.d
> > /usr/share/app/defaults/ and then /var/run/app/ .  Don't quote me on
> > the exact paths, or suggest alternatives based on these names; it's
> > been a few years since I last looked.  But I can assure you no other
> > app is looking at these dentries; they're looked up exactly once.
> 
> I got that's what it's doing, and why the negative dentries are useless
> since the file name is app specific, I'm just curious why an app that
> knows it's the only consumer of a file places it in the last place it
> looks rather than the first ... it seems to be suboptimal and difficult
> for us to detect heuristically.

The first two are read only.  One is where the package could have an
override, the second is where the local sysadmin could have an override.
The third is writable.  It's not entirely insane.

Another way to solve this would be to notice "hey, this directory only has
three entries and umpteen negative entries, let's do the thing that ramfs
does to tell the dcache that it knows about all positive entries in this
directory and delete all the negative ones".  I forget what flag that is.

