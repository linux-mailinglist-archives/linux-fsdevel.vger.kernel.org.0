Return-Path: <linux-fsdevel+bounces-68784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4480C66176
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D9493608F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9545333733;
	Mon, 17 Nov 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VSEiF0ni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1830F954
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410659; cv=none; b=lMRGDgGAPx/5xXRybrxUf5MebWJSfHQk0TVMd2o90d+nhQgpklduhly6iRljJpSMeOz+i4jQjgWT5B+vvgUjpMP99aNwIvicIHW6p2FC5qpweZk7eqpM8SOsvvWeN3yBMzYeztP6w572yCQiH6jsz7RNrl6vKjuXxEcZkbdxxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410659; c=relaxed/simple;
	bh=S33O+CF2B1r3tkcDztO9KxprMMVy543GWsitFXBZZIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qweBmACjRfgGRWKMBlwLCCbqFJmFna0DE5leuGJnUzZSzQV3X74Uzm6Q9/VO62E+5sGgZCjs/LtCfmmyZRAsqDQzFYve7EaXG29wMERFnDKPnRiAxuMIP/M+JNg8z9/cCAIrZjIPZkH6ScnpCnpiNIw4mxrN5ovAENHOOwtCQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VSEiF0ni; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso7744665a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 12:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763410653; x=1764015453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S33O+CF2B1r3tkcDztO9KxprMMVy543GWsitFXBZZIM=;
        b=VSEiF0niubI0/T1KkAyD6Jo1VIJgW5qOyli6sh6xtCuKlNwx7nkMIDeNbeEmY/ggDM
         iqot6HUzbBRC4iyPdUjF3f64CrBQJ+AY8trjtbRKH1JkbVbPwgTktAUXcy0+zFHqSZYq
         3kXVPSjsCTnAlHkwgQsmyJrjc11eVSC3EoLxztHxnz3t6QPQQUTTkWCjZ38TNFWBlEyf
         1m6i2io51I2wdRKgXKYmN0SjKcN78/ji2w8A1WxqMH0OLiQiGgsFTuIHPZK+Yvv91CyG
         HWK4b8QQkVnIJDCGDmOHyH2g6GzeIQjA6EjOFCi0rO+2yaQG7978KNbfDc1iG5VHbkPW
         Y9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763410653; x=1764015453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S33O+CF2B1r3tkcDztO9KxprMMVy543GWsitFXBZZIM=;
        b=SV+DZUfNw9+Utb1PdkGC75THHxEtq4/707uDvzbXbENgDDLiG+krcQNGdsrPIhta1B
         3FB2mZ66uihWA2Juo+OHDAZDj0Y0M7sXMKVuUR14ffvwQ0y4HrbI2yk1SuydDodM3wcb
         Eh3n7uci6fYZqM5NiG/O1xGy2OtBGeaKUa7s4MaiBoZMb1fMrAul1DsIP/RTUmBaeGap
         BokQSSSonkZwxhyRb6k17CJBZPJfBdOIBesm0BIaJ4HcVdyzkYrIqewsG1O4GeB/qT1S
         ueWpsA7xGrrwP92cDElqde8lwtDkOSiKSWBNi98E9yp15kZ1WH0bkLpgRtyr5xi+zpZQ
         kTAg==
X-Forwarded-Encrypted: i=1; AJvYcCXN8ESu7koEuNor1Xqz4gAR1meouYAgKhU6Fps/VJC0UKTyFGAgjAlQQUDrviXFGezJPdGg/3kfdYEfXzXv@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZAZbEsPqktvp1oxb04s1RPlJh962LRZM6kG+6RbHkYQk90QB
	NnQwx5kT3oPurfDXK8LhFGhjmpIbEC26V57zwRc4MZQ8oC1zPligrnGVNYsqtWkYsLkgZdgOJWV
	4wdY3KUMzBWX0zKcZFipuh6lxBckB4ykaITblGPXoaA==
X-Gm-Gg: ASbGnctjDJ1GL3nsuA/dfO+I+XDyoFpebN3YWl8od/PDTmGq1MU44kuF7qqX9JEEYcT
	yYRkbCojDft95Jx9b570y1c193wfP1dy1vFRcrdCakK4olrlRewAcmUjoNYk9jfXqxWtTrwkTcN
	iQYDpdve5elU9XfkmH2Cdi8j4HeOTeEADjupapDUGqurbh/jmlpsh4pP5zTh/+u9gWAIQg3UtY6
	jMCP56ehdqSfJL8AauL5Aeb8cThioEWn1vz4S3RLtfUYEMV+TZHz53MkDhToXgN0/nW
X-Google-Smtp-Source: AGHT+IFItSdGQdOgeoVWjbSlLG/sP/FZzoFWO1rtvgD6y2lU/+PX1v1prFL+slWcS3blQ8WlJsrEVKQ7VXI5F5genq4=
X-Received: by 2002:a05:6402:50cd:b0:640:ebe3:dd55 with SMTP id
 4fb4d7f45d1cf-64350e04b82mr11009068a12.6.1763410653320; Mon, 17 Nov 2025
 12:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-18-pasha.tatashin@soleen.com> <CALzav=eskApQk6kstsQWThwV=h4Qmd85kAw3CxZt=6hj=JS-Xw@mail.gmail.com>
In-Reply-To: <CALzav=eskApQk6kstsQWThwV=h4Qmd85kAw3CxZt=6hj=JS-Xw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 15:16:56 -0500
X-Gm-Features: AWmQ_bm_MkoZE--tsc-fA0lwBQn6VGwYgaMcS7NtBv5sswRv0JDdatkuBxPFasI
Message-ID: <CA+CK2bD-57sMM1pm9GkdrpRkvk5qCf3CfQ1yr1q=X5+e4dgmoA@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] selftests/liveupdate: Add userspace API selftests
To: David Matlack <dmatlack@google.com>
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

On Mon, Nov 17, 2025 at 2:39=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>
> > diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/test=
ing/selftests/liveupdate/.gitignore
> > new file mode 100644
> > index 000000000000..af6e773cf98f
> > --- /dev/null
> > +++ b/tools/testing/selftests/liveupdate/.gitignore
> > @@ -0,0 +1 @@
> > +/liveupdate
>
> I would recommend the following .gitignore so you don't have to keep
> updating it every time there's a new executable or other build
> artifact. This is what we use in the KVM and VFIO selftests.

Good idea, I will do that.

Thanks,
Pasha

>
> # SPDX-License-Identifier: GPL-2.0-only
> *
> !/**/
> !*.c
> !*.h
> !*.S
> !*.sh
> !*.mk
> !.gitignore
> !config
> !Makefile

