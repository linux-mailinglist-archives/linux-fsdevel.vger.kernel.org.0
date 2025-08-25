Return-Path: <linux-fsdevel+bounces-59116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E525B3497B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7867A5E7993
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D4B3090DF;
	Mon, 25 Aug 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7+dSJWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF7308F1E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144720; cv=none; b=UX7eQak/PWb8+nVb11APXAYmSZ3sZ13BciVwL5MrRVtCJqE538XooYv/q3BCRIxu3OB2+gQ2H0oDQ8+qIXF8Xny/8QMHN60aHR8QTX+8kNhNVMOHuDMIwR34TbcuZ9jzaYcJmo6rbInGcNIOcDPr02OTt//I3ChCfU4Yz+db+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144720; c=relaxed/simple;
	bh=4GQMW7y4hB6OnpRIcEB2iZaqJ0oZoARp3ba61McckPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4aT0QAsQGsMFSiqBpjGTu8bUSznmJlKzDjZFRVucvuAlUqKu5wgoR0wQaMcnHSsrgsViPSiXXHTg47aeqtvTCp6jdBV3PsUGlfkmMSspvA6Jp6TOU+JHSXngWRS92gSRYKNz32a8imDjbe81tZ3MYxc8rayGFEsr2l6RJFtM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7+dSJWm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so6395e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756144715; x=1756749515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5yo9Tha3EYZ7QDWhjTh1gNp5eXSF1E//nUjICwrq4k=;
        b=u7+dSJWmVmjCDzkOc/+o9pNju1PVWZxyMDFdMqcF1qQUWCrO3gOBEufIdc6TDhYb8a
         pqdW7m6yd2jcjO3p0y5g9rSPMktXUwJr1oEkSJcsjJoowgiF2SbxGpV5l21gyNJsvHJq
         LTGulZYKbV9dmabNwXL4XxgOfhfXn7uefmZgJWI26f2DRr2Rb1Vb42MEiyVcMUZNjtzL
         fWwIRd4gVCoRNLH5ZgMwLwkxon09bJ9kE0XCOyZ8KcxN/+LIZxxJfyzcJIywx7B7q3R4
         zUklveOK6ovTkTEUIyVD4E2SVa81Mcp3/aLfyq+xhwwwb5FQUR8h7G8Ht7oB3PcPsEqV
         LsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144715; x=1756749515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5yo9Tha3EYZ7QDWhjTh1gNp5eXSF1E//nUjICwrq4k=;
        b=iBM8LLd02GaWCH9co61MAlGAna7ua/gGUhj3Pewqjkj0lPT1d9f2xZuTGkxfrzAT3r
         UdNahQpLmyR+Bz4z7bDxsrwo8Af5D3LKUEJzHp0qU20Fjp5BtPQeQKJ3020eYhmqjrdQ
         FTo21USqoed0Zzq1SvBvQWTUMUJefIBwZGAJjWxiPO7C5LZnMUKFlvOV6rIU6mQ3tadb
         StSSH+n8oB+bAEtjEx92WQF0bFTx8b/usGjPB2xsxjNy4wQ/v2moCz9W4yNf6oNpTBDK
         PX4JsOf1Ts4+hZkr8vCvMokzYeUhIjmFp6+xfRETW87BANl7UtbezPuJ6q+yPY26xDo/
         lWPA==
X-Forwarded-Encrypted: i=1; AJvYcCX/YLjaxHbMRnPPP1zeCaAaU+8SSFjFSNZYuQGIZ+jFtpauUx2OmxtSGXoXD7p9oy6NzyurecQr3KlrUHGP@vger.kernel.org
X-Gm-Message-State: AOJu0YwvujfSJzrnLtwAXOkrikylyV4MPvmOoSkGraHsRgw9qkHtQy/s
	7MV1dLY8UIl052LoXGSN6vH/mpOipEzetAmQ25uvQT8mqGCYk0oD+d7EnA/YR6urYSOXtMCS9ty
	wXgd3ssxFXgFdDAaNJ2n2bEEg5azevJD6wRU/3Jn7
X-Gm-Gg: ASbGncsr2COTYiPQeA7IDRKGwLVmz0SlbMrlqDqFxkfKYgQRzYv+Re4JDR78cjWai7g
	G1xcrAAXyHU8bqG7gm31tySkYM5qal+HcsrkAr1oPbaQOS06KupehDmRsMvoR163d6bzGNptfcD
	7ItX5mOfqsbXayEtPawOGIekYsoEsZpdG4jq0rg/vej5h+kyKmTYfJIYI5dbF2ZDqzSVEMCT+Cz
	DEWEwwDnLEu6wanpcLJJxEmrbmV9xNhQ97t19YamNSm
