Return-Path: <linux-fsdevel+bounces-11587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3231854FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CB71C26DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0D7D41E;
	Wed, 14 Feb 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nfzj2FGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846F7C086
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930887; cv=none; b=l4j4GtCPZTTxBYbRXNW62R5npDHRm4HawFoXN0EBm0Hv/psS6lf1f67fGKwdltkOYprx0JSTafuhpoPnqwX8BmffDqt5T32Z25JFnxhXOCxFMx65UDshAWutYiF8QwsP8LW+xWfNvtpKdWEMEsGWsUUyPbbggV08XvoGFe6MDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930887; c=relaxed/simple;
	bh=8ou5WjqaFbf0d6dlT4/+7co77L0bUTMJQFMyMq7YuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkqlfGeoE06wt7B/BKPr/K9BGQicJ3vxA4wrFKWlTANFyfrl6ax/1eFYCsjSO74o5DIfN1T70AK6/UCkEMt1d1akx/0w9BKBf7JPsn1FXECQQ3UXFgK76AeqA8+kxCj5DF+wwum9Nt4FYnGLRyfawkaTb/QAKMRd6IlP0mUOD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nfzj2FGl; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so821796276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707930885; x=1708535685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ou5WjqaFbf0d6dlT4/+7co77L0bUTMJQFMyMq7YuMo=;
        b=Nfzj2FGlgB96dAxnYVux5aTYI24Jx6lVlPdgWAzkHqNSad+efPitOrmSSQ7ZeKvZDk
         GXRiW+A5T8Q/UaFzJaeCcE7juGM+T4QBxF2aCsi+eJ2Q4qBk9SuEjq8ynudjOKhSrndJ
         8sInBIBP/WLRxbkxbwOiryYviQUYrv0H15f7yO/Kx47EGAXXDWKCE7puN1zuo1A3cUmK
         mKXFztD9Nc9mkmNZl6O7yCYUb77+yf6BLfFzQb6Ail9dX+pkdX2IxyNq9DYqdHGgUX0P
         PbY5+1UDOYA5gxwsFQ2+52lSDPQxgivhCoMuTFNqqOn7OnsZ85UcGVzxf9jr6bhPFFA8
         BwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930885; x=1708535685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ou5WjqaFbf0d6dlT4/+7co77L0bUTMJQFMyMq7YuMo=;
        b=XRIPtOMkrYg+YhuqVJlzn/ZIlHBG22KljwJnALv7iput6XFQrRD2DbUk13fkBmCEas
         iIBFvQzQc0FzaQQFDEPtyck4TuP87DwdGUHZ5cL8Xe/MkRl6ffeTD611ZhJU/2NO/naD
         Npb4mH0EAXsh232iiA1197QBElZO7tFBc3Z8N1Zc5mxqkFLKwPkPkBQ4Bb6hwyQqghXC
         dNwT0WWNnqBFUP1Ki5yxyFqz/O1d/BisrnB8LKtDjGteV4FaSO7j5VK14oNNnPSYm5c5
         kHZUuEfydBDZKQsIS2IU7pWStWF/dZAqXBiD0P7+1Hc1VvY8cTfohWyn50C1wRv5wsxf
         sEQw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2QIa/l3/Kj4yPm7dECZerSBRevgi331meZA6z28Y1SENYWFmow1LyPLNZsmejanzq+0ZZdTx7i+isgGDDNjEfGWewuAjEyAiYs3tXg==
X-Gm-Message-State: AOJu0YxL64OB66qMUuNoJ5nJ1b2WQmAUdkGKgrD3RInPrWOxFgiNcyGV
	dxVtvoBxltDtK2BEr/LuFiBiJt1LHWICEaBMR0u5yyQfwXXqiYiSVf6X7qv2nNSDTF/v+VHrw8d
	Epn2qxodbKuCBY6gizRiB/Z20UmJauInM0TL1
X-Google-Smtp-Source: AGHT+IEklcDkHwhJJTRfE00RVqD2YD9tPurIlvkQmweXW1ROZAgTvoBmd93LGr06RSN2meH7bqCAE1CDi8ShYu3HlN0=
X-Received: by 2002:a25:4b84:0:b0:dbe:d2ec:e31 with SMTP id
 y126-20020a254b84000000b00dbed2ec0e31mr1980533yba.27.1707930884496; Wed, 14
 Feb 2024 09:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240214062020.GA989328@cmpxchg.org>
 <ZczSSZOWMlqfvDg8@tiehlicka> <ifz44lao4dbvvpzt7zha3ho7xnddcdxgp4fkeacqleu5lo43bn@f3dbrmcuticz>
 <ZczkFH1dxUmx6TM3@tiehlicka> <udgv2gndh4leah734rfp7ydfy5dv65kbqutse6siaewizoooyw@pdd3tcji5yld>
 <Zczq02jdZa9L0VKj@tiehlicka>
In-Reply-To: <Zczq02jdZa9L0VKj@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 09:14:30 -0800
Message-ID: <CAJuCfpFR85w5_8sX0uLfi4SsVb8Yr6DDu=VTA25PB-3SgC=5UA@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Michal Hocko <mhocko@suse.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:31=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 14-02-24 11:17:20, Kent Overstreet wrote:
> [...]
> > You gotta stop with this this derailing garbage.
>
> It is always pleasure talking to you Kent, but let me give you advice
> (free of charge of course). Let Suren talk, chances for civilized
> and productive discussion are much higher!

Every time I wake up to a new drama... Sorry I won't follow up on this
one not to feed the fire.


>
> I do not have much more to add to the discussion. My point stays, find a
> support of the MM community if you want to proceed with this work.
> --
> Michal Hocko
> SUSE Labs

