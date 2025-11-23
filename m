Return-Path: <linux-fsdevel+bounces-69577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC0C7E68A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 20:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A177E4E3EA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2623257448;
	Sun, 23 Nov 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eKzuao9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8610957
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763926227; cv=none; b=DO5ern5xAr9p7P1sl07BKOKkgf9w1SCdEUYNBIwzRC4CPPJfuqZ3QUUe7NXefiPBfapnpKmzztKj+TcgNPabfHffoaJO4vOogjkOIoUcNnq1UOiw3rnoLvc7S8N5q0JNFDFvt3+XkVpgnb9WOCMUOX/FmylQpWbltveuB4HlZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763926227; c=relaxed/simple;
	bh=0DI7DlauJNt32lri3m7Vr6BUkI5ZqR7Pk3QrFXxr4Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfCttC3D8Us784QYOM1I/b/WhOdj22sGjQlbmuE8uPVXS7uxbs11tkfin4g4WacJi6YUtNgdwBUPRmaqH/fTse46a9ZEt7sf7gG4rcYN7tv8AmSc9XMvX6UjS3CnaKUkzsR4SGMh95enWX6F3oAfv2W6B9XagprZwNIUSNPLsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eKzuao9r; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so5439150a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 11:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763926224; x=1764531024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzqHK/TIOOgnA9zIhGUtOJHBTL40HX8egZzA4W6eWFI=;
        b=eKzuao9rSqLDtF/ggrq12zSjkuQNSDd9g5YpTwb6PoWZvQNRo+g7bEQUUhPYemNJu3
         nMw55A2x/DSoY8zVeOH0PDL+uYcJ5YBvH8nEJPSMc9vqYuYti3PezHtYog9ZbOWLy9fs
         oAXYhm+Fz55lQg76EKAMIa/8LVAxHyrngbmhBsUExs1fYWGDTGMEKCzTpCmu/k1peqpY
         SkrhaLr8ovUi5GoQuYQfrwChqJBahBLjsGltC8Lzg1InFja5jJfzxiQ/lVkIJJTUgXrf
         RQGkALdiJvOvzXuxajCFG5ZAn0SR0ukS12ErRx+9ZHeQvw/QSRG/N94JJCDnrkUCk/kw
         qUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763926224; x=1764531024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzqHK/TIOOgnA9zIhGUtOJHBTL40HX8egZzA4W6eWFI=;
        b=OX1WLlCIt8NW+7bdu6IKV0uYAcVZTmg+v0qQwCOK6CijS2fnUMlY/PnsjOkngef8pY
         39s1utR1IQyZiIrClgi1fWimOyDQnqhP/TZzWrbf4+D4jS9IaothcR7LEhfwZqd96uta
         Aa30fWhhBHo6yPoMbxZFuOQcApbFlFP+zrBcJA4Mwg4DJDAl3j+8fJuBsfkvHFry7qMp
         pfYxhTFPkDWEV1kDcgJk343JKUVsbwsKYCZ+jq+HLsyh5xKxy17JsGum0lb/ziPfzvzV
         jM26DL4R82St/sxfb7MP3MSiMsLMlSQBEyJoSER42Yn8ilG7pKQKT8kV6VOigNlVL3ql
         YRnw==
X-Forwarded-Encrypted: i=1; AJvYcCWqsUfcsMJ3wtxL6FFoaAzP5xNgbBbogH+C/b0S7vCj0RbqVe0S6W52R23ABTS38naMk53udh6xSvEa+XAm@vger.kernel.org
X-Gm-Message-State: AOJu0YyojnA/qasCQqY63LFazmLAwfAxsrrCqG5h+yH/KUoOV3yWvS4g
	oY0XSQQdcAZr0FlWN9WezWa0pOevo+Di4o/H/ZzzkIlVsQz6AGeBCJQxl+ooox80gBsYk32sH0m
	FEu3PfOPl1dthQb4DLF2l+MeVJM0F+WfZteq/M/4vDQ==
X-Gm-Gg: ASbGncs0a+9QAIuJ7oQm/eSnJHy9bJR/j/B3KMcD2QHddjQ/bkD05EMbDeP9lSKRK1a
	Emotkad1a4lOg7qUpV9GARNn0gT8RkueVbkwpS7x2gnTOooSlfyW2+eXcZBDgSMrWEcEpRs02fl
	hSfR+4BA2EFCCKKmNeX2HC2sJf1pzCe3agYGanD9eK79OM90wYaaXGwtf+luAZQ2Sa8c7BpeRIi
	EsQQczDx4O0OdwBH3EtbEJbJqBYlrfKJq9ZLbzbUfwfWbtwTW043kQQ6RR/qo2Z088/
X-Google-Smtp-Source: AGHT+IE05jz80rZyj75VVfkojSuXeLlQ8FesBIh1qUPzdQMfW1RSq+XVJJpyUf5jF0hPWhI5fJ55dpas+SZJguxrA/U=
X-Received: by 2002:a05:6402:27c8:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-64554664dd9mr9384496a12.18.1763926223214; Sun, 23 Nov 2025
 11:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-9-pasha.tatashin@soleen.com> <aSMwsLstAutayHbC@kernel.org>
In-Reply-To: <aSMwsLstAutayHbC@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 14:29:47 -0500
X-Gm-Features: AWmQ_bk8jtjaq-w2yB5rB_UsOYzOhWiPvf-U2Ch5k2I-jXXb8CYrf-XuoPC_iX0
Message-ID: <CA+CK2bC6_Ls0AthtWHmFH7hc-ER1uaG11Ques0=zVyozP-gyOA@mail.gmail.com>
Subject: Re: [PATCH v7 08/22] docs: add luo documentation
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

On Sun, Nov 23, 2025 at 11:05=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Sat, Nov 22, 2025 at 05:23:35PM -0500, Pasha Tatashin wrote:
> > Add the documentation files for the Live Update Orchestrator
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
>
> > +Public API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +.. kernel-doc:: include/linux/liveupdate.h
> > +
> > +.. kernel-doc:: include/linux/kho/abi/luo.h
>
> Please add
>
>    :functions:
>
> here, otherwise "DOC: Live Update Orchestrator ABI" is repeated here as
> well in the generated html.

Done, thanks!

>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> --
> Sincerely yours,
> Mike.

