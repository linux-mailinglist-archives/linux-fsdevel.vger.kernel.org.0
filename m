Return-Path: <linux-fsdevel+bounces-41298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3865A2D873
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 21:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D42E165FAE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8394024111A;
	Sat,  8 Feb 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="agEPuoWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E224112C
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739045011; cv=none; b=APpQgMKt8tVLNvwptwPJlqQIrzHGfYaF8VgGRAZs7uZdh5EvgyyBgNoAluiK6qU3ce35nrhdJC1LMmkTtd2/8RasLuvtYsXiYeV+Uje/PeP9WKTONMQ0bzcEsEyFz0PbIYzpDhcEOV7oqGaKlhPEEfTEloGNbDbO3zp4dxMwIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739045011; c=relaxed/simple;
	bh=AJGPjA2vBe2mQhjSwTRb+LXPJOxsjjHsk16fLuvBC0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt8Yo5aMxQVoR7RMxIFaJUdcN8+v9Js8e477Dd3oMLl/m3nfQXr6mcGW0fI8QvPMjOOtd2JUuLl5Vpd9/y5J00SatOn6rA5pr2lvXfifE+5SHSi9XZGdiiwOghDzZNcRtPLMfQbLTIn0wZN2ietgrNROxUNRxBgZ94IAeUBuciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=agEPuoWb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7a5dbe96dso71646066b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739045008; x=1739649808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYBjQ5V28Z74l1FXDnErVmTh1dw5xbuX4O4FtPTrSJI=;
        b=agEPuoWbGC3GwpuLltaVeFfPBXQo6G2oY88/mc5f2rU9nnJZlbc8qLvzbnT9/Udq0v
         taAnb59wBgAH4u4gtKgY3eOUzVGU9iQp6wckuKjUSemIzN0LuMBw4knx+P6n0N/dYC04
         ZCwsgRlXvmX3XkKUQ1JK1pXSuKl2dIzYY1wI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739045008; x=1739649808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYBjQ5V28Z74l1FXDnErVmTh1dw5xbuX4O4FtPTrSJI=;
        b=bymEB5mrW9/H74FKA+Py+Q/E5Y8RJXD2dNm12yKLxmWxXRH+IvbzOZLDTbKrTlPfhZ
         tx/vBmcFifDiaZm+ZXJgCZtESy9zUb70ASX10Q7JCCh11Y5rZEOFIRvoq25qgDegULlo
         M3tlzrXXdZBoW20NRSyIZja6bIbhmBvKilRRzr/hfBDaKSfoCLEdWVjSu6wdW6KDTv6p
         ra14vpwCLDV72d+NemD3p/nns5kAUahioZk28kfUHWP0mB8mF6LvjxT3VRtJIJRAGGSF
         Ev1cp1rxjX6lu6L/PTZsVcJN5yXrAPhchqdk1GQjzjjvKnaWrwoHJWsqUkxtsoB+lcHA
         cd1w==
X-Forwarded-Encrypted: i=1; AJvYcCVODxNk+15Wn9WGtlnhIE2KjHUYGpSAwNLfNAgqgT5h+ZR1R46wBBaBqMZT9MJw1SDoAKLFd3da/jvrg6Jj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhejk34YI+ECGGByn+k7uLcDSVgozCBTMckBACLYYrBMZ7zDDN
	Tj05vZHYs41Y4akK8fzzGnXl2f//XUUqwU+iQTkoS1zjsqQshfpATYugk5idAbmNqxj5xnQu1gO
	abId1Rw==
X-Gm-Gg: ASbGncs9tq/ifkrmzyPn0AmZ9YqdlqudDcpBa+HRqUL5tTymIlL/qqsJhcT7pe+4AUb
	WNjMNrcnXlKMftcxxFDtJ3pt1+y8fgcBDI5+6/ZrFEujqivaSijTVDfIDCJpGXJs4xgHs6PSAcH
	kS7bZ7vOW4DLeQmQAD/pEW2AVT3COZZ1+3cHG6lgldcfKnHPtpo8vfe+AXHuhQcyYL+DUSP/7f3
	1kpewM+hZU4s+b1ri7D90wdHPXASqf/PI7ojulyJguJAxVTJ1z+OkNsKmO4VtG4Apv9+xHZ4SIT
	ANmhi73xlT9iHBMlqRh6uVXRr1BeaSBuytrrzZmgvSI0pkyIlbiOry46H6n4JHxZWg==
