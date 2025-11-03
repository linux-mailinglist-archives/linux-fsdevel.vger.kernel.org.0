Return-Path: <linux-fsdevel+bounces-66803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE75C2C7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307CC3BB1AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE74280318;
	Mon,  3 Nov 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tcpIk2F7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266428031C;
	Mon,  3 Nov 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181208; cv=none; b=uXDgLJOaliqw1wrZMKK2OfJdEEysYViR1SsntRldza/LjzH30TTbEWhLa+wkYsMGCkjsPaL7AWpRlKEH7fDObOpilX+Jbjd4yaB+Zwu93AtWaU3eQaHrYPsNd8fJLwbeTIzxHKCZroUYwBKoaQJhFVlUmCP5zSEBfNUmZ+m3I2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181208; c=relaxed/simple;
	bh=Ss8YmFMubkU3R8CK92vjhdXQQ9WFeGGw2QU3hfyxH4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIhAFo8zZTWi0w6sm8C4khB7B0puqW4QEhdMWU8DRQLukTIpP9noNWWPFgdIigDU+K5mOn31YdB/M+V4UqPre1oS5dquULh3sGJOKuz9fHYafgp4g02fyWG5K8h6SmgLsXdM7pxwYrSrzyE/BirP7Q4AXLePWGGtUCelFw0xDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tcpIk2F7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iI95N45xUlZVhTMjnyMu5qguS//l74sBdQ6FwuCHQXw=; b=tcpIk2F7iJsy2Cok39kpG4TNpm
	lKGFJAP9fR4texKlFgtntVEWzbhlmiENIrTA4l+0JifVpJqLmNZfyAXXzOs8FaCh5TGjX0XUTzarD
	8Bot3EmkXkU73yUEzFf/8auMdO142JWOdp6VgE+ueiT+l21xWODyM9U7fixMQ/Zt1hFAeXAgJGlvM
	yc7JRFC4M5dUyOMS2EHvc/py/A352QKchG1ymiHG1p+aVeuaAEdBB7aRZ8j+BXdpJvRIJwtRaNrR/
	ekhG7PmxVehxdQ8KrpsBgKsQGg3mU3AAzOvUzl92pYuLNuhkTO5useVCbiw5bU+POSPXTGYVwLK21
	AblPip2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvpC-00000009AtY-0Qhs;
	Mon, 03 Nov 2025 14:46:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40487300220; Mon, 03 Nov 2025 15:46:26 +0100 (CET)
Date: Mon, 3 Nov 2025 15:46:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
Message-ID: <20251103144626.GX4068168@noisy.programming.kicks-ass.net>
References: <20251027083700.573016505@linutronix.de>
 <20251029102331.GG988547@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029102331.GG988547@noisy.programming.kicks-ass.net>

On Wed, Oct 29, 2025 at 11:23:32AM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 09:43:40AM +0100, Thomas Gleixner wrote:
> > Thomas Gleixner (12):
> >       ARM: uaccess: Implement missing __get_user_asm_dword()
> >       uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
> >       x86/uaccess: Use unsafe wrappers for ASM GOTO
> >       powerpc/uaccess: Use unsafe wrappers for ASM GOTO
> >       riscv/uaccess: Use unsafe wrappers for ASM GOTO
> >       s390/uaccess: Use unsafe wrappers for ASM GOTO
> >       uaccess: Provide scoped user access regions
> >       uaccess: Provide put/get_user_inline()
> >       futex: Convert to get/put_user_inline()
> >       x86/futex: Convert to scoped user access
> >       select: Convert to scoped user access
> 
> Applied to tip/core/rseq along with the first set of rseq patches. The
> core-scoped-uaccess tag should denote just this series.

Due to various build fail, I've re-created the whole branch, including
the tag. Sorry about that.

