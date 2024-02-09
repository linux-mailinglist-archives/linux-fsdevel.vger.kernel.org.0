Return-Path: <linux-fsdevel+bounces-11010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89D84FCD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2971F28854
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC184A32;
	Fri,  9 Feb 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NQam6JzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5CE82D7D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506895; cv=none; b=Urp5G2liHt75CzTvZfBsyjmU1exAOJ4ASAEh+lqGat1k8Y7AjGgSLhxk3LXIgwJAgSMGNjr3A4fJ6fbPqL4/fIWu82SaEdZSHgnCcJGp6qhFAN8vZV6UKjVUDsY8c83oFG/R5/ln0h6btgyMMWmxqneG2H0OB93gpRz0WBCRwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506895; c=relaxed/simple;
	bh=Ul9XvGXJ6o+C2+ZNlBKQJv5RtNqOYku9qcAZQsvfX2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hInrJVgAZBxteJt8V1SgZ5PHwtTbq10I6FWD7eyII8yE6XnkS1+2AdqiUdCekZR8kvBVC3Ht0zUo/PoeVkwNYoSu2gw7X3T9q07q+hCz3mPfyRQf3gJ2WoK7CmuF2QIprX8CdZXmDsfWQhwKWUHeym3pCtClW4rMGo/UPeBGEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NQam6JzI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56002e7118dso1821250a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707506891; x=1708111691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6iq6xEbrKhqchVTH5nSmYuKsoeruNayprfXe44ium5M=;
        b=NQam6JzI269Lv93+UdN1znPvaHYhnlQ3bpB5ZubreRUP6e+OV0gH63t4GLVWbKzRmD
         7Mw1dSq0r4W6c1EIt785dqA/fLtYfgPjqIxiQ0cP/FeGaPGo5JNn7d9Q6grlgE8kehDO
         8I91CCkn5v4dhd4Aj05ZyzUSzONXrPwtKRyGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506891; x=1708111691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iq6xEbrKhqchVTH5nSmYuKsoeruNayprfXe44ium5M=;
        b=mtDDhP/tejxSaZG6IUfte9RAWzaNkrtpijGbnGnPoG1vNIEz8wA6EELEXt6AggKiRO
         CHdEXBsmXtfvmn1iCAbTUknvxd7nCJ0GAfBoT5wXO/Rqj+7YwuK+2M9E9WmlfcZI0zdp
         yai6OsErf+AdY3aubPpPHnw1ppbYwbk4M4IctVmJJdHAQ9aiiFyPlA9uR/7ZZbRpc2mL
         0XS4+mMc9+7Yzlc/YUipxdRve8/az2HWMApIXN0uTIE5VOm8+z+FlssCFBMHy/JTGKWy
         ROORQJqumU2DHcArO230fUrgyCCVbqsbd56CnhXVDz03bxeUKDYFvO1vjZBXzN9rc+xH
         wvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgi1bFYTUs62sBu2pIBWvgEooSPs9sU3CiDI3AOynf5VpiCCt2l9HX0XcohqTYf8l+b1U5fB+lHE89AAl3w3WGijyRfVATXhIqx3oOqA==
X-Gm-Message-State: AOJu0YwGprQHGzd5XIrRaB2Mvzk+HU0iQ0UZpTARWp7y84T3nlcA0xbu
	VvQhEBlXM+vlMYgABj47Li0FlQUObl2uItIklGbIQEWO6vK332Jdnjrtu8EYOBR6JRWa9pubJLL
	VP2I=
X-Google-Smtp-Source: AGHT+IHFwfOHyiGYJcC2G1TLHmbJk2t3cdc1CsCr6tOb0i8Nyjf178Lr3z0nDoP5IJVBvsrGjBqSFA==
X-Received: by 2002:a05:6402:649:b0:561:aa3:f9e5 with SMTP id u9-20020a056402064900b005610aa3f9e5mr2030260edx.3.1707506891290;
        Fri, 09 Feb 2024 11:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgLy51dGrIRRDv4tTSk95kQ/DVN1HdduboTZuJn567xDyikYmdBjiKfbkFoEghrdGTkwrhl7gG/th2LqCDB2RlC+KScn5DkkrFuEycgQ==
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402035700b0055ef4a779d9sm33947edw.34.2024.02.09.11.28.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:28:10 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1707994a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 11:28:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+QVPoOI7Ha3ytEyxAtus4eG+Nnssh21cxgJvl/PwuDTjM4LHeMievepbO3r9nzEESke1iRBsBujcF6S/nEes6A4SI1RMGEV9GZuwUcw==
X-Received: by 2002:a05:6402:750:b0:55f:ccec:ba51 with SMTP id
 p16-20020a056402075000b0055fccecba51mr2016076edy.22.1707506890042; Fri, 09
 Feb 2024 11:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207222248.GB608142@ZenIV> <ZcQKYydYzCT04AyT@casper.infradead.org>
 <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
In-Reply-To: <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2024 11:27:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqtMfRySaBoShSivAL3SYbYDTEUz-hbc4xXSNUrpSaGg@mail.gmail.com>
Message-ID: <CAHk-=wjqtMfRySaBoShSivAL3SYbYDTEUz-hbc4xXSNUrpSaGg@mail.gmail.com>
Subject: Re: [RFC] ->d_name accesses
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 11:10, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> I have 100% observed llvm throw out writes to objects declared as
> const where folks tried to write via "casting away the const" (since
> that's UB) which resulted in boot failures in the Linux kernel
> affecting android devices.

*PLEASE* fix compilers that silently generate bogus code just because it's UB.

That's pure and utter garbage.

We want a compiler flag that says "don't do that idiotic sh*t". There
are very good reasons why Linux uses flags like

  -fno-strict-overflow
  -fno-strict-aliasing
  -fno-delete-null-pointer-checks

and that reason is that the ANSI C standards committee has had its
head up its arse when it comes to these areas.

Optimizations based on undefined behavior are wrong. If you have to
resort to those kinds of optimizations, your compiler is bad.

*Silently* doing so is even worse.

If the compiler decides "I will throw away this write because it's
UB", I want a warning.

Better yet, I'd like to see compiler writers admit that undefined
behavior was not a good language feature in the first place, and that
any time the standard says "that's undefined behavior", you ignore
that bogus standards language, and you turn it into "implementation
defined", possibly with a warning.

                   Linus