X-Google-Smtp-Source: AGHT+IExdrCZ7+eleBhn+2iH6biOMsufFWk2/DuduMml97ThLg7Sfxn/U091hcyrdi9xrMFyUfrLjA==
X-Received: by 2002:a17:907:970f:b0:ab7:85a4:faf6 with SMTP id a640c23a62f3a-ab789c66783mr912807166b.48.1739045007909;
        Sat, 08 Feb 2025 12:03:27 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79668f32esm270880966b.176.2025.02.08.12.03.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 12:03:26 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de4d4adac9so3124911a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 12:03:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGRK/9s+Q6RzPfa9Y9J1TRnRjRU1fBQ/rrEXAhC9vQQXceDaOwsoiox0tZTQxuySMZzIdZ3cyCgKnCgHkb@vger.kernel.org
X-Received: by 2002:a05:6402:5252:b0:5dc:5a34:1296 with SMTP id
 4fb4d7f45d1cf-5de45022b20mr8922570a12.16.1739045006312; Sat, 08 Feb 2025
 12:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208151347.89708-1-david.laight.linux@gmail.com>
 <CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com> <20250208190600.18075c88@pumpkin>
In-Reply-To: <20250208190600.18075c88@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Feb 2025 12:03:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvmGhOzJJr1LeZ7vdSNt_CE+VJCUJ9FcLe0-Nv8UqgoA@mail.gmail.com>
X-Gm-Features: AWEUYZl5iiB4XZzXu6gQI_yRDYLP1S23MRx2SK6qDmf7MiSIz-0VnfM7Dlycbb4
Message-ID: <CAHk-=whvmGhOzJJr1LeZ7vdSNt_CE+VJCUJ9FcLe0-Nv8UqgoA@mail.gmail.com>
Subject: Re: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
To: David Laight <david.laight.linux@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 11:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> Can the 'alternatives' be flipped so the .o doesn't contain loads of nops?

Sadly, no. The instructions generate #UD if the CPU doesn't support SMAP.

Now, arguably the alternatives *should* be fixed up before the first
user space access and thus it would be safe to switch, but honestly, I
don't want to risk some early code doing odd things. The potential
pain would be too damn high.

> It'd be nice to see the clac and lfence.

Heh. I agree 100%, which is why my personal tree has a patch like this:

    -#define LOCK_PREFIX_HERE \
    -           ".pushsection .smp_locks,\"a\"\n"       \
    -           ".balign 4\n"                           \
    -           ".long 671f - .\n" /* offset */         \
    -           ".popsection\n"                         \
    -           "671:"
    +#define LOCK_PREFIX_HERE
  ...
    -#define barrier_nospec() alternative("", "lfence",
X86_FEATURE_LFENCE_RDTSC)
    +#define barrier_nospec() asm volatile("lfence":::"memory")
  ...
    -#define ASM_CLAC \
    -   ALTERNATIVE "", "clac", X86_FEATURE_SMAP
    -
    -#define ASM_STAC \
    -   ALTERNATIVE "", "stac", X86_FEATURE_SMAP
    +#define ASM_CLAC   clac
    +#define ASM_STAC   stac
  ...
    -   /* Note: a barrier is implicit in alternative() */
    -   alternative("", "clac", X86_FEATURE_SMAP);
    +   asm volatile("clac":::"memory");
  ...
    -   /* Note: a barrier is implicit in alternative() */
    -   alternative("", "stac", X86_FEATURE_SMAP);
    +   asm volatile("stac":::"memory");
  ...
    -#define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence",
X86_FEATURE_LFENCE_RDTSC
    +#define ASM_BARRIER_NOSPEC lfence

but I've never made it a real usable patch for others. It would have
to be some "modern CPU only" config variable, and nobody else has ever
complained about this until now.

             Linus

