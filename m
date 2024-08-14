Return-Path: <linux-fsdevel+bounces-25915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72AF951B14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D572802AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246834688;
	Wed, 14 Aug 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HNxHxsAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159A79D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639522; cv=none; b=k/qw6YHdOmT3B982Ppfob83RjCMFGxM32vSX51GeRqtWnJV0KHMMswlY52GUzqi0n7OHmvmMLzkzGhEICvDWptOUCnZ/vR0nZcGN/gt2UDQejI2ks57kJKykx+eM4RcDaRkH4RYUUewkVlVViZnkj58/6G4lmr4Ae8ydUGFH4ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639522; c=relaxed/simple;
	bh=EUsWXBn6t2w2Xsc6OaQ1DX6hfop4amCdqltG2xKXiSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwrzpSWowm/Ca+qDqEew+JMzVwEcBT+kc3zXaNszNs9JxkNYm/pcBkFvSmdTJjpC3myy8WXPfZTYZjJ4EGqcLIa2R4TvMDoowQNqhv618Dq+EUm0Q0W1AbhSN6naHFyBusiYUpyZEO2ZiB8bBIdQrCrqa+iUgIdF28Zmvv7YVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HNxHxsAI; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WkSQJ0pfLzVKF;
	Wed, 14 Aug 2024 14:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723638919;
	bh=vnCxUntYacIZIfiYYg8WFfGBgaaHSMZO+dkYJFcKRmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNxHxsAIrA8Ff8u3dcIPhfgYu2pnRrBU4n1gF5RkQeMLdCQC2z/HJ7Czs9kRdapvP
	 acrXydAEWnbThCUg/ZLFWt/HE29hiZtYHrtCJtda/rvpEjRI25T9Hnz1oXFtnnYxJ6
	 ZOGXXy4OvECayzR4JMELPDxoQgynPr8Kp3nREqj0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WkSQG199QzQNX;
	Wed, 14 Aug 2024 14:35:18 +0200 (CEST)
Date: Wed, 14 Aug 2024 14:35:12 +0200
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
Message-ID: <20240814.OiNg5geethah@digikod.net>
References: <20240812174421.1636724-1-mic@digikod.net>
 <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net>
 <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
 <20240813.ideiNgoo1oob@digikod.net>
 <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 13, 2024 at 07:39:45PM -0400, Paul Moore wrote:
