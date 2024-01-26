Return-Path: <linux-fsdevel+bounces-9133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58C83E62A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2143B22072
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8156775;
	Fri, 26 Jan 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rrlVeSV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606251033;
	Fri, 26 Jan 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310280; cv=none; b=NmCO9QnLwb03/TsppiU1IL+ZrImmOz2eP2P9xfOhXCC2ZAzoNd+P3hCTOtm5nYFhSIZQbLeHrYYdtAq+njCu2ukg4xUNoTlBrZ9EmijVEuW/TpGuPjSSsT5RgT+NrLQUtZ8CmoYG8p0IwCwiFv9ghTXmYrqoQmp2r0p6dcJrIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310280; c=relaxed/simple;
	bh=0gSsxB18ZgrEF2eblnqIQDWFIhAl09gsxMxKVlO6beQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqceD3c/q4XPUloTvOJHkBrRgv4mzX3DNLHemIvr3AuLgWe8+z7kXT0+GTAxFlF7kCTrBSlvoEb4WF5DPssoX9bk6OIshGK8Haa8j5d1y3Mvs0P6RphufB7gOXVTyNxs2rYYv9gDelrtmv0Zy3Tu8B8o16rx9gw331Rz+AT+XFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rrlVeSV2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DN8d2owzns57iSopJhp978Ll3aD6BBmAl0reMwcNfdI=; b=rrlVeSV2YcrCQu1oQKlejA2XcZ
	awJ5SF5dZchxBzdZPwsEx1T5FCZITiwWdoVhClA1o/BVXF5OPfGAzMhVPoPvuE+CJUSjfewEUesGH
	DFd1HS8YxfS6WECKXBMQEbEyQlY8kw6CQM4YbrT2ssdsmulv3nur/YijiJr2umdrAJyH2jYRgV9Pj
	Sp6x+B4aexzxIx6xG3lpc/WACano+RlMDKkiRElscM7bRgXlj/5VTI7OUYgYLCIOkYU0Ib3dqlOpi
	82amaM1sMM6mmB7eCTmo6p9Tq/fCZVL1Hcy6xvmbBoZC9NGlDRbPK/8ffwtBEV65vdt1qRHt/dnnT
	aaoBvXGg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTVFS-0000000F7cc-3ErG;
	Fri, 26 Jan 2024 23:04:34 +0000
Date: Fri, 26 Jan 2024 23:04:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <ZbQ6gkZ78kvbcF8A@casper.infradead.org>
References: <20240126150209.367ff402@gandalf.local.home>
 <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
 <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
 <ZbQzXfqA5vK5JXZS@casper.infradead.org>
 <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>

On Fri, Jan 26, 2024 at 02:48:45PM -0800, Linus Torvalds wrote:
> On Fri, 26 Jan 2024 at 14:34, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jan 26, 2024 at 05:14:12PM -0500, Mathieu Desnoyers wrote:
> > > I would suggest this straightforward solution to this:
> > >
> > > a) define a EVENTFS_MAX_INODES (e.g. 4096 * 8),
> > >
> > > b) keep track of inode allocation in a bitmap (within a single page),
> > >
> > > c) disallow allocating more than "EVENTFS_MAX_INODES" in eventfs.
> >
> > ... reinventing the IDA?
> 
> Guysm, this is a random number that is *so* interesting that I
> seriously think we shouldn't have it at all.
> 
> End result: nobody should care. Even the general VFS layer doesn't care.
> 
> It literally avoids inode number zero, not because it would be a bad
> inode number, but simply because of some random historical oddity.
> 
> In fact, I don't think we even have a reason for it. We have a commit
> 2adc376c5519 ("vfs: avoid creation of inode number 0 in get_next_ino")
> and that one calls out glibc for not deleting them. That makes no
> sense to me, but whatever.

Maybe we should take advantage of that historical oddity.  All files
in eventfs have inode number 0, problem solved.

