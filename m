Return-Path: <linux-fsdevel+bounces-49179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D5AB8FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B111B18916F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BF198E91;
	Thu, 15 May 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxwdAHV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FD1548C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336604; cv=none; b=Nvvx450Eq0ZrqZJbAYDbopX4eSGh7cf+YM8VXLjJvNnvEuxDcy9rEfAgyQ7yMlca1O1BqPReBfD8GFmQzkDBEVezKC4jc5GJO38PVzcJgL+Vqi3Tu7YnWyUghlLWyVk3zKfoiU5QoYifnw6XYdOu/gOrauvC2l2zg1ugFW6Vcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336604; c=relaxed/simple;
	bh=tXz5FbccWZcyNb17rZ1Jt6ym6ilL14Qj/63macpzKvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0UOfPucB1ndN6Bv9mGEB2D2dMvoZf/UVCIn1U9r0P/lVs6Ml3opjk9XzeXU7zMjBcEMkaF8mjUDhxcrFh4HU16lkN4IYz5qD/MLfw3c4taNQhooI+p4q1gApoKDt9mwRoJ04ZKfPI67T4nJlqKAqrmvMQfPgIHIptpVBoXYoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxwdAHV3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so10461951cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747336601; x=1747941401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXz5FbccWZcyNb17rZ1Jt6ym6ilL14Qj/63macpzKvY=;
        b=mxwdAHV3RnrhKaT2TIbLsn7Q1dqUjNbIOynvFoKTmJEZTXbPgRAZHhBGFzNePf4g/o
         nEfgI7w8tyO/HoNlk75ivzKWsjgYJmGmYWkPW19gZDzXOjyOKAJx5gy1D9Db+wppt+O1
         0ZVfIggfdhQzFBApsdbaP56YJKOsTZDnpYcWfmmr9D4RMrrZft+WFjybe0RE1rN7HmVD
         zPkFzCcZLokpIKyUOoRyZCYfdfTJQ6Q+H2H84n7iBPey6OpmQWh8UKaPAKZznuP7lo7P
         TPKqh4xA1azyT6BwvsV1IDkHp0hSXtV/6Zw10mauzn2CHgq32uQ0v+XiZUTVflIHu1CO
         W2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336601; x=1747941401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXz5FbccWZcyNb17rZ1Jt6ym6ilL14Qj/63macpzKvY=;
        b=RjRykWsIENCIdKHAQiLzTpdHxati6u4j8olkgkMJuglqyGWCgVLELVaWM2fc/Biz5m
         4CmSy/C1wGklk0vElKNoqDD2L8l345AwtrhCRfVU/ECLuBCfuizQFoLOM0KTBd86rvJC
         +iVs728zgF5p0U6s/RlPCAzEiN85+qM56C3n9AYa9eWXm6R0ReEXmJB1Q9DbX5Fqhr3w
         d14tN3h2HKTMWIuSE1m8/fOhEcLYoxlUxqBMoasdfs+pNov0qk8RimrmRiSDJhNun7XX
         1FSfcwOZxmIjda0+IvBUt4N+Rx0Mv/++xHxdxG6vOWcZ5d8UKhEeJw406FRzGfavkxL0
         TNYg==
X-Gm-Message-State: AOJu0YziTp1VE9Woj/eKMGRLMypeLowWv4inW846hzGNzaxAWyH3c4xb
	nI/VdSQH9wKZFqsjzZSoDTPfPwRfRLED7iXM9DAhYnad+TciKpjGP80KhWpjtixEt62T0YLDxoX
	gmHYLJ59rcn9x//6YLXhJua7JAb6XKBc=
X-Gm-Gg: ASbGncux3R0/R4xBtDyM8BeJp/G9DynvpR1VyDk9qdCYhlSTfyVbRn83VsBDYCB/Sar
	6aCq6gznTvBRv+G4TXiTkeIvGgYeLS+MTggFO81zHkFidnr3WFAlEeJPzphcBVOIUwBCh9Q4QUd
	wOU3qBhfpayh78GP19wrE2m1AMcIsf74BM
X-Google-Smtp-Source: AGHT+IG8GeX/ffDMNbqJZsorwNCErAgCyk323uPKf7XJwCZdJ/HsUp/7Eb/JO4ZXFvNfRcc9aOybbDoiS7B8ggY2jbA=
X-Received: by 2002:a05:622a:1f9b:b0:476:b59a:b30 with SMTP id
 d75a77b69052e-494ae388a19mr9895991cf.16.1747336601306; Thu, 15 May 2025
 12:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
 <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
 <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
 <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com> <CAJfpegvayjALR9F2mYxPiM2JKuJuvDdzS3gH4WvV12AdM0vU7w@mail.gmail.com>
In-Reply-To: <CAJfpegvayjALR9F2mYxPiM2JKuJuvDdzS3gH4WvV12AdM0vU7w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 15 May 2025 12:16:30 -0700
X-Gm-Features: AX0GCFs9pJNvBog9Dmn0JfITtPwLt_uXwORr36zVbl69W6RD8segbbZjH3yrQhY
Message-ID: <CAJnrk1bibc9Zj-Khtb4si1-8v3-X-1nX1Jgxc_whLt_SOxuS0Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 15 May 2025 at 01:17, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > No. The server copies the buffer to another buffer (for later
> > processing) so that the server can immediately reply to the request
> > and not hold up work on that libfuse thread. Splice here helps because
> > it gets rid of 1 copy, eg instead of copying the data to the libfuse
> > buffer and then from libfuse buffer to this other buffer, we can now
> > just do a read() on the file descriptor returned from splice into the
> > other buffer.
>
> Yeah, splice is neat, but that pesky thing about the buffer liftimes
> makes it not all that desirable.
>
> So I'm wondering if the planned zero copy uring api is perhaps a
> better solution?
>
> In theory there's nothing preventing us from doing it with the plain
> /dev/fuse interface (i.e. read the FUSE_WRITE header and pass a
> virtual offset to the libfuse write callback, which can read the
> payload from the given offset), but perhaps the uring one is more
> elegant.

As I understand it, the zero copy uring api (I think the one you're
talking about is the one discussed here [1]?) requires client-side
changes in order to utilize it.

[1] https://lore.kernel.org/linux-fsdevel/dc3a5c7d-b254-48ea-9749-2c464bfd3=
931@davidwei.uk/

Thanks,
Joanne
>
> Thanks,
> Miklos

