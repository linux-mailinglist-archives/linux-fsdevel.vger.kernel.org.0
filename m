Return-Path: <linux-fsdevel+bounces-59320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36CB373D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5AB1BA4385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03423728AE;
	Tue, 26 Aug 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYfY1X1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404D2F0C5E
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240210; cv=none; b=AWHD+U4MSIfWb7o5jwonqW8LbQmvr2B7g4hfhhl9GfMTrjecGa3STXy6z2EMfdCsqRv9d9gqCq7uM3fM2BmrX1W4gG+KZ+8rf37yppHV8iqipO7QThiUJ1yjewCUCjtTjed95eTs24wEpq5DDTBrAhn2nGKdhf2mo03eRHr/sfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240210; c=relaxed/simple;
	bh=5Yva8w0OLKud+X5aAI7svQHkkphh5vemNMSFzLT6xf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQB++mHjQyPlAg6vodjNrrqXCnaCv6nePCgbJqros9n9+wlrSdn6QZaeUhuWshAMZR58zISGk2jEbQFAsJKN+lUkjWfjSXpu44I5/Glpp8zaiPs3YbLn+pFQbaE2tWtODgltcw8bXdMc80rJWicaEKSI74dBJHKXq2Twyq5BSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aYfY1X1I; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce58da66so770390fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756240207; x=1756845007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAsI7lkO85Qu24POEIN33spwG++nYWteW+y/gu6TAE8=;
        b=aYfY1X1ItZH0Nq+ABgXd2ZWXZ9XarQjryy8pSgZCM1C1MccBQyy+o0jtJKHipxXW2C
         /9NuhmpXKz6umMCCXaFe7HlLeL/WXwXbpE8aosW8BaOYcr6cAifaS/HFJ/eDOqyTgd/2
         k1Mg0NBpHzpMO0yQu1ZHQkfVXk+HTH8PFy/J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240207; x=1756845007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAsI7lkO85Qu24POEIN33spwG++nYWteW+y/gu6TAE8=;
        b=C+ENX796SqX63xauscEyCtMDrmNb4Fvl13xct4UcoDsuzCSN5No8Y98em6TNKhJuHk
         no1OPdi2n9M9BFk1nYsnfuT7Gd1ICHbFWzJGCqM0ueu7zZi6B0HN9JqM1Ay37OUPp1oE
         sERfwS8K4I8Aw/RNYglUCyDP3oIWgiN+B+tVqy18IMwpk1KymPvd1Vaw9BAosUkClnof
         1NzRz+daj7i+hVZH4xTq6E7sF3laMtFhpqXTTIdgnnlhbbZTTpjIfYHcLMhsVBkrQSyU
         blRlJRaq0kLDPVeeKQQgXxHIOI0SkYUdF+MKe53IeQRgRrVRolsP9RVAswfg9uAFWLAj
         wAZg==
X-Forwarded-Encrypted: i=1; AJvYcCWfO4H2Pj6XBCD45raP+ZE1QT1kgxxMp//HOur24qQBLKqX07TU9hXHd+qG9CFk2Q00GhQdC8CubwaV2fWH@vger.kernel.org
X-Gm-Message-State: AOJu0YyQa7+jrRQtbenAB732jvcLGhngqdVbOsm1vbqY/Qx3MEOWqtLv
	Y1OZtWk7/IwCWHYDA3YpdfCPr9/2a3jiCuAKhA8vgNuE0aCG64lB4AvXaT6mLFZEecd+fagYtBY
	DuryynQHzo7iN/Zg/5GOxIR9P2RGW0/WtAWYd3hzo
X-Gm-Gg: ASbGnct5bc526hXsM/EpfzpPCWSGZUV68SgRDUWfCZV4TOclZ0pWLYlXULIXXfVNkgu
	8ldBEWTv2jwboE0PtitwY/Yv+EnygBADDzjrWlX2AVuBdNs5HaDe1Oqine+0v8rgFtMhuQmd09Y
	rVWqOqylvBdRgYp3XD7SwzEnclKP1vZiiIuvtSz3jBPEUzgMxYFEbqneyizDd+A1IKHVRMrIz0n
	XBDeDJs/c5WkIOORK8BCTPKWIagBJY+7zjE1iIAU7FU6ND5
X-Google-Smtp-Source: AGHT+IEqMMabA/35+v3UTBnnJZZB7a76MG6s4q+lyF2blEFWTaSGCycoM6fEKn6oGGUjAN3NGYoIAVE7wBld6B8kh8o=
X-Received: by 2002:a05:6870:17aa:b0:30b:8000:7cc9 with SMTP id
 586e51a60fabf-314dcb65a17mr3692227fac.5.1756240207161; Tue, 26 Aug 2025
 13:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net> <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net> <CALmYWFv90uzq0J76+xtUFjZxDzR2rYvrFbrr5Jva5zdy_dvoHA@mail.gmail.com>
 <20250826.eWi6chuayae4@digikod.net>
In-Reply-To: <20250826.eWi6chuayae4@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 26 Aug 2025 13:29:55 -0700
X-Gm-Features: Ac12FXzXGcYCly10UOhTkJvRs0pLvpZsq1ovTThMDokvEl9gFo72WEQTeksVM4c
Message-ID: <CABi2SkUJ1PDm_uri=4o+C13o5wFQD=xA7zVKU-we+unsEDm3dw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl

On Tue, Aug 26, 2025 at 5:39=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Mon, Aug 25, 2025 at 10:57:57AM -0700, Jeff Xu wrote:
> > Hi Micka=C3=ABl
> >
> > On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > > > On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > > > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > > Add a new O_DENY_WRITE flag usable at open time and on opened=
 file (e.g.
> > > > > > > passed file descriptors).  This changes the state of the open=
ed file by
> > > > > > > making it read-only until it is closed.  The main use case is=
 for script
