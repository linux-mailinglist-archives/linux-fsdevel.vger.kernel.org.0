Return-Path: <linux-fsdevel+bounces-67373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC4C3D46D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B01893A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C53502BC;
	Thu,  6 Nov 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OxEE2XHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD434E765
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458584; cv=none; b=uLnoaWfX2y9iw1MJcjwKK8/AvWRQpa2JhAFbbTdDjDha97H4Dyx2Vg/Ihq/EDKbe/FMTaxDQbW8NBWahM6gcQio4a3fW79+f/LTCEE9Yd8HLul/+kMYUB0a/eMpSBhH7cdI+xhkUPn2RrtKkdNQC7PtZZkBci4SsvOdyXIZlRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458584; c=relaxed/simple;
	bh=KNglB+is572fPQik1I8VuhdCkPupPcFd+dhc6oteTRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N20kbUkByo2RdkmCuxGEvpZ9zhHiI0VQl33xpweV236Ej6nknl+3ebgBigAvU9snRYUFmo1TfCanISKAcPL3VMt+FPxBDvWh3dRm1UaiDnZmtc9E0J+8nNBDnWJsKMTbOF+5AhiVutkdl2eS3MGP6qsYJBgX74U74yud8BLAkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OxEE2XHn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b714b1290aeso178222166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762458580; x=1763063380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBrsl6/CQ1RQ5Pw+U65hqGvC9Glz2m//zyu11cb91Go=;
        b=OxEE2XHnid83VI3lutzOsUpSbGPK2mGwMQdKqGfm8It+YgIKbG1INgVuQOJssjOr23
         XWQ0c44fv2hAfAMeXmjmVVLSRWksfWiF4ATGUSl82IYSxr6LqnNo6UVOxXW+T5X5V0fi
         lCk8FAro3in854AGzoy0W9y+lPnehFf0kojw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762458580; x=1763063380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBrsl6/CQ1RQ5Pw+U65hqGvC9Glz2m//zyu11cb91Go=;
        b=S6kreb+THMBfdMNauKNjMqp0ult7jAGKbHGJNpZFPP/Q/mPPrZ6E5ITbTV9m6EsBTD
         VbrQkTnBDvblbMgJFcdMbME502X5IGiZyTblGQMmU8q5Oft/vhKzT8+TXeoYdxmUiYMw
         i91M1gSowIF1iX8zT+Kz5OG0kCXvijV3ce6vH1OMwBGKTmEzgMmX85YqhqGFzJ25njxm
         SuEThqFL2pzNt1cN/zRSb1R9UaktHQ7XMS/YQJCAOvAuglTVK/FTl+3k5zWJ347NUTp2
         Ds3CNdOc3iTjmLbemfqpBQK4vKAnkXrEKKk3LSr0mlTinii+SZxjwEx4yvZtVtvRwFtD
         p1xg==
X-Forwarded-Encrypted: i=1; AJvYcCXlrG4ORhcUlYDV3Qv7wM2v7fRKyONwKj8ohgpEgnJ7UGkUm9GBFWZj9+9Ifi/wo24apqAq6UdULxS6FUBO@vger.kernel.org
X-Gm-Message-State: AOJu0YxygVsLF51w/DgY+ho+ENPBpnEjAHmtrIhoHmjnQol1BBDveos4
	yHYXPpaksrFmoJw7accEPm0DywOUgXRnadFnjGaRcL1YhX+nLWiSUL2DJSNoGKOktzfC+GTG65k
	raxLs474=
