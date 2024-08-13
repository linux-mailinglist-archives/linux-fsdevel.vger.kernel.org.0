Return-Path: <linux-fsdevel+bounces-25815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B28950C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C5D1C21805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA71A4F10;
	Tue, 13 Aug 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rj1JXUnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FD1A3BBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573737; cv=none; b=M70RKlJNRuTbFQQjf0cuZpfj+lZ504ZgEuEjM548pNa5vLc98bKXitf8EjeSrgOZp39t77waGKwIKag0P9wYdhxBBS6SkKUHbnYidM0Yili1FJa6658o7Cf+DrdY2qTz9rdU2AZm2V6qqFPGT/A7h6F4sej4Jm2Yg6O07CeiNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573737; c=relaxed/simple;
	bh=xm1cqf5R06MuIpZRd1RteoO4ZigWyBv9Fo0mR/YSiuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRhlEXob/sNXEHcOWDisjkQJPA1g0SApDQk/rfr9+2t58f+1RrmiPvK0BJdUSP4xknoHceTnG8s9dd0KZtohyJq2TzgsrZ0xJf7KDa42zmfIwz8tKifqLhhv+yakbytn22aJT7wFg8LotNwt+nLF1TmVzkurlEb+pK7o+kAgd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rj1JXUnz; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wk0JW2CPpztSY;
	Tue, 13 Aug 2024 20:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723573723;
	bh=tVwpdZ57Rto++tHKPeBvT32p89UG/hGxOfM4Wm5DE3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rj1JXUnz+jjMX2r8ev+IcI5ky7kfWpG+DKFVJC7ScCSRwpKZV/J6tiqWbN2JUplfm
	 lc02JSTwEvLM5VnXjK7IfMKTEn1hbhe1Ojqv3geAfEc7hzBs/WBag7ajAvrsg25WZt
	 P4q7YexjEbvJdZGZkqDdPYhvgmSSj5eGJ9h5CRmc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wk0JT6xQYzPqX;
	Tue, 13 Aug 2024 20:28:41 +0200 (CEST)
Date: Tue, 13 Aug 2024 20:28:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook
 inconsistencies
Message-ID: <20240813.ideiNgoo1oob@digikod.net>
References: <20240812174421.1636724-1-mic@digikod.net>
 <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net>
 <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 13, 2024 at 11:04:13AM -0400, Paul Moore wrote:
