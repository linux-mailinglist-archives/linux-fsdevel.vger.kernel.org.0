Return-Path: <linux-fsdevel+bounces-47442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7707A9D77F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 06:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D014A8450
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 04:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A91F180C;
	Sat, 26 Apr 2025 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bmcq/u1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4A189B8C
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745640700; cv=none; b=Xpn6JEPcAGOcsge9OVGtuvOodX3mlsmvC0zipzcPdGtIkMu2CgTDBeOExb4fugcIjqj6Am0kPSmWTzAicBgKzoGz+WHk/I2GKvHoMxxrpPn3pmnUz2gVQUmGNgJuRRtYX07hmoM3/cg+G4QeiMrAzO8cFtJNARrB8rv+CjUsXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745640700; c=relaxed/simple;
	bh=LZaA39QZ/1ssboLrqcr0tnGr9TONpBKqHUvnz68tQ8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXIntzM/ZH3qST6M47osfX4FRZ+rcuAQTh1JegW6czLeTQOzpq9vg2G4je3irycioONykyCCiKugSC4NNU+RXoJee6KKpvKWVanFZmlq2riGysg8caWLCSZby7wMXqEjteCXr/tYWpwtJczWFMb0WC+rpgCm1OL2p/3I9Zo3tAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bmcq/u1R; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so5174560a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745640696; x=1746245496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eyFr35xmw7E/ixwUNF7HuIhiUoN7WKp+7IA8FTndH+M=;
        b=Bmcq/u1RB1lM5/VGjc8i38+Dx04UFrmd7ooQOIRdasLO83MLOVWYrL1PMb4yxWidDV
         8LOH0iQgGVQw1ALUHnPUjdJ2Zzz/GHmbSD7FHnKYjRdmoLAX5eMBTwdmDxg/TKEWPBSX
         H33boTApfw6+ZLt9zoPv+SXZxOCddHgcnNp9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745640696; x=1746245496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyFr35xmw7E/ixwUNF7HuIhiUoN7WKp+7IA8FTndH+M=;
        b=lwbJ1SzThzeX9w+PN8DFb9O30pqArHFuRPs4CyNaydeooXZ1zDQ3kXRkG/rGjE0N5Y
         IzfRq700wKeRWsBBfmmgY0iqI8/AHczWbBI943pbnexco/koBQr5IRZ1AAeIVG9+fpKf
         QP8S0Z6GfE2jcO8UzzK8b6/oUjuOxvl5+UCXoHXM1fSMfGTzD8qVo3rDh96g6ytpSDWH
         Dj7+9ss8r9VKcz0D+x/u0a0qhUWeGmfTHCZCAtMSUeqD5uZqAj2PhGj5z+UNcWRWFuWV
         tgJ1oNBLQjNfsyyvSi88E/3Qsnw8XSPh1k/IfTwDBmUWQFJ3LnyLqkf1D5RRzEF5KsbC
         L4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3B+hFoKq6t+oeWUeO/C3gnVk3MNCiRUJccrY20jIIBQ5e4GEZo6ZuGdO4CtPC2q/KRfgmi5FNSx23xkr@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHOTgf+AUbuLU6QB8rRWwq99npeym2ZWlktCqp5sMuW/ny5E9
	topdQxijCC+6ZDS82XyWbbca7d4pCMWwgVQHEnjwA2MPNnI3ko0qtII05FBu0Gq5XyeWPNgnpKe
	Ccgk=