X-Google-Smtp-Source: AGHT+IGoEbuuaQmf6ejPreW/3EnO6Pdxa5HefL1xaCUoTpRbYEOTACur/ikE7cpdM/TuCFok1aNUpgjgLfri4GxZboA=
X-Received: by 2002:a05:600c:3b9f:b0:439:8f59:2c56 with SMTP id
 5b1f17b1804b1-45b65e97671mr61125e9.2.1756144714893; Mon, 25 Aug 2025 10:58:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net> <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net>
In-Reply-To: <20250825.mahNeel0dohz@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 25 Aug 2025 10:57:57 -0700
X-Gm-Features: Ac12FXxz9pJE0h6HrBGgWJl3z0z4f3e-FfLHbDFV9MrECVyOF6U4dJWEVdkn5yM
Message-ID: <CALmYWFv90uzq0J76+xtUFjZxDzR2rYvrFbrr5Jva5zdy_dvoHA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>, 
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
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl

On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > Add a new O_DENY_WRITE flag usable at open time and on opened fil=
e (e.g.
> > > > > passed file descriptors).  This changes the state of the opened f=
ile by
> > > > > making it read-only until it is closed.  The main use case is for=
 script
> > > > > interpreters to get the guarantee that script' content cannot be =
altered
> > > > > while being read and interpreted.  This is useful for generic dis=
tros
> > > > > that may not have a write-xor-execute policy.  See commit a5874fd=
e3c08
> > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > >
> > > > > Both execve(2) and the IOCTL to enable fsverity can already set t=
his
> > > > > property on files with deny_write_access().  This new O_DENY_WRIT=
E make
> > > >
> > > > The kernel actually tried to get rid of this behavior on execve() i=
n
> > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that ha=
d
> > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > > > because it broke userspace assumptions.
> > >
> > > Oh, good to know.
> > >
> > > >
> > > > > it widely available.  This is similar to what other OSs may provi=
de
> > > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > > >
> > > > We used to have the analogous mmap() flag MAP_DENYWRITE, and that w=
as
> > > > removed for security reasons; as
> > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > >
> > > > |        MAP_DENYWRITE
> > > > |               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 =
and earlier=E2=80=94it
> > > > |               signaled that attempts to write to the underlying f=
ile
> > > > |               should fail with ETXTBSY.  But this was a source of=
 denial-
> > > > |               of-service attacks.)"
> > > >
> > > > It seems to me that the same issue applies to your patch - it would
> > > > allow unprivileged processes to essentially lock files such that ot=
her
> > > > processes can't write to them anymore. This might allow unprivilege=
d
> > > > users to prevent root from updating config files or stuff like that=
 if
> > > > they're updated in-place.
> > >
> > > Yes, I agree, but since it is the case for executed files I though it
> > > was worth starting a discussion on this topic.  This new flag could b=
e
> > > restricted to executable files, but we should avoid system-wide locks
> > > like this.  I'm not sure how Windows handle these issues though.
> > >
> > > Anyway, we should rely on the access control policy to control write =
and
> > > execute access in a consistent way (e.g. write-xor-execute).  Thanks =
for
> > > the references and the background!
> >
> > I'm confused.  I understand that there are many contexts in which one
> > would want to prevent execution of unapproved content, which might
> > include preventing a given process from modifying some code and then
> > executing it.
> >
> > I don't understand what these deny-write features have to do with it.
> > These features merely prevent someone from modifying code *that is
> > currently in use*, which is not at all the same thing as preventing
> > modifying code that might get executed -- one can often modify
> > contents *before* executing those contents.
>
> The order of checks would be:
> 1. open script with O_DENY_WRITE
> 2. check executability with AT_EXECVE_CHECK
> 3. read the content and interpret it
>
I'm not sure about the O_DENY_WRITE approach, but the problem is worth solv=
ing.

AT_EXECVE_CHECK is not just for scripting languages. It could also
work with bytecodes like Java, for example. If we let the Java runtime
call AT_EXECVE_CHECK before loading the bytecode, the LSM could
develop a policy based on that.

> The deny-write feature was to guarantee that there is no race condition
> between step 2 and 3.  All these checks are supposed to be done by a
> trusted interpreter (which is allowed to be executed).  The
> AT_EXECVE_CHECK call enables the caller to know if the kernel (and
> associated security policies) allowed the *current* content of the file
> to be executed.  Whatever happen before or after that (wrt.
> O_DENY_WRITE) should be covered by the security policy.
>
Agree, the race problem needs to be solved in order for AT_EXECVE_CHECK.

Enforcing non-write for the path that stores scripts or bytecodes can
be challenging due to historical or backward compatibility reasons.
Since AT_EXECVE_CHECK provides a mechanism to check the file right
before it is used, we can assume it will detect any "problem" that
happened before that, (e.g. the file was overwritten). However, that
also imposes two additional requirements:
1> the file doesn't change while AT_EXECVE_CHECK does the check.
2>The file content kept by the process remains unchanged after passing
the AT_EXECVE_CHECK.

I imagine, the complete solution for AT_EXECVE_CHECK would include
those two grantees.

Thanks
-Jeff

