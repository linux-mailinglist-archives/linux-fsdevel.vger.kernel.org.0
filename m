Return-Path: <linux-fsdevel+bounces-23966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BB937099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764A31F227E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE71146587;
	Thu, 18 Jul 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hc9Q9u1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F939145346
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341637; cv=none; b=X6lg4uogd02QiPYHi9bTTQfhO0vRZaNSLZ06XaqUNk8tHWHO1oAiXb6i7gPcMlj1/aCquIYbGiRpTvE9yABucGN2nbJWsIEpAz0TTaclMPWwc7aB6cmMtpOOBlbwKiu+HsdXoJbUstfJAa9Q7aX5aQlUF5u1R8gBBOtd32QAkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341637; c=relaxed/simple;
	bh=zDgU2SeIdYUFXxQD+LyyJxHubKApfobdHZJlnZImCX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdZdZwtGXoxqc7/y0Xcuu3Z15ggD/VubcYpxV7TYBYGzdYTqhd3hHz+0Q/eAfokiDPY+CVXDk2NL3T+9ZwB+nLJuRqlQ+nDKlOeY/bmM6wD7bvgrI1Js/pcBqthY1ECbA18pqAcajvPmgsR3MIFcQZ48rVeN+n07EGf0IvGYKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hc9Q9u1W; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77bf336171so216269766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721341633; x=1721946433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHdzQrdk/WoOtHbpZ/K+IpYkj14320RN1AlLLGKZG80=;
        b=Hc9Q9u1WoPQ1bSigW6TkgUsx1Zi0xCJ1qZa0kodWcKk0CRVNCuO/+aUZ/h8MRoZNa3
         8cd9x4YdaKpUzL0Vi2WH13ZeRrY4v4SkxqqUZfDnYFk6YX0Wz1EUh0LU4jvNsqKMUtIQ
         BFA83eqCJI0X4WUYUk7sIqqb4Fs3GdL4/Dq8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721341633; x=1721946433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHdzQrdk/WoOtHbpZ/K+IpYkj14320RN1AlLLGKZG80=;
        b=RRcEBtTU/hqD54Z7B4QO0/LsGv3H2hiP636FduiwwnZzNexgYgvrp14FzjWGfs7sST
         +ErSI/SGwCKuU/VL+WChgSs8Kq3iNDy7Fu4Czpjo+w3dzK/C6I1mERIQ+Rd7wf9TQt+e
         CgMnKKEVoc9gBid8vezJIJTfD4WDx3z3crtCvUP173pOaE5UtAQO/AdYrXgDtE9O3YSC
         HFjYSbehzIQAyb2JGJnpb+6Mc03B8Gq7ghTMvXWVBZKdePkXE5AC6NK+WIO+RA1nNmXl
         X7TViTuol68Ghk00SWy3m39e3M+bI91JEoqDZkP5gqQMFrEI3oKaePPfvK0I+bdvZAFB
         c/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2j4EPPwBDNMPWC8LZlkBjh4uc9gyjnfg9D0svV92k/1JqlnGxhvBEhduQiFIFabSPAniExTVjoWdtAOZqT6s8gJLwqyqfswtv+5QBUg==
X-Gm-Message-State: AOJu0YxATKSnr8VyY/hg1goNwWcs+pMZgF9h1EG2f2SKo2dfFHVHcekJ
	fnq3BIgwa6+UT4S2X6KOmPDBb9nDvKhLTgEWta0LuVMEGRR034wQbSk7LBG7GS/PrSI3+A2vMe4
	eKtI1NA==
X-Google-Smtp-Source: AGHT+IGHwaVi9zj4monzGizUiIbUhMhvedjX9EEr/Ty1rUiLROhkvc9kz0vYWYxaTZDEfZox492Sew==
X-Received: by 2002:a17:906:55d1:b0:a72:7b17:5d68 with SMTP id a640c23a62f3a-a7a0f0fea4fmr435951466b.3.1721341633539;
        Thu, 18 Jul 2024 15:27:13 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a33d9fc1csm8904266b.119.2024.07.18.15.27.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:27:13 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so564238a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:27:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5uRzlbDgBOXe64oYIBOuC6NKIFesxlacZgYKOkNZL/XCRbMfnK0h8YbuhfiocSQrlKmogS4ukqKdoOS1yFTghwwrjrHRL24s6L+gf6g==
X-Received: by 2002:a05:6402:358f:b0:57d:4692:ba54 with SMTP id
 4fb4d7f45d1cf-5a2d168127emr524937a12.6.1721341632616; Thu, 18 Jul 2024
 15:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com> <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
In-Reply-To: <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 15:26:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmXpbFKmmk53c8Um7naf-AAwOGU-26RTHiafbGbostCA@mail.gmail.com>
Message-ID: <CAHk-=wgmXpbFKmmk53c8Um7naf-AAwOGU-26RTHiafbGbostCA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.11
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 15:24, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Sorry, I must not have been clear. My master branch is a) not where I do
> development, and b) not not a branch that I will be sending to you -
> that's simply the primary branch I publish for people testing the latest
> bcachefs code.
>
> So: master will now be just updated by a hook on the server whenever I
> update for-next.

Oh, ok, then that's fine.

> > Now, if you want to do _additional_ testing along the lines of "what
> > happens with my branch and Linus' latest" then that is ok - but that
> > should be something you see as completely separate from testing your
> > own work.
>
> Yes, that's exactly what I was describing.

Good, sounds like we're on the same page.

            Linus

