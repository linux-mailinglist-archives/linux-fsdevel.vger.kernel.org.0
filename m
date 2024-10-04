Return-Path: <linux-fsdevel+bounces-30928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC398FCDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 06:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19F3B2282E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 04:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EF4965B;
	Fri,  4 Oct 2024 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eGh9X5+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF94DA04
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017547; cv=none; b=KeVZQ2pJA41BItnZzAkGMWCyNiyzP3KSirsYYzpsvQyNlcFwr7n7bIIfedw71G8OeB32tztnaOrHhPoI6mZsMffgj4IFMvtrrMPleGI4BKkwCu4PxF4j3nE3h+5V5cYTzRsRdUcFGGCr5xvcDnT7mpAP2h9Aizq527f12AMEvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017547; c=relaxed/simple;
	bh=oL7+vbTSbcplIH/Iw9YsoN8xO6a34tuwzkYwr+15dN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcA9moAVAdV+8KaRWSezkvZdBZAuRmUJjOezvDPFMvsVhvdS5LHiLUk9c77Vd6QoXgYOyWEAwLJG5oxX7UdRltwtnB0x/uPBlkVoFENVd9Pipn5RdzkKcezLNOMPJIN8rHjeKW072/kNCI4mNHV5ky9+qtjvzKwPt46Nfw+iqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eGh9X5+R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aIE77rre37xJBZv8cY8wtIuFxPNqb/cLri2gnhgbw1Q=; b=eGh9X5+Rjac9KCug0db0AeAJY7
	HyCCo09EB+6SQO8hrdSs8R0vdOdwp3aheaZMbuCjsfBTf8Bx/qRbKg71T7Cy23IrICJLbkfj8DPQX
	KNHpdU+OQpHFLU6+yo92s5Q6yw3Cqf3NLdbZiiFnwJrThY1Fm8zng6LofNokXXbd5A7vX/8jxYuFi
	1TQ96T00R2pgE2HwE2BRqMd2MnNmIjuPIO9NPtdfBFBaCUNxdgAh3iM7OoKAbTbBYxO7UiP6ly0gb
	NVh4hOaV8XiP4azxKsPaInhgEoPCJMV3yaoI5tDyjCWpGoZHWv+51WGke22hs4RRvTAK1tgFL8E/h
	uiMikzjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swaIg-00000000fni-2muU;
	Fri, 04 Oct 2024 04:52:22 +0000
Date: Fri, 4 Oct 2024 05:52:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20241004045222.GO4017910@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV>
 <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
 <20240816181545.GD504335@ZenIV>
 <CAHk-=wiawf_fuA8E45Qo6hjf8VB5Tb49_6=Sjvo6zefMEsTxZA@mail.gmail.com>
 <20240816202657.GE504335@ZenIV>
 <20240816233521.GF504335@ZenIV>
 <20240822000004.GK504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822000004.GK504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 22, 2024 at 01:00:04AM +0100, Al Viro wrote:
> On Sat, Aug 17, 2024 at 12:35:21AM +0100, Al Viro wrote:
> > On Fri, Aug 16, 2024 at 09:26:57PM +0100, Al Viro wrote:
> > > On Fri, Aug 16, 2024 at 11:26:10AM -0700, Linus Torvalds wrote:
> > > > On Fri, 16 Aug 2024 at 11:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > >
> > > > > As in https://lore.kernel.org/all/20240812064427.240190-11-viro@zeniv.linux.org.uk/?
> > > > 
> > > > Heh. Ack.
> > > 
> > > Variant being tested right now:
> > 
> > 	No regressions, AFAICT.  Pushed to
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #proposed-fix
> > (head at 8c86f1a4574d).  Unless somebody objects, I'm going to take that
> > into #fixes...
> 
> Well, since nobody has objected, in #fixes it went...

... and there it sat, forgotten ;-/  Sorry, should've sent it all the way back
in August, but it fell through the cracks.

Rebased on top of 6.12-rc1 without changes on Sep 29, so it had replaced the
older commit in -next since 20241001, no complaints about it (neither before
nor after rebase), so I'll send a pull request in a few.