> On Tue, Aug 13, 2024 at 6:05 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> > > On Mon, Aug 12, 2024 at 1:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> > > > for the related file descriptor.  Before this change, the
> > > > file_set_fowner LSM hook was used to store this information.  However,
> > > > there are three issues with this approach:
> > > >
> > > > - Because security_file_set_fowner() only get one argument, all hook
> > > >   implementations ignore the VFS logic which may not actually change the
> > > >   process that handles SIGIO (e.g. TUN, TTY, dnotify).
> > > >
> > > > - Because security_file_set_fowner() is called before f_modown() without
> > > >   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could result to
> > > >   a race condition and inconsistent LSM states (e.g. SELinux's fown_sid)
> > > >   compared to struct fown_struct's UID/EUID.
> > > >
> > > > - Because the current hook implementations does not use explicit atomic
> > > >   operations, they may create inconsistencies.  It would help to
> > > >   completely remove this constraint, as well as the requirements of the
> > > >   RCU read-side critical section for the hook.
> > > >
> > > > Fix these issues by replacing f_owner.uid and f_owner.euid with a new
> > > > f_owner.cred [1].  This also saves memory by removing dedicated LSM
> > > > blobs, and simplifies code by removing file_set_fowner hook
> > > > implementations for SELinux and Smack.
> > > >
> > > > This changes enables to remove the smack_file_alloc_security
> > > > implementation, Smack's file blob, and SELinux's
> > > > file_security_struct->fown_sid field.
> > > >
> > > > As for the UID/EUID, f_owner.cred is not always updated.  Move the
> > > > file_set_fowner hook to align with the VFS semantic.  This hook does not
> > > > have user anymore [2].
> > > >
> > > > Before this change, f_owner's UID/EUID were initialized to zero
> > > > (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is now
> > > > initialized with the file descriptor creator's credentials (i.e.
> > > > file->f_cred), which is more consistent and simplifies LSMs logic.  The
> > > > sigio_perm()'s semantic does not need any change because SIGIO/SIGURG
> > > > are only sent when a process is explicitly set with __f_setown().
> > > >
> > > > Rename f_modown() to __f_setown() to simplify code.
> > > >
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-b039dbc6ce82@brauner [1]
> > > > Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com [2]
> > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > ---
> > > >
> > > > Changes since v1:
> > > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > > - Add back the file_set_fowner hook (but without user) as
> > > >   requested by Paul, but move it for consistency.
> > > > ---
> > > >  fs/fcntl.c                        | 42 +++++++++++++++----------------
> > > >  fs/file_table.c                   |  3 +++
> > > >  include/linux/fs.h                |  2 +-
> > > >  security/security.c               |  5 +++-
> > > >  security/selinux/hooks.c          | 22 +++-------------
> > > >  security/selinux/include/objsec.h |  1 -
> > > >  security/smack/smack.h            |  6 -----
> > > >  security/smack/smack_lsm.c        | 39 +---------------------------
> > > >  8 files changed, 33 insertions(+), 87 deletions(-)
> > > >
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index 300e5d9ad913..4217b66a4e99 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
> > > >         return error;
> > > >  }
> > > >
> > > > -static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> > > > -                     int force)
> > > > +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> > > > +               int force)
> > > >  {
> > > >         write_lock_irq(&filp->f_owner.lock);
> > > >         if (force || !filp->f_owner.pid) {
> > > > @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> > > >                 filp->f_owner.pid_type = type;
> > > >
> > > >                 if (pid) {
> > > > -                       const struct cred *cred = current_cred();
> > > > -                       filp->f_owner.uid = cred->uid;
> > > > -                       filp->f_owner.euid = cred->euid;
> > > > +                       security_file_set_fowner(filp);
> > > > +                       put_cred(rcu_replace_pointer(
> > > > +                               filp->f_owner.cred,
> > > > +                               get_cred_rcu(current_cred()),
> > > > +                               lockdep_is_held(&filp->f_owner.lock)));
> > > >                 }
> > > >         }
> > > >         write_unlock_irq(&filp->f_owner.lock);
> > > >  }
> > >
> > > Looking at this quickly, why can't we accomplish pretty much the same
> > > thing by moving the security_file_set_fowner() into f_modown (as
> > > you've done above) and leveraging the existing file->f_security field
> > > as Smack and SELinux do today?  I'm seeing a lot of churn to get a
> > > cred pointer into fown_struct which doesn't seem to offer that much
> > > additional value.
> >
> > As explained in the commit message, this patch removes related LSM
> > (sub)blobs because they are duplicates of what's referenced by the new
> > f_owner.cred, which is a more generic approach and saves memory.
> 
> That's not entirely correct.  While yes you do remove the need for a
> Smack entry in file->f_security, there is still a need for the SELinux
> entry in file->f_security no matter what you do, and since the LSM
> framework handles the LSM security blob allocations, on systems where
> SELinux is enabled you are going to do a file->f_security allocation
> regardless.

That's why I used "(sub)" blob, for the case of SELinux that "only" drop
a field.

> 
> While a cred based approach may be more generic from a traditional
> UID/GID/etc. perspective, file->f_security is always going to be more
> generic from a LSM perspective as the LSM has more flexibility about
> what is placed into that blob.  Yes, the LSM can also place data into
> the cred struct, but that is used across a wide variety of kernel
> objects and placing file specific data in there could needlessly
> increase the size of the cred struct.

Yes, it could, but that is not the case with the current implementations
(SELinux and Smack). I understand that it could be useful though.

> 
> > > From what I can see this seems really focused on adding a cred
> > > reference when it isn't clear an additional one is needed.  If a new
> > > cred reference *is* needed, please provide an explanation as to why;
> > > reading the commit description this isn't clear.  Of course, if I'm
> > > mistaken, feel free to correct me, although I'm sure all the people on
> > > the Internet don't need to be told that ;)
> >
> > This is a more generic approach that saves memory, sticks to the VFS
> > semantic, and removes code.  So I'd say it's a performance improvement
> 
> Considering that additional cred gets/puts are needed I question if
> there are actually any performance improvements; in some cases I
> suspect the performance will actually be worse.  On SELinux enabled
> systems you are still going to do the file->f_security allocation and
> now you are going to add the cred management operations on top of
> that.

I was talking about the extra hook calls which are not needed.  The move
of fown_struct ou of the file struct should limit any credential
reference performance impact, and Mateusz said he is working on
improving this part too.

> 
> > it saves memory
> 
> With the move in linux-next to pull fown_struct out of the file
> struct, I suspect this is not as important as it once may have been.

I was talking about the LSM blobs shrinking, which impacts all opened
files, independently of moving fown_struct out of the file struct.  I
think this is not negligible: 32 bits for SELinux + 64 bits for Smack +
64 bits for ongoing Landlock support = potentially 128 bits for each
opened files.

> 
> > it fixes the LSM/VFS inconsistency
> 
> Simply moving the security_file_set_fowner() inside the lock protected
> region should accomplish that too.  Unless you're talking about
> something else?

Yes, the moving the hook fixes that.

> 
> > it guarantees
> > that the VFS semantic is always visible to each LSMs thanks to the use
> > of the same f_owner.cred
> 
> The existing hooks are designed to make sure that the F_SETOWN
> operation is visible to the LSM.

This should not change the F_SETOWN case.  Am I missing something?

> 
> > and it avoids LSM mistakes (except if an LSM implements the now-useless hook).
> 
> The only mistake I'm seeing is that the call into
> security_file_set_fowner() is not in the lock protected region, and
> that is easily corrected.  Forcing the LSM framework to reuse a cred
> struct has the potential to restrict LSM security models which is
> something we try very hard not to do.

OK, but is the current approach (i.e. keep the LSM hook and reducing LSM
blobs size) good for you?  What do you want me to remove from this
patch?

> 
> -- 
> paul-moore.com

