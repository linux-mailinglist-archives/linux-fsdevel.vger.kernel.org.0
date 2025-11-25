Return-Path: <linux-fsdevel+bounces-69834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D35C86B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579BD3A40F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66042F692F;
	Tue, 25 Nov 2025 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XtG8w+eB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844218BBAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096908; cv=none; b=pJZmN2HSaEqYaVnMFE9tnN6+EBM7zIgXQWgF+4JGBu0IXEMYVqPeCwhLsJs9VSGnJLBFvN//EZRrZEcOk0DZhlij+h8w1WtizaZAe+XKHUyIkOYKaXGSr5JXVdboKDl4/+unuEHFvXrmS9xLjCeJzmfZxA3wSHo3xkmq7qPacBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096908; c=relaxed/simple;
	bh=HRq0fEmSLdbqSqBDU+IM/YitmlyC+uQDyXNbdhOeZwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk3anoDcIvEBG1JHjh4d4I/ukzpHK0k07XOQrfhFJk+M7BgvY22Wn8KL8qVFynCOdf0JDEG77i+9TXw4BE/bDIPfQNavg0GDW8fhXz0M3rHW/IkmGYFe/F8E5kZgqz45T/xIeof4l0LkwJctlrfaaqixlFeOTvxoCt/138YLrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XtG8w+eB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso173040a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764096904; x=1764701704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTCNx8vWQBYhmY++zaqhyqyyYNnaJr9KGGVzzHKQdqA=;
        b=XtG8w+eB5qRXzPUgChF/yWMI90bL9wBGTJZonr71PdWsilhnchYUYbU8ktoM5jSBjG
         M48R7ZzKCgh5y4SjsO8xwDPTrzzzfLM/eMyLLWsVgSdHrBbvdkT1027JBw/vxgqmBiCx
         pt4rd7Bg0seNjlTrb6bCA7ywnjVXyQMQ8LJohNPtuR3iyKAZEEP/dELLoHF8QMZfiSqf
         T1ZIOB1S+xfMkkLG9y8rqkg50JGiVoGsp5mU2KwLihpP4ibpgSY+csFoUd79VP1zp5mN
         PZVSpHod3QkgieyEgI7E9UlhW5hLg95ghwgVOi46fvxxo4b2TLQvJl4E0nChDfhOPxyd
         r1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764096904; x=1764701704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTCNx8vWQBYhmY++zaqhyqyyYNnaJr9KGGVzzHKQdqA=;
        b=DyH3TnrKFpK/cekTbxeqEzDH0zuvd193IpX/Z7lfPJp7jhV9GtgYnm8iFgGAMR3ntx
         T1FiJjVPbm74ceQjlg9Ef+RW86ExFV+FO9YMd/mbT/q+EOkeLTserzUl+nlxypFO5uG9
         DnLwd7/lntEx/ffAm27epVTDgXZNd/Ky3nLVlyd58w1A6XAaJl2Lcl7QOQ+OtT+2or6R
         kHstGEhHZ+HnH+GYqHbVYG3sQ6iF8uqc0tfXjsMad4hVPj2ZRvL3KClQaE9/GyrJG9vj
         nqwzEzsxKRahXEkD75Jtms4+B1O5mkIA7iib1j5ScTvxbw1DqfwtuyzNimgyS+81RzEv
         wOTA==
X-Forwarded-Encrypted: i=1; AJvYcCXmW43T8BEzZh3xD6mYgd9W8pcGPx48YYGpz2yRzWgrOs+BIuLnrYEPgmUZ4aa38dHlbiJeUokzeE2I23Tt@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwNj3wfHqqG54fX9gB//RyDH7jEUl61kz8dG1Ibrv6u4cwp97
	fRSe8glGxj8UUPW1MyZtBKhUuR/vUl4WAesAHnAHZGh/M+s9ZPee0oJN5vo0+EycQ2fEu1ZIs0k
	Bm6VFzZEdNoGQD41HTxymmfisPVLSgcE1MT+FslvdZQ==
X-Gm-Gg: ASbGncvNKnabhKUpzqoqfIjlwnSdKhWa7ggbrllHBTTTUv/zl3UmooIL/4VVmFV7M6t
	k3HmQSKciX+a1jFEv03IT31Q9CkWYYClzn2+IWeyUKmn9JAv49u1Ot08vV/mG9Ca/s9wlX0dk7Y
	C1RqU/WzQvxbgzd36l8FSpFWKXiVwE0N7XpBQgZ+exWaiZEbr2IiYjq39RCGkH7gRkx9teT4v37
	mryF+QVv9FQmDgqP7LirqQo8MKb2lpuc+P5BxGblMmjYsRu8A2h7HFfTcIx6PTLYHun
X-Google-Smtp-Source: AGHT+IEfzHlIPEiuolnmC+PUY7Qx4g6VZmzqaCh+kJH+E2RdrqezJkmRTURyahiQenFGIYx+F1u+CuUpBK9+z1Di0cU=
X-Received: by 2002:a05:6402:4499:b0:643:130b:c615 with SMTP id
 4fb4d7f45d1cf-64539639594mr16646192a12.6.1764096904062; Tue, 25 Nov 2025
 10:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-2-pasha.tatashin@soleen.com> <aSX6sQqwwA6I2mxW@kernel.org>
In-Reply-To: <aSX6sQqwwA6I2mxW@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 13:54:27 -0500
X-Gm-Features: AWmQ_bn51TAVMNgVIbPP9PoxfS_5IRPJ8eZ2jrzKpsVEpovGvgRKZept8XkPO9Q
Message-ID: <CA+CK2bDUgU8iBOL6eUeK96fZ3-XfokCma43cTore20c1L6GE0g@mail.gmail.com>
Subject: Re: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato,
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:51=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 25, 2025 at 11:58:31AM -0500, Pasha Tatashin wrote:
> > Subject: [PATCH v8 01/18] liveupdate: luo_core: Live Update Orchestrato=
,
>
>                                                               ^ Orchestra=
tor

I like the sound of 'Orchestrato' :-)))))

Thanks,
Pasha

>
> > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > keeping designated devices operational across the transition (e.g., via
> > kexec). The primary use case is updating hypervisors with minimal
> > disruption to running virtual machines. For userspace side of hyperviso=
r
> > update we have copyless migration. LUO is for updating the kernel.
>
> --
> Sincerely yours,
> Mike.

