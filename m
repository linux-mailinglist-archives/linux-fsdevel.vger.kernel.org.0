Return-Path: <linux-fsdevel+bounces-25054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B0948650
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6CF28459C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50F16F0C6;
	Mon,  5 Aug 2024 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="unDQe2jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D716EBE2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901501; cv=none; b=tdsSLXoaTjDyonRehYOPnGefWU6ha7hOQhmdbDhnD4OEKoYkaR4k1kIZ/4w3dBsNzunOUu2qlxLARY6k/UlcuIXYIlaMiubkeA6WjxrVj4h+Z6JOeMNspNc2/axnx+pK5o1DLD3JPfAlkg99DtIlzi53XwQnNO9+MGT2O3bReVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901501; c=relaxed/simple;
	bh=myAqGyuZVKv9x7bG/POQP8MK6jUdFMl04R4r5Z0inl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy2pX2d1BvWNfc6AOdvC6PadWHRiexFWa/N7dfPwT5aETsFEkT6/vNBpu3U6uDniTedvn/13tRzGE9Hvy+6Paw1npquCCLS9vtHVNi4aelAeLIy1E6AY7QjFaCR8XOx69ZMfK6kAVPsrQOna2Ht128oRoMRa5B71cQo+ncMPAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=unDQe2jk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YyM7YXYmhe4DBXLp8tk0POve426H/FYpv+WFEx7mMpI=; b=unDQe2jkZnTeBLUG7fmHMSkMlB
	OTJvOrS8Y0p6pzgSDXEb0TSHFmBw3+wPLGEzLzD0DwVoAebdEys7Xtr97cvihwQr4cBwYqQ0ww9ey
	mv4mQDnQGwafzQXWvGElhjRD05Q+re8eATJ4BAnc2VPW0MHwbmyPHBpBVLIsnCxd2Fh+VAW/Qzntr
	mvMLk6RGqOLZF5TO/3Tmjj9OsGFRRBJhSwFHtOW/fbSokkGMJ9vtOmom8vU4nQOk5itz8t+Fja79z
	QzOllKglNPmIKlRnU9fTzj/JvHh/UNpLc4macaiM0lFHbqvgbBnK2n1Si3nPwxcyy1KZwsXYZWhYQ
	WM/nXpBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sb7No-00000001oFy-2sMi;
	Mon, 05 Aug 2024 23:44:57 +0000
Date: Tue, 6 Aug 2024 00:44:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240805234456.GK5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
 <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
 <20240804211322.GD5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804211322.GD5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 04, 2024 at 10:13:22PM +0100, Al Viro wrote:
> On Sun, Aug 04, 2024 at 08:18:14AM -0700, Linus Torvalds wrote:
> > On Sat, 3 Aug 2024 at 20:47, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > >         bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
> > >                         copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
> > 
> > Ok, thinking about it, I like this interface, since it looks like the
> > compiler would see that it's in BITS_PER_LONG chunks if we inline it
> > and decide it's important.
> > 
> > So make it so.
> 
> FWIW, what I'm testing right now is the patch below; it does fix the reproducer
> and it seems to be having no problems with xfstests so far.  Needs profiling;
> again, no visible slowdowns on xfstests, but...

Seems to work, no visible slowdowns.  Pushed into #fixes.

BTW, speaking of fdtable, the longer I look at it, the more I'm tempted to
try and kill it off completely.

Look:
	->fdt->max_fds is non-decreasing
	->fdt->full_fds_bits only accessed under ->files_lock
	->fdt->open_fds is sometimes used with rcu_read_lock() alone,
but such users are very few - it's
	bitmap_weight(fdt->open_fds, fdt->max_fds);
in proc_readfd_count() (stat on /proc/*/fd) and max_select_fds();
the latter is checking if anything in the fd_set_bits passed to
select(2) is not opened, in addition to looking for the maximal
descriptor passed to select(2) in that.  Then we do fdget() on
all of them during the main loop of select().  Sure, we want
-EBADF if it hadn't been opened at all and we want EPOLLNVAL
on subsequent passes, but that could've been handled easily
in the main loop itself.  As for the bitmap_weight(), I seriously
suspect that keeping the count (all updates are under ->files_lock)
might be cheap enough, and IIRC we already had cgroup (or was it bpf?)
folks trying to get that count in really scary ways...
	->fdt->close_on_exec has two places accessing it
with rcu_read_lock() alone (F_GETFD and alloc_bprm()).  In both
cases we have already done fdget() on the same descrpiptor.

So... do we really need that indirect?  The problem would be
seeing ->max_fds update before that of the array pointers.
Smells like that should be doable with barrier(s) - and not
many, at that...  

Note that if we coallocate the file references' array and bitmaps,
we could e.g. slap rcu_head over the beginning of ->open_fds
bitmap after the sucker's gone from files_struct and do RCU-delayed
freeing on that.  Am I missing something obvious here?

