Return-Path: <linux-fsdevel+bounces-64988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F903BF82A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4DF24F7B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C2034E747;
	Tue, 21 Oct 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKWVjebL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557634E74E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072965; cv=none; b=aIDVYAHYDygmalLPWyHOpC1Kxq3wE3xPXNLpEG2x86ud65eWYBhtEZ/5aFFjwlFSNxXpbqzY9ad5hhn/BAkzUSdiXFvu1wGPrxe1cPWODf6F6IaRnY+oKXtI5dM5YdFQi/zcQxQrnOsBFasO16HbPAIJGCT5TdRfw3ftM1FqKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072965; c=relaxed/simple;
	bh=52iR6LmGwh1Tv4WZrZVBPLVN9n+QfjxmRktHCwjQfmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNpbwd5LhTFLVI0yb9R86YWva8kRr+7VYLwXf762LsUOsvIfNbHhAqgg91CmTN840xZa2A9FVfnv7GPb9ynwQjzoekshckey2l4yESkuuaDEt19tuTgZhiVbfhfoXqvNGRzLVgv4DCee+tGckbZDhuzsJTkdzR9E5bYOZtcB744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKWVjebL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fc536b5dso3330534f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761072962; x=1761677762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qgPMRJSF9sIfpOYtKRyUUBt+NJHpNn43neFwkUQbv0=;
        b=dKWVjebLqls33Z8OfQQ3H3nal7dPyv7wN0UBgKwHtTc5+/wvffD6xKCye7Mkwo7Ze7
         RdqTSxNnOBFMLNB9tn+DoUr/qLiQEB8kJMcMX28Cd2g4rX5OM8puFSCvgFO7GDFZw54a
         C5qZ3/iyVqHN8mT0zjZI2+5moLkQDCLxguJRR39iS3LOZ5yJTD18+W/wRSr7nEWZLNyW
         FwJIETX7e68jj+EU0duVJvmpczfx2qQa4wz0AiBQQF+YSsNNZ9TCPKvkbS7klQbXW4n2
         2oQk2Ar4GAnoTVqPCbvDSjOoNtVF6OahvNWD3HuFGl63bxf4XFLSgk2h3mKupR5HWh2N
         2tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072962; x=1761677762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qgPMRJSF9sIfpOYtKRyUUBt+NJHpNn43neFwkUQbv0=;
        b=kdeo/x50F9wSHt8sfiUI/XYyBSBwO16H39tp4atEm0h80YveFiajPtRunHKO9yBBXB
         W/f2b8s1bmeTWjeLvq6pJ2e8mN4wiMRUVtYUhSayVulJMd9Zi0+130886E2X+CrzAq55
         StewfjL6QG9A9qREdLqdea1HzbkGK5C/zMCvop/z2S6aEtFIIZAjCUs8/ziQ1CQhagVn
         8rkyro3LrrAoYVcThQIPac7czS17Ko2oi+nkCPuex/nbOFlCZLKl0Eaofmviouf/H7Me
         wbyquZ3hs4gbimugzDXupcixhWY4axZnkwUc7SD0lnjDIlDGXiDDw6f2wADqGRjc3ZzK
         9fag==
X-Forwarded-Encrypted: i=1; AJvYcCXrmms9c8ujtukD7qfpMLDG/7OoPRpiltEmniY1xY0jhjZGYAe3M9KdmZJvjCQydq6RqPgBfCOi4nO+wjqv@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUQpo4vPoxHp3jLepaTRrGRB47AZD7CfIrfOp6EYoQBX7r24q
	amSJCwaWss3XTGjTs5NpY+qOm+Sr1IR/2zBToRCFxqYWYNhylPD31ItV
X-Gm-Gg: ASbGnctinZhlh+EZ1UETeXjXc4Tiumi0mBPgeJgH3zWqcANw9q8Kye4XK2TB5/C7B58
	42+2dPbcfOH9rkxiriVHYElVlGBaNl8CZReK92HOMG9dahxxv7Pjhkp7s51LF481T4WUPWA/TF9
	Q50FI2fQ/y3OjnP/pW07x3I494MTd/FbKdicp1zBjdtTbFsp+moDYI83WzCHSwESJ6exELzg/lD
	4vi2anyOngeo+hP9R7KAJt7q6s8VH+QR7q280jUQjwRJCNgH0kNBd0blgT2QgG3roDO5vcMW3eA
	mo/DRyuTEMS1tpPpTyBxz+G/6nXDnfMJB4XNm88E2ew5/cXigYTaJz4otXcDGC/dvDjFfVN5k1n
	XTQXSN4UEofNM6ZCT3y61SUvVPJjJdZFdS9uNypy5shZ7ldchAr5J3+A271nMalFJO58nydYyTt
	WRuhPWJbxm1aA7+gQhOPZvkufmVbEnrMI2zyctaMPCIw==
X-Google-Smtp-Source: AGHT+IFjOxufFJONTpxys1bngEKe+lRcQqq+LVDgs/0okuT/Rc8W/l4ZwbhF8BXNqZX3cWqKXviWlw==
X-Received: by 2002:a05:6000:491d:b0:427:55b:cf6 with SMTP id ffacd0b85a97d-427055b0cf8mr13206929f8f.7.1761072961864;
        Tue, 21 Oct 2025 11:56:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm19566507f8f.10.2025.10.21.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:56:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 19:55:59 +0100
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
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
Message-ID: <20251021195559.4809c75a@pumpkin>
In-Reply-To: <877bwoz5sp.ffs@tglx>
References: <20251017085938.150569636@linutronix.de>
	<20251017093030.253004391@linutronix.de>
	<20251020192859.640d7f0a@pumpkin>
	<877bwoz5sp.ffs@tglx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 16:29:58 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, Oct 20 2025 at 19:28, David Laight wrote:
