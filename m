Return-Path: <linux-fsdevel+bounces-44882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B929A6E073
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BA9188B596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710F263F5B;
	Mon, 24 Mar 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Z4NowI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7025EF8E;
	Mon, 24 Mar 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835729; cv=none; b=r0esHo4LhwFCQb66jfdRukJU3Para1y0ezHutLegOgD59WcIG6U8Urf1ZxYY5boRfsF5RXWZ2Q0zLydIhhO7q7gFIsyc5JGIw+rt08r3WBaROGpVo+ya/G3l8oxpOjfrkKr96P6EY2+z2lwpuJpDhG2Nc+AcWAR8e+wVboar3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835729; c=relaxed/simple;
	bh=J6WRjYqz1B82Do/LC0H6Ho4K8gqdyw8WntJp5rB7ddY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdIl2q72gsnMCguW7JqUL5WeXvhvAjQyl7hL5WWReJVhxruONywG7jCEk7ebYBcLicy4X7sUK/2Qko0Y67le29dN6SHnJQujaEwQuzlCbyG6rpQbF7hfqxNRNIMFQ2tbPqBK1FPmp+QZxyl507qp0JNrBywiTXc9f4F24T4OlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Z4NowI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso6141307a12.2;
        Mon, 24 Mar 2025 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835725; x=1743440525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2up/SKxehnXgkWs4Ef7nSpSMX8c3dSxERNVt1+RKM+k=;
        b=B7Z4NowIlkAZuRICpxDYCgvRqjjGUA5q6y3FVmtcvSIdmcdTbklRdcBGb2U+y2CkqS
         WOxyUGRgph0q6/STWiwNIVam+DCGlmFxJjeFy9Q4iJjUlz76tpjVURuDx+2o0wHMvfFb
         8ntTTXuq3XS/qS8QrmDBo6KCxyKpH4qcKnfOU40MulaXxL9fjRFK+RkKO/onotkeANTM
         yR5snCRYTqM4RFPL2APp4nNg+B3FQsQxD9wqnLAcIfT/6cfeT/B3RMT1Weymx1fkQF0N
         7Cx1MNnLt7wnrg6i/Aux+aE4YYKKa+WbWeXYtkDBL8wbseKBIX8qzyluBx33FWmgZ2UJ
         cmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835725; x=1743440525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2up/SKxehnXgkWs4Ef7nSpSMX8c3dSxERNVt1+RKM+k=;
        b=dpkrW2U3ITfa9aJSQLa5VY/MZQFVATtEqoFX4pxax1Hx1nd8pmBT4CedW7tGc8fNJm
         ts6S/5tWBvdg3kVQvumXF/4fZW3yUtvDQYPWGimJ2FjKnfalYKIa+wHLdnmJsnxe1dOw
         PgkMGHzLBnJcpryoFXS3UgJLknRcs7QqT7IkVFrYbbUZ8OKRY29oz/dYeTYC04P2Nt3A
         s4DXPVz5dd+MZswUpxVVQpxjxRf51BTsB2zC3BxcCA0kT+TW3PXgfmG76AOAov8UEHKx
         mCfeo9dNfG8xJUadEckaJW6cHjOrTnXO0HTrjqMcobArQVJvCLnb+PZ9UW5qByZJl9jc
         5wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4RE3Y6j0Avp0HypA3aQawTiJQGiKEpB4hzq/HwZ7ELlG4H0dR5LXvRgyXXyHm1KrEkMa/coIL3m6fymuR@vger.kernel.org, AJvYcCWoVLLLcfFgJmjCiipwdGsgNy3Av+MKQBoCjMhGbaAyCPTvxaZdmLXW1Ik7AB1ibOJFJUd9Yo+kE45d2b3j@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzdghfd/gVfs3HPGoYFsI6WEG/EXfXRHl6rAgSyy0JjO7uNQJ
	3gk37V3CIJdoTffqn1xO7rBjDT+ba/h49WZW6u+VsVVeclD8ebhjPJoIhSA667I49ZggE5MV7tW
	aHiC0DYYvD6czu3qsv9UnthJg3Ocx7biL
X-Gm-Gg: ASbGncs7A6qrOtWnPySbT/i3dEIEbiEN+PYGyDYlYgI8MvJLW8e2REyqtdhmq1VE86S
	JIllJbBCtWZsbYoytcXljK/7Z5Y0o1GWi49wiq4FyCRd1ZJUfDc1y11fDO1sogIMsDlrCiVRq6N
	SphL0nbBq6FNUShpfebqGQelivqdabV+6Yb+MH
X-Google-Smtp-Source: AGHT+IHuiWa1FtlMrtBlsq9an4gefRWo3qK5hBfqWQZhZL88FVZ8mCE1dqHyAEQzQpcUJefJLinbnNkHzTWEJdcI5nM=
X-Received: by 2002:a05:6402:270a:b0:5e5:c010:e67e with SMTP id
 4fb4d7f45d1cf-5ebcd521363mr10382450a12.31.1742835724279; Mon, 24 Mar 2025
 10:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com> <20250324160003.GA8878@redhat.com>
In-Reply-To: <20250324160003.GA8878@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Mar 2025 18:01:51 +0100
X-Gm-Features: AQ5f1JrNHUcbs-my_evWJlj7MfcVWW5i_6x-T-zxej8wazTFGmtUxOJEEWF9t2U
Message-ID: <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>, 
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 5:00=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> check_unsafe_exec() sets fs->in_exec under cred_guard_mutex, then execve(=
)
> paths clear fs->in_exec lockless. This is fine if exec succeeds, but if i=
t
> fails we have the following race:
>
>         T1 sets fs->in_exec =3D 1, fails, drops cred_guard_mutex
>
>         T2 sets fs->in_exec =3D 1
>
>         T1 clears fs->in_exec
>
>         T2 continues with fs->in_exec =3D=3D 0
>
> Change fs/exec.c to clear fs->in_exec with cred_guard_mutex held.
>

I had cursory glances at this code earlier and the more I try to
understand it the more confused I am.

The mutex at hand hides in ->signal and fs->in_exec remains treated as a fl=
ag.

The loop in check_unsafe_exec() tries to guard against a task which
shares ->fs, but does not share ->mm? To my reading this implies
unshared ->signal, so the mutex protection does not apply.

I think this ends up being harmless as in this case nobody is going to
set ->in_exec (instead they are going to share LSM_UNSAFE_SHARE), so
clearing it in these spots becomes a nop.

At the same time the check in copy_fs() no longer blocks clones as
check_unsafe_exec() already opts to LSM_UNSAFE_SHARE?

Even if this all works with the patch, this is an incredibly odd set
of dependencies and I don't see a good reason for it to still be here.

Per my other e-mail the obvious scheme would serialize all execs
sharing ->fs and make copy_fs do a killable wait for execs to finish.
Arguably this would also improve userspace-visible behavior as a
transient -EBUSY would be eliminated.

No matter what the specific solution, imo treating ->in_exec as a flag
needs to die.

is there a problem getting this done even for stable kernels? I
understand it would be harder to backport churn-wise, but should be
much easier to reason about?

Just my $0,03
--=20
Mateusz Guzik <mjguzik gmail.com>

