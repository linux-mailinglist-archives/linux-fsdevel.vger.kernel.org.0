Return-Path: <linux-fsdevel+bounces-69266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B338CC761C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8A3162C02C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B23271F5;
	Thu, 20 Nov 2025 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXua4HGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0122FE578
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667800; cv=none; b=GT5p+ebM4Bu1SNR1tKh3WflpZ6UHnq8RYfWP79CyU+LiQoxGGNym32+4MB0X8ewPwxC081M0evLucTGtpY6lY/U/IPB06e9pT9j/d42ZbEr7p1KMYoYQXqkQkm/HZGtG6KnxJjxhb1mEza9kRi4aFFCY7KOYVCW9i24yaKH9K3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667800; c=relaxed/simple;
	bh=J0ISvo7oGGx2XMTRMYzlrvz8O6mEdN7rqUcNJBXwRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWXkIbm6MXGr7cmu5/h2WDjWLtkpITQL5OaMuhUKyPWC0TI+/kgKDWGSFmsAVtP/gu2XedpKRwQ5QfikAgrEAZ2d1Qan4ydMbUOqUCdQvqcLp2m0mqxwvD+sr0f1uyFZszZuBB8ZftcuKCz6g64Nd198A3O+mp1Lokj5S1Zd8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXua4HGm; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37a49389deeso8527861fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763667796; x=1764272596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOb5k3bbgLdxLAU2xBUhkNf6M8DrTXlh4mqXRt4KFAI=;
        b=BXua4HGmpbDOq48gQaoCoH6BAhPu8UVSID1z9gub+SfUGmpRKN9vBERIgzn6b//Lng
         vD+yWQ72igMHrHNZSBxlzB3NKFHaYYbSyhnAw2xn6Pk577SXHeWyICDazSa3UEbcW+u6
         FORDQaQznjENEJXxm0GCz5R/p5Ium/d9d21KtSpymRIQ+NTRjcpR/dR/7vNVncEZjKRf
         F+ovLA4abK9RNa44yihms8d3O4jTMJskGSZg7Q/HHLAZKTvofJV1ZM2GR53uqrDt/1lk
         EeysRfzdLM/53BB89x5OG/HXbi3vryVKL7oLv68DDCDv6Um7NJI9ORi6f7SczqB5IfNd
         Le9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667796; x=1764272596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOb5k3bbgLdxLAU2xBUhkNf6M8DrTXlh4mqXRt4KFAI=;
        b=dgEl5hjt6Sf3QJxRNZHWi54EqYx/Ke4XtuFGdkvMb8j4/I5vUlwbO91+huNR6FYwPp
         JKuL74l5r9w2D/T5CsILj+9O5SBW0wyCy/Sf8upScJPHQ3hgFcBbxrU96rgZT33Jyj/8
         /60bhiUn7qPB8LIfHOHxX3X2NzvGB9NDBwr4rfQYQNwec0ko8ZA8VXNc79Wk46eEyn99
         lrcF90FUiiC5dlTsBbAdOV75lEgqYDs6dHSow5t53X6wR3Efqh6hneGcVyeyUwwVxeRe
         Hmx1/pLMuSE4Bh2AAIvE3zyzHJ0d8P0fufkWK14Dd0gZr/o5JSPWTTrnpzFuVdYvJFcw
         wHHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfjWC5TaQouDyltX4dNOpgiAggubVGAu5pz9JjvBRXSSAWgG1N7KE+0w8KCgdUD82sveBVveL6UZddoJff@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76comsy5TIpum4ESExgrP+sA3+Lvv++fyKGLjfGDiRsA6Fgtv
	vb+e2y9As7bkLIch7wO3ebjG1kEdXNrLud1axpIQ/7BFYHPPfZTaSky6F+bnw9/6kE3vFpHHWi7
	aGFPHMFfMYzOjxw2M4RISTFYB0gSHV/ZYizzpimkh
X-Gm-Gg: ASbGncuWl4g6bVEVGG4uJBOEkZO/kcQluS52eCeqjd1fozdmdlZmw0i/YoA0ADVD65z
	RwEOlSpIGCXk+6Am1VYViL33kg+XcAThDUa+Hjp318M/6y5EySPotT8px/9Cno3fr8YXqQm7i5i
	qE4gqb9984bdCoRtIatPLQSzrmrv0cuWtPyE99suwheb7nQL0f4q8S1pPmfOwkCu6MT9NR1yThk
	UoT2xheokBncz5tLQ0hM1hkqUPXv3gUT37Gf1JZeqQadeQbn+3IS9riGSXnpduSFZ3+TI8=
X-Google-Smtp-Source: AGHT+IHcyfhgJOxNFwVB1wmP5vbwR6JERZRpaFBPUMh7cIOOgFdIrerxF5fqZb7M8NqokF29pYgwiXqXN0SorsacWb4=
X-Received: by 2002:a05:6512:3093:b0:594:346f:4850 with SMTP id
 2adb3069b0e04-5969e331044mr1508727e87.49.1763667795875; Thu, 20 Nov 2025
 11:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-6-pasha.tatashin@soleen.com> <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
 <CA+CK2bD4Y3CMHcTGKradmv-hAbdtA7zsw2CYeh7-8LNianYMZw@mail.gmail.com>
In-Reply-To: <CA+CK2bD4Y3CMHcTGKradmv-hAbdtA7zsw2CYeh7-8LNianYMZw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 20 Nov 2025 11:42:47 -0800
X-Gm-Features: AWmQ_blhAAizSjkijMqBfleikcubXUn4oYnXzPUSaeKAUDCiwV_6zW22M0WcB8M
Message-ID: <CALzav=dmFQr+BrqzRDgio0q68MPRVnZPK4-wUXVj47o1FObgNg@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
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

On Thu, Nov 20, 2025 at 11:23=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, Nov 20, 2025 at 1:38=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > > The idea is that there is going to be a single userspace agent drivin=
g
> > > the live update, therefore, only a single process can ever hold this
> > > device opened at a time.
> > ...
> > > +static int luo_open(struct inode *inodep, struct file *filep)
> > > +{
> > > +       struct luo_device_state *ldev =3D container_of(filep->private=
_data,
> > > +                                                    struct luo_devic=
e_state,
> > > +                                                    miscdev);
> > > +
> > > +       if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> > > +               return -EBUSY;
> >
> > Can you remind me why the kernel needs to enforce this? What would be
> > wrong or unsafe from the kernel perspective if there were multiple
> > userspace agents holding open files for /dev/liveupdate, each with
> > their own sessions?
>
> By enforcing a singleton, we will ensure a consistent view for tooling
> like luoadm (which will track incoming/outgoing sessions, UUIDs, etc.)
> and prevent conflicting commands regarding the transition state.
>
> This is not a bottleneck because the vast majority of the work
> (preserving devicse/memory) is handled via the individual Session FDs.
> Also, since sessions persist even if /dev/liveupdate is closed, we
> allow the agent upgrade, or crashing without requiring concurrent
> access.

Yeah, I'm not concerned about bottlenecking. It just seems like an
artificial constraint to impose on userspace at this point. The only
ioctls on /dev/liveupdate are to create a session and retreive a
session. Neither of those will conflict with having multiple open
files for /dev/liveupdate.

