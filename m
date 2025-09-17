Return-Path: <linux-fsdevel+bounces-62003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B76B819AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F084116B1D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1643002CA;
	Wed, 17 Sep 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkcCRMHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WE8/k5UV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3082FB0A3;
	Wed, 17 Sep 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137116; cv=none; b=exrTQjghBErgTW1/jEtD+U+hJZflpdABJjIBKpVDvukOri++AfM5GBtIZMEMDV+osvrTuYbuRRk/2t6X6XOPGYzPVp60L8oLFaZyxKrp2SPBjuLBnZt7IYznz2ydzJG6Ea+Z6DVDlgN6mH8K0rdpV4SNZbYBulbU744YWX+ZyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137116; c=relaxed/simple;
	bh=A+IkSFLi4yKn4JnkRkwwzD5xfgwB9iMUVof2DllG4bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pipnOWs3+1lPpreJTv1cihcgOl4vvvkyHj6Y1ykLX2ShB/F19euUea7MkSOkA5UAakC/1ZwWPyOFnrN5t29EmmqRlJRrD/bewZ0jnt7YlHDI9DTM9b6cxj+B+XPjDxOfUo6+6dz5qhNKxwJlflHRERGK36DFP6sYHLOtUgJbo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkcCRMHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WE8/k5UV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758137111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqAQXggoclFDa2Uc+OS/GnqoBV+1bK3M22kzAETucqk=;
	b=qkcCRMHlqbHlQ+ihneOeLgC3lXlZ2JlMNJ2yZEfGlusdIjCo0oigXFnfCKhmxcrLIaGEHC
	TKIQ5ISc7+tUerqZm4t/8qO7gz97N2i842L5viLZniXWkaSReoccFIBsqTXmkb/3rV5Eau
	YGCkQLHir6RWC9Io/b6Fffe1jWvkRW/HSDVm9tiMH0lMPsSao/U/ve2o83mgBXP+Agq2u0
	1cum3TQ5wUc1kyv4Yx/3EemOQ7wKoghENrXWUaNhRrODD5ybGPZ1Q2SVUego7OLpmaIwWX
	6eUxEcAGTMU9aquxGISRwa5aPLUkgJBmihhAkDJ1h+Y5u5+iPic+zOX6La64Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758137111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqAQXggoclFDa2Uc+OS/GnqoBV+1bK3M22kzAETucqk=;
	b=WE8/k5UVt+1BxyiG8k75FlR6g4D3mPotvXxc1ALxIcRhOa8husqwKlI6SkcAGLdqS/znDZ
	LRpE13Qp647ioiCg==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Nathan Chancellor
 <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <lkp@intel.com>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?An?=
 =?utf-8?Q?dr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
In-Reply-To: <aMrxF3AnFox0LH8V@shell.armlinux.org.uk>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk> <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk> <87y0qd89q9.ffs@tglx>
 <aMrREvFIXlZc1W5k@shell.armlinux.org.uk> <20250917171424.GB1457869@ax162>
 <aMrxF3AnFox0LH8V@shell.armlinux.org.uk>
Date: Wed, 17 Sep 2025 21:25:09 +0200
Message-ID: <87ms6s990q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 17 2025 at 18:34, Russell King wrote:

> On Wed, Sep 17, 2025 at 10:14:24AM -0700, Nathan Chancellor wrote:
>> On Wed, Sep 17, 2025 at 04:17:38PM +0100, Russell King (Oracle) wrote:
>> > For me, this produces:
>> > 
>> > get-user-test.c:41:16: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>> >    41 |         (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;                \
>> >       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > 
>> > with arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0
>> > 
>> > Maybe you're using a different compiler that doesn't issue that warning?
>> 
>> Maybe because the kernel uses -fno-strict-aliasing, which presumably
>> turns off -Wstrict-aliasing?
>
> Thanks, I'd forgotten to pick the -f flags for building the out of tree
> test. Yes, that does work, but I wonder whether the powerpc 32-bit
> approach with __long_type() that Christophe mentioned would be better.
> That also appears to avoid all issues, and doesn't need the use of
> the nasty __force, address-of and deref trick.

Hmm. I just noticed that include/asm-generic/uaccess.h does exactly the
same what I did with the per size case variables and that seems to be
not subject to endless bot complaints either.

But sure, the PPC trick is neat too. No strong preference, just that I'm
leaning towards the per case split up as it's less obfuscated IMO.

Thanks,

        tglx

