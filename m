Return-Path: <linux-fsdevel+bounces-64454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC4CBE8170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 215EE501819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F773126D0;
	Fri, 17 Oct 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rx05nYJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAE288D0;
	Fri, 17 Oct 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697499; cv=none; b=PGGxNKMstjSAi+YIhge9d4i4OOe9NOIuhsNKbw+NQZ3wselc7IZwzIfjd5+U6za1GAtij+DBp6QVl8MFglxVrRasQaqzYUwW9z5Wcz2wr4i9wefyKy0e6dKkAQbz3ae5ZuoYpzLEEkFjjdJVIFqn6xww26sAM9w/ma3ce7XRDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697499; c=relaxed/simple;
	bh=8B4uYIt4n/VpUaqrH6E24NRdkkxqDj4yA/FMe0ayRhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf/v+cdr/LEarrl+e7jO+T6gJJug5zbPMZoIldnL2zxzdmTE+HLSg4jnAvCIVUOevkN/yXMX2qyp8MdR6PN0y0G3Bif0uhI0RZuys77xcR8VFNeI0R1NGd2I6NGdNhqchPpV57jETAu3dBBtYVNGxkJqybK/hNRMypi7YTzx+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rx05nYJA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nWS8mbbAyKknksTkgFaSq1Uk5/fAQaz/isktn9K57hg=; b=rx05nYJAYN+RTwLB2lGfP1bKqX
	cPz5fqwLakGazsonqYKuradYhuAqs/nZNMp1UmMdmEfCx/0wwDD1Jo8DUW2lVPnJwIO6NufWGAA9r
	ZiUDqFrLMAam5RoKlt9adHo8b8Nkesw6GoiJ3pPrPHmQwBLTDcZDeMMDpoeIh/vzMVcK8i9VuHnvA
	GdtPmogaKpTQntPRIva/xPzJCazhbx9a7ZE/fV3ObzJngfuEGmNt4pPpmcf/oqbUye2TOgbB5JjbS
	DIiU97r47NbJ1u6sTo7huCPbrCOm4ElFLO5G2diIbCi3+DVFhpmeU5zExTsMiYzZevf9n4rETyW3X
	VfZs2JcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9hqO-00000008mcj-0Bmj;
	Fri, 17 Oct 2025 10:37:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AB1130023C; Fri, 17 Oct 2025 12:37:55 +0200 (CEST)
Date: Fri, 17 Oct 2025 12:37:55 +0200
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
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 00/12] uaccess: Provide and use scopes for user masked
 access
Message-ID: <20251017103755.GZ4067720@noisy.programming.kicks-ass.net>
References: <20251017085938.150569636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017085938.150569636@linutronix.de>

On Fri, Oct 17, 2025 at 12:08:54PM +0200, Thomas Gleixner wrote:

> After some back and forth discussion Linus suggested to put the local label
> workaround into the user access functions themself.

> Andrew thankfully pointed me to nested for() loops and after some head
> scratching I managed to get all of it hidden in that construct.

These two hacks are awesome and made my day; thanks!

> Thomas Gleixner (12):
>       ARM: uaccess: Implement missing __get_user_asm_dword()
>       uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
>       x86/uaccess: Use unsafe wrappers for ASM GOTO
>       powerpc/uaccess: Use unsafe wrappers for ASM GOTO
>       riscv/uaccess: Use unsafe wrappers for ASM GOTO
>       s390/uaccess: Use unsafe wrappers for ASM GOTO
>       uaccess: Provide scoped masked user access regions
>       uaccess: Provide put/get_user_masked()
>       futex: Convert to scoped masked user access
>       x86/futex: Convert to scoped masked user access

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>       select: Convert to scoped masked user access

Basically okay on this one too, except see the comment.

>       coccinelle: misc: Add scoped_masked_$MODE_access() checker script

And that's just pure magic, I can't seem to get me head around
coccinelle syntax.

