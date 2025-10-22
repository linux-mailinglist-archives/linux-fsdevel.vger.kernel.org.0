Return-Path: <linux-fsdevel+bounces-65104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D9BFC264
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134C319C0F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD334679A;
	Wed, 22 Oct 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZYwOhBus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804512FD664;
	Wed, 22 Oct 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139760; cv=none; b=sD41541n8wH9QOmimw6taoPbC6cDRBvEQ5boLyuSME0eYnssMY9eCDo4lU50H/3dnwpRHWR49LN7rJX8mbm8+Ps2MRLIpKMz9EDi4fjY7p/y01ZtWjStTe2Po2KZ38qsXpQ0k3I78BeAamlyknbcWb07qq+AXSCOtW/lc647npo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139760; c=relaxed/simple;
	bh=9MWwfLqVy2MR8ym9agdxv8YD0Vk1zDzt40KD44jYGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUz01YVfdjXX53pNkV+uxIEGmpleb5gQXjqUmT8FJNrJ46i3wld8dA5Pjn/U6/eRHt/xadhNTQjzmI6lyUd0FTlnFioP9FxU0i6yudqt2qf9gjVsG9Q7aNVNc+5ImE1qZnG/V+YEfb90UHxQbPIUNJZ9htHLUPWJ5Js/CSLKaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZYwOhBus; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vI5ygdM2fUq0WhLkjqvyWdwalTGXtImKgD/K2E+hX2M=; b=ZYwOhBusiUOSHhKLetWTNJNMjy
	bOFMKbx4lkmtmrO7n86UGdT9Kf1mBZ2CQzanXcplCmrt35Ffy7u8kJ4PXpYYAoyQ7w9LT6BL8cQsu
	PW0GEbL2LjAVq6xWvTlmWE/UmTIr5UKBTZDdwQTFoL+yMxe+9raqn9/DMtx0KaH9xWUFiN5fT1cMA
	9Uyt/h1JzFxUl6Gz+WZVYYAqcbxOJexz/7zuC7PQu03jBwQtGNfpf7iTJUvMlJo4svTajaxMxLcPG
	hZ9H7QIEIEqI2UQ3wSDJ6YzYR2PArEaH+qCVC3MCNssf15mS9nUiFou3pKuZjw17TFGNTrV218T/Z
	aj9uPCFQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBYtb-00000006NrR-0yQr;
	Wed, 22 Oct 2025 13:28:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF53130039F; Wed, 22 Oct 2025 15:28:55 +0200 (CEST)
Date: Wed, 22 Oct 2025 15:28:55 +0200
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
Subject: Re: [patch V4 00/12] uaccess: Provide and use scopes for user access
Message-ID: <20251022132855.GP4067720@noisy.programming.kicks-ass.net>
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022102427.400699796@linutronix.de>

On Wed, Oct 22, 2025 at 02:49:02PM +0200, Thomas Gleixner wrote:

> Thomas Gleixner (12):
>       ARM: uaccess: Implement missing __get_user_asm_dword()
>       uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
>       x86/uaccess: Use unsafe wrappers for ASM GOTO
>       powerpc/uaccess: Use unsafe wrappers for ASM GOTO
>       riscv/uaccess: Use unsafe wrappers for ASM GOTO
>       s390/uaccess: Use unsafe wrappers for ASM GOTO
>       uaccess: Provide scoped user access regions
>       uaccess: Provide put/get_user_scoped()
>       futex: Convert to scoped user access
>       x86/futex: Convert to scoped user access
>       select: Convert to scoped user access

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

