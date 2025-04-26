Return-Path: <linux-fsdevel+bounces-47444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08931A9D79C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 07:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61B84A8742
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 05:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D431A0711;
	Sat, 26 Apr 2025 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="befHzSvp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC544409
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745643704; cv=none; b=Mn0yCE01lp1QAqiVoCwl7+bu8Bco5VtaWVbkLTgX9fDiinr1NrtpbXfP5esNu4MrTUqUrlf9ykfB/3RZemAnNHva12cy+YwnQ2xe5ukVXCGdQ+oW+TSWYDd603jYzigfOIZ01Bk+Xl9DDRPpWlerNji+AEI2R9HnkQWbRRX7mHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745643704; c=relaxed/simple;
	bh=cXDJuE/yHxwV04PJPoKVlfNQF+rhGqfW81Ns96b8E2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw2OfPULc6zFQCHTMQAurd87SXO+B89Vy+m2Fmr6mIm7RKecg/4nniZ2EfBcgyMS9uyHouzNrkaxxJNCzQxnjCHbm3/B030LCcsmk/mAxh8ZzUJPuzZjx/eSceWtl+rBF2bTdOtf9PvHjOs7Ooi7Y+WkbqVyTct0A92wMU8Q+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=befHzSvp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so4447241a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 22:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745643699; x=1746248499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zg0s0tJJS2TEem3MFSImn2y5n2w5Xsq8PYaeuyKw6E=;
        b=befHzSvpC6nEm049fo2PSKtmwjM2uEQmg5QBRwJajygSMbCXpt5xtyA9HC+GvPcjeh
         xrfEV47/qGquenENAwLniSXAwYXJ/YW/GslzxAatGfRb5FOxtCWREe/0u0xenyBQj7JA
         OKZaMabyvs8QCcSUZD113i4bdZublzgxyIumg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745643699; x=1746248499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Zg0s0tJJS2TEem3MFSImn2y5n2w5Xsq8PYaeuyKw6E=;
        b=JXkta8RCmJblw/4/ivh5EPFbLncSRGySlV/lWvK+m2KEOugOHUtQWOqusMLgAwlqvV
         fztbvg1c7fU7hAQ6aDy4sog+NAD+D0fNfcd09znBxD2UBmNPldBpHHgfvPMmhhDnVPHf
         GMK2l+zSOJ0PlP0Mur6hBYjLKqGNMll7h05DvOZVQO/0Y5m38uf1bsF9v0x3Omw7B7xb
         vMrLNjOzxEqQueifRubKdKa0KRqoXUW+/B9FLB361tDrTKyvdedFgnDUEk9545Lo7FJ7
         ZmeM9eZ14px4Y2jJSp1H72t8tova7dTcMLHhmk5xM82O9tnyizxEVDDC49ksJY9FwwLn
         R3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVgaQ91CT1Y1jkt1giU8Ztiue9OZiG+dbsZbsAN75Rn/NyHfVyUCLijhyfMdOOIl41c9f7Zh5nSid605u//@vger.kernel.org
X-Gm-Message-State: AOJu0YyjukYpNNWEgjH5D68BKirRIOdrzhNXMzb2u7TUIfOCCt2ktlIb
	RcMVlSjC/QiT8gp8TGSCTKryaQaUpvDOZv0aWiDOUPAw9NtfZXd/8cs+E3kNWFDijBai4ThkXQF
	slwU=
X-Gm-Gg: ASbGnctTIbt9x1ZxwunLWPSy1mtJtooi5e+T+bcF51R1pRAL8J+HjzvH9okVi3LirE9
	PxcalNtNLKOCv7qHDXyI5iHV4VfMtmwsVyXq+QNmm+Jg0rWOHjAtMuj7g9DrlOBb3NMeCwm89y1
	qP9KB1fYXXvBABSlMMmpJJuSpu0+lddlt0sRlMzx+WZcX2vpRB9udZstoGNgPlNcyBpMM9UHbLD
	1YNL4Wdyc8gsq+s1x/8PQDGj9jGkEioyYCLGxr+woC+P2yF3xO63/iasqgXpLlHsLa/k8ehxunP
	fcRQTPYiye82cb95r+Y884NbhI8rzP4ke8gvcb8UoNBAhH9Trj0rC+qcXBNLpPEBSrmV+75rblo
	MhbQttacWU7a57p4=
X-Google-Smtp-Source: AGHT+IFpsu2w4vwKcA33gT0gS5ADMpoKztNPK5GOCkNzwA6xrupmCTa3pHFzDtBttG4IlpIIMBadYQ==
X-Received: by 2002:a05:6402:2750:b0:5f4:d4e7:3c2a with SMTP id 4fb4d7f45d1cf-5f722b6be4amr4185580a12.18.1745643699458;
        Fri, 25 Apr 2025 22:01:39 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7380cbda1sm858159a12.74.2025.04.25.22.01.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 22:01:38 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso5604850a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 22:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF3Nm2lU9UUYJvoCM5Kyh102aMwoUdyPW1mX0SkSpkUtok9sECiA3cNZFzzIu/GrI1XpmA+WC4oDKqFrR1@vger.kernel.org
X-Received: by 2002:a17:907:7214:b0:ac7:ec31:deb0 with SMTP id
 a640c23a62f3a-ace739dce1cmr296946666b.9.1745643697218; Fri, 25 Apr 2025
 22:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
 <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
 <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
 <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com>
 <opsx7zniuyrf5uef3x4vbmbusu34ymdt5myyq47ajiefigrg4n@ky74wpog4gr4>
 <CAHk-=wjGiu1BA_hOBYdaYWE0yMyJvMqw66_0wGe_M9FBznm9JQ@mail.gmail.com> <rn2bojnk2h3z6xavoap6phjbib55poltxclv64xaijtikg4f5v@npknltjjnzan>
In-Reply-To: <rn2bojnk2h3z6xavoap6phjbib55poltxclv64xaijtikg4f5v@npknltjjnzan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Apr 2025 22:01:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLE9BkSiq8F-mFW5NOtPzYrtrXsXiLrn+qXTx4-Sy6MA@mail.gmail.com>
X-Gm-Features: ATxdqUHWqxV-OrhDY-rKh16ASGQeohXR7OrfwoZY40F3L9gFfuaxZ44BLo28GKU
Message-ID: <CAHk-=wiLE9BkSiq8F-mFW5NOtPzYrtrXsXiLrn+qXTx4-Sy6MA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 21:49, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> And you never noticed that the complaints I had about the dcache bits
> didn't make sense and how I said it should work was how it actually does
> work? Heh.

That's a funny way of saying

  "Oh, Linus, you were right in the first place when you called me out
on my bullshit"

Here's a clue, Kent. I told you you were wrong and full of shit. Let
me quote that for you again:

  "I think you're confused, and don't know what you are talking about.
   You'd better go learn how the dcache actually works"

You doubled down and tried to tell me otherwise.

You were wrong. Again.

I'm really tired of your constant attitude where you think you
absolutely know best, and then EVEN WHEN YOU ARE WRONG you try to make
it be about somebody else.

Now you are trying to make it about *me* somehow not noticing YOUR
ABSOLUTE BULLSHIT.

Just walk away, Kent. Because I'm very close to being done with this
constant aggravation.

                Linus

