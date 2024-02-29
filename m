Return-Path: <linux-fsdevel+bounces-13222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F286D6AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3469B22A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E974C05;
	Thu, 29 Feb 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEJlEXp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACA74BE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244840; cv=none; b=k6upwd8cEEkvjcHWSXrwZbZAMrUMJUrJDKDfW1f3D66CpPMlebPQG6VcscC641N1SR6DbcuZFXkKF0ki5kEi1mHUHt5nS/30Jtki7Ug/5+GGwxa3Eg4yz/ZjIZ2v3i5AhgR4FKDeIcyiXctoD450udF9ERUMq1IfoM7LKB42rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244840; c=relaxed/simple;
	bh=t21HnzIGHk+n6QlvVMMSXJY9HBCCiiEVREtwL2Cu0k0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHGXyjAxxiwF4D+6696F2Ws0/Zw5CpIWwn5v3tm+HDG344O4wzCI8SezZoLadVgGF2pF5rds4+POLED2OjjxBugcS1rKAFtuz0622anXXeHXUQmsVyUKoy6EoH3097WZbRyo5nua8eJzBovheq/7SiJR9+f5PRdmFP+OjRGwsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEJlEXp/; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bb9b28acb4so1055559b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709244838; x=1709849638; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=F0bbqczj3Keglw64JiNfdvO4M759XtAlzANrlsOPWOc=;
        b=vEJlEXp/t0sGocdgJ+1M/q7Vfl/icZb3SlgkPnVhhgAUne7jyVapSyV5iz0w6jQESv
         eLMmE3SE59/cufa8fdT8VBWPspFkAJb+ps0oVBcTePciNYAzhreUrDI7V2xiduDdhhEU
         QFdHdaZzqfv6my4Zp98pxSdcHPEx0I3q8W0dGJ6CqwagyxzDTpBAiTCLnpIlQ+O6O5M4
         y2jWTnaNTZAxe1mVKuNtWOkE9OiZ+4BHWVQQHl5icIcLMZidNcECZeWYzlnehjpykhYU
         BEVCyq3LDwkHt3zS64N+l1AleFgaLMccgfZDfMNJP3K02ojEikeQuLjWNC2fn4E++25u
         ME6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709244838; x=1709849638;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0bbqczj3Keglw64JiNfdvO4M759XtAlzANrlsOPWOc=;
        b=SxUUJY1IilMbYrzDWAU6TnYD9je//T8R03jL9wvjf3y4Zq4TWQ3B6eRaI/ZG6mJ/a7
         WBQVaIRk+PCTkNzWdvwObjubwaF6UhWoC2k0Bq3stUu4gyxu7D9z/v/0kLn2/LFgJvz3
         w0bYLD71MkyeYgm15EBYr+MSzKwkHfl1pmSAQUaGcwdLZdMLD65xM6Rmhk8ALSEcc56l
         a0uzzPZJhLHrTEm/dvnMO8dIu2Yy1MU8fxR+Rf85cLqocUkD5ULZ0qEeuDH+v6TQuh+K
         1hzLTTo/Iv0kzxL/Yj2GiX/YugLJQDmbh57xZGEPugJF+Ioeix4t6i+b54HWgT9z22Oq
         ICIw==
X-Forwarded-Encrypted: i=1; AJvYcCXtYiGuW9yVRg6Fokjg+aGni6asxytcbo7LVuNqUdx+sf8sdxdPQwmW1hLhE4wzDF6jzhqh6qitqsoy/siylSKk3RWmlNjfmEMUUuXakQ==
X-Gm-Message-State: AOJu0Yzg/7Kyu5HV1juFojDzGgEFQOp0UsoDmvjPFg5RkNOwU8L7bsTf
	odd4WYVLJyJeOIW00iUemOm2265tSrbtmGJCnjPNByCLjU8M3qTEca8BVjy36f4=
X-Google-Smtp-Source: AGHT+IHdJxypAmK3qvNYc2vGOAmkw9y2ZwPcLUGqtAKe2grsU0Su0E62P6Tt4LBvrgbMxt6+5DcYzg==
X-Received: by 2002:a05:6808:438f:b0:3c1:c2e6:b046 with SMTP id dz15-20020a056808438f00b003c1c2e6b046mr3051822oib.23.1709244837897;
        Thu, 29 Feb 2024 14:13:57 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a90b:ac37:af4a:feb9])
        by smtp.gmail.com with ESMTPSA id ei4-20020a056a0080c400b006e57e220ceasm1771460pfb.6.2024.02.29.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:13:57 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
 <87sf1n7uea.fsf@linaro.org>
 <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
 <87ttlzsyro.fsf@linaro.org>
 <c710a6b1-cf58-4e32-ada0-c0b256a62b2c@sirena.org.uk>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
In-reply-to: <c710a6b1-cf58-4e32-ada0-c0b256a62b2c@sirena.org.uk>
Date: Thu, 29 Feb 2024 19:13:55 -0300
Message-ID: <878r329avw.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> [[PGP Signed Part:Undecided]]
> On Thu, Feb 22, 2024 at 11:24:59PM -0300, Thiago Jung Bauermann wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > I believe based on prior discussions that you're running this using
>> > shrinkwrap - can you confirm exactly how please, including things like
>> > which firmware configuration you're using?  I'm using current git with
>> >
>> >   shrinkwrap run \
>> >         --rtvar KERNEL=arch/arm64/boot/Image \
>> >         --rtvar ROOTFS=${ROOTFS} \
>> >         --rtvar CMDLINE="${CMDLINE}" \
>> >         --overlay=arch/v9.4.yaml ns-edk2.yaml
>> >
>> > and a locally built yocto and everything seems perfectly happy.
>> 
>> Yes, this is how I'm running it:
>> 
>>   CMDLINE="Image dtb=fdt.dtb console=ttyAMA0 earlycon=pl011,0x1c090000 root=/dev/vda2 ip=dhcp maxcpus=1"
>> 
>>   shrinkwrap run \
>>       --rtvar=KERNEL=Image-gcs-v8-v6.7-rc4-14743-ga551a7d7af93 \
>
> I guess that's bitrotted?

Ah, sorry. When I renamed the Image I messed up the kernel version in the
filename, but I did confirm via "uname -r" that I was running the
correct version: 6.8.0-rc2-ga551a7d7af93.

>> My rootfs is Ubuntu 22.04.3. In case it's useful, my kernel config is
>> here:
>
> ...
>
>> https://people.linaro.org/~thiago.bauermann/gcs/config-v6.8.0-rc2
>
> Thanks, it seems to be something in your config that's making a
> difference - I can see issues with that.  Hopefully that'll help me get
> to the bottom of this quickly.  I spent a bunch of time fighting with
> Ubuntu images to get them running but once I did they didn't seem to
> make much difference.

In that case, it's interesting that I still run into the problem with
the defconfig. One thing I failed to mention and perhaps is relevant
considering your result, is that I didn't copy the modules into the disk
image, so the FVP was running just with was built into the kernel.

That was actually the main reason for me to use a custom config:
I didn't want to have to deal with kernel modules, so I created a config
that didn't have any.

-- 
Thiago

