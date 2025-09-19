Return-Path: <linux-fsdevel+bounces-62212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A991EB88860
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C882D5A0925
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521B2F5337;
	Fri, 19 Sep 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuK5wRa0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYy6M2/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E72E92B7;
	Fri, 19 Sep 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273052; cv=none; b=IGwRc2Jv9RvRMTWz76oQ8DLjsEcUOUh9CwZculV4hZn1AkC1kD6roizCrWJU3Zkab5BHKfTGcF2BushN7nrUReoadxrREsMqFOT9ggvYbM9CRd4PVjS9SmlrNrElBaOA55TSqPPlOb7tXEvfxg8YuRRNhi5e44mxzVRBtoqMqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273052; c=relaxed/simple;
	bh=mKK9BZSlGpFwYARvF3teGUSt/yQQr+Sq0fzoXrino+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDBENw+VGMadvJH6+U/ANh2G363ogRPUNm+9nIhnC90vyTU9bZXDcTcMVfUwFMyWNcT0V4xP7vNuCHWjUAlNi7/4z5vT/7B8z2b10xJyu2XoQQQft8ud5UjFRWN86XM0iCjV5wyMRcAERgnMoSn9Pj5buz1ZdtdKFUc8MEWV1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuK5wRa0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYy6M2/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758273049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DX7ZWTGcfO6cjMLSuPAPLarY79uM4KjOvmSn3Yf+60k=;
	b=QuK5wRa0gDQO1gXgXehNLVasmKdIhOap5o64R2lG53jbo6J/WT4kVJ3gBmtdp5Kbz++Us4
	1xhgDgHTmFas3SJGlGEO3NiLQMIQokw5F3MhYbuQneqBKJB9JczoJF0aNvX417+jxDAs+R
	X3ywGry7Rp8uEvN21n02DE0781iXrphv/m9W52CXuBkskWKIa6zpRr2PsyQnROEqjXRuHS
	a08Qf3dsf5uiq2XvNMKmhxGGUK5gidEf4wQJa2LYQr71wqnmxgk5ic9dabJkN6DWw3Okwj
	uUxA+mg75xRft7B5XFN5q+sYTv8eo+PefhCyqlbpsErvZjxXOu6S8fwJErbhOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758273049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DX7ZWTGcfO6cjMLSuPAPLarY79uM4KjOvmSn3Yf+60k=;
	b=WYy6M2/T0lb7WW23IIDdRWWBS23UuLkHY4UK6FOSWYzoGycbAdkixRSpst7y1Vv4h8T1H5
	1Gf58LjH/I8W1jDw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, kernel test robot
 <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Nathan Chancellor
 <nathan@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,
 x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 3/6] uaccess: Provide scoped masked user access regions
In-Reply-To: <aMwHHkaSECBDjuir@localhost.localdomain>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.164475057@linutronix.de>
 <aMwHHkaSECBDjuir@localhost.localdomain>
Date: Fri, 19 Sep 2025 11:10:48 +0200
Message-ID: <87bjn6959j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 18 2025 at 09:20, Mathieu Desnoyers wrote:
> On 16-Sep-2025 06:33:13 PM, Thomas Gleixner wrote:
>> These patterns beg for scopes with automatic cleanup. The resulting outcome
>> is:
>>     	scoped_masked_user_read_access(from, return -EFAULT,
>> 		scoped_get_user(val, from); );
>> 	return 0;
>
> I find a few aspects of the proposed API odd:
>
> - Explicitly implementing the error label within a macro parameter,

Which error label are you talking about?

> - Having the scoped code within another macro parameter.

Macros are limited and the whole construct requires a closed scope to
work and to keep the local variables and the jump label local.

> I would rather expect something like this to mimick our expectations
> in C:

I obviously would love to do it more C style as everyone else.
If you can come up with a way to do that in full C I'm all ears :)

> int func(void __user *ptr, size_t len, char *val1, char *val2)
> {
>         int ret;
>
>         scoped_masked_user_read_access(ptr, len, ret) {
>                 scoped_get_user(val1, ptr[0]);
>                 scoped_get_user(val2, ptr[0]);
>         }
>         return ret;
> }
>
> Where:
>
> - ptr is the pointer at the beginning of the range where the userspace
>   access will be done.

That's the case with the proposed interface already, no?

> - len is the length of the range.

The majority of use cases does not need an explicit size because the
size is determined by the data type. So not forcing everyone to write
scope(ptr, sizeof(*ptr), ..) is a good thing, no?

Adding a sized interface on top for the others is straight forward
enough.

> - ret is a variable used as output (set to -EFAULT on error, 0 on
>   success). If the user needs to do something cleverer than
>   get a -EFAULT on error, they can open-code it rather than use
>   the scoped helper.

Just write  "ret = WHATEVER" instead of "return WHATEVER".

> - The scope is presented similarly to a "for ()" loop scope.

It is a loop scope and you can exit it with either return or break.

> Now I have no clue whether preprocessor limitations prevent achieving
> this somehow, or if it would end up generating poor assembler.

There is no real good way to implement it so that the scope local
requirements are fulfilled. The only alternative would be to close the
scope with a bracket after the code:

      scope(....)
        foo(); }

or for multiline:

      scope(....) {
           ....
      ))

The lonely extra bracket screws up reading even more than the code
within the macro parameter because it's imbalanced. It also makes
tooling from editors to code checkers mightily unhappy.

Thanks,

        tglx

