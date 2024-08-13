Return-Path: <linux-fsdevel+bounces-25843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0F9510AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2441AB22B40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC41AC447;
	Tue, 13 Aug 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Zs4w46DB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712371A0AE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592399; cv=none; b=piMaeXKcUrgJSizCZjcOHLvtjywo9NGI/vkiVpbFo0dwQL+N0GHQrFQKC6M4sHOYaVaYLOL6tryBAWBUT0WuzeoHxwF5fCeS5Y30RpY/UE/fsJBke/sZKhM/NdE4TKg+uHxoiVMr6ImsysGfWKCDO3vRCufdJeVjGp2GLQoFQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592399; c=relaxed/simple;
	bh=XPE7PifyKIQTXDVhG2o65ghTKjKDk/DQqJv4dIBIoNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6GJ2LDqwPwsV4RD2ravwzkbGHnX9lKGiHfsMEs4OrmH4ll8736YtRQCK8LWWHHfzBN1iYYLlqbnJYA+NoCHwehSq2jjRYL78yaF6ZotAc46nR1V7RZaxKDrjDjNbvf7X7t+oXM530NfCbzPoeyFS8fZPWJRFg2/zyMvqK88Sic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Zs4w46DB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-699d8dc6744so3312167b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723592396; x=1724197196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDQf98wVgqtnt7GJUEUuSvz77H9RkjHMPYmNvqJv22w=;
        b=Zs4w46DB9bBgpnfnpxPxEwSLH9eHFg0Q7cC73KG3nNiJOfdLVG9tleRfrjCGkeGEa6
         GUc6soL+KsQAbXhA7wOPCxB1U8+TJcnCLr7ygb9TrN7xA3tGRb9uPGz75be5EKFa+OX8
         VseS9qwN8YQq5BYAXVYFl/b2p7FUI2zQ+0aTa5bWfjuPvVGJO/t3ZHinGdgA68Ndx1MZ
         sWw59L+PNZJKRDL3F1Sdh/seqd4+kspkm1OLWNOi4e7bNiqLhpKDv8Ou7vO13CSV6xaW
         Aqq74Ma9q9VUfD0aFHwgBu2UcEYybdfxQFCOQcX/26GIgn4/WP+U5ANXc69t5Pc1Zbxy
         IbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723592396; x=1724197196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDQf98wVgqtnt7GJUEUuSvz77H9RkjHMPYmNvqJv22w=;
        b=I8MKzSZwiS9ePdAJBJP6qmkGREahjhP2XERQWrtUitxvKX62KaaSpovvkWvzUJxgv2
         fI/UQyqfCmPielQP6TBpF40AnqMxql8evt3I5H/BeBxLQW2ySZbEVTXlbOfQtlq8QrR1
         VibSTwRKxhPSl2OEOk8RkIg0VIljMYqdK1vbAWzCgfBSrWJLE9OmY28Rtq4rfYSogLfO
         lAHBAfmmaVJZPAtpDOlAbKAp4Lud8c9R8MeVtcHjILFOj54mBJuJInV8fsBJe5arR5j0
         eZD0IFgs5fCysXNwqk0wrDQ7y9ph3hklyOrlTyBtPybTpkl00k5z1cWi4At2HCHwJJGK
         dLbg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Y2iXkSY+MGBvgwmUP15ulUfynm045yTT+h/+8bX5bmsJ7MvWz7h6qWvZMB3BSYWi5rEFyReqgF2ffAnU9igHA1Vxlq5ur6sf+YL+pQ==
X-Gm-Message-State: AOJu0YxpvgXqDF0AxIdwHr8W0wtFwv0qTTO+tchtkncM11PkArQz/soM
	G7tybZMAjFi4IJ+bz3X0PWyXcZGJjZf/6ookKtFzPlYY/87edmK7qkmt/d4ug8HdSdKujCN07v6
	SdjbmS8b54yXQQDgYUZuUpGA4P3OTX+HnktwH
X-Google-Smtp-Source: AGHT+IEGfB5nTeoOSJssS3GUnBC7oP3LxdFZ3wud3lHRx6WFqJjYsb1CAfo6dizsB7JjD0qzFKvGiy99i54VIaYs+U8=
X-Received: by 2002:a05:690c:4808:b0:630:8515:f076 with SMTP id
 00721157ae682-6a9e61fd383mr45866787b3.7.1723592396324; Tue, 13 Aug 2024
 16:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net> <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net> <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
 <20240813.ideiNgoo1oob@digikod.net>
