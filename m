Return-Path: <linux-fsdevel+bounces-65105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB663BFC6FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046A01A05910
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B134BA59;
	Wed, 22 Oct 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXUpJ+YD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AC34BA29
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142813; cv=none; b=TYuRfsjsXm61S+rLl2F/TbThadPBKA3OTTAGe5q7xSTJef5Rw1LXj9QBkb8AmEHRKNv879+kb4fbIPwLr+CUzxWonMpBnm1FzMFh3yyT7frChixri8gGV1BT0t5OS/8w2UIWhEY/4abzc9rSs7ao5SOQ2ESauLURUQlo8ZcZDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142813; c=relaxed/simple;
	bh=NwZ3v2qm3tb7kvUbWrw6uW7qiocAFO8+8xoF6L5Hm88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFEEE4VERaBmJ2XOJmi2yrTpANUpWuUVvJFyNgDA/FooV7r97zx3zftXaK3GasiBqlSU+MEmc5nXIAPDWazwkrx169Y2r8iDCaFNlXbe+QdcEH06qgfKAAxNLVW1LNhAfmWrUNOAv1HwycgoljacePl3eaZf4rGGLo5CGSGY0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXUpJ+YD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471075c0a18so73157265e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142809; x=1761747609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcGPa9BZoRh/cXSf6MM7skWFc5+sWNLhhAzz4IrXMW8=;
        b=QXUpJ+YDHO2hZydw3IoAUvS/ktOXG/rHqwXvAed/PpPEFgCzNNUKuHL57hSlEDJZxb
         eHzPanmF9Gx0TuvKil1Xu4JlopB9l8Bmz+mZMrmhExmOZUPftiCzM/8Otta8RjemGlC0
         3IUjcokvs3oiqXnrU0dKGu4uGUf+pILNAZfsTcjylULaKiHLcliJ1QcrsLWjGOPyKatA
         7o5fQAPYVmId7CK4hq0+9qcfMdR663/GG50DP0NVGputN+adrd68aEkV1Mh/VEzzGjym
         rKZZBrMfTJS8zLOZmYZY3RMD+Stqf0Ne60KdK191n25ok/mx0t6tQtGJe8ZRbQy9PqYX
         WV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142809; x=1761747609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcGPa9BZoRh/cXSf6MM7skWFc5+sWNLhhAzz4IrXMW8=;
        b=Rq81c82KphtdTzsmV361FCbyTDodJQat/h2Vdd8kz8/bqqN3xDldAZIC7DU/LbTcCr
         s8xIFDSH4dJD8BK6zsyn3+PqKR7MAc9vbcXuxN9Z3kb7WvY7uKgLpaOAdBpf9mG6kd3O
         uuKdnLKaTqNM2rRag1M0b4AnB3OuRjNle5v75hEZmfkMyFdHObIQT4X8omo0dWh4xyXq
         6G5jWTXpVo3YN0Xe7jbIFN8mx/mj6mDG23yaGaGSgheX1Y+PjnNW/TRVPYVkJPhGEN0q
         SW7lmhgI4WKpH51TKSIzpuq1eWEnCMNmt7REoHpyGT5z1YtXVLXQsCX0zi1zajOk/jOE
         IUWw==
X-Forwarded-Encrypted: i=1; AJvYcCUR45FHeZvUeuq8dBcQKmwlxnWayIEgWhAF7SPRes/oOYRPlQdqtmVCwj4PYrTk/IQLi+1TRj2c/lCDbLa4@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtVf10qaYa/2o4q16uXwKj1WjPWC4vPL16I1/ugKwD06lTRGY
	th6TOXaXoHgfczolmaW88l2nojhOk6sBUez5CME1g/bPJ7TIZ3FctPBf
X-Gm-Gg: ASbGncumSGHTsipmG/vvLhLpd0OlumvHePDPGvdMkg4MkyXVsKITXxk0zDRmGgZQcIy
	E2ZiHspLr/1ZUtONPHGkEi4IBypAMVDsfZnueBYZljpj+QaqBPeI7Bzg+JIT29EpEvv2W/3Mk+O
	VvFlbHVcEd5kg6pGzx6o4214SnOnj32bsoOS2LRIEDfbJFv6vIZpG6bJ9DBN9qolGKjBavoOCym
	FCHsbwbogK0w15K6aIrnD1/HjkQKRUTC8vgCr/a7w/umS6VIoSWOaXYfPiKn5uCNY0TYrRNg/Kb
	nwc2CzyhoUokks4/JEfnMQy/X/QmZMghWHM3qWj9GDNUjnwRdKa/FaKtIPkr183BeURPkfaPFJj
	CJJQg125zUvB/0YJogNBVmGmi4n3zrX8MnCaIR+geIiiwmrSZ+CN/49DQSm5nROwHUe/2yAsNvB
	2d1Fqp40VQ3B3BGIgQxIRxLHu3dZJr4VOTcyLxJGm1w/MPacOdi3OO
X-Google-Smtp-Source: AGHT+IHX7Sum1LYsRGk4yzm8MqGMXKVdeHe0F7N67aNpUhUFJkxVcT5YpUlblTfJtsz2LXnINVBACA==
X-Received: by 2002:a05:600c:3e05:b0:471:16f3:e542 with SMTP id 5b1f17b1804b1-47117870720mr183174425e9.2.1761142809122;
        Wed, 22 Oct 2025 07:20:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428c62fsm48753105e9.8.2025.10.22.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:20:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:20:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 07/12] uaccess: Provide scoped user access regions
Message-ID: <20251022152006.4d461c8b@pumpkin>
In-Reply-To: <20251022103112.294959046@linutronix.de>
References: <20251022102427.400699796@linutronix.de>
	<20251022103112.294959046@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 14:49:10 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> User space access regions are tedious and require similar code patterns all
> over the place:
> 
>      	if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> This got worse with the recent addition of masked user access, which
> optimizes the speculation prevention:
> 
> 	if (can_do_masked_user_access())
> 		from = masked_user_read_access_begin((from));
> 	else if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> There have been issues with using the wrong user_*_access_end() variant in
> the error path and other typical Copy&Pasta problems, e.g. using the wrong
> fault label in the user accessor which ends up using the wrong accesss end
> variant. 
> 
> These patterns beg for scopes with automatic cleanup. The resulting outcome
> is:
>     	scoped_user_read_access(from, Efault)
> 		unsafe_get_user(val, from, Efault);
> 	return 0;
>   Efault:
> 	return -EFAULT;
> 
> The scope guarantees the proper cleanup for the access mode is invoked both
> in the success and the failure (fault) path.
> 
> The scoped_user_$MODE_access() macros are implemented as self terminating
> nested for() loops. Thanks to Andrew Cooper for pointing me at them. The
> scope can therefore be left with 'break', 'goto' and 'return'.  Even
> 'continue' "works" due to the self termination mechanism.

I think that 'feature' should be marked as a 'bug', consider code like:
	for (; len >= sizeof (*uaddr); uaddr++; len -= sizeof (*uaddr)) {
		scoped_user_read_access(uaddr, Efault) {
			int frag_len;
			unsafe_get_user(frag_len, &uaddr->len, Efault);
			if (!frag_len)
				break;
			...
		}
		...
	}

The expectation would be that the 'break' applies to the visible 'for' loop.
But you need a 'goto' to escape from the visible loop.

Someone who groks the static checkers might want to try to detect
continue/break in those loops.

	David


