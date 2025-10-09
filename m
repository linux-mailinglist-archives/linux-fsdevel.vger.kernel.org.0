Return-Path: <linux-fsdevel+bounces-63682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04701BCA969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 20:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13E5426F78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354924169F;
	Thu,  9 Oct 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DdN8Be6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97387241679
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035106; cv=none; b=l6HLh7KtIOlDQHkBSmjWLv73maQUOB5Tvn+abqyWjGwh7c/1Zyc8QSPKGiL83h00DvZudvVcMsJFVxVbiV77mRnMcZH08joiTQsC7Mo/ntk+VnsX0siAvYVH65GboP6w0ZjzVma5kXbb6NwTJp4imjcDFiFHFwobVRRtf3yJQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035106; c=relaxed/simple;
	bh=81ILHOUYQAEk70D7TUtGk2AtcHVEKY4trbt5HGWeKE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWYKNe7JYr4TEwc3oWThEJD7tHK9aNZ8tNXY2Ujtl5yYsHdIURNmSFvKzLTgt3VhiG5na+ztm+6LigHvwE/iNcVK6IUnN/I+Xlm/5Z4zrc5BjEl7+pp1CHtCPa25BO6BOH692Uukof5AsVFKRjWxtUF6XLu7M8wQbzQZffzUlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DdN8Be6T; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e6d9573c2aso17882791cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760035103; x=1760639903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81ILHOUYQAEk70D7TUtGk2AtcHVEKY4trbt5HGWeKE8=;
        b=DdN8Be6TgRd2DJqm9hoEjld7fiiRRoy/gg2rq8hB8XMSGqtbrho1mmlgP3ujmJG9tW
         EgMnSl2DvAxhhEYB3acFYpzoJri0ZU2ek22364JfA0vqWZ4o49tHEJ6TBjRp2XYXwK26
         n4b9SXRJsqgZyw9X77BFSpyupFwYFS1qsbTwz1SVxrOohgjFNnWkqbCT8JhEWol38m7g
         dqVtiFDz1r5RPkZwOOKaa3us56ySMtF8CiemqTwLCRgHOPhiMtYmvOXz3PBUxYPE8VVN
         yFd+L4agMLB+UvmvlkSAzFkG/0pmSrUAy2XlfiqiMa2d/nzKhSgjEIAu8EK4SZF1FxT+
         nfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035103; x=1760639903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81ILHOUYQAEk70D7TUtGk2AtcHVEKY4trbt5HGWeKE8=;
        b=eIJBGMS/JOiwiNgLiLl/874ATD6beHjV+5lpROCsoJmyacu3spoCDjbGO6RZKK5iRb
         xc8kSFxrN9m8TcbMWxo8BWcHmkhJRmu7eAkvfjbtbvJjXR5Rybh/gGRB8FKuXAaZDwCT
         Lzg+UH+uilx5fF7fDlGhL5BP3uIfIhLwLD7jn/swQ7rEbYJGG5O46QmUOwhI0A/F6Opz
         wUcRxbOuU0wCzzYrY+Zh/+7c7UXkWqmMm21MUDKZLn7LuIIVxA1GmapW8QYSe5tPILD4
         wyxjfwcySHZxwmff+82winZ7rrsnobpt7eFv68QxiEstkbVHOoRJNNY0APt+lrAJ/U7J
         sxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU23OOebJBu+qo7qfJQ2VGKIIv3i5han9EK5tMQmXcQ/Z2P4c6CMj4NMgTJeMuhQmLwHKhEAmJBrNY3fWBN@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJHc1ipjUyFAU3AivUr6oW5dH0z3kXubeh72/jxBNB66Iamb1
	6FUHCCJFXSoW9S59z6P7mMqDM1LwNmxb3LF7Nf6Fv7cF9zbHbw1Fdg6RX2oTreMr7qc3BOAHX/H
	tYwDMh9YDSs5T5nC53Yi+K+VUwG+5bQzFj1PFgfuywg==
X-Gm-Gg: ASbGncuWDcBOrgZ4+HiykulXa5WbVkZfu8+YxFjOqV1CrFwnNm8dzgbJ/ROKjlstUuj
	9DnMUKszVfACg1c33VJOhjoqZZuyLseAxtS++ux28cS9T6lfTiGbmMKgVUdw7MH0nIEbxg48gH2
	281oMjs06T0M2EUY73FJobLV11SC6KCYkdg1KkEHbub6NriDDzZukVH0UgSyu4v0pxkcA3xNxqh
	ukOeDVnvQ21xZ/JLlpNIuUpkcgK
X-Google-Smtp-Source: AGHT+IFTvUtN/rpWG7psFmkleFQat5OJKejLftUiIf/dP75zdni12r9jj+HSaQKLJe6iZf61h/vhuCDqOsTOwxoEzRc=
X-Received: by 2002:a05:622a:5517:b0:4b6:15d:b3f7 with SMTP id
 d75a77b69052e-4e6eaccd340mr110183671cf.12.1760035103219; Thu, 09 Oct 2025
 11:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
 <20251008193551.GA3839422@nvidia.com> <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
 <20251009144822.GD3839422@nvidia.com> <CA+CK2bC_m5GRxCa1szw1v24Ssq8EnCWp4e985RJ5RRCdhztQWg@mail.gmail.com>
 <20251009173914.GA3899236@nvidia.com>
In-Reply-To: <20251009173914.GA3899236@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 14:37:44 -0400
X-Gm-Features: AS18NWCn4swK0ST2nIuzLp0_IoWDyMPKV38mC4btlFHmbHQv1r2bdrSfddLjGqM
Message-ID: <CA+CK2bBtrkdos6YmCatggS19rwWYBXXDLwiUWmUrs2+ye23cXA@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Oct 09, 2025 at 11:01:25AM -0400, Pasha Tatashin wrote:
> > In this case we can enforce strict
> > ordering during retrieval. If "struct file" can be retrieved by
> > anything within the kernel, then that could be any kernel process
> > during boot, meaning that charging is not going to be properly applied
> > when kernel allocations are performed.
>
> Ugh, yeah, OK that's irritating and might burn us, but we did decide
> on that strategy.
>
> > > I would argue it should always cause a preservation...
> > >
> > > But this is still backwards, what we need is something like
> > >
> > > liveupdate_preserve_file(session, file, &token);
> > > my_preserve_blob.file_token =3D token
> >
> > We cannot do that, the user should have already preserved that file
> > and provided us with a token to use, if that file was not preserved by
> > the user it is a bug. With this proposal, we would have to generate a
> > token, and it was argued that the kernel should not do that.
>
> The token is the label used as ABI across the kexec. Each entity doing
> a serialization can operate it's labels however it needs.
>
> Here I am suggeting that when a kernel entity goes to record a struct
> file in a kernel ABI structure it can get a kernel generated token for
> it.

Sure, we can consider allowing the kernel to preserve dependent FDs
automatically in the future, but is there a compelling use case that
requires it right now?

For the initial implementation, I think we should stick to the
simpler, agreed-upon plan: preservation order is explicitly defined by
userspace. If a preserve() call fails due to an unmet dependency, the
error is returned to the user, who is then responsible for correcting
the order. This keeps the kernel logic straightforward and places the
preservation responsibility squarely in userspace, where it belongs.

Pasha

