Return-Path: <linux-fsdevel+bounces-52862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38573AE7A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F9F165F28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C697275AF2;
	Wed, 25 Jun 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9w9Eu2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192926E716;
	Wed, 25 Jun 2025 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840247; cv=none; b=cVDvUVyWSllj9kqGr6tGmEM1hPex96oEBuJSEMyWrDnOUlXvuc6Jc+Smd78BPUcxu/9S2S+rnaJ20R9Vd/VTA9SuaI4UAyrCzEklWw6f7+eTYwKTwVdbM7Dy6veIrCrOWpXywiMT26u+s521m7X7+H2VEdkkn2Am/Y6xJZycUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840247; c=relaxed/simple;
	bh=8QFAJ86d0MGB6UGV+yBXTFPGaiCI5SxyEXhxguHfF9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCZO5lXx4bP0/j/+VGL1AP3LEhGlBW0zxkOhDY17m/8hWv3g19Bofk1+SbzzssWIosheeSRdq8HYMoy/4wp6zdhIUIDqEI4MOXq026xyCkhtkJOauMq3BJa+mFY+GSQrArVy8tgbbCsYeAaL3YretQUpLUoQ+BvIJiP9F6NYPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9w9Eu2K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45363645a8eso10428365e9.1;
        Wed, 25 Jun 2025 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750840244; x=1751445044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWZO9vBydLguvscfxtiLRMgmMbnzb9l8oTdYX/pGmn4=;
        b=W9w9Eu2KiVf7DF7RVBnvYUwo8megURo0zSqVI3xnMBlkBCGWfphFghznQ+5jHtxnk/
         Dro+yGBXN9f4js5Poe0MP2aOMuisjkqtwgDUaTRJ8ApqLpJdrNwyJqVcG/be6OA+uD07
         7lMgUXoVjqJkKsN0bEbivV1Gnpo+SQ4yMaa9G1DI0dkByzzLjMCgxVQSDO6YPU0YwmOc
         NN1GFNPw+sECxDkYuBFSU3K4BQQjIM19Qjl4OIMbGd0OVNWyATj7DzRB0SU0h44YHPp2
         pOUnYedtgS8Faq4BL1gNL6JZqAfV6lYVAyyBWBJ93aH1/0cG3k72laYdmEbyTR+hCrH7
         Va8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750840244; x=1751445044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWZO9vBydLguvscfxtiLRMgmMbnzb9l8oTdYX/pGmn4=;
        b=bKqEr8msxtr785oLYPmsLbbbq2fVDwmS+lyDBICpJXy82mso+338vPocKzdWsVMofh
         VxZKryWRhzUOr94z/V5n3NKvqlEBmDvr2o1kE3Wn2IIenQk24a+gKWa2Ey4ZTXGeIXiA
         MQOZeiost4VjC5BaFPsVJwkpyYD9MO2MJrCqhxje0Gab8EnC9ohdW4KyBI3ujokg5bpj
         eEEW8mv/IOJroBbmS6oRiRu2RUciva8fQLmfl50Qj0JGxIiBNIsWiWdPHu7R05TwXww+
         +emnJqm1pQ9CacXEvaHAzFc1EOsWGjK5IK4Kjds4uAWYXO15S4z64/2lwJ6NG0gAOUjg
         D6bw==
X-Forwarded-Encrypted: i=1; AJvYcCVD4z5hl6twuJ3x8OfTC7NAwPPgIDgjdhOf2wHf93pVAQx0D76/cOJoh94loWXoNNbOTkjQYb3wHNOujU8l@vger.kernel.org, AJvYcCXLuvVR97ednpjVW+q0WrDIhAkGDuLuO1H8KnDV8ORnpvL0ru32bB1JpazU2uv+/bjQwazFhEtHMpvWGQlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7K14M8rH1biGFsTKHXIHgQn0+I+Qon77U61QpwNgFjG7BvgmB
	GMT79OflF4YuQY/vhTvwQVd5whl+JrgXaf2G9ySOtaJyy/Pl/BDmYs4o
