Return-Path: <linux-fsdevel+bounces-64939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA0BF7225
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF5819C19F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD5302CBD;
	Tue, 21 Oct 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/g8k/vY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+qP/IJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646733CEB3;
	Tue, 21 Oct 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057746; cv=none; b=j5E0PsISpwAt5WE171aa8kT8SbUGKrCJpXs1zc0N2hRUIwHj/CcJ+MMimAWnbYBJwR1B7kyALXJTX5/Xqknbgv+Icufoxkk7DlaFHhe1xk/ljPkuF+yAgIt7GW8BvCCpL0X+KKwJ37SBWc825UhtZ8bqXKj1R1VH9hmlQSM7WaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057746; c=relaxed/simple;
	bh=iWayTAfFXRO8xfZ/dC8UhRQYS4+XpIUIjHZcn526K+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BV59VpUNK8a2a6muJDtswtpp0IUb31eBFMNValAO+g5XVKWcvzjDm929q7m7F4VAMvZL7CFC/bTK2mYiTdNnZ00FLs0EF4NPC4M7dreEbEZ7nuekn/ghsm2/WRYyMv72R9NYQ3C20CgXDxltj79DCErOgYSXyNO4zZxoBk7dOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/g8k/vY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+qP/IJ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761057743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c27Kz3PCpHpOUA2hxoFAn/lgFIxKWu9eCciI5q0PFVA=;
	b=1/g8k/vY5UCh/boWPJmgNdB7ubbYE/A/fsOkfq3wSrNQGzQ5valPHvmdpxXGZqcnRroQ58
	Bejn39YCg/SlHMeJklk2aBag1ZZ/ZkJkTivx6X2k6zFCy9QlKITW6ujrMH0xoF2co7FakR
	/dutCEVT+SfKWOjjeaJTqJRMh89jW+zebxPrs6Ff9MEqAR4Jz/7LUbv+E7A5ITdaxbZChA
	LQsIRW35kAAcwrybohHORnbCHtCEJbOoM88Ok56KpnArXwbr5s8s3yRrxzfqZOWUQSPOoj
	HHlLFLvQYsl/+KPI+DNPkp5iCy3GtuWwAiSjCg7LL/RU6tt4yt9gYNWiE4WiKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761057743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c27Kz3PCpHpOUA2hxoFAn/lgFIxKWu9eCciI5q0PFVA=;
	b=v+qP/IJ72B74NWtVCOdsRXgUn8qUa/Jvf+CPgpV7YyvANjj4e/t31Aew02eNWfxowW2zLI
	+slcDYUqT+9nxODg==
To: David Laight <david.laight.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>,
 Russell
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
In-Reply-To: <877bwoz5sp.ffs@tglx>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de> <20251020192859.640d7f0a@pumpkin>
 <877bwoz5sp.ffs@tglx>
Date: Tue, 21 Oct 2025 16:42:22 +0200
Message-ID: <874irsz581.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21 2025 at 16:29, Thomas Gleixner wrote:
> On Mon, Oct 20 2025 at 19:28, David Laight wrote:
>> There is no requirement to do the accesses in strict memory order
>> (or to access the lowest address first).
>> The only constraint is that gaps must be significantly less than 4k.
>
> The requirement is that the access is not spilling over into the kernel
> address space, which means:
>
>        USR_PTR_MAX <= address < (1U << 63)
>
> USR_PTR_MAX on x86 is either
>             (1U << 47) - PAGE_SIZE (4-level page tables)
>          or (1U << 57) - PAGE_SIZE (5-level page tables)
>
> Which means at least ~8 EiB of unmapped space in both cases.
>
> The access order does not matter at all.

I just noticed that LAM reduces that gap to one page, but then the
kernel has a 8EiB gap right at the kernel/user boundary, which means
even in the LAM case an access with less than 8EiB offset from
USR_PTR_MAX is guaranteed to fault and not to be able to speculatively
access actual kernel memory.

Thanks,

        tglx

