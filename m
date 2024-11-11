Return-Path: <linux-fsdevel+bounces-34233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A909C3F92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A111C21B23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83C19DFAC;
	Mon, 11 Nov 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwySVczB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495419D091
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331786; cv=none; b=a+Qx9VdQuXBFQCIQYzMX2mMi345N6lDUCdTYtleGJT6mGpZRyoYXTJB/Jl9rZCVGXH2s4x83QAo9jNxfIDuZ9MC5ePF8+Q5QQl6brR8LZpqT82tQJO+BbnQNZDprSM057wsiP3NV6BJe1tgFS9JSECa7EOUCcq7a08PZAJHn+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331786; c=relaxed/simple;
	bh=ClNRl8wTJvgbV+GTIgCtut6Wms6whzhshDkV0v9AKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeKYXsKqJSKrD5W8MRbIg/yhJ+INC8UIOydL0SzVjnNbmBa0rpOUcRbuaHD1ERZOp6wzIHEt6QQorYs/flwvQ6lx0GEkRTQSxc5SGHs9PAXd4TNLLynda1O/edMI6Ij772Kg8cfhHHbwDGMeDG4QOk+QIjmBZ02r+fBB2NtVcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwySVczB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C213CC4CECF;
	Mon, 11 Nov 2024 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731331786;
	bh=ClNRl8wTJvgbV+GTIgCtut6Wms6whzhshDkV0v9AKK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwySVczBf6Hh3FwJyMn4hEimRo/VJSxtROT5EclKh/VWbY+74oNcUBTvOeaWZD0xm
	 SKlnUz6IFOK3H/82J9gpBIiBx3rHWHenokJaJqiMzcPI9ptp4q/v+XU3HkmLUFTFCE
	 yugVV2PiF4GFDnbVk8XOsv96+GARfbf6VuIIXodGhT3kbv6JnGL3li9IyTkwlGK75f
	 3eXPS904B1JYfcSPIffFE5hFnudqnEqZLvorAf7KTWdPA+jgqTYRw0QmcPHyBMeMCS
	 btrGGFGfYtimZIGX5VHVCa98YrPk2sKfnjQiFIp79LIa0MmbSSB3nH/8IQ0xtNIEFj
	 Z78yc0KPeSybQ==
Date: Mon, 11 Nov 2024 14:29:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, Karel Zak <kzak@redhat.com>, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20241111-tosend-umzug-2a5a4c17b719@brauner>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
 <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting>
 <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
 <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com>

On Mon, Nov 11, 2024 at 02:12:16PM +0100, Miklos Szeredi wrote:
> On Wed, 26 Jun 2024 at 14:23, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 25 Jun 2024 at 16:18, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > > But that means getting the buffer, and going back through it and replacing every
> > > ',' with a '\0', because I'm sure as hell not going and changing all of our
> > > ->show_options() callbacks to not put in a ','.
> > >
> > > Is this the direction we want to go?
> >
> > IMO yes.  Having a clean interface is much more important than doing
> > slightly less processing on the kernel side (which would likely be
> > done anyway on the user side).
> 
> So I went for an extended leave, and this interface was merged in the
> meantime with much to be desired.
> 
> The options are presented just the same as in /proc/self/mountinfo
> (just the standard options left out).  And that has all the same
> problems:
> 
>  - options can't contain commas (this causes much headache for
> overlayfs which has filenames in its options)
> 
>  - to allow the result to be consumed by fsconfig() for example
> options need to be unescaped
> 
>  - mnt_opts is confusing, since these are *not* mount options, these
> are super block options.
> 
> This patchset was apparently hurried through without much thought and
> review, and what review I did provide was ignored.  So I'm
> frustrated, but not sure what if anything can be done at this point,
> since the interface went live in the last release and changing it
> would probably break things...

I understand your frustation but multiple people agreed that the
interface as is is fine and Karel as main consumer agreed as well. So
ultimately I didn't see a reason to delay the patchset.

None of the issues you raised are really things that make the interface
uncomsumable and Karel succeeded to port libmount to the new interfaces
with success (minus the mnt_devname we're adding now that he requested)
and was happy.

If there's genuine behavioral problems that cause substatntial issues
for userspace then I would request that you please add a new flag that
changes escaping and parsing behavior for statmount().

