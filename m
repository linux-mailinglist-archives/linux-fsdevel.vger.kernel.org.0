Return-Path: <linux-fsdevel+bounces-52407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC8AE31D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799FF188F9B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021D1F8908;
	Sun, 22 Jun 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt8FEs0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4145163;
	Sun, 22 Jun 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750621875; cv=none; b=C7eLJdif35aboBdg4V/BCNAAoTGdskf8wnjllu87d7Rv/urY6+LtD8JE4m1YX43wW7qJGgszGSEK/H60QPp38fa1dBswmfSPmBygq55SvyC9bm0yxVCDybO5W8UQo3HOfeLHRuuk53B9Tomy91l/HVmQpVYRmujCvIQlIFSUQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750621875; c=relaxed/simple;
	bh=ON2CfoueUnnCVOfZXRk4YWo97VgW9iBkO3c3sM+N2Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGM5BGzAk3fuJbRdPRxPJdJ8dRnAUOgUZt575m6eBjRZXYF2CedtsNxkWuHGysEtKeMvHQIIsnkmIUdJ3iF9Qswyyd++oH02Jep0/f9iLymtqrfmyrPucQYbCYZar7UksODjMTgMPyFPiJbBMDP8mfFJcwIbOlQ1ZmIWGwcMHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt8FEs0a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so32740035e9.3;
        Sun, 22 Jun 2025 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750621872; x=1751226672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUcrx2SGK4k7VspPrA1kZfeY9CvCdk1bQCrmf4AIFEs=;
        b=Jt8FEs0abIE4Z9XEQzqw/3vPJlmZAHIAT7s4FST+BUTTnlPV+Twbvx0NyLQoXWSYYS
         sDAJH6KypFmNNkNB6CsfpzN3Tp23A+D1LSTf2VeU4AQIVqR0Fbay/sANt7k/i9+8jRtc
         VQ/dceY3IuGG+oOTf4rZzyfHzbcWbmM5s2MCOatIVMKqLEkS0VB36N3H8dNc4Ezjed2Z
         J3Dim5aMiGYTU8s6UKEgA0psg2PaNbZ6kSjmIN5f1UXt3L7P7kiHNahS3eJMScenZK1X
         h0DdcWU0QxuuknRqH/Uglm2OFbahuULfRgblRaATDFC4FIumkklba3666CU0R+TRkOHg
         2h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750621872; x=1751226672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUcrx2SGK4k7VspPrA1kZfeY9CvCdk1bQCrmf4AIFEs=;
        b=OW5Q48It3EcrU6vFlfNh8gUi5eidtaYH/qUsKTHTOcKoIhkUq3Rz5QmZ8icPwic/8D
         XxcBR2m/2PZJeIfysjx/4VS0+vYZr4RZfRDO4r8+/nqKwUHdZdhvX/1EidDIk1SgkFch
         Ea8QjJE+J/KWpuz2qG6jKS0M67p0hRvxARMaQFRXsoeav/JM9vB1C6v5zSIIhGLg+CN6
         1oV6Eh+BWEFjhv1FQr/Twv6Pw+L2j77rdQGcoao/UhOMYjWQzNQWUeEVUe0nSE3rSNJf
         adIhht17mZRtLE1huYasSA1saJRuyNlpLQJDVmYYyYfs7A25CQv2QLEsm4QKZaS+Z4rc
         Endg==
X-Forwarded-Encrypted: i=1; AJvYcCXL2T+TSb8YrtSN+n/OWgAhyes/stioKPvWi0uGlkTKxAfSfrHWamP/9x+aCpyl2wTGvy+TAxlXtkJv7ER6@vger.kernel.org, AJvYcCXrjSJvkhpCBmCDO468bjm0Sy+P9FyD4Bhp1tSnGFr+kJA5GLkKY1OQVdNO1ysiqjV5QK0u86p2DyZsH3ot@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAehSCOQS2vl34T2BYzzxZ8i9y5oRRBBfrd3ph6kBsAQt9R7q
	2zISXeR1JfuXJwZ943YnYqBbVh7aB7qnS4ax1q4snYCRWCCrj4y+Ncln
