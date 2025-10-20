Return-Path: <linux-fsdevel+bounces-64647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60897BEF844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A14400332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF342D9ECE;
	Mon, 20 Oct 2025 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBpWibfQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHg1coFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7082D8DB1;
	Mon, 20 Oct 2025 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943059; cv=none; b=Pd4pcTDtw2RAWQW8+qsGk8tTZUheBk0gt7JIu2lQUHp6ixGqyZ7DPyrVXFhl++7TKufbaHOg4WLCmjWTR6/rcrmRLyfM3JDp8AjgB37IjhDBnR+gVnujpt9hkkxnFfTYJhWkGGxNyyCJOL7dWxNyiaYJg/Sq5vlYJ5TVsDKtFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943059; c=relaxed/simple;
	bh=B/foAdjJs+95KY0dHy3ZVMhSlwtVNbYpNRvQlirlYIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F8w0o9IvowcibTwjgpr/09XEaOl6ko4QuuibNKuUq6gDYp0tSqearpNXAVCXJ7gCHD+otVyZ2pb7koNvROFCk1gF3fiOBgTpgiPWJEJs/kNpIGWaBrZdCrYMBQCYzffO5cbE8ER287dA6LWx/Qh0OnSQuHrCbMN5Sv/aX1oZBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBpWibfQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHg1coFA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760943055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZCiJUNbDBKZU7NscC9t+cPIbwSt1d1aTLOIOEONDRo=;
	b=aBpWibfQy7NDvaZaGXNCdeOTgstNqJSd72h/HvfsU+bxtPLg46jN298a5AmbZZ0I8qsmk+
	d+9FiLZZFEkKF34+6aD/geC//vXqFAxlhvsIuTZ0otTv1PFTa68B8uXOwFcWk4+8WYI5an
	IUvxnjVByp5cBtfO9vsxxCUqKZIHzZsfrdbZZf3kacNHifOfvhESr5BlU2Lf/PbfyV38By
	KVznd395E5j77XdHOnXPD6Z0vpewpRYK/FK7/w8iwdhVqFvHHEA4Stu+hyylX4JdUwRORb
	fu7YAxMMiLqA2Vrpd+zZrafVfIA99TO2e4VyA7/HhfSxLwAND/A9kWLVflkZvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760943055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZCiJUNbDBKZU7NscC9t+cPIbwSt1d1aTLOIOEONDRo=;
	b=JHg1coFAEo4pN71GSm+4Y8XD2IbiEBac1CDhS7fUoq52oNxVyS/BaH8IlhDFLi/qxEKwbs
	tEjcxtPV9FDv1sAg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Linus Torvalds
 <torvalds@linux-foundation.org>, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Andrew Cooper
 <andrew.cooper3@citrix.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 08/12] uaccess: Provide put/get_user_masked()
In-Reply-To: <d58b798a-3994-438c-9c02-678f3178b21e@efficios.com>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.315578108@linutronix.de>
 <eb6c111c-4854-4166-94d0-f45d4f6e7018@efficios.com>
 <d58b798a-3994-438c-9c02-678f3178b21e@efficios.com>
Date: Mon, 20 Oct 2025 08:50:54 +0200
Message-ID: <87ecqyyskx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 09:45, Mathieu Desnoyers wrote:
> On 2025-10-17 09:41, Mathieu Desnoyers wrote:
> [...]
>>> +/**
>>> + * get_user_masked - Read user data with masked access
> [...]
>>> + * Return: true if successful, false when faulted
>
> I notice that __get_user() and get_user() return -EFAULT
> on error, 0 on success. I suspect the reversed logic
> will be rather confusing.

In most cases the return value of those is treated as a boolean
success/fail indicator. It's pretty confusing when a boolean return
value indicates success with 'false'. It's way more intuitive to read:

       if (!do_something())
       		goto fail;

Just because we have this historic return '0' on success and error code
on fail concept does not mean we have to proliferate it forever.

In fact a lot of that 'hand an error code through the callchain' is just
pointless as in many cases that error code is completely ignored and
just used for a boolean decision at the end. So there is no point to
pretend that those error codes are meaningful except for places where
they need to be returned to user space.

Thanks,

        tglx


