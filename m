Return-Path: <linux-fsdevel+bounces-58252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC56B2B866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F061C1B659A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9630E0D4;
	Tue, 19 Aug 2025 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uGoT7THU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175872614;
	Tue, 19 Aug 2025 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755578650; cv=none; b=aFagF34WO9nsPL3hLqPrp3r4KrUIFuNQ5UnRNskgMf+iRI3yvGIR3ohkjgzfeCJ8lzxQxGv4hVoAClnO2Qr1HAHHpwNkhVn9m5iTikA3fCf3glfxp5PR45w1dzRZHxzGfsy7OHggJJIogMS0kGsI6wl6zm5SCchVCcr4ImOmusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755578650; c=relaxed/simple;
	bh=mXhag/7LOKu3FMbBn+qnQXwdDJg1rk8PC9GagZtNr3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LURugF68hu+/koFnJiSuPwgsvjqN2u2h5GT38tAHDu5uLWwcBHBzejADXGVXqOysuf4siYHINgdaiW2EicOvm/0dS5h7w+PRbRE7JCNHxep9kDXMm0ufC1VdTFxgwCGWJpcZSEYx8G8toGPbXUG1oe89WorW7lvq0YeeKprvcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uGoT7THU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755578646;
	bh=mXhag/7LOKu3FMbBn+qnQXwdDJg1rk8PC9GagZtNr3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGoT7THUU+er5KQmGgenfZhC2u6pkvTOU5IhkRm9lh+OLa6kyLQMpipexnXGgHwVp
	 DgR2hZG3PtCjMrl3xayNFFCGNijM/lQrfcsvulVQ/rJtt7SIeKUwDMRaRNwC/edvO3
	 dgCOcd/W7q+UIYYPqgQDH/10M6ovK9IgQ6NCTjDg=
Date: Tue, 19 Aug 2025 06:44:05 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <9b9b414d-0782-4bcf-aaac-386db96843bc@t-8ch.de>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818222106.714629ee@pumpkin>

On 2025-08-18 22:21:06+0100, David Laight wrote:
> On Sun, 17 Aug 2025 14:49:43 +0100
> David Laight <david.laight.linux@gmail.com> wrote:

(...)

> Would something like this work (to avoid the hidden update)?
> 
> #define user_read_begin(uaddr, size, error_code) ({	\
> 	typeof(uaddr) __uaddr;				\
> 	if (can_do_masked_user_access())		\
> 		__uaddr = masked_user_access_begin(uaddr);\
> 	else if (user_read_access_begin(uaddr, size))	\
> 		__uaddr = uaddr;			\
> 	else {						\
> 		error_code;				\
> 	}						\
> 	__uaddr;					\
> })
> 
> With typical use being either:
> 	uaddr = user_read_begin(uaddr, sizeof (*uaddr), return -EFAULT);
> or:
> 	uaddr = user_read_begin(uaddr, sizeof (*uaddr), goto bad_uaddr);
> 
> One problem is I don't think you can easily enforce the assignment.
> Ideally you'd want something that made the compiler think that 'uaddr' was unset.
> It could be done for in a debug/diagnostic compile by adding 'uaddr = NULL'
> at the bottom of the #define and COMPILE_ASSERT(!staticically_true(uaddr == NULL))
> inside unsafe_get/put_user().

To enforce some assignment, but not to the exact same variable as the argument,
you can wrap user_read_begin() in a function marked as __must_check.


#define __user_read_begin(uaddr, size, error_code) ({	\
	/* See above */
})

static __always_inline void __must_check __user *__user_read_check(void __user *val)
{
	return val;
}

#define user_read_begin(uaddr, size, error_code)	\
	((typeof(uaddr))__user_read_check(__user_read_begin(uaddr, size, error_code)))


Ignoring the return value gives:

error: ignoring return value of ‘__user_read_check’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
 1629 |         ((typeof(uaddr))__user_read_check(__user_read_begin(uaddr, size, error_code)))
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
note: in expansion of macro ‘user_read_begin’
 1635 |         user_read_begin(uaddr, sizeof (*uaddr), return -EFAULT);
      |         ^~~~~~~~~~~~~~~


Thomas

