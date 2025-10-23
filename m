Return-Path: <linux-fsdevel+bounces-65376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E1C030C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 20:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BBC3AE401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269D296BDC;
	Thu, 23 Oct 2025 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z6JyVVvX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k2PqTysZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934E28D8E8;
	Thu, 23 Oct 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245058; cv=none; b=FbVraLigPqXCyVV2mP+qDuOXQzPR4pwPPEHsOX7oBspfuybeCBXbP6VX/a6ED323Za4TmfuUvhlAmirTPSTzZ0mGRzBeUK/VotiIeghiiDMrVQr3v2Zx7T0LBusoVU82paWaVGnLfwUsfAteNmSgUvhX8FdmgUrehZi/TIEnak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245058; c=relaxed/simple;
	bh=ID+SpeZlrXXoHcTWUOnXULiwe1j+Sg0bew4QgPVBIVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tP/jW7AsYCh2sFMSYANIcQLKRktH8Hc4It0j2gJV4jMn/Ovgxd1ee6Hf4XPeY1aUeKZuZmHkg5OGVx3HaRAPP7lDPyAVfbnqY8TblCXCK5uEadtjBRt3nDGixvoHuYJmkuTbi5n4PQL8BrsOJ8d+79fQ8iUrd11WMluEq2/31vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z6JyVVvX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k2PqTysZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761245054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gr+iTa6I2/obiorgX/iYvIq85HArhg0aBMc30DEux0I=;
	b=Z6JyVVvXaWOYv4K7XWupHxBpzZlYpgf5Va2pTz0xKoekHimqy8m9kpzWJR67k8NTSge6Pu
	pj1eoQeYp8npSoNhcmRFl+wtklkvdSbntGU/+ZU+VkEYhATJ/2w67pfLl6NrKzFL8YkFBj
	tz+RIae+Vg6+/gA7ZwvSAx8jyyfFhHWoerQNsfsX8vZwG++ZSmVquE3u5d9Qky5u/pWhfe
	Z27mkNjesStYEnSIaLWsvH9GU2GdvVJ+/1wsaxCCyTnv7bk0dW7oyVKDPvU36ZH4tGdIz0
	SAAZZgn3S2Kdp9w4d8AFHEvN5ZwXz+cPMrMK16HbkBELjB3xvZYnc/4yMJ00yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761245054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gr+iTa6I2/obiorgX/iYvIq85HArhg0aBMc30DEux0I=;
	b=k2PqTysZqIKK5wnAuNAF6YkOs1yYrSVeb86wNNECOCJRF4fnFtNx18Z5K79S+1+JpepjUk
	+w4iQ08K50QRq8Bg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, kernel
 test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
In-Reply-To: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
References: <20251022102427.400699796@linutronix.de>
 <20251022103112.478876605@linutronix.de>
 <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
Date: Thu, 23 Oct 2025 20:44:13 +0200
Message-ID: <873479xxtu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22 2025 at 05:16, Linus Torvalds wrote:
> On Wed, 22 Oct 2025 at 02:49, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Replace the open coded implementation with the new get/put_user_scoped()
>> helpers.
>
> Well, "scoped" here makes no sense in the name, since it isn't scoped
> in any way, it just uses the scoped helpers.

I know. Did not come up with a sensible name so far.

> I also wonder if we should just get rid of the futex_get/put_value()
> macros entirely. I did those masked user access things them long ago
> because that code used "__get_user()" and "__put_user()", and I was
> removing those helpers and making it match the pattern elsewhere, but
> I do wonder if there is any advantage left to them all.
>
> On x86, just using "get_user()" and "put_user()" should work fine now.
> Yes, they check the address, but these days *those* helpers use that
> masked user address trick too, so there is no real cost to it.
>
> The only cost would be the out-of-line function call, I think. Maybe
> that is a sufficiently big cost here.

I'll have a look at the usage sites.

But as you said out-of-line function call it occured to me that these
helpers might be just named get/put_user_inline(). Hmm?

Thanks,

        tglx

