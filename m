Return-Path: <linux-fsdevel+bounces-23310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B092A876
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911211C21115
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14414AD3E;
	Mon,  8 Jul 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBUeVMhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACA149C79
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461198; cv=none; b=Eq8qtPeAWLItPww3s34g6pomxaBgHwCveDQsXpBJVt4ERy5jWHWLe58c/QlLgwctKHh1kLBof5xOTuI0HpZztbNpUDJfz7FWKMoY4ksObLQwCLrhMrGnodCkJCe79TRDBUfPWH8Ms7gI0SZHu6X+vK5jhxqgK0Wr8lV9SY1+Qj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461198; c=relaxed/simple;
	bh=A51TjF59OTkpsKWSIYn/LlAqbFDjDhnXxoyl83snzzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ7Igf4/Lg6vYzoRhLAM91stALGH36J4HNGc/8glcxsEB3wRiSPOmwCxQenLSV/TrVXoBmDjvL/Pro8+CSIxm9R07+02RfR0PDpXdEaR+KhGCUy52VqNLt1Uh/cFlTkU2dk0fxzotZja0z9u+fJchvou7VbUwO5mEnOvQgaWZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBUeVMhH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so1171a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720461195; x=1721065995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3TbkBbvUVbFeDVSEP1fW1+EltO1UgtRB4Zsk2MimJk=;
        b=UBUeVMhHyoAEuzPBDsDDW7ygRkxeRScsR8pIIQ92bjzur3K1AS9VY/UYvQaWNcIQlG
         IH7LA482FL8ab0BnOBLNoZ47d5sGruaBvSsWwBCF2yLr4H09MuBoQsEQJ5Ayh196qk+K
         mtp4yFrPAEKiZPD5jez9sn424UHAVzWwwr++zUwIR87l6ILDzYNxv0mndqbcAxBBTPKD
         1w1nh+uBxsQ3W61VJAPg8f7n6bZTzqw0Ql36+QGSU12S663n8alf3NwxI0NdQEQpzndl
         Enw6BdonEl5hGuy18mbEdu9oX8XSw4ml7Oxm7EcNHhZP0P85YXfduMh9suY9K5kqTjGv
         Uc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461195; x=1721065995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3TbkBbvUVbFeDVSEP1fW1+EltO1UgtRB4Zsk2MimJk=;
        b=qoHTN6XJcWFFMPZsG7JK2gOddif1UZZhXafehBdbSkpCRJaQqcb5tcL+Qtr1V5Wv7z
         0O8UJE3K03Fmf62qumbduGhDWwE7PCuB4dgORdoKxjAy/4JuyeKUlaBLzK1IdFjX7Ksd
         W2M4e3zqo7dgPoozueMEqNh9fV3ftfNX5L+haQ6ZbTQkKDpaEjcBqCbKgncFNTCuIm83
         KlokMjKW9W1Ss+3Mx+TZNZKaCTebiNPic/oCkiOVD2DU7a7MPlmYkuJPdhPw0Pv7KKCr
         E7V3n+DCclP/0D59pryRErU97lxIHf55PVtO8jENNDAoSIhmm5Be9ecbtT++nId2Gqz2
         tjPg==
X-Forwarded-Encrypted: i=1; AJvYcCWdU9tgHOs2BKQ8gt0rTnr3alzCK3tjrfCshQQBbbIpQwSNeMBFhbPPlrYv+RhzfX5PVOuOdyqcOU/Ma+trn4rUXjoipumGXeFmvFl7VA==
X-Gm-Message-State: AOJu0Yzjlv6rtgzvEv66+tXPNf478rRxRe77gOWmx6B75UJAG6uggj8M
	FT74DVxMmqmdQatzzi+oN6Plv2lr/nqKWNky4CQSfmIsuss3oJIg6JueFSs103eN9H8j29cxjG4
	bYIawi46PcGnLMY2PTa+2uZ+B4+zzkIJYBzX2
X-Google-Smtp-Source: AGHT+IHHxKVbyksIrCSInAfN33CbHiJrGetzywRVqsOhmUb93ffLYHC9Q2t9UkNSdOIhMtNmgF5pWC4xS+6p5oWJ6ps=
X-Received: by 2002:a50:bb2c:0:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-594d6d8047dmr3249a12.3.1720461194964; Mon, 08 Jul 2024 10:53:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com> <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com> <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
 <87r0c3dc1c.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87r0c3dc1c.fsf@oldenburg.str.redhat.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 10:52:36 -0700
Message-ID: <CALmYWFvA7VPz06Tg8E-R_Jqn2cxMiWPPC6Vhy+vgqnofT0GELg@mail.gmail.com>
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

On Mon, Jul 8, 2024 at 10:33=E2=80=AFAM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Jeff Xu:
>
> > On Mon, Jul 8, 2024 at 9:26=E2=80=AFAM Florian Weimer <fweimer@redhat.c=
om> wrote:
> >>
> >> * Jeff Xu:
> >>
> >> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> >> > libraries too ?  or just the main executable itself.
> >>
> >> I expect that dynamic linkers will have to do this for everything they
> >> map.
> > Then all the objects (.so, .sh, etc.) will go through  the check from
> > execveat's main  to security_bprm_creds_for_exec(), some of them might
> > be specific for the main executable ?
>
> If we want to avoid that, we could have an agreed-upon error code which
> the LSM can signal that it'll never fail AT_CHECK checks, so we only
> have to perform the extra system call once.
>
Right, something like that.
I would prefer not having AT_CHECK specific code in LSM code as an
initial goal, if that works, great.

-Jeff

> Thanks,
> Florian
>

