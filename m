Return-Path: <linux-fsdevel+bounces-47440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08570A9D76A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 05:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2340B1BA7EAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA71CD208;
	Sat, 26 Apr 2025 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U+bVQ1JV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95518BC36
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745638871; cv=none; b=JmYB3/Weaqb6DDh3JBJpNNTxzawOxlq7M6zF9R2VBnoPAdHoS4NIkX7BxWUOa1OWK1wWueR3CnYZpknGW505dwoSR+NTb4vkMkXOZx2/Nf8ASzcjC+2zClTGl/5pke6QY5/vkDdkVBGGpBfCyVQvn8cMQutU6ep7eDeGN+YsnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745638871; c=relaxed/simple;
	bh=0eHXO77AAyGUMGMq7VTE6t2K6BioW4E11zC+/xXCKsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5STYPlKwriQbJEgiRBWp5r0zxdTaEhqK/NjJc/gqlVTgghbb5cm+TU5E9fMM1Hm8YHft9Kwo3htZ/61VbHIMmyLwoQUKqnRRPqTW8BQujh2wZ53d6lTJt2vKJYA+RN4M2i2OwKotskC2nms/x4yijdXGkybNWyEvkOrclZHeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U+bVQ1JV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso3858502a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745638867; x=1746243667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jnw7cB8PnBwNO4vq3emLlRW++0sbsZCdtmwKmtUbY6A=;
        b=U+bVQ1JVyoL+LgR2y88ykK5yiiq3wxNl9NsmggKjvG+ByLrM2oOiv3XMR1C+sa6y/c
         w9pi6aHBUHBEJE11pv2g+LdF40Eguaw8Zquo3AnUqwaLa8astwOGAvE7G2Akrm26fTIr
         2PdBpB5bpfmjeLo9MupC39cDiE1mcqjx8cmgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745638867; x=1746243667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jnw7cB8PnBwNO4vq3emLlRW++0sbsZCdtmwKmtUbY6A=;
        b=ZTWgoJ8imXaKO/E4t3X/bj4R+L24bpRTVSBym29aROpAgTt7OVaJDxvF6HL12RdhrH
         CWWF4pqK9zVaHRYoSbpQPzvb6DzwTUvQnk3gya7JDHyw6ztlOw562Go4vKJlQY+XH6UE
         dkiiBJ+oNC4aLWkkFLXPdM4HVrD/Kh2geAjZr5ab/o8xz6pobQlycSX4TuP1M7RTTbHt
         7YNVKAc2DQ0+AHWPJBAu9rbfbWdq3DSC07sPA1IGBQf3zmf/BEP2lUPZs7h+ehzYq8js
         JjJHgpU3kcNy+LqPEu8KJGWLZKQ6Tlgwl+paxmnaTP9RBudCuKVoSMjwuODPHlQjddcQ
         SsfA==
X-Forwarded-Encrypted: i=1; AJvYcCVdHUqcIcOp5sxRKx9RNfSJCdCMhc9aRCQoBdAa0a9P19djVDRddOqvWDu3FqtDMrpyUCgcyF0mjKHgo2wc@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJapJi78BaIcKBEvR1I2C4QznF+sszPjirzfwZiQCtOv81hqN
	1xsl/G1MQMpZqj0LokyMxUf5Tqato2ikNtE6vfmVaeFhm6Uz+ERjGJ/gCMnurOzyzPox9cieW7R
	8MD0=
X-Gm-Gg: ASbGncuS8U4YHTVzkh2so+HnVUCQ11E2k/X8rDnqTKxobKeEwh9DL5rt6JoTg4EDJxT
	a9IrwpO0TWXrnL1gIN2K9XkJ3wC5p+qvokzWagBYQRU0DMcYv5p/dYwCheKGGWWHusSiSPLTGOT
	qzK4TkdhEJAdjmxEp3oGlWt7lzsimEdCd3Teb56YzAf+KcK3BdAtim86NCabBLgRVPmNxMtxZmO
	ejIzQCKaxXEZNlJqKs6S3W0ycG5AyvP4v4lY04F/pginyyfC88vPq9AWRfK+Zs5q1RgWjSgLHtD
	9eCoTgl7VEMOhSx2XIDJJ7lSmzB9eRZ1ybOqcDvapzbnamel7O6DjfV5DK7R+W7XTcwQvmAUL2x
	lc2Q1orQHmhyqc24=
X-Google-Smtp-Source: AGHT+IFyTR5hUBQhKPkM/EzN0lWHQGt046r+cQpYdZ6LqRq95HTJo/v36wFk07/YMfDcM1xd7tpP9w==
X-Received: by 2002:a05:6402:d08:b0:5f4:370d:96c4 with SMTP id 4fb4d7f45d1cf-5f7394d37ccmr1323680a12.0.1745638867198;
        Fri, 25 Apr 2025 20:41:07 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f701400078sm2145563a12.27.2025.04.25.20.41.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 20:41:06 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2c663a3daso557456466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 20:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXli+3vVZa4JJEiMmDw+C2d14NZtT2LPKg+aKyTb+MuQFdjHfrzKxO11Zc7qHhzVEU0j50DKhe5MH0ktaRh@vger.kernel.org
X-Received: by 2002:a17:907:3dac:b0:ac7:391b:e68a with SMTP id
 a640c23a62f3a-ace84be069bmr123676766b.60.1745638864888; Fri, 25 Apr 2025
 20:41:04 -0700 (PDT)
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
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com> <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
In-Reply-To: <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Apr 2025 20:40:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com>
X-Gm-Features: ATxdqUGH7mQMKhNc_ZyOpUoBrH1zpBO2k8Qe7v9LI4_RH5cpFyznGVafbugfOHw
Message-ID: <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 20:09, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> The subject is CI lookups, and I'll eat my shoe if you wrote that.

Start chomping. That nasty code with d_compare and d_hash goes way back.

From a quick look, it's from '97, and got merged in in 2.1.50. It was
added (obviously) for FAT. Back then, that was the only case that
wanted it.

I don't have any archives from that time, and I'm sure others were
involved, but that whole init_name_hash / partial_name_hash /
end_name_hash pattern in 2.1.50 looks like code I remember. So I was
at least part of it.

The design, if you haven't figured it out yet, is that filesystems
that have case-independent name comparisons can do their own hash
functions and their own name comparison functions, exactly so that one
dentry can match multiple different strings (and different strings can
hash to the same bucket).

If you get dentry aliases, you may be doing something wrong.

Also, originally this was all in the same core dcache lookup path. So
the whole "we have to check if the filesystem has its own hash
function" ended up slowing down the normal case. It's obviously been
massively modified since 1997 ("No, really?"), and now the code is
very much set up so that the straight-line normal case is all the
non-CI cases, and then case idnependence ends up out-of-line with its
own dcache hash lookup loops so that it doesn't affect the normal good
case.

            Linus

