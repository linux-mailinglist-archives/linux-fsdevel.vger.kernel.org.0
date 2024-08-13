Return-Path: <linux-fsdevel+bounces-25794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56E950870
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937B91F219D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90E1A00C9;
	Tue, 13 Aug 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z28wd3r+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB51DFD1
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561467; cv=none; b=VnUIgekomBpRIvsJl8SX1rzSzketnW5pn1bXGzhIEl72nQ8XBZyfPvnO2B/rvBTUd7aNcdkqw0oSdF+GfzksLErzfT8t/SiSacBKk6fWP/KMXjvcINkGFrsh6AxEakftQyK461T2kJ0RfNfMiskg9srqyh/HRrjxdB5hPADKgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561467; c=relaxed/simple;
	bh=rlMeZFw2l5meUNRx2SEMXoKUXtDu/BtobZpP6EJPnk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VebU7k+zwFZKaRUZan2RSVP02IiU+0JNP6TbXj1M8i6tr8oXhceH5pJez5Pc1InTrvCsCl/yHXQPAyRh9SHSCqPV2h/PSX9JBQwTZIKzGZbnewDc7Uapyt5oiZOWG83yehkCeOHGoCq2CpMMgrNjcDpoWmHR/YNb1Fhchcu9s2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z28wd3r+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0bf9b821e8so5467707276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723561464; x=1724166264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJyLP31uzhtBv0LyySvr0BFuiD5ePD4qsAd+xXreOM=;
        b=Z28wd3r+Bb9210QgFjdOlq4Tg/jtKsu7O7QZqHOsqzjzAXb0bvoViV6wVPTunJcvB9
         Q4j1ny0T0t0r4lMaqyTfyj9YaShM2RQ4Y3yuOQRvWrzMRD1C57sLloiWasqiytIlQa+h
         +Ose0Qtnqtki9hu9MATEttnZvf6NL6XyiZOLBc3wzq6D6jbZ7HCOrIn3luUGO+40seN6
         WCTIVmgWwPojSt1RGUwFjZAsGafRjJLRi5t3OdjPoT6HTsacUt6QZBen5lflE1KMWy0Q
         WDaQzCtkAecG+CC0EIHv1Iydt1LrCvCmdv2v+p+gg47A9Lj7hj5R6CsqpWN6skbTWRRZ
         nWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561464; x=1724166264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTJyLP31uzhtBv0LyySvr0BFuiD5ePD4qsAd+xXreOM=;
        b=Hx9SF54L+PZWU7ssNDIuic/3VLdQe033aTBYXelMXzhayIK/pkhwWx6aQ4ss4dcu7X
         iIhwRCJnMKavABT0OZS12dYC2XjLHMgWYgNAXZ6SsjKECq9poZuyBC9tlNTQap9p3Zdi
         azC+ZPAde1zN4tqTMFrxMZx7G4TPS4IGK9uEQjl+dgXXL1ddkIaz3f6d7olb+a1OnNoB
         1Kg5fD2yhTuucl8Uw6RYHbFs+u47GzuiBUUiVnGma1p9XVb17DPMcHvH/IBdXsONqhWF
         Uum/rLhns757Dg0KAUIdSKk+CMdXSVZop5GvI8xIvtgQVIkqf9e/hXL4VBR7jW6DUmdN
         W4BA==
X-Forwarded-Encrypted: i=1; AJvYcCWsiU/+8Q3qOo4iwLU08lmpGfUCRKwWYaFDEaFqYEtjgt+JLIeo/az6PIqnk/kVSuXKM0Yk4UcG1dGHRfdZjaWCYz02E46KbWp95xl+zg==
X-Gm-Message-State: AOJu0YzyGvpnkSYVJ2tQ2cvoUw++qtno4j3YFxKcjgsSDj2S1H7eLET1
	MT8IGTIitatEaMSn3iDP1hkttJT+fk+vAR8cAHuPxZIgRstyD5NBalWQhdLs44SVEXfldWLtjGr
	kWRxeXx8/iwZBupg8gUvrZWzATjZ2wmShUGej
