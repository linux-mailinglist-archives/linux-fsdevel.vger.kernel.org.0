Return-Path: <linux-fsdevel+bounces-58213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F1B2B34D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 23:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E923B4471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B2266EE7;
	Mon, 18 Aug 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRy6NIba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D36223DDF;
	Mon, 18 Aug 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552073; cv=none; b=fnSx2mnYx4Dg5BB9N7U8RE6Gg2YVcZ/3Uy10rWhEOalzPbAlv/2Q7/0ZkOwaL45mD7ccWUvaZWj2WvF2XOwX1MJ1jJqJnpCgf9XGMxSnT4eSikkuxZLIK9vXF+YScMt1lljW5zSr+w6Ei9NNpTIw1NpaiLcqYWg0b5eVtiZK/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552073; c=relaxed/simple;
	bh=8sYxEPPi5m6As2djnx+RUdD2DWFle8xZd3DGnUL2Uyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDWDn6KN7IMBXjzov9+k9j9b9rdLl5l7xd02zdSEKXLeC06UoCKlBDUxfgWyxoBtC7k9UDgf00eBJlzcKjjkqbOhROwbQKVcRpA/TSw5PUdAcV5qmLairl8VmMhvOYKCPSTF/+jFAHUGPsVHow55VdX/4vqd6jusJCOBnBq2z3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRy6NIba; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso32619035e9.3;
        Mon, 18 Aug 2025 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755552070; x=1756156870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mq5OOEmUE9OkgN/VAU4XTp9x+IbIBr1PXu6WZVa1WQ=;
        b=gRy6NIbavEVTvVJoPpyAG715kJPRGDwiluehhS/DqH3YExDDF6z/lcVDP5dTXWwRBt
         5laBolh4nrL0QjVx10YGVwTxXAd/upMViLWWbwBfYncb5Q2/nwCHPtndIQatiViPJR1g
         uw7ymtaZC+tmw7zj6scp8RfFjMn2dgMAjlTXBC0prv6GoFbV0+cfK4TgFqOp9Z8VyDPO
         t/zH5tC1iUmxK3TwiH7DFHrRd0vKes8gIp75n3imv0yc8dluCeTBGpxCBnCujb5dIZ50
         /Hn5aXvZMA2EX/mQnoHVpySG3dKKMLQzGXhwuGPqkj3LBMgYY+foekuGaAyttsu4i+7V
         KL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552070; x=1756156870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mq5OOEmUE9OkgN/VAU4XTp9x+IbIBr1PXu6WZVa1WQ=;
        b=X0s2wpwyDZWOf9uf2lIxuD5ysSVdWJQve1oJyfzQdpdqR1fsT2cuwWpWBLJUhta7td
         XTBZYTPLeoySQNLTMO4vRIu2ddMgTyLYrY7VWpltg1yE3wR3MpuuwRXO3X3ehCBFj/ad
         IwJ0wsIxTArdWB0WgWAaNk4g3JeXDWM6vcXAPs5qsYy2NF4f2zFEEPcRhixtVmfq4dnO
         oxoIIWpAYplDtnjP3Hy3E7TSGypZchyr/nyPTDTNBJ5HpIpbh9OanKbMS5JWwil7M/lP
         VVSZOCzt8xJRkCH2gE1apJbidYkxGVwMPT8p4As3ji3B446bM36W9Zn/uyLRysCifntI
         QDrw==
X-Forwarded-Encrypted: i=1; AJvYcCXvgw658G2ZVGO4EcFK9mauMuKkbFHoeGrV1ofWbfhRg+IK9f+Kamb689vyKpUj60Pa24wZ7YEALx1Vm38p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+stMYiiqBQwHsmOsTe8Pvlz5sbIPSLAqqKI9Fhw1Efw6L2s8M
	5VNGAneXEvQTW237yf9HESfqKd653YElyNHHDvV2Q+lUmQBmkLRAAApk