X-Gm-Gg: ASbGnctFL7fzgDh7BnsTsqrdJWvayDIdgzP1ppBqTflznXYzP0mI72+bf0Aj68nqCKT
	QeAEfkdVI/sTSEq386YSaKjCo5iT9/LATtDoR51xCuc7Qsek9LiObNNRPR0w37SiECcNvLCSlFn
	/hc9G/NFDFQgrWHdOcurYqkz96gqe63n3ytPeL9t6jwUHjoZf7grqamczNIr1GQJHa/4nlh0pMw
	+xavivcAaIPabIMECydBIAjLbAj9ZjxOGGtp3/x9k0dHA2lylaOMkTGFzzgNiqz1B9QPRuW6Aqh
	vgdKocxhcglasl2WLJRou+0GNgWncmV6Khu54hVP1nZwykwqaHX1RYHioLbigujSfbaRNij2YQ6
	mKRMDxVJAVvhkWtYh78ZotMJM
X-Google-Smtp-Source: AGHT+IE9XkEDDWe5avnMKVyJiktIxY/anhzBr2iUjPbEYXho5HvfSLdB5xhpcwci6yKEnr3ElCb9VQ==
X-Received: by 2002:a05:600c:4e02:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-45381add658mr19874775e9.13.1750840244055;
        Wed, 25 Jun 2025 01:30:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538327fed8sm4463545e9.1.2025.06.25.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:30:43 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:30:40 +0100
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
Message-ID: <20250625093040.7a7eaf3e@pumpkin>
In-Reply-To: <20250624213712.GI17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622172043.3fb0e54c@pumpkin>
	<ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
	<20250624093258.4906c0e0@pumpkin>
	<20250624213712.GI17294@gate.crashing.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 16:37:12 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> Hi!
> 
> On Tue, Jun 24, 2025 at 09:32:58AM +0100, David Laight wrote:
> > > So GCC uses the 'unlikely' variant of the branch instruction to force 
> > > the correct prediction, doesn't it ?  
> > 
> > Nope...
> > Most architectures don't have likely/unlikely variants of branches.  
> 
> In GCC, "likely" means 80%. "Very likely" means 99.95%.  Most things get
> something more appropriate than such coarse things predicted.
> 
> Most of the time GCC uses these predicted branch probabilities to lay
> out code in such a way that the fall-through path is the expected one.

That is fine provided the cpu doesn't predict the 'taken' path.
If you write:
	if (unlikely(x))
		continue;
gcc is very likely to generate a backwards conditional branch that
will get predicted taken (by a cpu without dynamic branch prediction).
You need to but something (an asm comment will do) before the 'continue'
to force gcc to generate a forwards (predicted not taken) branch to
the backwards jump.

> Target backends can do special things with it as well, but usually that
> isn't necessary.
> 
> There are many different predictors.  GCC usually can predict things
> not bad by just looking at the shape of the code, using various
> heuristics.  Things like profile-guided optimisation allow to use a
> profile from an actual execution to optimise the code such that it will
> work faster (assuming that future executions of the code will execute
> similarly!)

Without cpu instructions to force static prediction I don't see how that
helps as much as you might think.
Each time the code is loaded into the I-cache the branch predictor state
is likely to have been destroyed by other code.
So the branches get predicted by 'the other code' regardless of any layout.

> 
> You also can use __builtin_expect() in the source code, to put coarse
> static prediction in.  That is what the kernel "{un,}likely" macros do.
> 
> If the compiler knows some branch is not very predictable, it can
> optimise the code knowing that.  Like, it could use other strategies
> than conditional branches.
> 
> On old CPUs something like "this branch is taken 50% of the time" makes
> it a totally unpredictable branch.  But if say it branches exactly every
> second time, it is 100% predicted correctly by more advanced predictors,
> not just 50%.

Only once you are in a code loop.
Dynamic branch prediction is pretty hopeless for linear code.
The first time you execute a branch it is likely to be predicted taken
50% of the time.
(I guess a bit less than 50% - it will be percentage of branches that
are taken.)

> 
> To properly model modern branch predictors we need to record a "how
> predictable is this branch" score as well for every branch, not just a
> "how often does it branch instead of falling through" score.  We're not
> there yet.

If you are going to adjust the source code you want to determine correct
static prediction for most branches.
That probably requires an 'every other' static prediction.

I spent a lot of time optimising some code to minimise the worst case path,
the first thing I had to do was disable the dynamic branch prediction logic.

	David

> 
> 
> Segher


