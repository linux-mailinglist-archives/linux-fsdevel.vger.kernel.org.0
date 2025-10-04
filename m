Return-Path: <linux-fsdevel+bounces-63426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36327BB883F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 04:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2336A4F00D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 02:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C027F4D4;
	Sat,  4 Oct 2025 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UVBohL8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12427B35D
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543727; cv=none; b=sqIlFMfB+dIoMp9mKbu/aCVkbv0IhCn88ZrrkN9cGKJvHePlSdf8wHj60u60tpRYyGOMS0hgDxxpIrCBy612we+Yz/nYpqxdwZZCpYbXy71eJihp252AdYqQ98ujHsoZQKBV+4pfHpB5/zW3/LSXrN/J8375WYjIxniX7r/AzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543727; c=relaxed/simple;
	bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BavpwGMIYr9DTMdoOrmEiuwP0ldtcg4FiO/cv2F5Wk+CgTW2gcUbkVH8bxp1ibgNjTSd6gtmWyZIlxal2RNW0OWkL0A7T8E5jslMy+osAKkceng+KUA9g+K3LHfE+U6pFblXbItV4Av6C9qk0T94HBvCWQtmHL0wtKdh0Wt/ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UVBohL8c; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4df2911ac5aso17758991cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759543725; x=1760148525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
        b=UVBohL8cU+t8AHNXNBFMhP3Q1+ncT7/G64axJBW6tt6F87RkpDFR51Fn6SnQuXE1sW
         zMlqgn85RiMJx+APlHTL8Mupunuf3Mto4vwrClsFZwF3iZu2ccU9dJ6JRlRyzPECC5DX
         +M+8OuzvGRyJ3scu3u4q1CRCWAVaTDN/SL2ohwmfAUp/ZIDkfJWAqRidOCH6iJ3qUG71
         R4MVttxjbYVr0YOEpK0kBQD+5W2+BJo49b+lmv91vUqvuVTBcXKwlv+u/1pgjruKvZsq
         k9OApD4/bcxXXIN5TVARF+5M/3dM9Gfnj5jkiDnFxHRwZZQCkr6/X7O9MYejnitZ4oOt
         D5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543725; x=1760148525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
        b=P7nibXSPuDUeGTJGUAkowv4uYqIInDy6UCVaP2pm2t/PEqLgJuD5aQc8QCJHF2vo/B
         SeYDLKnKwHtYKDiUiC1MPHhPrSKDCG4SWAXDY78fR1+Yim2H24xRZdh/Tyr9AIwpi3Tm
         Xg3jbM+DXwMeS7vQupOQgEPSmTQvSo0wxMqDkS9RdKGTLmr5C/dkt1DGC6+BcdRJaJcp
         IeYoZFO6bCaLtOaVFcIDoQUyz/44F6nTc7nfdKCrMQtLE/rm4knFtTWVV99xUrlXbN97
         EHAUUwSEVvw9R9MOV2WOUuKdPRN42y3tFC61r78BJFsQbvGsOD7ZSR0WyOPwf30Gl5By
         fdgw==
X-Forwarded-Encrypted: i=1; AJvYcCUkj9uIRpHYzPJ2pkb4+gkkZRIbzZAkqw8Z+cwcg1OG0l3VsZLxcs4G87S5pVlj/Wz/N4/NSgcBi6N1/1zq@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWierzf4Ep1zIgMWzcjsGYQ/Y+SzwcjEnfbLh2y8VvpzYH2Cd
	05vMv9AUrAeMjvhFA4Kp6VBAfPUsJSm4cKWmz5rAdhrQfjYvKk4AP5hTs5X4mKMt8Uk+5YiQ9jP
	gVEV9o2mNv5/1hdN6Avk2uTn5PJgiArBfp3tmY7TDaw==
X-Gm-Gg: ASbGncv9z54JOtRlDgO8390EC/+D3fNF8+4Q5ziMe/LBdsxTbkX9CJ09JJ4hJu0pg9e
	cNwV4V0Yn7laLpqCixz3zy2EzO8/MNXOTYdnTZnF6+VumxJG0/RzSBkYBGXUM0ASCiZT/RlV1jD
	P7HUT/x0+0VrQQLvQ8OBAXz4laz2prpVSfSJ4YZu4RQ7UV9/0a0bbhmikM6EyFmQ6qlgk7cINPT
	aiBCGONzpX9keUF0fMz59w1M4xG
X-Google-Smtp-Source: AGHT+IHbUzSApGmCRxnFWZElbyxsoU4/P0TZBLF0BzTvLsCV+miCnogbHJNniWq337bBkZeh/jjC8xT2gDd4cs+U3JI=
X-Received: by 2002:a05:622a:5c98:b0:4d6:173a:8729 with SMTP id
 d75a77b69052e-4e576a44213mr72478001cf.10.1759543725080; Fri, 03 Oct 2025
 19:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-19-pasha.tatashin@soleen.com> <20251003231712.GA2144931.vipinsh@google.com>
In-Reply-To: <20251003231712.GA2144931.vipinsh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 22:08:08 -0400
X-Gm-Features: AS18NWCqgXSjTPwyDSbb0KSJXp4c4gz9L9NTQCHF71G2zcSqEq0ghlLm9Q7hBiI
Message-ID: <CA+CK2bD+gG41LA5=kfuWh=zsYm5L9Dq+M8Bhg9-2sn05YvNfaw@mail.gmail.com>
Subject: Re: [PATCH v4 18/30] selftests/liveupdate: add subsystem/state tests
To: Vipin Sharma <vipinsh@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:17=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> On 2025-09-29 01:03:09, Pasha Tatashin wrote:
> > diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/=
selftests/liveupdate/config
> > new file mode 100644
> > index 000000000000..382c85b89570
> > --- /dev/null
> > +++ b/tools/testing/selftests/liveupdate/config
> > @@ -0,0 +1,6 @@
> > +CONFIG_KEXEC_FILE=3Dy
> > +CONFIG_KEXEC_HANDOVER=3Dy
> > +CONFIG_KEXEC_HANDOVER_DEBUG=3Dy
> > +CONFIG_LIVEUPDATE=3Dy
> > +CONFIG_LIVEUPDATE_SYSFS_API=3Dy
>
> Where is this one?

I removed the v4 SYSFS interface, and this line is a leftover, I will fix i=
t.

Thanks,
Pasha

>