X-Gm-Gg: ASbGncu08Bk7TOkzCZV92tkscH9X/yzDuvq5dsmcgAZ+h4BI8IPxMyKUmB91LGmdhDf
	CCF4qpgXPIefDrGrQHOQYGWIBhdHDs9cdpSVmoo8lq4dHxtgSFrv78cI9uC1Hj8QhTm5cD7xl82
	LjbiIeapHddvn28DLEhqmjH/HQ//BGJcktpOYGzU8OSqDlrZX0DmgTYyJpBWkapaC/9xcgrgNNA
	9LqNzoHd4LUOdxk+YY1pWpv3qHtOroNGIzyWR5TuWSPKlXAgSOwPGqSWvfzoHXtg4ElEHoOk+OP
	VoPmbV/nVdA3z64LonfuNHDq3w4TfX5/ISY5dNv+DynNGNAkz9shD3LWnuvKfu7COWWtFL92r7T
	lmPjVHN3bpZHFt3Td+VHAKc/XTljMX829xlRgo7ysMcS3VFT2s2kF4p21phpkgtsCsFN6ypPUUj
	cscNwzlWQ2L+OvWqZnQXi51jVdH1K+LtAUlFTfC0o0VkZGH3Xahg==
X-Google-Smtp-Source: AGHT+IGf+jzaPw+Rlwqq60vpE+bVZv7nWwsdgO23mXP0P3pf0LyU+bfczLB1Oej0QcqVRQEyVTgPvA==
X-Received: by 2002:a17:907:7256:b0:b72:7601:a321 with SMTP id a640c23a62f3a-b72c0d76e22mr43157566b.57.1762458580444;
        Thu, 06 Nov 2025 11:49:40 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf72337dsm36102066b.33.2025.11.06.11.49.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:49:39 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b714b1290aeso178216266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 11:49:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEEZjmh1czofjbhxmmi15It1pW+06lk0v5lyfiHWymD/BDA2pTS+9g6sdeK15Bimz2Rwm9yZQTPot+pN/r@vger.kernel.org
X-Received: by 2002:a17:907:6ea5:b0:b6d:4fe5:ead8 with SMTP id
 a640c23a62f3a-b72c096d4fbmr51233066b.25.1762458578590; Thu, 06 Nov 2025
 11:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local> <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local> <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
 <20251106192645.4108a505@pumpkin>
In-Reply-To: <20251106192645.4108a505@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Nov 2025 11:49:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9yyNH7Xj3r_zO2vOtwfB8+vBt03Z7XRpJE9qCo-K6vg@mail.gmail.com>
X-Gm-Features: AWmQ_blSRvPDLC84LiEOMXHpSSJxscSXsXuq9j4k7UimqA5YjK9SBdhiuq1mY0Y
Message-ID: <CAHk-=wj9yyNH7Xj3r_zO2vOtwfB8+vBt03Z7XRpJE9qCo-K6vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: David Laight <david.laight.linux@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 11:26, David Laight <david.laight.linux@gmail.com> wrote:
>
> IIRC it was a definite performance improvement for a specific workload
> (compiling kernels) on a system where the relatively small d-cache
> caused significant overhead reading the value from memory.

Some background:

  https://lore.kernel.org/lkml/20240610204821.230388-1-torvalds@linux-foundation.org/
  https://lore.kernel.org/lkml/CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com/

where that "load address from memory" was particularly noticeable on
my 128-core Altra box in profiles.

That machine really has fairly weak cores and caches (it's what I call
a "flock of chickens" design: individual cores are not particularly
interesting, and the only point of that machine is "reasonable
performance on multithreaded loads thanks to many cores").

I did have numbers, but never posted them, because as mentioned in one
of the emails:

  For example, making d_hash() avoid indirection just means that now
  pretty much _all_ the cost of __d_lookup_rcu() is in the cache misses
  on the hash table itself. Which was always the bulk of it. And on my
  arm64 machine, it turns out that the best optimization for the load I
  tested would be to make that hash table smaller to actually be a bit
  denser in the cache, But that's such a load-dependent optimization
  that I'm not doing this.

IOW, the actual biggest impact on that machine was when I hacked the
dcache hash tables to be smaller, so that it fit better in the L2.

But that's one of those "tune for the benchmark and the particular
machine" things that I despise, so I never did that except locally for
testing.

The patches that actually got committed are "these improve performance
a bit by just making the code do the same thing, just being less
stupid".  Much less noticeable than the "tune for the machine".

               Linus

