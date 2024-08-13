Return-Path: <linux-fsdevel+bounces-25766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD309501F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C06B1C2194E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509518DF62;
	Tue, 13 Aug 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OTFC0ea9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6817B4FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543521; cv=none; b=RSJH2uDAkBqlns6l0yvzDzY0Emn7uyhtdcDbUEEEnkuOMNyYddqr5PQeDHZPP2T/n/JlBjNCsysx5U66Dai9SfXq7/uQ/qJ9oHLQmEYBL6iKaUpdHXpJ3Wn4NvM5cYEqhb9QpLLXLRC9ZBYrczVWwPEklwsUjwvG75QLPcmtv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543521; c=relaxed/simple;
	bh=mcVXGd7HEj3qie/WwvYJrS76ohzixIpRyTnktrmAATU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKf1A4rx3n8S21m+a088rt8ofvozDdzQ6QnJoREfOVKoV1cRPY/50xzRl5qFBctVZAJNEe9T136VI5/qfeT7kX2Rzrm+X/MvqMfYzyyerEQvSTzfvwu4+aWqJN/OClM2qAK2etUhOwvP00xa1tmrT3MDfpnm+xbYCRJcCy/f03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OTFC0ea9; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wjn7X6y2ZzDSX;
	Tue, 13 Aug 2024 12:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723543512;
	bh=4ouoaXjq3cssWM64uNKVrlNuRIEzdBnGbfaxp1fhKEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTFC0ea96KOVuNXqUg9PashAKp+Egn6zWk/QOCye+vFUNX0LRrPZ8MU/NninpLGzb
	 ++vK198kk9pGicr6j0vBkcqOUKb3lPT2liAlmBwZcBbfhLoDmenI9ShiNbojHVCYqj
	 VCguEmZILYGfE561ONQl3v/qGGk+OQGEbxUalaOo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wjn7W5lGDzKHQ;
	Tue, 13 Aug 2024 12:05:11 +0200 (CEST)
Date: Tue, 13 Aug 2024 12:05:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook
 inconsistencies
Message-ID: <20240813.la2Aiyico3lo@digikod.net>
References: <20240812174421.1636724-1-mic@digikod.net>
 <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> On Mon, Aug 12, 2024 at 1:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> > for the related file descriptor.  Before this change, the
> > file_set_fowner LSM hook was used to store this information.  However,
> > there are three issues with this approach:
> >
> > - Because security_file_set_fowner() only get one argument, all hook
> >   implementations ignore the VFS logic which may not actually change the
> >   process that handles SIGIO (e.g. TUN, TTY, dnotify).
> >
> > - Because security_file_set_fowner() is called before f_modown() without
> >   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could result to
> >   a race condition and inconsistent LSM states (e.g. SELinux's fown_sid)
> >   compared to struct fown_struct's UID/EUID.
> >
> > - Because the current hook implementations does not use explicit atomic
> >   operations, they may create inconsistencies.  It would help to
> >   completely remove this constraint, as well as the requirements of the
> >   RCU read-side critical section for the hook.
> >
> > Fix these issues by replacing f_owner.uid and f_owner.euid with a new
> > f_owner.cred [1].  This also saves memory by removing dedicated LSM
> > blobs, and simplifies code by removing file_set_fowner hook
> > implementations for SELinux and Smack.
> >
> > This changes enables to remove the smack_file_alloc_security
> > implementation, Smack's file blob, and SELinux's
> > file_security_struct->fown_sid field.
> >
> > As for the UID/EUID, f_owner.cred is not always updated.  Move the
> > file_set_fowner hook to align with the VFS semantic.  This hook does not
> > have user anymore [2].
> >
> > Before this change, f_owner's UID/EUID were initialized to zero
> > (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is now
> > initialized with the file descriptor creator's credentials (i.e.
> > file->f_cred), which is more consistent and simplifies LSMs logic.  The
> > sigio_perm()'s semantic does not need any change because SIGIO/SIGURG
> > are only sent when a process is explicitly set with __f_setown().
> >
> > Rename f_modown() to __f_setown() to simplify code.
> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-b039dbc6ce82@brauner [1]
> > Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com [2]
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >
> > Changes since v1:
> > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > - Add back the file_set_fowner hook (but without user) as
> >   requested by Paul, but move it for consistency.
> > ---
> >  fs/fcntl.c                        | 42 +++++++++++++++----------------
> >  fs/file_table.c                   |  3 +++
> >  include/linux/fs.h                |  2 +-
> >  security/security.c               |  5 +++-
> >  security/selinux/hooks.c          | 22 +++-------------
> >  security/selinux/include/objsec.h |  1 -
> >  security/smack/smack.h            |  6 -----
> >  security/smack/smack_lsm.c        | 39 +---------------------------
> >  8 files changed, 33 insertions(+), 87 deletions(-)
> >
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 300e5d9ad913..4217b66a4e99 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
> >         return error;
> >  }
> >
> > -static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> > -                     int force)
> > +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> > +               int force)
> >  {
> >         write_lock_irq(&filp->f_owner.lock);
> >         if (force || !filp->f_owner.pid) {
> > @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> >                 filp->f_owner.pid_type = type;
> >
> >                 if (pid) {
> > -                       const struct cred *cred = current_cred();
> > -                       filp->f_owner.uid = cred->uid;
> > -                       filp->f_owner.euid = cred->euid;
> > +                       security_file_set_fowner(filp);
> > +                       put_cred(rcu_replace_pointer(
> > +                               filp->f_owner.cred,
> > +                               get_cred_rcu(current_cred()),
> > +                               lockdep_is_held(&filp->f_owner.lock)));
> >                 }
> >         }
> >         write_unlock_irq(&filp->f_owner.lock);
> >  }
> 
> Looking at this quickly, why can't we accomplish pretty much the same
> thing by moving the security_file_set_fowner() into f_modown (as
> you've done above) and leveraging the existing file->f_security field
> as Smack and SELinux do today?  I'm seeing a lot of churn to get a
> cred pointer into fown_struct which doesn't seem to offer that much
> additional value.

As explained in the commit message, this patch removes related LSM
(sub)blobs because they are duplicates of what's referenced by the new
f_owner.cred, which is a more generic approach and saves memory.  That's
why the v1 entirely removed the LSM hook, which is now useless.

Also, f_modown() is renamed to __f_setown().

> 
> From what I can see this seems really focused on adding a cred
> reference when it isn't clear an additional one is needed.  If a new
> cred reference *is* needed, please provide an explanation as to why;
> reading the commit description this isn't clear.  Of course, if I'm
> mistaken, feel free to correct me, although I'm sure all the people on
> the Internet don't need to be told that ;)

This is a more generic approach that saves memory, sticks to the VFS
semantic, and removes code.  So I'd say it's a performance improvement,
it saves memory, it fixes the LSM/VFS inconsistency, it guarantees
that the VFS semantic is always visible to each LSMs thanks to the use
of the same f_owner.cred, and it avoids LSM mistakes (except if an LSM
implements the now-useless hook).

