Return-Path: <linux-fsdevel+bounces-71543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBECC6C27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51BE730181D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149923507C;
	Wed, 17 Dec 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GF22Ll9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAED2561A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963037; cv=pass; b=I8QuPQoTIhWDUDFzNYajJAYnE6GFNVit/2dN+KTwfAUvaKlcMWnCs61ZYS/0raR0hzjsxhlYE0yImSi6GH1bfepqsmcEakIWMrGuq3troinGK2cB9HPK+otkbDHA5U7ulYzr5Q3s7CsfvCggVPs/WiaeMl9Aiu52ue6cjJyBAUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963037; c=relaxed/simple;
	bh=UW36q3zvbgCajqZYtGawrjbY3qA3kuNESz0YioL5TSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DP/bnWGkF27ds5bw0LO3TwCLnG7NAT107GLjjY3Ja7XLdQzWiIo8fLhAgbvwxoPEmcnYJ+vtPLStyR0Pr/Y3M26TNCiAkafo1+vmS921Yr2XfrwhwIVLZ9xp/gBhSCuqBzQUuKxzktrBoLiWZLtBfxi1bJy5lhpbRy71n7A5Oa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GF22Ll9q; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f34f257a1bso363381cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 01:17:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765963032; cv=none;
        d=google.com; s=arc-20240605;
        b=DjZOhU+C8sFdydXJQuZgNTaizBnMaVF8X8E5Q5OnHiBdDeJ6CMF11eVG/p56Qn0w0n
         0g7f6bnKJc6GFMjY/pRrdxXH60XknATOCAoOC5vaVQrdcXfq3AixhMgVeKua/tnd0Gjx
         cXL3OIrPOacLvOIS6X4Hfi3CYHaJyND1TCAvPGPcox5aZUUD26t2WHSOK7GC7ZycZSH5
         +AGPSfHIsmnnWSdSmCo+XzpW2/pi7Pf08nWijRgQj0JY6EL4kuc0Zb0Re9MrnmcMBDK0
         DPoRztS+f+MVtUCIDMQya2xM278JDGesCmfCjp+7/yPUQWsCAcFF4kKuLyBOwVSjav7o
         u2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fMG0Q0My7VJEU8VJQun8PNHKLf/xL/+KCJKJlRjjJEs=;
        fh=2tGhgHakDOHgbSylmUZFPWlOuvDi/LcxAchj83fwjiA=;
        b=GacXw3lZx7iJOQDfeiyoiNmGiucM3crmGnsrRTV9fHzF98NjESrp18Ahzwu/Uaec63
         0k28aU0fLb7AixSLat0gjT2DDBf8tWvFkw3RgXLsTKvw5cd88j0/0gxLdV8EodvS8UcA
         t0311OHdlO+22+OjpNHDnImANhl/hntbxIEWU1EYwxzIZd32onum/Gae52/NmLl40oY7
         pNXJxy/pcxgT92YN9aEdb4kWZ+3I2n7UdfEQMvUmjRlmwktJWJ6dXlDS/61hUm3MogCq
         4rb7rc6TzgEgLooxro1m+9TzOV2SPo5zzzBn1js4nw1GRARCFjGRMB7XM8Ufs6UZEijK
         LgYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765963032; x=1766567832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMG0Q0My7VJEU8VJQun8PNHKLf/xL/+KCJKJlRjjJEs=;
        b=GF22Ll9qAYZAHCHKknzqHZIH5ZZXLyb41E6b69VUsWaKgi90mJCmbCAbHcCt4H0k27
         N8lnC7Syc0GV9Ep3tsZwyXQphNa8v4LLMySmXJRctQjGq663Hb+uN5tHwqTEE4Xyc/Wi
         0lmon5jvXhzhb2hh1WPyMskUs+33/TQE+JCgIwEjoKfAjdpuGHVW8Q6T/q3Hja6+HlZm
         RtWduDZz7oiKWRVdRwcBXd/e1k54nFrIr0JMxMS1kESgloKfyZ5Esleyj98krFuxYqof
         2epD+Zmkx2EW+DuZKIWQd97MdbqZkna1c5m2ZLmIcGFAHsb2nd/9oHBpqgXC7oMeoOVo
         ZYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765963032; x=1766567832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMG0Q0My7VJEU8VJQun8PNHKLf/xL/+KCJKJlRjjJEs=;
        b=Q8RqSJmVWYtHTEwXaP0T5uDS9e84h2saivthcc9jQJn17M6FzG6BMoC/Gy5oFDPJ4t
         IPJ37zAM6ydimQovUxBJveG3dSizs4/IGXnbQBOVVYjjHkkMF/BTvjCQHgyVJIJCyo5z
         N7CEk+ZHNzTJvvIp8rSLWZ29CObBBbi3YScTk/chIqlCNlnv0bR2BLkyWTr7kBz2NRwp
         tU+JDHk25tvw+bDEPbaClWT4KjieQuyCyaBl+AXuODYhgYfNJ1tOweNEnlDVwl6BOBwx
         4wGRAJdf9/7jMgnXCQbNDdQjgpF/v8JCdATB27wSBtWb9cXbJGvq8b90MKddNuG5GZHH
         UhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWTCnE++VIXOo8VyHeqgr3zTVHpqQQ2h3AVdRwxke6xdP96kTHv9vPmldV3mN+FIQE9pQy8WSacOypGrrQ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPTo2dT//53wsDar0Mj8KN6rCwn8QCmzOlySuc/Knlsfk2LiD
	kC9e/YI6mbZxR3IHcZRcPEhiH9UI/KAKLYoGlWuCyX7lIJnfL10JvTaI99ago06+lPOn9Uj/W7I
	IwMbp/HqQABT4IpM4TYz9WzhvIcthll1FN7k1wtMelYd7bWfzDCBs4GIxXaROHQ==
