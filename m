Return-Path: <linux-fsdevel+bounces-23301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766392A6DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDCA1F21BE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C51B146595;
	Mon,  8 Jul 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqrsY0w5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AD13D2BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454953; cv=none; b=HC8oEo+7bePPgWfrz4ePd8KNjFc5Rg8iB+JJRHcUpLC0YJkBWo+9Fw4lr3gtFGMWFJPAfghs64xf1LUyVaXsy0uCKSySLfFCj9KM0yB7ftJtzY13f4iEHR5UVQfAbXe8Lc2bB9w4DHdC9BU23gQ8NEPgUvN1FCeLo2dF2LeZRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454953; c=relaxed/simple;
	bh=Vuy+tdEYiWTkuOL1+Ju14j/vlrE3oT4RzPh9CG4iLj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRagxpD7RIfiGkzRx6yJzAMywO6gVjaNif0hdN44i4MqFtVYKdw/Y7HceOXwCfiFzMa12n5iHnz74Ly8PKlu6M1nUn+3e742wpEjpDCZyQDMIkBtQdP9fb3qlFEguRAQ2ltGM6JIPZPGa01YYZbJmr6WyyErrKVscpgpeqT2sVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqrsY0w5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so38704a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720454950; x=1721059750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsiFj/WxLrZpXhxwXs3+FDSwWwZ1Cd4GcIfLRJ1s7ho=;
        b=VqrsY0w5ejKEVldgEKJIRbeyqZ9zuUGKF86JuCw6p2IFCoAxNFyaeqq2Dh3q64hO/x
         dkYXzluGQPJrYaBUD5Gj7NTBQrkFQtRwXL8lmrZPD9IS4z1MRKEcY7/H+mFMMSBteQWa
         FR44zgKoCMFDmg/ZsDIkwintaK4q7XqQgrjnvxdc1AU+bwrZxA002cOnMqb6yU6atuRo
         1yhWKFVFGlraZeF2OxMQiW6L8og8fylrQmIBfLW/z67Loz7IGpSKIr+O7XXezhTPDcIv
         qzrnEejjDLidPqvbrKh5667Lu4di/DuUoikzbLfCuKJISjNRlGs3u64mKrJE6aduhb7b
         53lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454950; x=1721059750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsiFj/WxLrZpXhxwXs3+FDSwWwZ1Cd4GcIfLRJ1s7ho=;
        b=Nng291UbD4SQuqE5Jhj3GHGCkPJMIdWuDyrpU1WeAsrxBnBIgM0u9Ul+civVAF8QZQ
         t5NZJ8t25rLtAQi+BuL0rSGXkMsYXp7OsgKRjMHRF1F4Ebh6h4qxMUu3nOLn6iv43+cQ
         QuwffPWKUkX7MJvFxmiC/y21UV3eO89juZ5z7qNR7tnm68/klD+D/nNncdrFvzc0XA4V
         SWn4HaNMtBwIcZnhogHwZj4ydMO/1ONbRYxnfxwMhhgCHFvh3kdfi0JqA4O8ZwkChfom
         nWW22fRbi4qrKNs2u64kXvhPZ7FghFVs06vUW0QmpOp2bgYLbjQp60YHwK5dwOiNBYke
         qYQg==
X-Forwarded-Encrypted: i=1; AJvYcCUnLYE4quVQRCqxrPxMiXD1976cnFRFAZZxiQPox6FxEwXtmoo8NTlUn+ZvyIMS5lKJKRWd3F2nHS9c4Nf9CjzmpAKBMwJSPmt6tA5ahw==
X-Gm-Message-State: AOJu0Yz/z2Jn8s4FBX8AlY4ALKHdp6krnrV/Lw53p/4zmyUOrK3gQ6dg
	py68YgrSaKkVQnxWYTpDPmvJu1iY8UaGu5SGM6jt5dqIyP7aV55SmdfGpNUAA6pkZedLEVLdpaQ
	kLC/v45fUrF0SnYxBLeThlKplrKz5Lc+MsjTv
X-Google-Smtp-Source: AGHT+IG68WVmOzY4xDmfQcCAQVMnFKtmNO3cbEdYJgbHLx0bLl7VhaJKp8PuklOozwexmfThc7tkOd6AwzlEUeRW6sA=
X-Received: by 2002:a50:8ad3:0:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-58e00933a13mr529925a12.2.1720454949927; Mon, 08 Jul 2024
 09:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 09:08:29 -0700
Message-ID: <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: Florian Weimer <fweimer@redhat.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Alejandro Colomar <alx.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 5, 2024 at 11:03=E2=80=AFAM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Micka=C3=ABl Sala=C3=BCn:
>
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > allowed for execution.  The main use case is for script interpreters an=
d
> > dynamic linkers to check execution permission according to the kernel's
> > security policy. Another use case is to add context to access logs e.g.=
,
> > which script (instead of interpreter) accessed a file.  As any
> > executable code, scripts could also use this check [1].
>
> Some distributions no longer set executable bits on most shared objects,
> which I assume would interfere with AT_CHECK probing for shared objects.
> Removing the executable bit is attractive because of a combination of
> two bugs: a binutils wart which until recently always set the entry
> point address in the ELF header to zero, and the kernel not checking for
> a zero entry point (maybe in combination with an absent program
> interpreter) and failing the execve with ELIBEXEC, instead of doing the
> execve and then faulting at virtual address zero.  Removing the
> executable bit is currently the only way to avoid these confusing
> crashes, so I understand the temptation.
>
Will dynamic linkers use the execveat(AT_CHECK) to check shared
libraries too ?  or just the main executable itself.

Thanks.
-Jeff


> Thanks,
> Florian
>

