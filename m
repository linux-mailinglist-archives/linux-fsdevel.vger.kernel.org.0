Return-Path: <linux-fsdevel+bounces-58229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96BB2B568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9685C19685C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06B17A2E0;
	Tue, 19 Aug 2025 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CZEXRq8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6915E5D4;
	Tue, 19 Aug 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563956; cv=none; b=a6v6wCFC26XIbZ6rXlfH5LkNBn0OrPWpUp/f1bbwpi5SuMXmlIS4CgT8vDwxVyGdPqVwKy2I8FkvQwz4vo1/CQOF0QqAHc3eauztIrFETl3NJqcRC9152dLdE/67vsktZ+xQsjVgpFJzYeIFlCC87dUpnBmZArIbU16EipuyDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563956; c=relaxed/simple;
	bh=yt9Lqnd575f5OqQR5pPxTSdmWCbjmcFsis/xjtsq1kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJIAEj/gJPjMF3Q85USoGuEnKkhW4iyfoGMsURpRV+y3h+CCOevRatRBkn0Hz59U+Sk3dAS7KtR3ucHEcage2FMjm8SaUXMlCYi/DHYM2h33J8nsRA83tVPaGXn8I/YhXKHJF/gVnHvzGsSZYJR2obBWNlUkmIsybLSIu1u4moc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CZEXRq8J; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DRdpKj3XT6X7bI/DgiUuy26B7gDg9uEGfnhKl06Ee0U=; b=CZEXRq8Jofmfaee29kRBaAV+GF
	2DyPsvEbGbLIkFNwyhEJzxZlIGsJVtersKvw4N029oiy0C6CUdSI1Sh04lbPBYmXSK1OqiqXj/Kzc
	+GgqCtwedK9LcvvUuE9Pi594wP5bOGMnvBgFiOQctaXAoMeMFu7q6JV7nfMIr3MZ0qd/gFFAGWMQl
	x0mqN+BJ4/TRlxf6sFzmkrn2886Wsc+4/QnA8Fc8d65YhIuqEbSRJZ09H58TJLgcTu0mHHBgblzlb
	4ibxCr47xcepdGu4A3YsFsLp0d0yyApKLwlU2Boc5IuN6cmpth1qM12imfHPWuiF4ZsjA3QfToDLH
	QsCzF2gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoANY-0000000AMBP-3Ttk;
	Tue, 19 Aug 2025 00:39:08 +0000
Date: Tue, 19 Aug 2025 01:39:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250819003908.GF222315@ZenIV>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
 <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
 <20250818222111.GE222315@ZenIV>
 <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 18, 2025 at 04:00:44PM -0700, Linus Torvalds wrote:

> Now, I don't advocate 'goto' as a general programming model, but for
> exception handling it's superior to any alternative I know of.
> 
> Exceptions simply DO NOT NEST, and 'try-catch-finally' is an insane
> model for exceptions that has only made things worse both for
> compilers and for programmers.
> 
> So I do think using labels (without any crazy attempt nesting syntax)
> is objectively the superior model.
> 
> And the 'finally' mess is much better handled by compilers dealing
> with cleanup - again without any pointless artificial nesting
> structures.  I think most of our <linux/cleanup.h> models have been
> quite successful.

I'm still rather cautious about the uses related to locks - it's
very easy to overextend the area where lock is held (witness the
fs/namespace.c bugs of the "oops, that should've been scoped_guard(),
not guard()" variety - we had several this year) and "grab lock,
except it might fail" stuff appears to be all awful - when macro
is supposed to be used like
	scoped_cond_guard(lock_timer, return -EINVAL, _id)
(hidden in the bowels of another macro, no less)...

I'm still trying to come up with something edible for lock_mount() -
the best approximation I've got so far is

	CLASS(lock_mount, mp)(path);
	if (IS_ERR(mp.mp))
		bugger off
	...

with things like do_add_mount() avoiding the IS_ERR(...) part by
starting with if (IS_ERR(mp)) return PTR_ERR(mp);

With that we get e.g.
	CLASS(lock_mount, mp)(mountpoint);
	error = do_add_mount(real_mount(mnt), mp.mp, mountpoint, mnt_flags);
	if (!error)	// mnt is consumed by successful do_add_mount()
		retain_and_null_ptr(mnt);
	return error;

but it takes some massage to get there...

