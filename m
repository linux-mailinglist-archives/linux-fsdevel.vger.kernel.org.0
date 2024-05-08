Return-Path: <linux-fsdevel+bounces-19119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C38C0389
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2F32823B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF712D20C;
	Wed,  8 May 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZWwyBDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426612C53D;
	Wed,  8 May 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190340; cv=none; b=jnXBRa40tEM6grxksi+LB0O9SC+Zz4d32b5DCdvKkrnKfMKKOBFEPFNZGPx/JnnzN1PvlsM/8dkQAETAa6fHEDvm854zGAF+9+OGTDhpqLkKXS9Rlrhb6paTVoj98hc0q/OzYCu93nyAnM6qDIW5dbhV+pFbQTxeYPl8cOcvcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190340; c=relaxed/simple;
	bh=J9rxaShe8DnD1zG+rIM4r+Ehc8sjR/2P5I/JoOOEs8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KveAggebSAZtIF3WjLJeSIk8eVJl2rY2qA/Kk9okk5/JqC9DdqdbS2chpbFhVL+VGrndPgjVAYhCQM0c0XTuMZyz7gLu9sv11Vb+MRUpvj27ty/nbg9rNajaq66Mm3q5MB6hdfcZI/Q5XqXXRo2h+3hPImaHEy+B1UYuBYyjVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZWwyBDR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518931f8d23so4515957e87.3;
        Wed, 08 May 2024 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715190337; x=1715795137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YpOyR7sEcKqWJ7zR1tbOjAV4YCtQJ/MHAOEDc9dmlI=;
        b=MZWwyBDRxs9KAXv6QVKMENvrQXTuyMrDkMGMZsaxoMBoL+9o4HuyJDo00/8+vEfh/I
         5Gt8bj1O+i/BwglAVZSofMfQKYrkuOSj6D8vLt6kukpUlmqW9isezyz3V0rcDmA9cGKS
         mrdi30HKwGX/db8wV9xpEuT4BmaoqjLbqKHFYGygLvEnyjk/d5LCzD3vp3xYmZLxoX3H
         jxBTbOnB8fJ5jMZCdPSpXlO+yIruUf9FAKw06YS6oXkT9a/gIwRoDPLSE31xrH8yk2Kd
         daULAggWL0K+2I90qrt5ArJplP9b0lPh+jQLSf1Ds+3Z66ehATYSKc3FPYMZeKTBsbnQ
         GlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190337; x=1715795137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YpOyR7sEcKqWJ7zR1tbOjAV4YCtQJ/MHAOEDc9dmlI=;
        b=GFlAg7f6P70kabvF1kY1iYgD7bsMcisfULT59dvoN7vMEeBi6CXngRD3WlQPRVUyPe
         GjidGtHw1Ia6oiNNJTvQrrDcfZf/9TKo03C/m/HcoVdQZXGkrEvzaF4X5IvLhn4BgE81
         Vu1QDIbnB4aeimOzsbJWO16H/lV2XfOglVXlslf7hgKFHZga+2Tc+dO+VdcTF2zk0t+6
         NaVTu+xMLAU58/z9YeHvJLaDtKzQQ9ojDAOvt4imm2d9h3YazL/Ery/vNYEJXgaCEAQV
         WdcPO1I0xbNAJpmXPkS/KXjexSAmgwDgCbhVOxiceukuIqaSRWVpmyUWCHVg6AaUiAMj
         vqZg==
X-Forwarded-Encrypted: i=1; AJvYcCV7pcZEmf6iokDDhVNARvBs/Puo/F+aA6mduHt2DwxQ5xai6+ryn029JMM0UnpndxQTOEnmHwA/EZtb0IxwN6TtA+VST5QT1klroFslUiqEtzICCnakhydIu3HMG6uEOI97y8RYGhg+9A==
X-Gm-Message-State: AOJu0Yzu8H5a6bF1Tq6oXBW1D6QkVIiuAWdO1/garqjazxLpRz2ApteF
	9m9GOrrkzd7xnYy+Zml5+E2+vlV6mv4mm6IOycHve+nLiKHI1ZC0UlF2HjC4gLAxxnksaH1ZeLh
	6NDM9bmCfGU27d3sp+Y08BIKEnAw=
X-Google-Smtp-Source: AGHT+IENyS4BGSIrm8+zmbnKFWxmMBVao31FcGAzKiMHqSZ2culOe/5GGFaG0D3SK6ipXNKNeRvfUYsk2+5RNBsgB3E=
X-Received: by 2002:a19:9158:0:b0:51f:5c3:2d6e with SMTP id
 2adb3069b0e04-5217c46c15cmr1928148e87.17.1715190336273; Wed, 08 May 2024
 10:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
 <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
In-Reply-To: <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 8 May 2024 12:45:25 -0500
Message-ID: <CAH2r5mt=CRQXdVHiXMCEwtyEXt-r-oENdESwF5k+vEww-JkWCg@mail.gmail.com>
Subject: Re: kdevops BoF at LSFMM
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	kdevops@lists.linux.dev, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, linux-cxl@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:48=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Tue, May 7, 2024 at 9:44=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
> >
> > Dear LPC session leads,
> >
> > We'd like to gather together and talk about current ongoing
> > developments / changes on kdevops at LSFMM. Those interested in
> > automation on complex workflows with kdevops are also welcomed. This
> > is best addressed informally, but since I see an open slot for at
> > 10:30am for Tuesday, figured I'd check to see if we can snatch it.
>
> The empty slot is there for flexibility of the schedule and also
> wouldn't storage/MM people be interested in kdevops?
>
> I've placed you session instead of the FS lightning talks on Tuesday
> after Leah's FS testing session.
> There are enough slots for FS lightning talks.
>
> There are several empty slots throughout the agenda left for
> flexibility, including the one you mentioned on Tue morning.
> kdevops session is for a very specialized group of developers,
> so if that group is assembled and decides to use an earlier slot
> we can do that on the spot.

kdevops could be *extrememly* useful to understand better (and
to share "best practices" and ideas on testing from various filesystems)

I would be very happy if there were an easy way to do three things
faster/easier:
1) make it easier to run a reasonably large set of fs tests automatically
on checkin of a commit or set of commits (e.g. to an externally visible
github branch) before it goes in linux-next, and a larger set
of test automation that is automatically run on P/Rs (I kick these tests
off semi-manually for cifs.ko and ksmbd.ko today)
2) make it easier as a maintainer to get reports of automated testing of
stable-rc (or automate running of tests against stable-rc by filesystem typ=
e
and send failures to the specific fs's mailing list).  Make the tests run
for a particular fs more visible, so maintainers/contributors can note
where important tests are left out against a particular fs
3) make it easier to auto-bisect what commit regressed when a failing test
is spotted
4) make it easier to automatically enable certain fs specific debug
tooling (e.g. eBPF scripts or trace points or log capturing) when a
test fails, or when a test fails - enable tracing and restart tests
5) make it easier to collect log output at the end of each test to
catch "suspicious" things (like network reconnects/timeouts, dmesg
events logged, fs specific stats or debug data that show excessive
failures or slow responses)
6) an easy way to tell if a kdevops run is "suspiciously slow" (ie if a tes=
t
or set of tests is more than 20% slower than the baseline test run, it
could indicate a performance regression that needs to be bisected
and identified)

--=20
Thanks,

Steve

