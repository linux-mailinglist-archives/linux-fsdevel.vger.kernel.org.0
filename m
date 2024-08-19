Return-Path: <linux-fsdevel+bounces-26284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E8957253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6737E1F238E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577E11836D9;
	Mon, 19 Aug 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fSCcoJE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7313C8F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089580; cv=none; b=tMK2QhhT/a6OgkIuvN96yMsZe/WrN3w+uD5E0QlZfAZEstUGcu1tVx5MzlxX3HnqnIwfF5yfyyi/jZ1yvGiv+WKS0IrtlSZgOV5PAr/LwTfRa/YwDn41pG73PUyCR4IOp4sZWZ/2vZYbWMZMd3BnY4KThjnmZKRq9askVrfwOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089580; c=relaxed/simple;
	bh=NMDNAwZ/85MrC2/KoFUt8yrMz0f+9BETGF/OtkHJWgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9Im+sZFCq0BKyciSW/WRcuO7B2IvmYvaewzTsOiQTMzk7PgwCzxvgHjsuNdEnJLttRvXPRjN3W95kwFFHCYviPmj97heQYwKfwQ2zmqVyHxb7kXwX+Wt4Mc4WHecaZ/xFEM/7SbOP9WdozoNMEkoChh9TpfMZco6IejpfR+h1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fSCcoJE2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01993090so5461585e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724089576; x=1724694376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COSENzSSJEpGLSrW02jqlSSjde6gi4NT90YipkfQ9+Q=;
        b=fSCcoJE2/EzVvIcCUo7Z6uC6v3rNLFJEL4UgXhEPdxVMq8T6QgDYlrbzdF17ijpMn9
         EoK+sBsSNP05u7Zdz7aqY2JFvX1cTqjVDpKLe1xrvL3SmkYA4bNWOH4Htoh4Bp8MkAYD
         /BI5HksApBUk9OIJuY0FYHfL2nFAPOIofWCKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089576; x=1724694376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COSENzSSJEpGLSrW02jqlSSjde6gi4NT90YipkfQ9+Q=;
        b=KzfnPjRrlE4BMLqfEytXcrKdobcSo44S+ebqvONxC/+nDRcDfE67PMjsDnFcSiuB/x
         FGHKojo94cY39QtDSRJ4YhRrv4gKpa94ZQ6p1e65DfFOMklVFxSZImNM3ryOSCVjs5Yh
         CttW8FLyhWGesoBVoosCLe3NYEC9cf8o8fWybsRowFC4NYadRpQDSmoHWjGUT98nUTFR
         /ije4Quv7wuYMYExHKia7f41AfXWrm1Od/MzQMY/I5h2Otvebg9+CdjbbT7icm8SSj7Z
         HeQnoff2bIQYZfzTQdZ5jX8b62rD12APz91kobK7kgy+5EQgof5rOF7/PGrhI5K4M9P2
         qYhA==
X-Forwarded-Encrypted: i=1; AJvYcCUTC4kvphkn0RyebJXNAwfzj1PdrUyEVbH6ySaSzDqNUljlfd0ZPn+kQeXijFbEfzcyF5etkQe8UGRUYWfC@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKjV1OCtN6bCxivnlCCSAkGybqKMeOvnp70HmGiJdbJKD28k1
	yFEbwOMvqv2+7agW+jR/ykCxx5vZ5ughZ3hwsI4sCIGZtS/4V3uCp57K5Q4UotJqzqHSMmam1Zp
	oO/q/EQ==
X-Google-Smtp-Source: AGHT+IHSfLzzIyn7Iqepwj8IFAYj7D3cqvS5l8ERiIyNNBIDhTUXs7HrtS7gvfVo/uClQoY+lIsBiw==
X-Received: by 2002:a05:6512:33d1:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-5331c6efb79mr8153444e87.58.1724089575823;
        Mon, 19 Aug 2024 10:46:15 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3af6dbsm1537158e87.35.2024.08.19.10.46.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:46:15 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so47024681fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 10:46:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZVx0XKg9kM9+3ECvp3PXfoMQJJBK6/fNVitKk2X2CzRN/J1n9wpSWqM1TLHLxLxFGE//8/stAM3IEA3Wi@vger.kernel.org