X-Gm-Gg: AY/fxX6Wk3qn+AyMTAMyyTPdE9KxvdjeEF5gYh3bTUCPkA4RFYct4lhbPWm4+ET2azT
	uxzYQcTZJPEqeMW7O6VzkEc2QkRTDndx1+XX83M6BqcnDUyJbZVccHy7PRYnc/gkURxN17bV49w
	3zMRIquTBEJblOnsKJHqGUylkbbqMhGCS9LaodmXYOO+edSm6rMXTtAG0fn2wzomQVC51fVOqsb
	plIcVh4WXClErzSkGeQ7AX0C0nnJcQTY7eO5ntwBN9ylSjviWD5UY3xWIT448m4Toz0YEekzge8
	4+z0gSHodogcJbaKE8pscH9/pmBrCMnQcTiv
X-Google-Smtp-Source: AGHT+IFWe40aTAJc8ZHRj69v9sZNNcURHJwV6lE6s+zSQVCWya515Sur1Xt9dcjdiwTsLhzAbgNW+NZbBdyuneO35BU=
X-Received: by 2002:a05:622a:351:b0:4ee:43fa:f3c3 with SMTP id
 d75a77b69052e-4f35469832bmr6132831cf.5.1765963032261; Wed, 17 Dec 2025
 01:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com> <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com> <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com> <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
 <CAJnrk1aSEaLo20FU36VQiMTS0NZ6XqvcguQ+Wp90jpwWbXo0hg@mail.gmail.com>
In-Reply-To: <CAJnrk1aSEaLo20FU36VQiMTS0NZ6XqvcguQ+Wp90jpwWbXo0hg@mail.gmail.com>
From: Abhishek Gupta <abhishekmgupta@google.com>
Date: Wed, 17 Dec 2025 14:47:00 +0530
X-Gm-Features: AQt7F2ph5B672o0lgTQCqcV7uDNXLTEykMkSguuKakLpMC8kvrwWTgZkDcQKv54
Message-ID: <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>, "Vikas Jain (GCS)" <vikj@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne, Bernd,

I'm seeing this regression on passthrough_hp as well. Checked it on
6.14.0-1019-gcp and I was getting 11.7MiB/s with iodepth 1 & 15.6
MiB/s with iodepth 4. To remove ambiguity (due to kernel versions), I
tried it on stock kernel 6.17 as well. Please find below more details:

# Installed stock kernel 6.17
$ uname -a
Linux abhishek-ubuntu2510.us-west4-a.c.gcs-fuse-test.internal 6.17.0
#2 SMP Tue Dec 16 12:14:53 UTC 2025 x86_64 GNU/Linux

# Running it as sudo to ensure passthrough is allowed (& we don't get
permission error for passthrough)
$ sudo ./example/passthrough_hp --debug ~/test_source/ ~/test_mount/
DEBUG: lookup(): name=3Dtest2.bin, parent=3D1
DEBUG:do_lookup:410 inode 3527901 count 1
DEBUG: lookup(): created userspace inode 3527901; fd =3D 9
DEBUG: setup shared backing file 1 for inode 136392323632296
DEBUG: closed backing file 1 for inode 136392323632296

# iodepth 1
$ sudo fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename_format=3D'/home/abhishekmgupta_google_com/test_mount/test.bin'
--filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
--iodepth=3D1 --group_reporting=3D1 --direct=3D1
randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T=
)
4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
fio-3.39
Starting 1 thread ...
Run status group 0 (all jobs):
   READ: bw=3D11.4MiB/s (11.9MB/s), 11.4MiB/s-11.4MiB/s
(11.9MB/s-11.9MB/s), io=3D170MiB (179MB), run=3D15001-15001msec

#iodepth 4
$ sudo fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename_format=3D'/home/abhishekmgupta_google_com/test_mount/test.bin'
--filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
--iodepth=3D4 --group_reporting=3D1 --direct=3D1
randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T=
)
4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
fio-3.39
Starting 1 thread ...
Run status group 0 (all jobs):
   READ: bw=3D18.3MiB/s (19.2MB/s), 18.3MiB/s-18.3MiB/s
(19.2MB/s-19.2MB/s), io=3D275MiB (288MB), run=3D15002-15002msec

Also, I tried to build the for-next branch against both kernel 6.18 &
6.17 (to figure out the culprit commit), but I got compilation errors.
Which kernel version should I build the for-next branch against?

Thanks,
Abhishek


On Mon, Dec 15, 2025 at 10:00=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Tue, Dec 9, 2025 at 6:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
> >
> > Hi Abishek,
> >
> > really sorry for the delay. I can see the same as you do, no improvemen=
t
> > with --iodepth. Although increasing the number of fio threads/jobs help=
s.
> >
> > Interesting is that this is not what I'm seeing with passthrough_hp,
> > at least I think so
>
> I'm not seeing this regression on passthrough_hp either. On my local
> vm (on top of the fuse for-next tree) I'm seeing ~13 MiB/s for
> iodepth=3D1 and ~70 MiB/s for iodepth=3D4.
>
> Abhishek, are you able to git bisect this to the commit that causes
> your regression?
>
> Thanks,
> Joanne
>
> >
> > I had run quite some tests here
> > https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-6-742ff1=
a8fc58@ddn.com
> > focused on io-uring, but I had also done some tests with legacy
> > fuse. I was hoping I would managed to re-run today before sending
> > the mail, but much too late right. Will try in the morning.
> >
> >
> >
> > Thanks,
> > Bernd
> >