In-Reply-To: <20240813.ideiNgoo1oob@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 19:39:45 -0400
Message-ID: <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Aug 13, 2024 at 11:04:13AM -0400, Paul Moore wrote:
> > On Tue, Aug 13, 2024 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> > > > On Mon, Aug 12, 2024 at 1:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > The fcntl's F_SETOWN command sets the process that handle SIGIO/S=
IGURG
> > > > > for the related file descriptor.  Before this change, the
> > > > > file_set_fowner LSM hook was used to store this information.  How=
ever,
> > > > > there are three issues with this approach:
> > > > >
> > > > > - Because security_file_set_fowner() only get one argument, all h=
ook
> > > > >   implementations ignore the VFS logic which may not actually cha=
nge the
> > > > >   process that handles SIGIO (e.g. TUN, TTY, dnotify).
> > > > >
> > > > > - Because security_file_set_fowner() is called before f_modown() =
without
> > > > >   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could re=
sult to
> > > > >   a race condition and inconsistent LSM states (e.g. SELinux's fo=
wn_sid)
> > > > >   compared to struct fown_struct's UID/EUID.
> > > > >
> > > > > - Because the current hook implementations does not use explicit =
atomic
> > > > >   operations, they may create inconsistencies.  It would help to
> > > > >   completely remove this constraint, as well as the requirements =
of the
> > > > >   RCU read-side critical section for the hook.
> > > > >
> > > > > Fix these issues by replacing f_owner.uid and f_owner.euid with a=
 new
> > > > > f_owner.cred [1].  This also saves memory by removing dedicated L=
SM
> > > > > blobs, and simplifies code by removing file_set_fowner hook
> > > > > implementations for SELinux and Smack.
> > > > >
> > > > > This changes enables to remove the smack_file_alloc_security
> > > > > implementation, Smack's file blob, and SELinux's
> > > > > file_security_struct->fown_sid field.
> > > > >
> > > > > As for the UID/EUID, f_owner.cred is not always updated.  Move th=
e
> > > > > file_set_fowner hook to align with the VFS semantic.  This hook d=
oes not
> > > > > have user anymore [2].
> > > > >
> > > > > Before this change, f_owner's UID/EUID were initialized to zero
> > > > > (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is n=
ow
> > > > > initialized with the file descriptor creator's credentials (i.e.
> > > > > file->f_cred), which is more consistent and simplifies LSMs logic=
.  The
> > > > > sigio_perm()'s semantic does not need any change because SIGIO/SI=
GURG
> > > > > are only sent when a process is explicitly set with __f_setown().
> > > > >
> > > > > Rename f_modown() to __f_setown() to simplify code.
> > > > >
> > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > Cc: James Morris <jmorris@namei.org>
> > > > > Cc: Jann Horn <jannh@google.com>
> > > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-=
b039dbc6ce82@brauner [1]
> > > > > Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=3D_e=
iUikRDW2sUDSN3c=3DgVQw@mail.gmail.com [2]
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > ---
> > > > >
> > > > > Changes since v1:
> > > > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.ne=
t
> > > > > - Add back the file_set_fowner hook (but without user) as
> > > > >   requested by Paul, but move it for consistency.
> > > > > ---
> > > > >  fs/fcntl.c                        | 42 +++++++++++++++----------=
------
> > > > >  fs/file_table.c                   |  3 +++
> > > > >  include/linux/fs.h                |  2 +-
> > > > >  security/security.c               |  5 +++-
> > > > >  security/selinux/hooks.c          | 22 +++-------------
> > > > >  security/selinux/include/objsec.h |  1 -
> > > > >  security/smack/smack.h            |  6 -----
> > > > >  security/smack/smack_lsm.c        | 39 +------------------------=
---
> > > > >  8 files changed, 33 insertions(+), 87 deletions(-)
> > > > >
> > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > index 300e5d9ad913..4217b66a4e99 100644
> > > > > --- a/fs/fcntl.c
> > > > > +++ b/fs/fcntl.c
> > > > > @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, un=
signed int arg)
> > > > >         return error;
> > > > >  }
> > > > >
> > > > > -static void f_modown(struct file *filp, struct pid *pid, enum pi=
d_type type,
> > > > > -                     int force)
> > > > > +void __f_setown(struct file *filp, struct pid *pid, enum pid_typ=
e type,
> > > > > +               int force)
> > > > >  {
> > > > >         write_lock_irq(&filp->f_owner.lock);
> > > > >         if (force || !filp->f_owner.pid) {
> > > > > @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struc=
t pid *pid, enum pid_type type,
> > > > >                 filp->f_owner.pid_type =3D type;
> > > > >
> > > > >                 if (pid) {
> > > > > -                       const struct cred *cred =3D current_cred(=
);
> > > > > -                       filp->f_owner.uid =3D cred->uid;
> > > > > -                       filp->f_owner.euid =3D cred->euid;
> > > > > +                       security_file_set_fowner(filp);
> > > > > +                       put_cred(rcu_replace_pointer(
> > > > > +                               filp->f_owner.cred,
> > > > > +                               get_cred_rcu(current_cred()),
> > > > > +                               lockdep_is_held(&filp->f_owner.lo=
ck)));
> > > > >                 }
> > > > >         }
> > > > >         write_unlock_irq(&filp->f_owner.lock);
> > > > >  }
> > > >
> > > > Looking at this quickly, why can't we accomplish pretty much the sa=
me
> > > > thing by moving the security_file_set_fowner() into f_modown (as
> > > > you've done above) and leveraging the existing file->f_security fie=
ld
> > > > as Smack and SELinux do today?  I'm seeing a lot of churn to get a
> > > > cred pointer into fown_struct which doesn't seem to offer that much
> > > > additional value.
> > >
> > > As explained in the commit message, this patch removes related LSM
> > > (sub)blobs because they are duplicates of what's referenced by the ne=
w
> > > f_owner.cred, which is a more generic approach and saves memory.
> >
> > That's not entirely correct.  While yes you do remove the need for a
> > Smack entry in file->f_security, there is still a need for the SELinux
> > entry in file->f_security no matter what you do, and since the LSM
> > framework handles the LSM security blob allocations, on systems where
> > SELinux is enabled you are going to do a file->f_security allocation
> > regardless.
>
> That's why I used "(sub)" blob, for the case of SELinux that "only" drop
> a field.

Your choice of phrasing was misleading in my opinion.

> > While a cred based approach may be more generic from a traditional
> > UID/GID/etc. perspective, file->f_security is always going to be more
> > generic from a LSM perspective as the LSM has more flexibility about
> > what is placed into that blob.  Yes, the LSM can also place data into
> > the cred struct, but that is used across a wide variety of kernel
> > objects and placing file specific data in there could needlessly
> > increase the size of the cred struct.
>
> Yes, it could, but that is not the case with the current implementations
> (SELinux and Smack). I understand that it could be useful though.

Please keep that last sentence in mind.

> > > > From what I can see this seems really focused on adding a cred
> > > > reference when it isn't clear an additional one is needed.  If a ne=
w
> > > > cred reference *is* needed, please provide an explanation as to why=
;
> > > > reading the commit description this isn't clear.  Of course, if I'm
> > > > mistaken, feel free to correct me, although I'm sure all the people=
 on
> > > > the Internet don't need to be told that ;)
> > >
> > > This is a more generic approach that saves memory, sticks to the VFS
> > > semantic, and removes code.  So I'd say it's a performance improvemen=
t
> >
> > Considering that additional cred gets/puts are needed I question if
> > there are actually any performance improvements; in some cases I
> > suspect the performance will actually be worse.  On SELinux enabled
> > systems you are still going to do the file->f_security allocation and
> > now you are going to add the cred management operations on top of
> > that.
>
> I was talking about the extra hook calls which are not needed.  The move
> of fown_struct ou of the file struct should limit any credential
> reference performance impact, and Mateusz said he is working on
> improving this part too.

I don't see how where the cred reference live will have any impact,
you still need to get and drop references which will have an impact.
There will always be something.

> > With the move in linux-next to pull fown_struct out of the file
> > struct, I suspect this is not as important as it once may have been.
>
> I was talking about the LSM blobs shrinking, which impacts all opened
> files, independently of moving fown_struct out of the file struct.  I
> think this is not negligible: 32 bits for SELinux + 64 bits for Smack +
> 64 bits for ongoing Landlock support =3D potentially 128 bits for each
> opened files.

I'm going to skip over the Landlock contribution as that isn't part of
the patchset and to the best of my knowledge that is still a work in
progress and not finalized.

You also forgot to add in the cost of the fown_struct->cred pointer.

I noticed you chose to do your count in bits, likely to make the
numbers look bigger (which is fair), I'm going to do my count in bytes
;) ... So we've got four bytes removed from the SELinux blob, and
eight bytes from the Smack blob, but we add back in another eight
bytes for the new cred pointer, making a net benefit of only four
bytes for each open file.  Considering my concerns around the loss of
flexibility at the LSM layer I don't see this as a worthwhile
tradeoff.