X-Gm-Gg: ASbGnctO+/RrPGajS7fBSrklCTkt8xvXqWzcX/bNhMkNuVYqvU0HgYBuvDZ1zA3OKBq
	cYvV0dRXV9qFUHoq1J2ycnPeScHCkr5TkYmdDJnfwTmx2joX48n43DPMZnLFG/++nGk4QG/DvWq
	pwdcQ8qU5IRGXbTJ3Ymiz9+gAqQLb2TZmMg5+o8fMXotNxuGFXDUInl44u4VpIRT89xlthZxg/V
	huTKYpbxxbhiC52foV3rY3IkU/G8Qig+4FZAuSWsrEjQj+qDccc6hCuj/d0fkAEbRM+WT0r3eAj
	jT4lJXlW4YFNsmjBschJs/bIwqoxpM4f+mClfml4FdeZKhbkTUTTJa64fkcqvaYjRtAGDhHuGqe
	8dct/Q41oPpCH38CN+bOEBO9zYdtCWcNeRSRZe6gfbc/Nb5fy+nd4g/fJa74z
X-Google-Smtp-Source: AGHT+IFjeJcl/CIROyINJYz2N4GIyL7wH/l6ez3R9eVxdJEOCoo9/uJ8oeF1uCKxLhDwqBW8u1rNuA==
X-Received: by 2002:a05:600c:1c0c:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-45b43db662amr522955e9.3.1755552069892;
        Mon, 18 Aug 2025 14:21:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a6d7b7sm14313195e9.1.2025.08.18.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 14:21:09 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:21:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250818222106.714629ee@pumpkin>
In-Reply-To: <20250817144943.76b9ee62@pumpkin>
References: <20250813150610.521355442@linutronix.de>
	<20250817144943.76b9ee62@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 14:49:43 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Wed, 13 Aug 2025 17:57:00 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > commit 2865baf54077 ("x86: support user address masking instead of
> > non-speculative conditional") provided an optimization for
> > unsafe_get/put_user(), which optimizes the Spectre-V1 mitigation in an
> > architecture specific way. Currently only x86_64 supports that.
> > 
> > The required code pattern screams for helper functions before it is copied
> > all over the kernel. So far the exposure is limited to futex, x86 and
> > fs/select.
> > 
> > Provide a set of helpers for common single size access patterns:  
> 
> (gmail hasn't decided to accept 1/4 yet - I need to find a better
> mail relay...)
> 
> +/*
> + * Conveniance macros to avoid spreading this pattern all over the place
>     ^ spelling...
> + */
> +#define user_read_masked_begin(src) ({					\
> +	bool __ret = true;						\
> +									\
> +	if (can_do_masked_user_access())				\
> +		src = masked_user_access_begin(src);			\
> +	else if (!user_read_access_begin(src, sizeof(*src)))		\
> +		__ret = false;						\
> +	__ret;								\
> +})

Would something like this work (to avoid the hidden update)?

#define user_read_begin(uaddr, size, error_code) ({	\
	typeof(uaddr) __uaddr;				\
	if (can_do_masked_user_access())		\
		__uaddr = masked_user_access_begin(uaddr);\
	else if (user_read_access_begin(uaddr, size))	\
		__uaddr = uaddr;			\
	else {						\
		error_code;				\
	}						\
	__uaddr;					\
})

With typical use being either:
	uaddr = user_read_begin(uaddr, sizeof (*uaddr), return -EFAULT);
or:
	uaddr = user_read_begin(uaddr, sizeof (*uaddr), goto bad_uaddr);

One problem is I don't think you can easily enforce the assignment.
Ideally you'd want something that made the compiler think that 'uaddr' was unset.
It could be done for in a debug/diagnostic compile by adding 'uaddr = NULL'
at the bottom of the #define and COMPILE_ASSERT(!staticically_true(uaddr == NULL))
inside unsafe_get/put_user().

	David