> > On Fri, 17 Oct 2025 12:09:08 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > That definitely looks better than the earlier versions.
> > Even if the implementation looks like an entry in the obfuscated C
> > competition.  
> 
> It has too many characters for that. The contest variant would be:
> 
> for(u8 s=0;!s;s=1)for(typeof(u) t= S(m,u,s,e);!s;s=1)for(C(u##m##a,c)(t);!s;s=1)for(const typeof(u) u=t;!s;s=1)
> 
> > I don't think you need the 'masked' in that name.
> > Since it works in all cases.
> >
> > (I don't like the word 'masked' at all, not sure where it came from.  
> 
> It's what Linus named it and I did not think about the name much so far.
> 
> > Probably because the first version used logical operators.
> > 'Masking' a user address ought to be the operation of removing high-order
> > address bits that the hardware is treating as 'don't care'.
> > The canonical operation here is uaddr = min(uaddr, guard_page) - likely to be
> > a conditional move.  
> 
> That's how it's implemented for x86:

I know - I suggested using cmov.

> 
> >>  b84:	48 b8 ef cd ab 89 67 45 23 01  movabs $0x123456789abcdef,%rax
> >>  b8e:	48 39 c7    	               cmp    %rax,%rdi
> >>  b91:	48 0f 47 f8          	       cmova  %rax,%rdi  
> 
> 0x123456789abcdef is a compile time placeholder for $USR_PTR_MAX which is
> replaced during early boot by the real user space topmost address. See below.
> 
> > I think that s/masked/sanitised/ would make more sense (the patch to do
> > that isn't very big at the moment). I might post it.)  
> 
> The real point is that it is optimized. It does not have to use the
> speculation fence if the architecture supports "masking" because the CPU
> can't speculate on the input address as the actual read/write address
> depends on the cmova. That's similar to the array_nospec() magic which
> masks the input index unconditionally so it's in the valid range before
> it can be used for speculatively accessing the array.
> 
> So yes, the naming is a bit awkward.
> 
> In principle most places which use user_$MODE_access_begin() could
> benefit from that. Also under the hood the scope magic actually falls
> back to that when the architecture does not support the "masked"
> variant.
> 
> So simply naming it scoped_user_$MODE_access() is probably the least
> confusing of all.
> 
> >> If masked user access is enabled on an architecture, then the pointer
> >> handed in to scoped_masked_user_$MODE_access() can be modified to point to
> >> a guaranteed faulting user address. This modification is only scope local
> >> as the pointer is aliased inside the scope. When the scope is left the
> >> alias is not longer in effect. IOW the original pointer value is preserved
> >> so it can be used e.g. for fixup or diagnostic purposes in the fault path.  
> >
> > I think you need to add (in the kerndoc somewhere):
> >
> > There is no requirement to do the accesses in strict memory order
> > (or to access the lowest address first).
> > The only constraint is that gaps must be significantly less than 4k.  
> 
> The requirement is that the access is not spilling over into the kernel
> address space, which means:
> 
>        USR_PTR_MAX <= address < (1U << 63)
> 
> USR_PTR_MAX on x86 is either
>             (1U << 47) - PAGE_SIZE (4-level page tables)
>          or (1U << 57) - PAGE_SIZE (5-level page tables)
> 
> Which means at least ~8 EiB of unmapped space in both cases.
> 
> The access order does not matter at all.

But consider the original x86-64 version.
While it relied on the guard page for accesses that started with a user
address, kernel addresses were converted to ~0.
While a byte access at ~0 fails because it isn't mapped, an access
at 'addr + 4' wraps to the bottom of userspace which can be mapped.
So the first access had to be at the requested address, although
subsequent ones only have to be 'reasonably sequential'.

Not all code that is an obvious candidate for this code accesses
the base address first.
So it is best to require that the implementations allow for this,
and then explicitly document that it is allowed behaviour.

The ppc patches do convert kernel addresses to the base on an
invalid page - so they are fine.
I've not seen patches for other architectures.

32bit x86 has a suitable guard page, but the code really needs 'cmov'
and the recent removal of old cpu (including the 486) didn't quite
go that far.


> 
> >> +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\

Thinking about it there is no need for leading _ on #define parameter names.
It is only variables defined inside #define that have 'issues' if the caller
passes in the same name.

> >> +for (bool ____stop = false; !____stop; ____stop = true)						\
> >> +	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\  
> >
> > Can you use 'auto' instead of typeof() ?  
> 
> Compilers are mightily unhappy about that unless I do typecasting on the
> assignment, which is not really buying anything.

ok - I did a very quick check and thought it might work.

If you can't use auto for the third definition, then I think tmpptr can be 'void _user *'.

	David

> 
> >> +	     !____stop; ____stop = true)							\
> >> +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
> >> +		     ____stop = true)					\
> >> +			/* Force modified pointer usage within the scope */			\
> >> +			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\  
> >
> > gcc 15.1 also seems to support 'const auto _uptr = _tmpptr;'  
> 
> Older compilers not so much.
> 
> Thanks,
> 
>         tglx


