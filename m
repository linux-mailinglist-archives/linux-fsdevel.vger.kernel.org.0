Return-Path: <linux-fsdevel+bounces-61985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDFB81614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961D71C2643A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567D3016E5;
	Wed, 17 Sep 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXH1VgXh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+8bpede"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4627C178;
	Wed, 17 Sep 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134659; cv=none; b=moIxVPAN+hOiX/HcDRgZgoH0Vp4V0FypEe0wslVtm9hJWlRMbe1Y51sLQpCJgsbfnsXnLVvV57uq5VaF+MK8HhtByMrlgoA406sGxJrJOXvSqllS2pjRrTqmpUqGXvPxCHWQrVOO6WDUrvKIsVXVHuKf8hB8HF8kuENheKtZfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134659; c=relaxed/simple;
	bh=mLQvr83zXMuYbaFkYFpVFQjJVMPu9z91kx6ntqCZRyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7lM4fDy4qQ7SSUvMgbNggYgrMoRmJDcIWbh+5fYfSjhzm2el4zLzZYKkz3ByWtgxDGkzL0SR2A2gfJKZUjM0/2X0LWzb5by4p8LVfzG697SDFnXyQMRxZavBb2jU4rDQOIaKObllEnb1qp+LpuWrKVqk2GtullPAJCyMKUzpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXH1VgXh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+8bpede; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758134653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZdhtdKmHa4dcSzhRJFOXRlBZfjh3uIPp6tQ1wYV5bo=;
	b=TXH1VgXhl9TJVLj2OH7Oa+fCy5KEUeSVC6i7C/B3Ch+CUD092lLvRy8+xwQTjJSvI/f5e/
	eCeA/9+a0bV7sx0ApCME8sCLslc16fzzcvXWQZ69KshZDFeqfU75hwHdmZr4qRoDeUJfnV
	9Nvgr5Lv5QN9HIQ2fRBqTfQeGJF+2Gs3D0qJRxGLtoyFEGkhf3MA/PsqA06mrLAr9+AjlH
	Ts7pW6mp6BXFXIy6/0gYGmjzC3OgGy444zbBQKIPt+n8ivbeJN5ObybKfgMwVR4iZez9Ym
	Qw2V7y+ci52ovVJ8vEvO6KZ+He1hJaLHm5MUQ9r1a9TJPSE5WSLv56nl/yZlrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758134653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QZdhtdKmHa4dcSzhRJFOXRlBZfjh3uIPp6tQ1wYV5bo=;
	b=6+8bpede4VR2LubUInjqoSUX1qxsOYmZ26JvPspTyzYGmmDUQGN/m43/bFNknXNpngwOQc
	ccNZYt4Gya//BQCA==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <lkp@intel.com>, linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
In-Reply-To: <aMrREvFIXlZc1W5k@shell.armlinux.org.uk>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk> <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk> <87y0qd89q9.ffs@tglx>
 <aMrREvFIXlZc1W5k@shell.armlinux.org.uk>
Date: Wed, 17 Sep 2025 20:44:12 +0200
Message-ID: <87plbo9awz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 17 2025 at 16:17, Russell King wrote:
> On Wed, Sep 17, 2025 at 03:55:10PM +0200, Thomas Gleixner wrote:
>> But it actually can be solved solvable by switching the casting to:
>> 
>>     (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;
>> 
>> Not pretty, but after upping the frame size limit it builds an
>> allmodconfig kernel.
>
> For me, this produces:
>
> get-user-test.c:41:16: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>    41 |         (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;                \
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> with arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0
>
> Maybe you're using a different compiler that doesn't issue that
> warning?

Yes :)

Was this with the one-line change or with the full conversion?

Thanks,

        tglx

