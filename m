Return-Path: <linux-fsdevel+bounces-61828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D3B5A368
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 546524E1B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952C283138;
	Tue, 16 Sep 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fHPtAqg+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxlwnHu5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A741D88A4;
	Tue, 16 Sep 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055425; cv=none; b=Epq7i7af3yDSGe9qzSI78rJEfZ6oHzBmLLjMoN+h1ss6LJczQqFnq19aVJibqIqFpQnDSmnBUe5ozisJfpKCbM4KpKIEkrww6KLh0tH4EKtL+J0buEmG+LD9jN6ZDBE8WYqe90X6IymmPtzeCTOGvL/6bMpD0w/LECggiA5C7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055425; c=relaxed/simple;
	bh=G4qi7O3CksgJSiBo3p6k5QYAY8HBAkE6FGj0OG3ESdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBFU72+WZxiD1ARarAHqoKQ1zdCGRzuwtPfyalh1Kq0CKlkFPKgjaUsN+/ZZbZ4NKD3H0GnIIYsExtA9+hFUp04oLQqBJlKEWQbltihiHlHm4QvBKG4DEo99+rq5/0fbp70CU8daH6ujCiHLr53dy06tGuXbjvRwmfC1P4FV3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fHPtAqg+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxlwnHu5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758055421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmwiWlv0Ck+IJdd3Cks26VCoCBj9MKGyMc1abZ8u9bc=;
	b=fHPtAqg+sMLZLZm4bRBdG+NiQpOen4eY6FYi8WhQrq19OvXZnf2i/z2g5rtCmo0qHGtLB+
	SeT7RZAk5FllzyIV1UyDvSAMM994Ex8at8LZHYteYOaPRhs6lS+WvGOPmw655mWBH5clU5
	IOjibH494K6t2MobsKztgrRJ+NAdU4Ff+eu5Rl49LjTLNTxsHPnvl5qHARxH/EEMdJEZiC
	+WIu8Al2sjL+EXjE4Njq3tBtKpetXd2HHl3g1BotVyH8956ySuA60kl8n3BV759LfRhQK5
	JOAXot8OcYRkSoxO6N1w9UO4uDCsuipPa8OMIdLEk0EAzGDgh8gH8jE56BBNlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758055421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmwiWlv0Ck+IJdd3Cks26VCoCBj9MKGyMc1abZ8u9bc=;
	b=WxlwnHu5OHd/bgNf03lRyfpAkm1XZWwyZSTeEMav+PPR2rXHI/bzmT7JiwFUd4uG6OVxel
	xAvZFpDnubaIGQAw==
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 2/6] kbuild: Disable asm goto on clang < 17
In-Reply-To: <20250916184440.GA1245207@ax162>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de> <20250916184440.GA1245207@ax162>
Date: Tue, 16 Sep 2025 22:43:39 +0200
Message-ID: <87ikhi9lhg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan!

On Tue, Sep 16 2025 at 11:44, Nathan Chancellor wrote:
> First of all, sorry you got bit by this issue.

The real annoying thing was that I could not makes sense of the error
messages and when I started shuffling code around for analysis it got
worse by failing reliably even with one instance or it exposed random
other incomprehensible errors which did not help analysis either.

Sh*t happens :)

> On Tue, Sep 16, 2025 at 06:33:11PM +0200, Thomas Gleixner wrote:
>> clang < 17 fails to use scope local labels with asm goto:
>> 
>>      {
>>      	__label__ local_lbl;
>> 	...
>> 	unsafe_get_user(uval, uaddr, local_lbl);
>> 	...
>> 	return 0;
>> 	local_lbl:
>> 		return -EFAULT;
>>      }
>> 
>> when two such scopes exist in the same function:
>> 
>>   error: cannot jump from this asm goto statement to one of its possible targets
>
> For the record, this is not specific to local labels, unique function
> labels could trigger this error as well, as demonstrated by Nick's test
> case:
>
> https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1636342477

Ah! I somehow failed to find this one.

I was actually trying to create a simple reproducer for using in the
depends on $(success,echo...) magic and could not manage.

The test case in the issue tracker is really helpful as it can be
condensed into the obfuscated C-code contest format required for
'depends on' checks. So we don't need the version number hack for
detecting it. That's definitely preferred as it catches potential
misbehaviour of later versions and of other compilers as well.

I'll send out a revised patch to that effect later.

>> That prevents using local labels for a cleanup based user access mechanism.
>
> Indeed. This has only popped up a couple of times in the past couple of
> years and each time it has been easy enough to work around by shuffling
> the use of asm goto but as cleanup gets used in more places, this is
> likely to cause problems.

Yes. I noticed that moving the label around or rearraning code slightly
makes it go away or even worse, but that's not a real solution :)

>> As there is no way to provide a simple test case for the 'depends on' test
>> in Kconfig, mark ASM goto broken on clang versions < 17 to get this road
>> block out of the way.
>
> That being said, the commit title and message always references asm goto
> in the general sense but this change only affects asm goto with
> outputs.

Right, that's misleading.

> Is it sufficient to resolve the issues you were seeing? As far as I
> understand it, the general issue can affect asm goto with or without
> outputs but I assume x86 won't have any issues because the label is not
> used in __get_user_asm when asm goto with outputs is not supported?

I haven't seen a problem with that yet. So yes, as things stand that
seems to be a ASM_GOTO_OUTPUT issue.

>> +config CLANG_ASM_GOTO_OUTPUT_BROKEN
>> +	bool
>> +	depends on CC_IS_CLANG
>> +	default y if CLANG_VERSION < 170000
>
> Assuming this change sticks, please consider including links to the
> original bug report and the fix in LLVM:
>
>   https://github.com/ClangBuiltLinux/linux/issues/1886
>   https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14

Sure! That's indeed useful.

Thanks,

        tglx

