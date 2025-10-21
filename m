Return-Path: <linux-fsdevel+bounces-64960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72DBF7780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0623F400EE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D0E340A6C;
	Tue, 21 Oct 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AimhTbm/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cvRNsdPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9E3446B5;
	Tue, 21 Oct 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061567; cv=none; b=lERAQtKc+VxAuqI8cdzHyVR6hQbNOeDn3XkqIKhA4APrORrt0sKzdPN8iDkDSGcSgNVxj0j0PFnkanycd5ftw6IrLiJUOdKtHQjwUja/N37nLRLuni7Vat9E1wlUPSeoBFzpaUr/jk+Bv9AuxKQRz5AojcEWw/VE3lamCZMxUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061567; c=relaxed/simple;
	bh=hpbrkEo/yliOaWMtFYNGmEqSFDf9eOvz/9ISpsw+wUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/3eAx+ixZJuPqk4Q5ttMAXXfHwmkrbBZ+boDXqRndOBM+ODOHNXJ/wpsMU24GP2FBCOtxzoAGSi7XwaP27g5CvzRBEof9LVHAFgmvm/NmUFpG2HZ7WaiOdyhYbVQ2e/jJD8lI+cyj9t4uDzbL35CuKyOWwPdt2WQX6vxKu9vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AimhTbm/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cvRNsdPS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761061557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwrcsQ4E69ewTeWtqAZ5emGZEvWIYhFcDibNTG0FA/U=;
	b=AimhTbm/MmiU0oRMAd3uF686t3hr81Y5owQjwPt+t/EQgCKBa69nmulwgBV69DAgmeOiLs
	0dBlFvHe0CuIkLHWUhiL1t/BqksXKeOpRZ/JKO0XZ3uhW83aU/uvkv0aGEtMB3NqQYbo8T
	c1a/8lfSam1pX5DGvhcfkGXmV4x32lsZ332bnVFLI1XCKFZjiwp6KgAVuCMJQhQZ/BG1+3
	zi05GK9tLktBwlzF4YW3WSZoTogjkHwXyP3B8Tirr/2VvmwbsYu+mDsX55tIF2MT64MPBm
	xLwiGchu4C52oZGHU6/XiSveriXXJanvaLMtB2ia9NFfIw4m6RTH0hIsSxsIxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761061557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwrcsQ4E69ewTeWtqAZ5emGZEvWIYhFcDibNTG0FA/U=;
	b=cvRNsdPSRZnlZAgeJWkp3R95tMpoJ7F1qDZZCErTmzw+alSEUX9RVLzo8yFL18BIEiQxRa
	dsntvmwnLjX8G6Dg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
In-Reply-To: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de> <20251020192859.640d7f0a@pumpkin>
 <877bwoz5sp.ffs@tglx>
 <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
Date: Tue, 21 Oct 2025 17:45:56 +0200
Message-ID: <871pmwz2a3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21 2025 at 05:06, Linus Torvalds wrote:
> On Tue, 21 Oct 2025 at 04:30, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, Oct 20 2025 at 19:28, David Laight wrote:
>> >
>> > (I don't like the word 'masked' at all, not sure where it came from.
>>
>> It's what Linus named it and I did not think about the name much so far.
>
> The original implementation was a mask application, so it made sense
> at the time.
>
> We could still change it since there aren't that many users, but I'm
> not sure what would be a better name...

I couldn't come up with something sensible for the architecture side.

But for the scope guards I think the simple scoped_user_$MODE_access()
is fine as for the usage site it's just a user access, no?

the scope magic resolves either to the "masked" variant or to the
regular user_access_begin() + speculation barrier depending on
architecture support. But that's under the hood an implementation detail
of the scope...() macros.

Thanks,

        tglx