> > > > > > > interpreters to get the guarantee that script' content cannot=
 be altered
> > > > > > > while being read and interpreted.  This is useful for generic=
 distros
> > > > > > > that may not have a write-xor-execute policy.  See commit a58=
74fde3c08
> > > > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > > > >
> > > > > > > Both execve(2) and the IOCTL to enable fsverity can already s=
et this
> > > > > > > property on files with deny_write_access().  This new O_DENY_=
WRITE make
> > > > > >
> > > > > > The kernel actually tried to get rid of this behavior on execve=
() in
> > > > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly tha=
t had
> > > > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e=
3d
> > > > > > because it broke userspace assumptions.
> > > > >
> > > > > Oh, good to know.
> > > > >
> > > > > >
> > > > > > > it widely available.  This is similar to what other OSs may p=
rovide
> > > > > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > > > > >
> > > > > > We used to have the analogous mmap() flag MAP_DENYWRITE, and th=
at was
> > > > > > removed for security reasons; as
> > > > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > > > >
> > > > > > |        MAP_DENYWRITE
> > > > > > |               This flag is ignored.  (Long ago=E2=80=94Linux =
2.0 and earlier=E2=80=94it
> > > > > > |               signaled that attempts to write to the underlyi=
ng file
> > > > > > |               should fail with ETXTBSY.  But this was a sourc=
e of denial-
> > > > > > |               of-service attacks.)"
> > > > > >
> > > > > > It seems to me that the same issue applies to your patch - it w=
ould
> > > > > > allow unprivileged processes to essentially lock files such tha=
t other
> > > > > > processes can't write to them anymore. This might allow unprivi=
leged
> > > > > > users to prevent root from updating config files or stuff like =
that if
> > > > > > they're updated in-place.
> > > > >
> > > > > Yes, I agree, but since it is the case for executed files I thoug=
h it
> > > > > was worth starting a discussion on this topic.  This new flag cou=
ld be
> > > > > restricted to executable files, but we should avoid system-wide l=
ocks
> > > > > like this.  I'm not sure how Windows handle these issues though.
> > > > >
> > > > > Anyway, we should rely on the access control policy to control wr=
ite and
> > > > > execute access in a consistent way (e.g. write-xor-execute).  Tha=
nks for
> > > > > the references and the background!
> > > >
> > > > I'm confused.  I understand that there are many contexts in which o=
ne
> > > > would want to prevent execution of unapproved content, which might
> > > > include preventing a given process from modifying some code and the=
n
> > > > executing it.
> > > >
> > > > I don't understand what these deny-write features have to do with i=
t.
> > > > These features merely prevent someone from modifying code *that is
> > > > currently in use*, which is not at all the same thing as preventing
> > > > modifying code that might get executed -- one can often modify
> > > > contents *before* executing those contents.
> > >
> > > The order of checks would be:
> > > 1. open script with O_DENY_WRITE
> > > 2. check executability with AT_EXECVE_CHECK
> > > 3. read the content and interpret it
> > >
> > I'm not sure about the O_DENY_WRITE approach, but the problem is worth =
solving.
> >
> > AT_EXECVE_CHECK is not just for scripting languages. It could also
> > work with bytecodes like Java, for example. If we let the Java runtime
> > call AT_EXECVE_CHECK before loading the bytecode, the LSM could
> > develop a policy based on that.
>
> Sure, I'm using "script" to make it simple, but this applies to other
> use cases.
>
That makes sense.

> >
> > > The deny-write feature was to guarantee that there is no race conditi=
on
> > > between step 2 and 3.  All these checks are supposed to be done by a
> > > trusted interpreter (which is allowed to be executed).  The
> > > AT_EXECVE_CHECK call enables the caller to know if the kernel (and
> > > associated security policies) allowed the *current* content of the fi=
le
> > > to be executed.  Whatever happen before or after that (wrt.
> > > O_DENY_WRITE) should be covered by the security policy.
> > >
> > Agree, the race problem needs to be solved in order for AT_EXECVE_CHECK=
.
> >
> > Enforcing non-write for the path that stores scripts or bytecodes can
> > be challenging due to historical or backward compatibility reasons.
> > Since AT_EXECVE_CHECK provides a mechanism to check the file right
> > before it is used, we can assume it will detect any "problem" that
> > happened before that, (e.g. the file was overwritten). However, that
> > also imposes two additional requirements:
> > 1> the file doesn't change while AT_EXECVE_CHECK does the check.
>
> This is already the case, so any kind of LSM checks are good.
>
May I ask how this is done? some code in do_open_execat() does this ?
Apologies if this is a basic question.

> > 2>The file content kept by the process remains unchanged after passing
> > the AT_EXECVE_CHECK.
>
> The goal of this patch was to avoid such race condition in the case
> where executable files can be updated.  But in most cases it should not
> be a security issue (because processes allowed to write to executable
> files should be trusted), but this could still lead to bugs (because of
> inconsistent file content, half-updated).
>
There is also a time gap between:
a> the time of AT_EXECVE_CHECK
b> the time that the app opens the file for execution.
right ? another potential attack path (though this is not the case I
mentioned previously).

For the case I mentioned previously, I have to think more if the race
condition is a bug or security issue.
IIUC, two solutions are discussed so far:
1> the process could write to fs to update the script.  However, for
execution, the process still uses the copy that passed the
AT_EXECVE_CHECK. (snapshot solution by Andy Lutomirski)
or 2> the process blocks the write while opening the file as read only
and executing the script. (this seems to be the approach of this
patch).

I wonder if there are other ideas.

Thanks and regards,
-Jeff