> On Tue, Aug 13, 2024 at 2:28 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Aug 13, 2024 at 11:04:13AM -0400, Paul Moore wrote:
> > > On Tue, Aug 13, 2024 at 6:05 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> > > > > On Mon, Aug 12, 2024 at 1:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> > > > > > for the related file descriptor.  Before this change, the
> > > > > > file_set_fowner LSM hook was used to store this information.  However,
> > > > > > there are three issues with this approach:
> > > > > >
> > > > > > - Because security_file_set_fowner() only get one argument, all hook
> > > > > >   implementations ignore the VFS logic which may not actually change the
> > > > > >   process that handles SIGIO (e.g. TUN, TTY, dnotify).
> > > > > >
> > > > > > - Because security_file_set_fowner() is called before f_modown() without
> > > > > >   lock (e.g. f_owner.lock), concurrent F_SETOWN commands could result to
> > > > > >   a race condition and inconsistent LSM states (e.g. SELinux's fown_sid)
> > > > > >   compared to struct fown_struct's UID/EUID.
> > > > > >
> > > > > > - Because the current hook implementations does not use explicit atomic
> > > > > >   operations, they may create inconsistencies.  It would help to
> > > > > >   completely remove this constraint, as well as the requirements of the
> > > > > >   RCU read-side critical section for the hook.
> > > > > >
> > > > > > Fix these issues by replacing f_owner.uid and f_owner.euid with a new
> > > > > > f_owner.cred [1].  This also saves memory by removing dedicated LSM
> > > > > > blobs, and simplifies code by removing file_set_fowner hook
> > > > > > implementations for SELinux and Smack.
> > > > > >
> > > > > > This changes enables to remove the smack_file_alloc_security
> > > > > > implementation, Smack's file blob, and SELinux's
> > > > > > file_security_struct->fown_sid field.
> > > > > >
> > > > > > As for the UID/EUID, f_owner.cred is not always updated.  Move the
> > > > > > file_set_fowner hook to align with the VFS semantic.  This hook does not
> > > > > > have user anymore [2].
> > > > > >
> > > > > > Before this change, f_owner's UID/EUID were initialized to zero
> > > > > > (i.e. GLOBAL_ROOT_UID), but to simplify code, f_owner's cred is now
> > > > > > initialized with the file descriptor creator's credentials (i.e.
> > > > > > file->f_cred), which is more consistent and simplifies LSMs logic.  The
> > > > > > sigio_perm()'s semantic does not need any change because SIGIO/SIGURG
> > > > > > are only sent when a process is explicitly set with __f_setown().
> > > > > >
> > > > > > Rename f_modown() to __f_setown() to simplify code.
> > > > > >
> > > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > > Cc: James Morris <jmorris@namei.org>
> > > > > > Cc: Jann Horn <jannh@google.com>
> > > > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > > Link: https://lore.kernel.org/r/20240809-explosionsartig-ablesen-b039dbc6ce82@brauner [1]
> > > > > > Link: https://lore.kernel.org/r/CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com [2]
> > > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > > > ---
> > > > > >
> > > > > > Changes since v1:
> > > > > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > > > > - Add back the file_set_fowner hook (but without user) as
> > > > > >   requested by Paul, but move it for consistency.
> > > > > > ---
> > > > > >  fs/fcntl.c                        | 42 +++++++++++++++----------------
> > > > > >  fs/file_table.c                   |  3 +++
> > > > > >  include/linux/fs.h                |  2 +-
> > > > > >  security/security.c               |  5 +++-
> > > > > >  security/selinux/hooks.c          | 22 +++-------------
> > > > > >  security/selinux/include/objsec.h |  1 -
> > > > > >  security/smack/smack.h            |  6 -----
> > > > > >  security/smack/smack_lsm.c        | 39 +---------------------------
> > > > > >  8 files changed, 33 insertions(+), 87 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > > index 300e5d9ad913..4217b66a4e99 100644
> > > > > > --- a/fs/fcntl.c
> > > > > > +++ b/fs/fcntl.c
> > > > > > @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
> > > > > >         return error;
> > > > > >  }
> > > > > >
> > > > > > -static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> > > > > > -                     int force)
> > > > > > +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> > > > > > +               int force)
> > > > > >  {
> > > > > >         write_lock_irq(&filp->f_owner.lock);
> > > > > >         if (force || !filp->f_owner.pid) {
> > > > > > @@ -97,20 +97,15 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> > > > > >                 filp->f_owner.pid_type = type;
> > > > > >
> > > > > >                 if (pid) {
> > > > > > -                       const struct cred *cred = current_cred();
> > > > > > -                       filp->f_owner.uid = cred->uid;
> > > > > > -                       filp->f_owner.euid = cred->euid;
> > > > > > +                       security_file_set_fowner(filp);
> > > > > > +                       put_cred(rcu_replace_pointer(
> > > > > > +                               filp->f_owner.cred,
> > > > > > +                               get_cred_rcu(current_cred()),
> > > > > > +                               lockdep_is_held(&filp->f_owner.lock)));
> > > > > >                 }
> > > > > >         }
> > > > > >         write_unlock_irq(&filp->f_owner.lock);
> > > > > >  }
> > > > >
> > > > > Looking at this quickly, why can't we accomplish pretty much the same
> > > > > thing by moving the security_file_set_fowner() into f_modown (as
> > > > > you've done above) and leveraging the existing file->f_security field
> > > > > as Smack and SELinux do today?  I'm seeing a lot of churn to get a
> > > > > cred pointer into fown_struct which doesn't seem to offer that much
> > > > > additional value.
> > > >
> > > > As explained in the commit message, this patch removes related LSM
> > > > (sub)blobs because they are duplicates of what's referenced by the new
> > > > f_owner.cred, which is a more generic approach and saves memory.
> > >
> > > That's not entirely correct.  While yes you do remove the need for a
> > > Smack entry in file->f_security, there is still a need for the SELinux
> > > entry in file->f_security no matter what you do, and since the LSM
> > > framework handles the LSM security blob allocations, on systems where
> > > SELinux is enabled you are going to do a file->f_security allocation
> > > regardless.
> >
> > That's why I used "(sub)" blob, for the case of SELinux that "only" drop
> > a field.
> 
> Your choice of phrasing was misleading in my opinion.
> 
> > > While a cred based approach may be more generic from a traditional
> > > UID/GID/etc. perspective, file->f_security is always going to be more
> > > generic from a LSM perspective as the LSM has more flexibility about
> > > what is placed into that blob.  Yes, the LSM can also place data into
> > > the cred struct, but that is used across a wide variety of kernel
> > > objects and placing file specific data in there could needlessly
> > > increase the size of the cred struct.
> >
> > Yes, it could, but that is not the case with the current implementations
> > (SELinux and Smack). I understand that it could be useful though.
> 
> Please keep that last sentence in mind.
> 
> > > > > From what I can see this seems really focused on adding a cred
> > > > > reference when it isn't clear an additional one is needed.  If a new
> > > > > cred reference *is* needed, please provide an explanation as to why;
> > > > > reading the commit description this isn't clear.  Of course, if I'm
> > > > > mistaken, feel free to correct me, although I'm sure all the people on
> > > > > the Internet don't need to be told that ;)
> > > >
> > > > This is a more generic approach that saves memory, sticks to the VFS
> > > > semantic, and removes code.  So I'd say it's a performance improvement
> > >
> > > Considering that additional cred gets/puts are needed I question if
> > > there are actually any performance improvements; in some cases I
> > > suspect the performance will actually be worse.  On SELinux enabled
> > > systems you are still going to do the file->f_security allocation and
> > > now you are going to add the cred management operations on top of
> > > that.
> >
> > I was talking about the extra hook calls which are not needed.  The move
> > of fown_struct ou of the file struct should limit any credential
> > reference performance impact, and Mateusz said he is working on
> > improving this part too.
> 
> I don't see how where the cred reference live will have any impact,
> you still need to get and drop references which will have an impact.
> There will always be something.

I meant that if there is no fown_struct data, there is no extra
credential reference.

> 
> > > With the move in linux-next to pull fown_struct out of the file
> > > struct, I suspect this is not as important as it once may have been.
> >
> > I was talking about the LSM blobs shrinking, which impacts all opened
> > files, independently of moving fown_struct out of the file struct.  I
> > think this is not negligible: 32 bits for SELinux + 64 bits for Smack +
> > 64 bits for ongoing Landlock support = potentially 128 bits for each
> > opened files.
> 
> I'm going to skip over the Landlock contribution as that isn't part of
> the patchset and to the best of my knowledge that is still a work in
> progress and not finalized.
> 
> You also forgot to add in the cost of the fown_struct->cred pointer.

No because fown_struct.cred replaces fown_struct.uid and
fown_struct.euid

> 
> I noticed you chose to do your count in bits, likely to make the
> numbers look bigger (which is fair), I'm going to do my count in bytes

FWIW, I didn't write that with malice nor to make it look bigger.

> ;) ... So we've got four bytes removed from the SELinux blob, and
> eight bytes from the Smack blob, but we add back in another eight
> bytes for the new cred pointer, making a net benefit of only four
> bytes for each open file.  Considering my concerns around the loss of
> flexibility at the LSM layer I don't see this as a worthwhile
> tradeoff.

