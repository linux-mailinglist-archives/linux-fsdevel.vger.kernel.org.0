Return-Path: <linux-fsdevel+bounces-66212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F6C19BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 11:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3661C2568A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69113396F4;
	Wed, 29 Oct 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpc+lgyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABF336ED6;
	Wed, 29 Oct 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733437; cv=none; b=M4hETyPlZ55a/x49f6/kawQMdx8U3hV08fTHIVtEP1p/nfFJ/KKDu5UdOrqz0IVEw9OLzMnX2tBiN2NFpBvN7mcjdmEDVYkVNJ1EMmYGzc+FbcG/CqWy9syqmXbK7XDhBdOZJbqv9u9VidxIfbx4Mfv3MDecjrQENS5qVGv6BxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733437; c=relaxed/simple;
	bh=ZRLYsCNv0Aku52fK8xrH+g+f56E6a620qWn/7FtTSxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkTuYlSwtn2FA9D2Kp6SQERp9P7UluhrkhwQJH+/35DGJXKcDqi9cruzhF483kxk0zY+PMJitiLmnji3oyMIXR7fiE/E3ETWu+mF/S31neNxgi0EezB6YTApNm4U97hSvEwG06rmHnHg1gyCbS71Db4cPl9x4POiEyj6JPUCtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fpc+lgyc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FTMUdLNlqjqoXX4P14LI/1ejbYO2CftFuA0qjvbF9f8=; b=fpc+lgycW1wcwUiZs6b4NjJePP
	iuaV9Xq7hNjiBnfjYwG7NBZlPjgZxOgGNDi8UoDFQ2xMc4q8YBYtO20x88uTqSr2tN5PTAcwTu+qG
	jRsNMYi3FjF+scS+TRjZ8raKrmJm9irXvKLA2qzlz3kQZOfHDnKWt3nYjxtU3QoTlJ9FFjc5NRt5i
	BJ0qtaYnNMLstn6zkZGJcqLrpPOfRpgOQIVchARnPISVBUlcFFYLLVx72Xb5bgAV7fHs8ehlsNrWf
	TG363xC52UimSsVO9P073iBgZndCyJUrWJNmVTw2mNHVCVo6NnZx0KzUujHtGahy82tqBVkLDkuet
	cNiQyKCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3L1-00000007Ffr-18tN;
	Wed, 29 Oct 2025 10:23:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 034AB300323; Wed, 29 Oct 2025 11:23:32 +0100 (CET)
Date: Wed, 29 Oct 2025 11:23:31 +0100
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
Message-ID: <20251029102331.GG988547@noisy.programming.kicks-ass.net>
References: <20251027083700.573016505@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027083700.573016505@linutronix.de>

On Mon, Oct 27, 2025 at 09:43:40AM +0100, Thomas Gleixner wrote:
> Thomas Gleixner (12):
>       ARM: uaccess: Implement missing __get_user_asm_dword()
>       uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
>       x86/uaccess: Use unsafe wrappers for ASM GOTO
>       powerpc/uaccess: Use unsafe wrappers for ASM GOTO
>       riscv/uaccess: Use unsafe wrappers for ASM GOTO
>       s390/uaccess: Use unsafe wrappers for ASM GOTO
>       uaccess: Provide scoped user access regions
>       uaccess: Provide put/get_user_inline()
>       futex: Convert to get/put_user_inline()
>       x86/futex: Convert to scoped user access
>       select: Convert to scoped user access

Applied to tip/core/rseq along with the first set of rseq patches. The
core-scoped-uaccess tag should denote just this series.