X-Gm-Gg: ASbGnctycXH71T14KPp2TdmA6OpUDShdEcyS+1WVB1t3EcA4HPpRdmTBZodhGC1fujy
	Bi+qbcP4I+xhMAuleokdE13IWrGO3TeHXB7Y/oMq1w8ycnxil1Oj78rLTuY03ge/8A/yJyG8SMu
	UyhkgrHadvNZGFeVUR5dsuY8Qw5yiMMGURF6ZfWTDLlPZo2S9Vc/JNaecd51r5WkUGg31w0zSUO
	pi4vPvKLcR+9fjN4DQUMfROhWj0UdJTHQ4f1sq2cpE5rV/+05lQTII6JPVl+6hf08LUglCIJWt7
	0Ms4iM4V4kDVafv41Qvk/rjF2sHdpa9njD++jnVMpOgdCkO9VjsW0854lOKdOjZpCPtDNkCJV86
	kc2kX37Qau2AMIwA=
X-Google-Smtp-Source: AGHT+IGrOabUxKKr3aKJG9kvbUXWqHqWOmaYPWBjujFGFA9ZUmD3RIbNKKljC/v3mJw/jwj6KJtIWw==
X-Received: by 2002:a17:907:7d89:b0:ac3:f1dc:f3db with SMTP id a640c23a62f3a-ace71087fc2mr457996666b.13.1745640696225;
        Fri, 25 Apr 2025 21:11:36 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8f3dsm226425666b.110.2025.04.25.21.11.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 21:11:35 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb415dd8faso418045666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 21:11:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/lK9MpGtK0bue0ShsAL3ZWAj3bFa2CJuSUOApwY9NeannBX4g/0cWbqeZMjiaCjBRVGwAYPD7Y5x+v1CV@vger.kernel.org
X-Received: by 2002:a17:907:7f8d:b0:ac2:912d:5a80 with SMTP id
 a640c23a62f3a-ace7103925bmr389163066b.5.1745640694818; Fri, 25 Apr 2025
 21:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
 <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
 <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
 <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com> <opsx7zniuyrf5uef3x4vbmbusu34ymdt5myyq47ajiefigrg4n@ky74wpog4gr4>
In-Reply-To: <opsx7zniuyrf5uef3x4vbmbusu34ymdt5myyq47ajiefigrg4n@ky74wpog4gr4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Apr 2025 21:11:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGiu1BA_hOBYdaYWE0yMyJvMqw66_0wGe_M9FBznm9JQ@mail.gmail.com>
X-Gm-Features: ATxdqUEOndetjy9WXSDQF_xoaos9kB0PLMfvWcYcUeLMoKS_bINLgYq1z0VMTUs
Message-ID: <CAHk-=wjGiu1BA_hOBYdaYWE0yMyJvMqw66_0wGe_M9FBznm9JQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 20:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Yeah, Al just pointed me at generic_set_sb_d_ops().
>
> Which is a perverse way to hide an ops struct. Bloody hell...

Kent, it's that perverse thing EXACTLY FOR THE REASONS I TOLD YOU.

The common case will never even *look* at the dentry ops, because
that's way too damn expensive, and the common case wants nothing at
all to do with case insensitivity.

So guess why that odd specialized function exists?

Exactly because the dcache makes damn sure that the irrelevant CI case
is never in the hot path. So when you set those special dentry
operations to say that you want the CI slow-paths, the VFS layer then
sets magic bits in the dentry itself that makes it go to there.

That way the dentry code doesn't do the extra check for "do I have
special dentry operations for hashing on bad filesystems?" IOW, in
order to avoid two pointer dereferences, we set one bit in the dentry
flags instead, and now we have that information right there.

So yes, people who want to use case-insensitive lookups need to go to
some extra effort, exactly because we do NOT want that garbage to
affect the well-behaved paths.

And no, I'm not surprised that you didn't get it all right. The VFS
layer is complicated, and the dentry cache is some of the more complex
parts of it.

And a lot of that complexity comes from all the performance tuning -
and a small part of it has very much been about getting this CI crap
out of the way.

A much bigger part has admittedly been all the locking complexity, the
RCU lookup, and the whole extra 'struct path' layer that allows us to
share the same dentry across multiple mounts.

The credit for almost all of *that* complexity goes to Al. Because
some of that code scares even me, and I'm supposed to know that part
of the kernel better than most.

             Linus

