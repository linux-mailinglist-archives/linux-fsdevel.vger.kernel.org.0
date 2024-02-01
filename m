Return-Path: <linux-fsdevel+bounces-9889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1AF845C17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B19FB2B3E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E149626CE;
	Thu,  1 Feb 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhWSB1Ee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19862179;
	Thu,  1 Feb 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802521; cv=none; b=fdEjNU3Z2sx88BOP1csuxn6k5ZYYhYQu2FXgku1xgYYZtyuV0e63IdBssq367D2o/7x8beTMcuREfxGIklWsxam8hYHZqWGtvS11EscJygQecJ80k1yIudU1wIOQF6P45Tcd+Ylz3tlZIwvCkmSbSkdv1mHQYM10OIt5hkakYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802521; c=relaxed/simple;
	bh=kth9kYZka9fDewdHa5KdV4hECkieaPMD8kH0gX5ECBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT1CwtjOTJl6bs16lkH92Z+0QRHVufsXHE6cPZ6yfSlMWtVEmxpeJVhKdzvXkIV3nCwOIatx0guekLdyFvtDH4vpiRQA4f0qja7lf5GUMTkJ1zSsT1s/inAtt1FWyeeqwvGxN3IVOBI4/oRNutkEvMPu/RqOnCwYN566aKqFpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhWSB1Ee; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4bdc96cfe21so370680e0c.0;
        Thu, 01 Feb 2024 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706802519; x=1707407319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1MxZQMO2vhw+OhMM7RCS7rHhxtW/Ys96YZbWutf5/I=;
        b=JhWSB1EeYRcNgCl4oWJekFQt05iMUhhL7v3QbuBcBCGXXwm6oj9iBsfJLpNzOL2ZTO
         Vdujd1cduyA54DiswxiKHBOYbrvh4BqXlEWBuPZubp2kF63HcRCTiw8uZr9O/u4SntLK
         KimfGIPm5l6s+90c4CAN4CCi4iD7hfyphc3GEciKBAVDzX+5COs+iJhAnIh8MOiov8Bf
         TMUSPTcCthmdgSor9oj5wEThvDVHpQ79V1E9Kho9FzqKF9GINZmWc2D/pzBE4eF0Rk9H
         xoxgNKZ9MRDt70RyyAIHUEgmO7czQ6Wdt2hb9u5zhiUqTcN3M38GaZwPK+N6S+6EPxgi
         bQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802519; x=1707407319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1MxZQMO2vhw+OhMM7RCS7rHhxtW/Ys96YZbWutf5/I=;
        b=dACj+mXDJ5qSWAp0udwKVSHbj3PNNNHldrVbQ7iuLBNSjIJMerA8O9Sq2Ll6PBtQfa
         UCohYNaQifIXnu5u9qs71FhNqZ1kIk5WX56ViIUo6/RD3CdcBCwVSG2gCa/jAVNWnS6k
         TPWqZZ9f7cNYiTQHm4I5saimqdJQkTNs2QQOrjtveoNMX/gyOgnpKOtv/t2fX62ycpiv
         KqQ2+Obm4W/o3YcptIRgdgCUXJmXVLhD/qte5GdnErAV7ELp3C22Xrn6UnvtRZ/2ppKw
         tRqthrl4698ZN4dZw0/sla8mrjBHYUw6LVjg/gDr9l4kzyXe4SzJCNotUTWgKLrI2ZHY
         ZZJQ==
X-Gm-Message-State: AOJu0Yzi5H4e/SunAxMRaEsK+plFrP7G2FAO68Z+sbmaZOMg4XwjPYjl
	CJQk9Z5JNf8e4OejqHkhxVWMXoJI7xyidpcyK+4UaM18FsQDQEEus0Ba7L6Smmr57GeQQRPkNbm
	J+vz04UPTYxmSUCQxwiShD+KwM4o=
X-Google-Smtp-Source: AGHT+IEtDAQaQeAzokMzWuQpMOulT26BLy0xfyj9kdSOWS8YtM2Glz6RyzYB/T0y+qVa4jWMD+F5G3VRETwSSxUg1yw=
X-Received: by 2002:a05:6122:2086:b0:4bd:3cb2:88bb with SMTP id
 i6-20020a056122208600b004bd3cb288bbmr2765574vkd.12.1706802518709; Thu, 01 Feb
 2024 07:48:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
 <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm> <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
 <95baad1f-c4d3-4c7c-a842-2b51e7351ca1@ddn.com> <CAJfpegtd1WehXkvLWfbBvFLVYO2nBgWSoq=3Zp-Kmr0spus4zQ@mail.gmail.com>
In-Reply-To: <CAJfpegtd1WehXkvLWfbBvFLVYO2nBgWSoq=3Zp-Kmr0spus4zQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 17:48:26 +0200
Message-ID: <CAOQ4uxi-iptWYOqmsDZFkhPG03Uf=2bHqL_0570cmVOUyhtT-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dharmendra Singh <dsingh@ddn.com>, 
	Hao Xu <howeyxu@tencent.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:43=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 1 Feb 2024 at 16:40, Bernd Schubert <bschubert@ddn.com> wrote:
>
> > Given
> > -N numops: total # operations to do (default infinity)
> >
> > How long do you think I should run it? Maybe something like 3 hours
> > (--duration=3D$(3 * 60 * 60))?
>
> I used -N1000000.  If there were any issues they usually triggered much e=
arlier.
>

Note that at least these fstests run fsx in several configurations:

$ grep begin `git grep -l run_fsx tests/generic/`
tests/generic/091:_begin_fstest rw auto quick
tests/generic/263:_begin_fstest rw auto quick
tests/generic/469:_begin_fstest auto quick punch zero prealloc
tests/generic/521:_begin_fstest soak long_rw smoketest
tests/generic/522:_begin_fstest soak long_rw smoketest
tests/generic/616:_begin_fstest auto rw io_uring stress soak
tests/generic/617:_begin_fstest auto rw io_uring stress soak

Bernd, you've probably already ran them if you are running auto, quick
or rw test groups.

Possibly you want to try and run also the -g soak.long_rw tests.

They use nr_ops=3D$((1000000 * TIME_FACTOR))

Thanks,
Amir.

