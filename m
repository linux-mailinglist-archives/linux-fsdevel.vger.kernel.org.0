Return-Path: <linux-fsdevel+bounces-23892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443E9345EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B41C2193F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE4286A8;
	Thu, 18 Jul 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbHQFiwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB881946F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721267513; cv=none; b=Ar0bMSzcTh9CBYhIt5I99Kd4xvrqs6zMcyvGDwOfwvYAjky5vMSWlj7xwm+rLVaH4HiTts7E3m/7DWB/lJlJez9RdYOsv0Z6Fbi8My6Td0wl4KXjnkK9uM2+zvDJPQKkWqEs3JIddAYAMOrAheBIWtXXQzDey1l/mMksI7RVZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721267513; c=relaxed/simple;
	bh=ncicT0K3UO60xiU/mIKg6ElpM+86+19R0KeSAIhcXsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKmMjo26nbOnB93PY1l1HT7PiO87gp7f0ZrD9r1jJA8P7S3rweMxz0Gko6vmH5m7pfTgBsggozKm7pCLqcozt0w/n2EblbNmu81gCI7edbi2umwxDyetvLU1sPHIbHw6xCGLZlZgQlS0kXfpGndbHiPCn9DhZIjwjgeqqc6JRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbHQFiwc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so4447a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 18:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721267510; x=1721872310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJZ63+KcodZOUJ9CCw+HbTDjxj9KTImYwSLlP4nPFDI=;
        b=kbHQFiwcwFZRRkAFfthpG6oS423MPU9p30ghgAk9MlSynHXK9+FxL8iYTGeeSjrghB
         LL1QKczu9z0LBXj/WZnx43oseAt+qBxVoziav/P2QzurgJBiE9YL0O3Vfx6yKW2mlleM
         vzKd7p3I3NV3a1zLyfpA43qZMnTShb2g34Fsmw4MPJGO89lUSjqsf2GnTFXkaWgOQE6B
         +nmoBcUMs5ZhLTx4eOvomQAg1a6ULSPES/vApXAWpse5/bgPYlnzSWdRQY4r9kUjgjiv
         ObS99NLKk14K63xKBZSEoZMlC3MRWUhstsO02owfX4z+ly8hUmsTKt4glJ93qltjWOIE
         4Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721267510; x=1721872310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJZ63+KcodZOUJ9CCw+HbTDjxj9KTImYwSLlP4nPFDI=;
        b=HRPi/HMfAH9Rc7b7SBgNqlsDLOKEvdIlaxIEVlQPjxvxYzM2qI1/vg/i8JgAvBeUKG
         K4cPma36we/GeniD1MbG8j8PCq+1vZxxdGtnqY8LWPVn8LCliKQGxR1tUzHI1aIfiEML
         ZGvuXxY99KJx19zpNNaa3j8tKScAI1q4nMwrIz4RnG79pNXBxB7/NRjc5syJ71Ms50IR
         KIg0Fd3wqBVXu3BaKyueztDju60TnTQQ10fS0Cx+QfVuTOhaR5cSQA0sKm1CS70yZmny
         EvDGLnOzqULNDUPVDC+NuIWj6XxTvNZFW5CMgxgLLqLXhXgG0GpPSTiZmVtDGhu7H8ZL
         ZaWw==
X-Forwarded-Encrypted: i=1; AJvYcCVpLAkBuTXnwDPlOnX7fXsXyJmrcqSJchKj4wBIiAGQpY48R1PGf17hXkeAFEuN1SpIbLtvxANqybRpXeFPNyh7CuPaMbyP0ocl8CKxQQ==
X-Gm-Message-State: AOJu0Yz4FRLDgSSzBrBdLjtRbvcxxXAfMc7UrRkdrZymoUTX53Baaf8K
	mvK5tIzNvwa8ZHL9tKTl2aOuMoNyBZLYpFfkBwQ62lp7gDklyq43ZlxZ5v+/Xt+QCzm5uDRmQrv
	kM+29ME9QDeYrtRo4HB3YM6eONOnIz7Nc3mKe
X-Google-Smtp-Source: AGHT+IH9jcKAI8n2GbWdrtyqQO31S0/aF0VaU5hERSsdL1d154MSEshBIghoJbVRDz92Y4QOgC4k+74aIDfa+EXvDTY=
X-Received: by 2002:a05:6402:254f:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5a1afc473bdmr44730a12.5.1721267509612; Wed, 17 Jul 2024
 18:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org> <20240717.AGh2shahc9ee@digikod.net>
In-Reply-To: <20240717.AGh2shahc9ee@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 17 Jul 2024 18:51:11 -0700
Message-ID: <CALmYWFvxJSyi=BT5BKDiKCNanmbhLuZ6=iAMvv1ibnP24SC7fA@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Steve Dower <steve.dower@python.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 3:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
> > On 17/07/2024 07:33, Jeff Xu wrote:
> > > Consider those cases: I think:
> > > a> relying purely on userspace for enforcement does't seem to be
> > > effective,  e.g. it is trivial  to call open(), then mmap() it into
> > > executable memory.
> >
> > If there's a way to do this without running executable code that had to=
 pass
> > a previous execveat() check, then yeah, it's not effective (e.g. a Pyth=
on
> > interpreter that *doesn't* enforce execveat() is a trivial way to do it=
).
> >
> > Once arbitrary code is running, all bets are off. So long as all arbitr=
ary
> > code is being checked itself, it's allowed to do things that would bypa=
ss
> > later checks (and it's up to whoever audited it in the first place to
> > prevent this by not giving it the special mark that allows it to pass t=
he
> > check).
>
We will want to define what is considered as "arbitrary code is running"

Using an example of ROP, attackers change the return address in stack,
e.g. direct the execution flow to a gauge to call "ld.so /tmp/a.out",
do you consider "arbitrary code is running" when stack is overwritten
? or after execve() is called.
If it is later, this patch can prevent "ld.so /tmp/a.out".

> Exactly.  As explained in the patches, one crucial prerequisite is that
> the executable code is trusted, and the system must provide integrity
> guarantees.  We cannot do anything without that.  This patches series is
> a building block to fix a blind spot on Linux systems to be able to
> fully control executability.

Even trusted executable can have a bug.

I'm thinking in the context of ChromeOS, where all its system services
are from trusted partitions, and legit code won't load .so from a
non-exec mount.  But we want to sandbox those services, so even under
some kind of ROP attack, the service still won't be able to load .so
from /tmp. Of course, if an attacker can already write arbitrary
length of data into the stack, it is probably already a game over.