X-Gm-Gg: ASbGnctGuFeRpep6EQfA5gJvTMpWawOdUIsdqHigxHSgHlqXpKYoWTx5cUZiVEheNO7
	LE41dMy2YDiNhSLJozUglYX+sVQ41F6NYnXRjmN1TCAPrTddn30G/Un+h68TeBsEAvm4+VrEDAB
	pgpyBzDalL5AHUQ13KL2SNKfMJ4WwEJzXWV46s20yqTXhTMWme1Q1aRUEi+qswj+yoKqQiOJ4Ci
	lE6t1EqBAa/21SvGciyGynqCiJLYepxSYWOyNHsL4hPsqEIU8VckRedpGBQJr0mGCsxwGJJv9Cm
	bNLV9uz2SMmVv0YxmQa+Tv+vSWzVphh7AGBYuDNJbYvQkcEXNDW8C1kFTKMTWKMvvPV69sec5il
	VzeR1B21PpnXRZpd0fmneithk
X-Google-Smtp-Source: AGHT+IGpGhtjsFvWIO86ULzWqyw8BmK+94ZW8xAj21rG1ZHpB7Q2zU99nx35rnDAsbLQBVkLd2sxxQ==
X-Received: by 2002:a05:6000:4906:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3a6d12e6a3emr7498266f8f.45.1750621872023;
        Sun, 22 Jun 2025 12:51:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c5f2sm7839533f8f.55.2025.06.22.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 12:51:11 -0700 (PDT)
Date: Sun, 22 Jun 2025 20:51:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 5/5] powerpc: Implement masked user access
Message-ID: <20250622205109.02fd2ecb@pumpkin>
In-Reply-To: <CAHk-=wgvyNdkYHWfL5NxK=k1DCdtyuHCMFZsbQ5FyP3KNvDNPw@mail.gmail.com>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<9dfb66c94941e8f778c4cabbf046af2a301dd963.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622181351.08141b50@pumpkin>
	<CAHk-=wgvyNdkYHWfL5NxK=k1DCdtyuHCMFZsbQ5FyP3KNvDNPw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 10:40:00 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 22 Jun 2025 at 10:13, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Not checking the size is slightly orthogonal.
> > It really just depends on the accesses being 'reasonably sequential'.
> > That is probably always true since access_ok() covers a single copy.  
> 
> It is probably true in practice, but yeah, it's worth thinking about.
> Particularly for various user level structure accesses, we do end up
> often accessing the members individually and thus potentially out of
> order, but as you say "reasonable sequential" is still true: the
> accesses are within a reasonably small offset of each other.

I found one that did ptr[4] followed by ptr[0].
Which was potentially problematic if changed to use 'masked' accesses
before you changed the code to use cmov. 

> 
> And when we have potentially very big accesses with large offsets from
> the beginning (ie things like read/write() calls), we do them
> sequentially.
> 
> There *might* be odd ioctls and such that get offsets from user space,
> though. So any conversion to using 'masked_user_access_begin()' needs
> to have at least *some* thought and not be just a mindless conversion
> from access_ok().

True - but the ioctl (like) code is more likely to be using copy_to/from_user()
on the offsetted address rather than trying to be too clever.

> 
> We have this same issue in access_ok() itself, and on x86-64 that does
> 
>   static inline bool __access_ok(const void __user *ptr, unsigned long size)
>   {
>         if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
>                 return valid_user_address(ptr);
>         .. do the more careful one that actually uses the 'size' ...
> 
> so it turns access_ok() itself into just a simple single-ended
> comparison with the starting address for small sizes, because we know
> it's ok to overflow by a bit (because of how valid_user_address()
> works on x86).

IIRC there is a comment just below that the says the size could (probably)
just be ignored.
Given how few access_ok() there ought to be, checking them shouldn't be
a problem.
But I get either io_uring or bpf does something strange and unexpected
that is probably a bug waiting to be found.

Remembers some very strange code that has two iovec[] for reading data
from a second process.
I think I failed to find all the access_ok() tests.
IIRC it isn't used by anything 'important' and could be nuked on
security grounds.

	David

> 
>            Linus