X-Google-Smtp-Source: AGHT+IFEH2UHHfqzjJOs+zOkRyDaP1qlz9v98QdLK/yiqrHGQs7eqhzN/Uc94M+fouP0QiOwiznQtTn01v1eWvVQJhU=
X-Received: by 2002:a05:690c:b84:b0:66a:b6d2:c184 with SMTP id
 00721157ae682-6a971eb6ed8mr59099287b3.16.1723561464066; Tue, 13 Aug 2024
 08:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net> <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net>
In-Reply-To: <20240813.la2Aiyico3lo@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 11:04:13 -0400
Message-ID: <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> > On Mon, Aug 12, 2024 at 1:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGUR=
G
> > > for the related file descriptor.  Before this change, the
> > > file_set_fowner LSM hook was used to store this information.  However=
,
> > > there are three issues with this approach:
> > >
> > > - Because security_file_set_fowner() only get one argument, all hook
> > >   implementations ignore the VFS logic which may not actually change =
the
> > >   process that handles SIGIO (e.g. TUN, TTY, dnotify).
> > >
> > > - Because security_file_set_fowner() is called before f_modown() with=
out
> > >   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could result=
 to
> > >   a race condition and inconsistent LSM states (e.g. SELinux's fown_s=
id)
> > >   compared to struct fown_struct's UID/EUID.
> > >
> > > - Because the current hook implementations does not use explicit atom=
ic
> > >   operations, they may create inconsistencies.  It would help to
> > >   completely remove this constraint, as well as the requirements of t=
he
> > >   RCU read-side critical section for the hook.
> > >
> > > Fix these issues by replacing f_owner.uid and f_owner.euid with a new
> > > f_owner.cred [1].  This also saves memory by removing dedicated LSM
> > > blobs, and simplifies code by removing file_set_fowner hook
> > > implementations for SELinux and Smack.
> > >
> > > This changes enables to remove the smack_file_alloc_security
> > > implementation, Smack's file blob, and SELinux's
> > > file_security_struct->fown_sid field.
> > >
> > > As for the UID/EUID, f_owner.cred is not always updated.  Move the
> > > file_set_fowner hook to align with the VFS semantic.  This hook does =
not
> > > have user anymore [2].
> > >
> > > Before this change, f_owner's UID/EUID were initialized to zero
> > > (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is now
> > > initialized with the file descriptor creator's credentials (i.e.
> > > file->f_cred), which is more consistent and simplifies LSMs logic.  T=
he
> > > sigio_perm()'s semantic does not need any change because SIGIO/SIGURG
> > > are only sent when a process is explicitly set with __f_setown().
> > >
> > > Rename f_modown() to __f_setown() to simplify code.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-b039=
dbc6ce82@brauner [1]
> > > Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=3D_eiUik=
RDW2sUDSN3c=3DgVQw@mail.gmail.com [2]
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >
> > > Changes since v1:
> > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > - Add back the file_set_fowner hook (but without user) as
> > >   requested by Paul, but move it for consistency.
> > > ---
> > >  fs/fcntl.c                        | 42 +++++++++++++++--------------=
--
> > >  fs/file_table.c                   |  3 +++
> > >  include/linux/fs.h                |  2 +-
> > >  security/security.c               |  5 +++-
> > >  security/selinux/hooks.c          | 22 +++-------------
> > >  security/selinux/include/objsec.h |  1 -
> > >  security/smack/smack.h            |  6 -----
> > >  security/smack/smack_lsm.c        | 39 +---------------------------
> > >  8 files changed, 33 insertions(+), 87 deletions(-)
> > >
> > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > index 300e5d9ad913..4217b66a4e99 100644
> > > --- a/fs/fcntl.c
> > > +++ b/fs/fcntl.c
> > > @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsign=
ed int arg)
> > >         return error;
> > >  }
> > >
> > > -static void f_modown(struct file *filp, struct pid *pid, enum pid_ty=
pe type,
> > > -                     int force)
> > > +void __f_setown(struct file *filp, struct pid *pid, enum pid_type ty=
pe,
> > > +               int force)
> > >  {
> > >         write_lock_irq(&filp->f_owner.lock);
> > >         if (force || !filp->f_owner.pid) {
> > > @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struct pi=
d *pid, enum pid_type type,
> > >                 filp->f_owner.pid_type =3D type;
> > >
> > >                 if (pid) {
> > > -                       const struct cred *cred =3D current_cred();
> > > -                       filp->f_owner.uid =3D cred->uid;
> > > -                       filp->f_owner.euid =3D cred->euid;
> > > +                       security_file_set_fowner(filp);
> > > +                       put_cred(rcu_replace_pointer(
> > > +                               filp->f_owner.cred,
> > > +                               get_cred_rcu(current_cred()),
> > > +                               lockdep_is_held(&filp->f_owner.lock))=
);
> > >                 }
> > >         }
> > >         write_unlock_irq(&filp->f_owner.lock);
> > >  }
> >
> > Looking at this quickly, why can't we accomplish pretty much the same
> > thing by moving the security_file_set_fowner() into f_modown (as
> > you've done above) and leveraging the existing file->f_security field
> > as Smack and SELinux do today?  I'm seeing a lot of churn to get a
> > cred pointer into fown_struct which doesn't seem to offer that much
> > additional value.
>
> As explained in the commit message, this patch removes related LSM
> (sub)blobs because they are duplicates of what's referenced by the new
> f_owner.cred, which is a more generic approach and saves memory.

That's not entirely correct.  While yes you do remove the need for a
Smack entry in file->f_security, there is still a need for the SELinux
entry in file->f_security no matter what you do, and since the LSM
framework handles the LSM security blob allocations, on systems where
SELinux is enabled you are going to do a file->f_security allocation
regardless.

While a cred based approach may be more generic from a traditional
UID/GID/etc. perspective, file->f_security is always going to be more
generic from a LSM perspective as the LSM has more flexibility about
what is placed into that blob.  Yes, the LSM can also place data into
the cred struct, but that is used across a wide variety of kernel
objects and placing file specific data in there could needlessly
increase the size of the cred struct.

> > From what I can see this seems really focused on adding a cred
> > reference when it isn't clear an additional one is needed.  If a new
> > cred reference *is* needed, please provide an explanation as to why;
> > reading the commit description this isn't clear.  Of course, if I'm
> > mistaken, feel free to correct me, although I'm sure all the people on
> > the Internet don't need to be told that ;)
>
> This is a more generic approach that saves memory, sticks to the VFS
> semantic, and removes code.  So I'd say it's a performance improvement

Considering that additional cred gets/puts are needed I question if
there are actually any performance improvements; in some cases I
suspect the performance will actually be worse.  On SELinux enabled
systems you are still going to do the file->f_security allocation and
now you are going to add the cred management operations on top of
that.

> it saves memory

With the move in linux-next to pull fown_struct out of the file
struct, I suspect this is not as important as it once may have been.

> it fixes the LSM/VFS inconsistency

Simply moving the security_file_set_fowner() inside the lock protected
region should accomplish that too.  Unless you're talking about
something else?

> it guarantees
> that the VFS semantic is always visible to each LSMs thanks to the use
> of the same f_owner.cred

The existing hooks are designed to make sure that the F_SETOWN
operation is visible to the LSM.

> and it avoids LSM mistakes (except if an LSM implements the now-useless h=
ook).

The only mistake I'm seeing is that the call into
security_file_set_fowner() is not in the lock protected region, and
that is easily corrected.  Forcing the LSM framework to reuse a cred
struct has the potential to restrict LSM security models which is
something we try very hard not to do.

--=20
paul-moore.com