> > > it fixes the LSM/VFS inconsistency
> >
> > Simply moving the security_file_set_fowner() inside the lock protected
> > region should accomplish that too.  Unless you're talking about
> > something else?
>
> Yes, the moving the hook fixes that.
>
> > > it guarantees
> > > that the VFS semantic is always visible to each LSMs thanks to the us=
e
> > > of the same f_owner.cred
> >
> > The existing hooks are designed to make sure that the F_SETOWN
> > operation is visible to the LSM.
>
> This should not change the F_SETOWN case.  Am I missing something?

I don't know, you were talking about making sure the VFS semantics are
visible to the LSM and I was simply suggesting that the existing hooks
do that too.  To be honest, whatever point you are trying to make here
isn't very clear to me.

> > > and it avoids LSM mistakes (except if an LSM implements the now-usele=
ss hook).
> >
> > The only mistake I'm seeing is that the call into
> > security_file_set_fowner() is not in the lock protected region, and
> > that is easily corrected.  Forcing the LSM framework to reuse a cred
> > struct has the potential to restrict LSM security models which is
> > something we try very hard not to do.
>
> OK, but is the current approach (i.e. keep the LSM hook and reducing LSM
> blobs size) good for you?  What do you want me to remove from this
> patch?

I agree that the security_file_set_owner() hook needs to be moved.  I
disagree about the value in shifting the LSM framework over to a cred
reference which effectively abandons the existing hook.  My preference
would be to preserve the flexibility of the hook, but move it to the
protected lock location, and continue to leverage the file->f_security
blob as needed for any LSM state.

--=20
paul-moore.com

