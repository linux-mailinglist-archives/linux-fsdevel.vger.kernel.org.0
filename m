Return-Path: <linux-fsdevel+bounces-69722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97495C82D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6696D4E159A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7F2F547F;
	Mon, 24 Nov 2025 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2lkP09Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B18231827
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027931; cv=none; b=sfD5uE7ZbB4TaScNi28O9MXgC6kwzyrHTy02dZqivM9Ay+OqNrMqig/eD8uYvivJeN1kl2eZDqP/MBrCY1dR8haV3AGIjzCpPTs9RgkInKahqBwFg+2r3ZlBRCPItc8XMgDkBIyVMijHTVO92lSMEd/bUd0ZjfMJZru02qIUkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027931; c=relaxed/simple;
	bh=1YT7lz9VAjzJFR6KJdWMrofH24QSVAwiNd/A0dtf4zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra/K2UNM6EnoHaQNj5YmsejkJu2hVDOcrk8FTlVCfjYY389rGhZxr9a1Lv8tOhN+3sG1AMCUlFZ0jnt/sH5segu2ZmoMmD/RXUk3tOBYhsa7WA17mr1z9PAX01rVKkjki7J4pH3j+hEbqS+tGaV9UsWyHSGRF8EDKBEtWbiboJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2lkP09Q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957f617ff0so5216066e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764027928; x=1764632728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05wP4M5m8hN24FSCktfwvvhdg9eAu0qN4WDwWhg5IsU=;
        b=i2lkP09QFZfmvM5LE5tWH3MrpB88FwrsAYBGUFlYDXVWWnE0FViOplvOsEJShw6UOc
         wGd5jbXrzsatKkAxno2xDJFUPnWIrscvD53KwKfrmjSasUO3y2/r3IDxeV0nPey1cYTR
         eykQQZ3NOmRTZrCAKBA0dYNHXRxkxTvV5f95HOsU/2/m/Wtc45SaHf6E8ayrKo5A7pXQ
         /UU5dWhj8lKF1KI3HeMXKPY8ccdRrHrVamjHD6h3GWqzVgCT4GKfo4dMFMHrXnvHoeFL
         /1POdbOzqrp6FEROgcJUaD401j6p6FYB7RLsMmvvvLJJD/81TSrEAGW0EliDs2ykSSsF
         Gcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027928; x=1764632728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05wP4M5m8hN24FSCktfwvvhdg9eAu0qN4WDwWhg5IsU=;
        b=sdnMG9rKr33bVnSxRM6dmojkmQFEkuE9kCAot71EGCiKOsP6rnjMzC+ZD+t5ayN7ps
         2Hg3M+B66OByow/UoXep5v00IozxHVskqld1BPDzI8T7Q3PAfukSIsuZC8aRLdBh+j/E
         FARFRI8MNJUJECbrTUJk32uhV5aCRQZGA7EKO9nfnmtzrdLiIu2kKFgcQAYy27BrxSOo
         iQKI7kbG7OHMf1EMeFAKSndK8cPUO+w8Nhx8SWRHHELsJyI/r9S7daanN+e1DuWc6o6g
         DAdN68i2kllVzcFyD4QVLreCwXVblJb+rkpqVXQuXL36fjfoYfF0dDiTlSV00H0wLy+y
         TCgg==
X-Forwarded-Encrypted: i=1; AJvYcCW2klP1iPkv/RK/qhh0ZwHgCjFL3jXP7ARLnFOojZQt4L3oBPpic22XhNNRCwp4pcI9LRn3ono/4T55nGbv@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTc3iOtZRAqC73whVH/KYXkHi9YCpHgYVYkkSSYUU4tK/xxnb
	RJ2FTlPWBxI4+6QbNW1BgExFpoAPkhosbqZAFZkMYyluwYVMdD8Mjdwzo4WI6CSR7aRtncnF6xh
	dLZZQLcdozCoF1NHOBbcW518RiQ2QlbFL8YAYNghT
X-Gm-Gg: ASbGnctrn+yHlE1fDdAPKAz8oEsCTdCfhbMpbRyxqd3nzW5hXtvq8MEP9rIyy0/uDQB
	2e7MyHJAyaTTytqg7J03i0RQylFhZ9051Mj32EFLeBnieP61WmD2tf2rjCcmdgQi3HHOeOLDFcg
	6L4gVCL8V5bNBycKdUWG/j0OQIcGTF+3+p7O0Cz0LJZi8U3B/DdaP8NiPHyMckV3X9OGRAO7yYP
	g99Qlxa8BXlndkIYbd1l5FWX37vMChXN83Pc1cEAos2Hxecj0RJAJEoYtAH/XDm0hwzM0xUivo4
	J/UicA==
X-Google-Smtp-Source: AGHT+IFG3B3wjJ5hUmdHvUSiONpPpEjo/smMGL+Sq7VqjhpIWo7YbanBRf0jnx+HWEMfNF7y44/hOJQ08ua0/lRI7nY=
X-Received: by 2002:a05:6512:3c89:b0:595:e35d:6b80 with SMTP id
 2adb3069b0e04-596a3ea6658mr4439445e87.5.1764027927918; Mon, 24 Nov 2025
 15:45:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com> <20251122222351.1059049-22-pasha.tatashin@soleen.com>
In-Reply-To: <20251122222351.1059049-22-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 24 Nov 2025 15:45:00 -0800
X-Gm-Features: AWmQ_bnJaOF-T9FnnUyFXJgRaTp9b-dM-s_K88NADK1Pd4LiL71E0T19a9fmhbE
Message-ID: <CALzav=f+=c5XH7Uw9EGVb2P6VxsnpF76e0DXAAXhM0gsWPxw2w@mail.gmail.com>
Subject: Re: [PATCH v7 21/22] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 2:24=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> +int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **ob=
jp);
> +void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *ob=
j);
> +int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **ob=
jp);
> +void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *ob=
j);

nit: "locked" should be "lock". "locked" is used for situations where
the lock must already be held by the caller.

> @@ -633,6 +639,7 @@ static void luo_file_finish_one(struct luo_file_set *=
file_set,
>         args.file =3D luo_file->file;
>         args.serialized_data =3D luo_file->serialized_data;
>         args.retrieved =3D luo_file->retrieved;
> +       luo_flb_file_finish(luo_file->fh);
>
>         luo_file->fh->ops->finish(&args);

I think luo_flb_file_finish() should be called after the file's
finish() callback. Otherwise the FLB data will be cleaned just before
the last file's finish() callback.

i.e. The order should be

  file1->finish()
  file2->finish()
  file3->finish() // last file
  flb->finish()

rather than

  file1->finish()
  file2->finish()
  flb->finish()
  file3->finish() // last file

> +static void luo_flb_unlock(struct liveupdate_flb *flb, bool incoming,
> +                          void *obj)
> +{
> +       struct luo_flb_private *private =3D luo_flb_get_private(flb);
> +       struct luo_flb_private_state *state;
> +
> +       state =3D incoming ? &private->incoming : &private->outgoing;
> +
> +       lockdep_assert_held(&state->lock);
> +       state->obj =3D obj;

I tripped over this when developing the PCI FLB state. The following
compiles fine and looks innocent enough:

  liveupdate_flb_incoming_locked(&pci_liveupdate_flb, &ser);
  ...
  liveupdate_flb_incoming_unlock(&pci_liveupdate_flb, &ser);

But this ends up corrupting state->obj.

Do we have a use-case for replacing obj on unlock? If not I'd suggest
dropping it.