X-Received: by 2002:a2e:6102:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2f3be5c13e4mr64640331fa.29.1724089574659; Mon, 19 Aug 2024
 10:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819053605.11706-1-neilb@suse.de> <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
In-Reply-To: <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 10:45:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLL5sA_GAEbFn+zELAxz9Jjf0umpORV4N1sQtRhDeZ2Q@mail.gmail.com>
Message-ID: <CAHk-=wgLL5sA_GAEbFn+zELAxz9Jjf0umpORV4N1sQtRhDeZ2Q@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 01:16, Christian Brauner <brauner@kernel.org> wrote:
>
> The problem is that we currently use wait_on_bit() and wake_up_bit() in
> various places on i_state and all of these functions require an unsigned
> long (probably because some architectures only handle atomic ops on
> unsigned long).

It's actually mostly because of endianness, not atomicity.

The whole "flags in one single unsigned long" is a very traditional
Linux pattern. Even originally, when "unsigned", "unsigned int", and
"unsigned long" were all the same 32-bit thing, the pattern for the
kernel was "unsigned long" for the native architecture accesses.

It may not be a *great* pattern, and arguably it should always have
been "flags in a single unsigned int" (which was the same thing back
in the days). But hey, hindsight is 20:20.

[ And I say "arguably", not "obviously".

  The kernel basically takes the approach that "unsigned long" is the
size of GP registers, and so "array of unsigned long" is in some
respect fundamentally more efficient than "array of unsigned int",
because you can very naturally do operations in bigger chunks.

  So bitops working on some more architecture-neutral size like just
bytes or "u32" or "unsigned int" would have advantages, but "unsigned
long" in many ways is also a real advantage, and can have serious
alignment advantages for the simple cases ]

And it turns out byte order matters. Because you absolutely want to be
able to mix things like simple initializers, ie

     unsigned long flags = 1ul << BITPOS;
     ...
     clear_bit(BITPOS, &flags);

then the clear_bit() really _fundamentally_ works only on arrays of
"unsigned long", because on big-endian machines the bit position
really depends on the chunk size.

And yes, big-endianness is a disease (and yes, bit ordering is
literally one of the reasons), and it's happily mostly gone, but sadly
"mostly" is not "entirely".

So we are more or less stuck with "bit operations fundamentally work
on arrays of unsigned long", and no, you *cannot* use them on smaller
types because of the horror that is big-endianness.

Could we do "u32 bitops"? Yeah, but because of all the endianness
problems, it really would end up having to be a whole new set of
interfaces.

We do, btw, have a special case: we support the notion of
"little-endian bitmaps".  When you actually have data structures that
are binary objects across architectures, you need to have a sane
*portable* bitmap representation, and the only sane model is the
little-endian one that basically is the same across any type size (ie
"bit 0" is the same physical bit in a byte array as it is in a word
array and in a unsigned long array).

So you have things like filesystems use this model with test_bit_le()
and friends. But note that that does add extra overhead on BE
machines. And while we probably *should* have just said that the
normal bitops are always little-endian, we didn't, because by the time
BE machines were an issue, we already had tons of those simple
initializers (that would now need to use some helper macro to do the
bit swizzling on big-endian HW).

So I suspect we're kind of stuck with it. If you use the bit
operations - including the wait/wake_bit stuff - you *have* to use
"unsigned long".

Note that the "var_wait" versions don't actually care about the size
of the variable. They never look at the value in memory, so they
basically just treat the address of the variable as a cookie for
waiting. So you can use the "var" versions with absolutely anything.

[ Side note: the wake_up_bit() interface is broken garbage. It uses
"void *word" for the word. That's very dangerous because it allows
type mis-use without warnings. I didn't notice until I checked.
Thankfully wait_on_bit() itself has the right signature, so hopefully
nobody ever does that ]

            Linus

