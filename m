Return-Path: <linux-fsdevel+bounces-28914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ADE970930
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80DAB21660
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9555176ADA;
	Sun,  8 Sep 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="F2aybbR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E387C8D7
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Sep 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725819617; cv=none; b=DM9A60NcJ8dAc0Qll9uzD2oPfIbJQfDWBHuD9JusrujNWVUp9TXNPe8EKcaYQo3gB6+61Eg+1Y5McpvcmkZ9lIdUJWtCjLGfXtbZp4Wvz9UqUeYF/hWdDR92OnGqMKsQPfy2yeYTonnz66NJJYwZ2M6Xl85T7lDHx609kBQycXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725819617; c=relaxed/simple;
	bh=gNKnIuGvVMJr191hD6VCownoEv1f54m/1RShTokZqUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugnmcqpa7dm0JP/5bBjwI4tiLsvpRAey+YpK9Rbuw0NivYtpGDeQbh50ZTP3hwNB5dw3IsqrSZbNAYaZm428+lkZUaJE8buD66Ot+V1oNUZnpiyc/LWx2HM0/bttbu8EzLGorkXOis1clOcWB9plaM4i4nMyzg6S6yC5BuIN45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=F2aybbR9; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X1yhM005Xzn4P;
	Sun,  8 Sep 2024 20:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1725819074;
	bh=nXI9xic4x3kUhmU/n/oTnixYiW2o/Ba+mWZgJ65FcYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2aybbR9SGRO8ntewsvTYFuHGvAUHrhTiLBB/jRK1/tkv4vPCc+/z+dcy1Fzwh98K
	 h8Ldft3UX4SPDXPe0qt22j+0PNrLPVgH4fvDqcSjzyuzHoDQmAVbGsLM9CpwGZ7gy7
	 loxmwtN9/Hw7IBhxZB2PN6qlA9udH6kKLaD+ydOU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X1yhK3qYJzggS;
	Sun,  8 Sep 2024 20:11:13 +0200 (CEST)
Date: Sun, 8 Sep 2024 20:11:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
Message-ID: <20240908.jeim4Aif3Fee@digikod.net>
References: <20240821095609.365176-1-mic@digikod.net>
 <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 21, 2024 at 12:32:17PM -0400, Paul Moore wrote:
> On Wed, Aug 21, 2024 at 5:56 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> > for the related file descriptor.  Before this change, the
> > file_set_fowner LSM hook was always called, ignoring the VFS logic which
> > may not actually change the process that handles SIGIO (e.g. TUN, TTY,
> > dnotify), nor update the related UID/EUID.
> >
> > Moreover, because security_file_set_fowner() was called without lock
> > (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a race
> > condition and inconsistent LSM states (e.g. SELinux's fown_sid) compared
> > to struct fown_struct's UID/EUID.
> >
> > This change makes sure the LSM states are always in sync with the VFS
> > state by moving the security_file_set_fowner() call close to the
> > UID/EUID updates and using the same f_owner.lock .
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
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >
> > Changes since v2:
> > https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> > - Only keep the LSM hook move.
> >
> > Changes since v1:
> > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > - Add back the file_set_fowner hook (but without user) as
> >   requested by Paul, but move it for consistency.
> > ---
> >  fs/fcntl.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> This looks reasonable to me, and fixes a potential problem with
> existing LSMs.  Unless I hear any strong objections I'll plan to merge
> this, and patch 2/2, into the LSM tree tomorrow.

I didn't see these patches in -next, did I miss something?
Landlock will use this hook really soon and it would make it much easier
if these patches where upstream before.

> 
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 300e5d9ad913..c28dc6c005f1 100644
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
> > @@ -98,19 +98,13 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> >
> >                 if (pid) {
> >                         const struct cred *cred = current_cred();
> > +                       security_file_set_fowner(filp);
> >                         filp->f_owner.uid = cred->uid;
> >                         filp->f_owner.euid = cred->euid;
> >                 }
> >         }
> >         write_unlock_irq(&filp->f_owner.lock);
> >  }
> > -
> > -void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> > -               int force)
> > -{
> > -       security_file_set_fowner(filp);
> > -       f_modown(filp, pid, type, force);
> > -}
> >  EXPORT_SYMBOL(__f_setown);
> >
> >  int f_setown(struct file *filp, int who, int force)
> > @@ -146,7 +140,7 @@ EXPORT_SYMBOL(f_setown);
> >
> >  void f_delown(struct file *filp)
> >  {
> > -       f_modown(filp, NULL, PIDTYPE_TGID, 1);
> > +       __f_setown(filp, NULL, PIDTYPE_TGID, 1);
> >  }
> >
> >  pid_t f_getown(struct file *filp)
> > --
> > 2.46.0
> 
> -- 
> paul-moore.com
> 

