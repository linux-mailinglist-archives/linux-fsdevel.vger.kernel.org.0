Return-Path: <linux-fsdevel+bounces-48918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD1AAB5E43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DB43A8DEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29A1FC7F1;
	Tue, 13 May 2025 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFnQoGNA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B41A3A8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170628; cv=none; b=Uv2rVlnn7r0/i7CpowUTvBbTyEKzmYW6YK/6Q82TttnHaMw4DGAxxhnvh38N/Q0yfeLr06NDHH+Wa/Bb6m80TiL+xMDk2trZLejerEVdPP5SEv8CxFBZ1QzOcKAXvlNw99ZoRrMKtEFW/SHxLnXU9BBWEeu7r7Hwz6ytmXm73+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170628; c=relaxed/simple;
	bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvgEjP1LHGRS2Q2eZRdn2pnb53EfK30L8VCBNvRUzzS0kwy2cZ6tSDB6Nm5/ran6hb+X5OzLE0jUMzXKer2DG+0l79qZG4/EjD+SBnJwTRVmzVdgRetw8DWCkdegrVEgXqnsnzxa8a8sAb9XMyHkQI1MonquPfxF2v9q8Bae/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFnQoGNA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3397a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747170625; x=1747775425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
        b=EFnQoGNAHT+HNm/BO6dpQc/hpbe4FHRkl/KBSUQ0dbVLmNf1M/tZoYwwQLKlJ1jvBc
         BAoKLv1G+V1ho4CrIRd74+jJrMhoaNo51UePMRuOJTirDrVCFR1P5CshEmy+NKwJtqx0
         np920pie86rdJPgxpk6p4tZbuA9U9Hk3HT+PUbdMrmbMo61cws7Lkgy0E6uwbxxceQ0j
         2GV8Bm42zgqd3kfTHRyahEojzz7pDLYOXzerYt1Byk37giujpPVNTtziS50YV34crund
         VDcILoEmCzogT4/PvpCEabuBfr/OZ12ib9FqUHMCQUC8LxnPUgrr6KSUUxIeVk26SyCp
         YHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747170625; x=1747775425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
        b=HvUW32NBiqxrYDLzEMGlLaHOXYtgE/NTHS+wdiSFBQ15rzjQmi3I1btO6ILO7S35s2
         BHFev1R5t5K9ybDFK7myXd0O13vbcLEgwDhujoigX1rigU5NGZgBGfgRqmCDG7Z1egtT
         doaJvWJK9IbAph5v0Zvv4V1C1uypiFiTe9zrM8AiRDX1wZsPk56f4HY3jqnv1KQGd3Jr
         lru9t/1rTmEDrIIteNC/tJ0MnKWLn48QSV1Rwu7RbWQt4xxLyL2mytFpad85VDr8eWuT
         9AQjHBBzEu1ltXWS29OirUlx1V3lwaEfR/OSP9YFoB0RZAY7+RwY+EaU3NvWIOYi7ZyD
         YcGA==
X-Forwarded-Encrypted: i=1; AJvYcCXlZFH4fD/Cz2mpXdlW2gIutHbJ90n2EihK1TAFrO/TwvhrocjOgThzDzcC5bxolMUw4L8CblwypPpdcFz3@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJcOlY++Shh3iCghsn8BCfWK0gs+M6NyqpidUEAqIuWHkG0vE
	nD7UxhOAwIgD8zfn8sh9oqHAkYSS0fTf6skk/4tClF5u2seccHbPyjhZzv0L1lYw4mQU8GvM4Gi
	hu5pKWpkwKo0mDrEAZ0mokQrp3AiIQurpoz6jM0r2
X-Gm-Gg: ASbGncsq/GFWLSTTG3+vENxiRiA1xNHbnVkpo82ANAomwWYemREMhQKAhXyxqtEkkxR
	UkG6WcasFNWydRAVYIR6MQwXehyCBskKqsr3AeQRAD5L+dbcTnvh/Cmh8UBqS+Pws/e/IklzcNA
	/IVmw4OcFSUSgGlaBbUr2DaAHA3LL6wmXqu7ex83ejJPBL+c1K4k91YwouQ7MM
X-Google-Smtp-Source: AGHT+IFFvoW0vaiQwXwOuLU8KHoNjqrz7yUskjzEQxJboJ77uRfEnj6qF+F1/xO6hcdFFQqM32ILfLKZ8071TJJxbuw=
X-Received: by 2002:a50:ed16:0:b0:5fd:6065:7bbc with SMTP id
 4fb4d7f45d1cf-5ff97e27b24mr28177a12.0.1747170624943; Tue, 13 May 2025
 14:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org> <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
 <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
In-Reply-To: <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 May 2025 23:09:48 +0200
X-Gm-Features: AX0GCFvSGCrl8jRaWXokLgXy6n507r0H59ZuhYg2-C-s2mYQog1RTVhArK8PEPE
Message-ID: <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To: Kees Cook <kees@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Jorge Merlino <jorge.merlino@canonical.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, Richard Haines <richard_c_haines@btinternet.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Todd Kjos <tkjos@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Prashanth Prahlad <pprahlad@redhat.com>, 
	Micah Morton <mortonm@chromium.org>, Fenghua Yu <fenghua.yu@intel.com>, 
	Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
> >shared. This will have to be checked for after the execing proc becomes
> >single-threaded ofc.
>
> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.

Chrome first launches a setuid helper, and then the setuid helper does
CLONE_FS. Mateusz's proposal would not impact this usecase.

Mateusz is proposing to block the case where a process first does
CLONE_FS, and *then* one of the processes sharing the fs_struct does a
setuid execve(). Linux already downgrades such an execve() to be
non-setuid, which probably means anyone trying to do this will get
hard-to-understand problems. Mateusz' proposal would just turn this
hard-to-debug edgecase, which already doesn't really work, into a
clean error; I think that is a nice improvement even just from the
UAPI standpoint.

If this change makes it possible to clean up the kernel code a bit, even be=
tter.

