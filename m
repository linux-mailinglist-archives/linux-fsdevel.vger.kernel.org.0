Return-Path: <linux-fsdevel+bounces-54013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330ADAFA132
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9D17F9EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD12144D2;
	Sat,  5 Jul 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VorXpLZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A42E371C;
	Sat,  5 Jul 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751740419; cv=none; b=qPNXy1kjbltqWUejosIgZ0wWXCeh1yPGMwMLBu2qOiFOdcB0ERkKSxyEis+jliHsawI7BciFSPEu8WbWR3cb4RvqU8VeYrJ8uCQyzlRUoNckku3S86Gj9tTtpncyNDvffqjcX7V18kh90io5n3wrhyND0U3CvHzDMiQRQuR+v5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751740419; c=relaxed/simple;
	bh=Gc/F+S20xy6IEWjcHHKIJuP7P9jFj8/NPcHz1gQVI+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTNcjd2kLWp1kYdUWoN1AKD7dB1EtQ2hRdR1z2wjgrKVnYWoyC8RX6lz2n4iHNNlB0llUpS3/jZDNHlvTei0yYG0mXeOzQP4gdz4DaNp7wTUTtlPb4ivpdW3qNZfeJspNzJ52OnNekt1te8+4nYeNHaBGjv5WlzRx0b/wJ1t9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VorXpLZZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so16893515e9.3;
        Sat, 05 Jul 2025 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751740414; x=1752345214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBiXD1gpNqEKHSH9dRs/IIiAb96ceShYwWC9AuMfQh8=;
        b=VorXpLZZUp6erLbhAJmj8zgGmp1IYGMK10n1n6/AneR9D+AkneWmAS8qLheuHvsucl
         dtwKCf3UTkM7ST9CsocO4WVDd9dGWQDWeWrWEeuUZenwrQXAOGmNJbCD1GsQNf5aKfec
         bTpPaO6RUbbBi5Aubo5qf3g5jp+/fKqO53Ww62xegLtyEE2uxPiDDoIWkx8fUyiRWSSq
         Ej+4iY1VdkJ9Qyk8XqDV4hC6YhKNg/J3o7/bFPjuxzBdoul9TXuAco8CWdWJ1N34RBPP
         9zUVZPRybIJgurej8cfgP7rQ/5DOuKDwlrQDTJ7Wzztwo8SkGlYraTAU4qbdtRoSTYMl
         rY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751740414; x=1752345214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBiXD1gpNqEKHSH9dRs/IIiAb96ceShYwWC9AuMfQh8=;
        b=Wk0crgxmBuR+R7nxRx+BjmFJIkPBy5Alut3X6w5qxX2V/IpJX19nLB9iNTve4lY73w
         G4lI1u8PoLhg3msccxR/8vLMBg9KkVF0gz7V5eKqd3KDh2yotit8sDidZfhWFmt6RuR0
         kMNZG2+PcVkVdpYDkc1k8E9fIJY887QCBRYh0KmT4xfNY/EyFu0amXaKZWGupoUOkUMN
         wj4KmWU4sV4DEMjZ9sisYYukUdZBUPKL1uOtI8C7tPmOAvwHIiisclsvUquz/8uR2qTj
         1dwvnkWMSe9Gzc5CyeL2DqsDsGuJ522deLkHhVCFkIfiwhPmFGeFvBO5N/BZSiJpOjoj
         7jVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5srooSDv+0ZqS7FkeAXjyQOtvJ4DtBW/A8CNEEWdTHS0VzfSSt3Dfhh9il4di1+A4Soz9GDIZxjsEK/z/@vger.kernel.org, AJvYcCWSQcX1F7nKBLvJxi6Q45iD/y+t3KsWXGAv0vuguFR0IL75f5126Wu1qmlfghJ0ga025Tq71glNc/hu+cIS@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEF2qp3wQ3sXYkRhTBj7VlWvtTDPpdpFOREtpvimy02LBP6X3
	zTT6n3k13uaFzMuqQlXsqDow6m+MKkLfuOVkgtTPvt2eZntAc8eU+yHC
X-Gm-Gg: ASbGncu9KEoibIdFACUrQsrfwGQxiPGaKbfm99RbYnqak68EB2tTOvFm6llol+J6xLe
	MYYxadnBGBG+xGN3/+J+LUvC26Ia+azxg/eZv0H4rGCsVhSXH8TzUgTeFJfx2z4dIdijVlr9tj6
	uiyzvem9NsSuXi1+YUPatKeAo/yKzytFFoteyY54DTOOtFu2ikDIZ7dNbsiKSPIqwPqZWXFGtfc
	qEcwkg2FIDzJlL+Z3U7jHC0tGXs/znWPQRO2nO+fl/uLDo24NaRWokQ/uPwhwEv3Qs64tjBffCg
	ghrhwGW8g7JuBe+e4knLo9QWfJqe8hATLIqlZpX1bLBSR3mx2vQj3scnxDAnWcfOG0y8BboXgF9
	HWy2/+KsRxpaJjZBo+w==
X-Google-Smtp-Source: AGHT+IG4wXxZJ5hURR9oKdPo1xtppRKhWiRw6KIdA9TlPv/AhIuF4jp+AN7AyHaQ8S9c1NeQJys0UQ==
X-Received: by 2002:a05:600c:3f1a:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-454b4ec2132mr69540735e9.30.1751740414244;
        Sat, 05 Jul 2025 11:33:34 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b168664bsm61780085e9.20.2025.07.05.11.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 11:33:33 -0700 (PDT)
Date: Sat, 5 Jul 2025 19:33:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250705193332.251e0b1f@pumpkin>
In-Reply-To: <20250626220148.GR17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622172043.3fb0e54c@pumpkin>
	<ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
	<20250624131714.GG17294@gate.crashing.org>
	<20250624175001.148a768f@pumpkin>
	<20250624182505.GH17294@gate.crashing.org>
	<20250624220816.078f960d@pumpkin>
	<83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
	<20250626220148.GR17294@gate.crashing.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 17:01:48 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Thu, Jun 26, 2025 at 07:56:10AM +0200, Christophe Leroy wrote:
...
> I have no idea why you think power9 has it while older CPUS do not.  In
> the GCC source code we have this comment:
>   /* For ISA 2.06, don't add ISEL, since in general it isn't a win, but
>      altivec is a win so enable it.  */
> and in fact we do not enable it for ISA 2.06 (p8) either, probably for
> a similar reason.

Odd, I'd have thought that replacing a conditional branch with a
conditional move would pretty much always be a win.
Unless, of course, you only consider benchmark loops where the
branch predictor in 100% accurate.

OTOH isn't altivec 'simd' instructions?
They pretty much only help for loops with lots of iterations.
I don't know about ppc, but I've seen gcc make a real 'pigs breakfast'
of loop vectorisation on x86.

For the linux kernel (which as Linus keeps reminding people) tends
to run 'cold cache', you probably want conditional moves in order
to avoid mis-predicted branches and non-linear execution, but
don't want loop vectorisation because the setup and end cases
cost too much compared to the gain for each iteration.

	David