Considering that the uid and euid fields are removed, the net worth
would be 12 bytes, but is is much more than that taking into account the
move of fown_struct out of the file struct because the LSM blobs are per
file, not per fown_struct.

> 
> > > > it fixes the LSM/VFS inconsistency
> > >
> > > Simply moving the security_file_set_fowner() inside the lock protected
> > > region should accomplish that too.  Unless you're talking about
> > > something else?
> >
> > Yes, the moving the hook fixes that.
> >
> > > > it guarantees
> > > > that the VFS semantic is always visible to each LSMs thanks to the use
> > > > of the same f_owner.cred
> > >
> > > The existing hooks are designed to make sure that the F_SETOWN
> > > operation is visible to the LSM.
> >
> > This should not change the F_SETOWN case.  Am I missing something?
> 
> I don't know, you were talking about making sure the VFS semantics are
> visible to the LSM and I was simply suggesting that the existing hooks
> do that too.  To be honest, whatever point you are trying to make here
> isn't very clear to me.

The existing hooks does not reflect the VFS semantic because
of the `if (force || !filp->f_owner.pid)` checks in f_modown().
When f_modown() is explitly called from user space (F_SETOWN), force is
true, but that is not the case for all call sites (e.g. TUN, TTY,
dnotify).

> 
> > > > and it avoids LSM mistakes (except if an LSM implements the now-useless hook).
> > >
> > > The only mistake I'm seeing is that the call into
> > > security_file_set_fowner() is not in the lock protected region, and
> > > that is easily corrected.  Forcing the LSM framework to reuse a cred
> > > struct has the potential to restrict LSM security models which is
> > > something we try very hard not to do.
> >
> > OK, but is the current approach (i.e. keep the LSM hook and reducing LSM
> > blobs size) good for you?  What do you want me to remove from this
> > patch?
> 
> I agree that the security_file_set_owner() hook needs to be moved.  I
> disagree about the value in shifting the LSM framework over to a cred
> reference which effectively abandons the existing hook.  My preference
> would be to preserve the flexibility of the hook, but move it to the
> protected lock location, and continue to leverage the file->f_security
> blob as needed for any LSM state.
> 
> -- 
> paul-moore.com
> 

