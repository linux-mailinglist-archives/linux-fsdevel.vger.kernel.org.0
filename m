Return-Path: <linux-fsdevel+bounces-60754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78531B51489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 12:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD83A5A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DCF3101C7;
	Wed, 10 Sep 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KJncWa/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42542367A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501570; cv=none; b=bp7xZB0TDGjpelU9jySxmIaUca9mgeDjNLE7wRS8F9jAiDt/yQ9l3BfaA5oVps/ZOCUE9buQynA6QgfEVP8WZnW7cfQh3lO1D4aSidI0eKuLmD9CyaiFaGq7zFQxOtq+Jl1mpIdzqfwdMwEzcSmRjaDWsqT0LH5L97QnTFMfYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501570; c=relaxed/simple;
	bh=Pu5n7af86vGvH823/Yp61O2TfCCCjb3TRVHLgzzO1Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hx6m3+zrD2XljN21VwEzzrVzB29uAXFWhEiB2ru24v7toDWEI+X5gI0c1+AHqmSAIXbBtjNno3CtH8mW0jIN4p0oF686s/lny/CdzdZVd0gfhUDfjtQZItLe1ofJGVYws7k5HeYj4O7Tg+ful5SNhuS3luQbY2642fcTVegXIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KJncWa/O; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-314f332e064so2170505fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757501568; x=1758106368; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT1ofiuSVoWseJh7MYOF/nr4mco48PliIphnXMl83A4=;
        b=KJncWa/OqYf9t5cElYrZgAfTqO7MLyjDhC+j5/UwdittfzKekaQDyG1svHG+WcL+qe
         CVLEsgclWew7bw3I3K11AXcDlhco7vAJNjIyP7BB8E05ZR4Fj/TfusWLrdMn82NTATln
         xEeCvnZij1vLVVzakj/PVcRSazTwAioBiU9X74VzRRg8LjEIHxJNQagk77kkNE+cCZo/
         VmZckB7jS1mGlVqC54mDB4H7i3dzxD6EpSweyqep2wp7pwM22fxxLTpMzkjg+zLZ1203
         6h33C9WVtnceyrDXMKHTntd/LZEy59tdFKfe1IqLecAIhSioviUnjmgjdoRfi9rZIIOd
         WtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501568; x=1758106368;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT1ofiuSVoWseJh7MYOF/nr4mco48PliIphnXMl83A4=;
        b=mhbzlYhcxVRQQ7VMEn//xEe49ASc7wvqSTbpqEZIbhmw1y0mwKbmdmQIFT5BYgR1sP
         nMECysrQsTlHHx7lJE/Y9sDiVddJXYePsKotzaVM7gQomm4mr5Dcxd/tb37qgArhlFYC
         R29t8LWiLMUc0Z7Utfph1yzoRImRqgA+s5n9mKLPMbamNh7PRqJC7DujKzkCSHXs9DYU
         9cvld1suIHNVoaMzU8mgMxC3BqBMhrJASe4SbNy73cyib3MdfY+3p9TWeesPy/5MZpMw
         72zcw/5XtOPIV/qzHR4CYASmX/TnjtmzLxFumRoKozP/AzqO9J3MqFVrvGWIGoMkw90M
         Q9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVdfzg9V575+HOfwScBQl2pcNuRmHMcAfprGR9V/2EfvwpZbq2SbxUyoSN/OzCyLDLdqqe1+4MNS+/4AITP@vger.kernel.org
X-Gm-Message-State: AOJu0YxQH7cGZ8ZY01NgqR7Lre97v3vpxsSx2ebbq3SG5A9byd/YGd7o
	W+UHE7DETTw5JDuOFxCXmTbKgLgrn9siU4ychL7qr8zMRCbKeq0r6920oJBI2tH/7BjpPOhayQu
	6Sz+CiWaK9ksjmFJqb7PF4zSDcNms66LaCmhKdvDvXQ==
X-Gm-Gg: ASbGncvvXPLFFioENVdd8Ep6JpWhH8+pX8VIXgVzHoqsMEqQaPSDhcBpr9HpdYmJ21N
	2EZDnrGJKbEvEYU1UZDG4OWLhzI0lxBcda8iuZdWOccTEcDW+viphvankMVNUddyi74s0EpGF7C
	75fLJgzOgtUWBaZShA5bI7nkWBnYcQv1tpGTDqeLjUHBciAagTWnt3d+RxiXYTO+VWnC/sHDFKI
	vowjwY9VBNfCuz+Vwj1WiWC2pfWoJ2dYKFzGiQCQg==
X-Google-Smtp-Source: AGHT+IFpMNnWy1Mpff3ONFTLVx27KeGSsvIhY8w+2YZiYG2szzBQUCGr6b1FcWDN3xQZW1C3esWefEhe++/4nWObHfE=
X-Received: by 2002:a05:6870:f706:b0:31e:1def:1e0e with SMTP id
 586e51a60fabf-32264e1f191mr7168001fac.25.1757501567607; Wed, 10 Sep 2025
 03:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com>
 <CAPFOzZtaKcaSsvUfjiJL2TOwMy-jUkMdboEmp++-USvoUoqjYA@mail.gmail.com> <879fb17c-e6d6-4b1b-bee5-9087ba24a4f2@gmail.com>
In-Reply-To: <879fb17c-e6d6-4b1b-bee5-9087ba24a4f2@gmail.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Wed, 10 Sep 2025 18:52:36 +0800
X-Gm-Features: Ac12FXxaXjFDhXYjy8vJN-rkpO3OKcRZyUBgBZDXgkSaBebRrBGN4SGFHpxr1DQ
Message-ID: <CAPFOzZu5e1AgjHZbKLbCQVn-We6jc-J7h5v1A0SJ9_KM8cPSjA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pavel Begunkov <asml.silence@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=B8=89 18:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/8/25 13:55, Fengnan Chang wrote:
> > Pavel Begunkov <asml.silence@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=
=883=E6=97=A5=E5=91=A8=E4=B8=89 17:52=E5=86=99=E9=81=93=EF=BC=9A
> ...>>> Now that per-cpu bio cache is being used by io-uring rw requests f=
or
> >>> both polled and non-polled I/O. Does that mean, we can kill
> >>> IOCB_ALLOC_CACHE check from iomap dio path completely and use per-cpu
> >>> bio cache unconditionally by passing REQ_ALLOC_CACHE flag?  That mean=
s
> >>> all DIO requests via iomap can now use this per-cpu bio cache and not
> >>> just the one initiated via io-uring path.
> >>>
> >>> Or are there still restrictions in using this per-cpu bio cache, whic=
h
> >>> limits it to be only used via io-uring path? If yes, what are they? A=
nd
> >>> can this be documented somewhere?
> >>
> >> It should be safe to use for task context allocations (struct
> >> bio_alloc_cache::free_list is [soft]irq unsafe)
>
> Why messaging privately? All that is public information people
> might be interested in. I'd encourage you to forward this
> discussion back to the mailing list.

Sorry, It's a mistake.
>
> > So bio_alloc_bioset is safe for task context, but unsafe for [soft]irq,=
 but
> > bio_put is safe for task and  [soft]irq context ?
>
> right
>
> >> IOCB_ALLOC_CACHE shouldn't be needed, but IIRC I played it
> >> conservatively to not impact paths I didn't specifically benchmark.
> >
> > What's your suggestion? Be conservative or aggressive?
>
> At this point in time I'd enable it by default. If you do,
> just benchmark the worst case to avoid regressions and
> attach the result to the patch.

Thanks for your suggestion, I'll do this, It's already in testing.


>
> --
> Pavel Begunkov
>

