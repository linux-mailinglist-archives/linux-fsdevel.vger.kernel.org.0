Return-Path: <linux-fsdevel+bounces-18600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA88BAA65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EBC1F23180
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80B41514C8;
	Fri,  3 May 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYY7lLlo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76F14D2BC;
	Fri,  3 May 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730284; cv=none; b=cNOYjHQStLJmTzNt09eEauS4pxtyJ+dc7+UtUBtS7BSGZ261J3JA0p9q5XYELUWbEPa4g+Z+caohxgzKkGxFewGhjLS+qktlJEk1AGkWgawdtmd7apJnZpbUvbM0k4FqSRmLzf3tHDIpCssA7b+S25uG/PKEoLRZ3udquAQ392Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730284; c=relaxed/simple;
	bh=f8Mn/L/rPRgscXzOJ4TK13C7rdziWCwow2p/jHjIwJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixS8mChSbTcwJXZ2G3I/3Ixwh/CuyWn20xluJX2l0q/D077N/85mx2isnrskHMBDwEHGbWAARZxY5dV/IyJe5ldWCZ0EOJ2JuSdKlZO/Uje+SDxP2w3AJZH8qd8IyKqvcq/F0/qE3a/oAMEBtBj0IBg442c11uzomjAjYgAUdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYY7lLlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0249C116B1;
	Fri,  3 May 2024 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714730283;
	bh=f8Mn/L/rPRgscXzOJ4TK13C7rdziWCwow2p/jHjIwJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYY7lLlogB03mbGSB3SgN+WPEjR3akhQYsqOL/HAjXxgEOk1biLm7Gy4WYyr12fQF
	 1lG/DTrRz7WofC8yDi/4cYNplVMGXjuIkuJV7kRYFydEm+vzIC74uwoYa8qZ4RSZtX
	 Jf3+olxTYdYiKQh2ghqGXScHeUQaw/sjqLWqVl4uc6Kjk3TgESTReef9kcoQkgu1L3
	 CrirGXZxlKJQIdgmLFcuez6Xyri0pGyzHhKRJQOO/NWXOUpSsZ4q1d/FfvhIS3KCyD
	 8+Et9wTVudLQiYemszcf74rgyEa4hsYqZLwMQ982eXTmfcjnsqTbZlg35mxT3Hncir
	 MMy3qXrsZaQww==
Date: Fri, 3 May 2024 11:57:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, 
	ajordanr@google.com, jorgelo@chromium.org, Guenter Roeck <groeck@chromium.org>, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v3 1/2] proc: restrict /proc/pid/mem access via param
 knobs
Message-ID: <20240503-nulltarif-karten-82213463dedc@brauner>
References: <20240409175750.206445-1-adrian.ratiu@collabora.com>
 <202404261544.1EAD63D@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202404261544.1EAD63D@keescook>

On Fri, Apr 26, 2024 at 04:10:49PM -0700, Kees Cook wrote:
> On Tue, Apr 09, 2024 at 08:57:49PM +0300, Adrian Ratiu wrote:
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> > 
> > Afterwards exploits started causing drama like [1]. The exploits
> > using /proc/*/mem can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> > 
> > One of the well-known problems with /proc/*/mem writes is they
> > ignore page permissions via FOLL_FORCE, as opposed to writes via
> > process_vm_writev which respect page permissions. These writes can
> > also be used to bypass mode bits.
> > 
> > To harden against these types of attacks, distrbutions might want
> > to restrict /proc/pid/mem accesses, either entirely or partially,
> > for eg. to restrict FOLL_FORCE usage.
> > 
> > Known valid use-cases which still need these accesses are:
> > 
> > * Debuggers which also have ptrace permissions, so they can access
> > memory anyway via PTRACE_POKEDATA & co. Some debuggers like GDB
> > are designed to write /proc/pid/mem for basic functionality.
> > 
> > * Container supervisors using the seccomp notifier to intercept
> > syscalls and rewrite memory of calling processes by passing
> > around /proc/pid/mem file descriptors.
> > 
> > There might be more, that's why these params default to disabled.
> > 
> > Regarding other mechanisms which can block these accesses:
> > 
> > * seccomp filters can be used to block mmap/mprotect calls with W|X
> > perms, but they often can't block open calls as daemons want to
> > read/write their runtime state and seccomp filters cannot check
> > file paths, so plain write calls can't be easily blocked.
> > 
> > * Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> > 
> > * SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case one layer fails.
> > 
> > Thus we introduce three kernel parameters to restrict /proc/*/mem
> > access: read, write and foll_force. All three can be independently
> > set to the following values:
> > 
> > all     => restrict all access unconditionally.
> > ptracer => restrict all access except for ptracer processes.
> > 
> > If left unset, the existing behaviour is preserved, i.e. access
> > is governed by basic file permissions.
> > 
> > Examples which can be passed by bootloaders:
> > 
> > restrict_proc_mem_foll_force=all
> > restrict_proc_mem_write=ptracer
> > restrict_proc_mem_read=ptracer
> > 
> > Each distribution needs to decide what restrictions to apply,
> > depending on its use-cases. Embedded systems might want to do
> > more, while general-purpouse distros might want a more relaxed
> > policy, because for e.g. foll_force=all and write=all both break
> > break GDB, so it might be a bit excessive.
> > 
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> 
> Thanks for this new version!
> 
> > 
> > Link: https://lwn.net/Articles/476947/ [1]
> > Link: https://issues.chromium.org/issues/40089045 [2]
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  27 +++++
> >  fs/proc/base.c                                | 103 +++++++++++++++++-
> >  include/linux/jump_label.h                    |   5 +
> >  3 files changed, 133 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6e62b8cb19c8d..d7f7db41369c7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5665,6 +5665,33 @@
> >  	reset_devices	[KNL] Force drivers to reset the underlying device
> >  			during initialization.
> >  
> > +	restrict_proc_mem_read= [KNL]
> > +			Format: {all | ptracer}
> > +			Allows restricting read access to /proc/*/mem files.
> > +			Depending on restriction level, open for reads return -EACCESS.
> > +			Can be one of:
> > +			- 'all' restricts all access unconditionally.
> > +			- 'ptracer' allows access only for ptracer processes.
> > +			If not specified, then basic file permissions continue to apply.
> > +
> > +	restrict_proc_mem_write= [KNL]
> > +			Format: {all | ptracer}
> > +			Allows restricting write access to /proc/*/mem files.
> > +			Depending on restriction level, open for writes return -EACCESS.
> > +			Can be one of:
> > +			- 'all' restricts all access unconditionally.
> > +			- 'ptracer' allows access only for ptracer processes.
> > +			If not specified, then basic file permissions continue to apply.
> > +
> > +	restrict_proc_mem_foll_force= [KNL]
> > +			Format: {all | ptracer}
> > +			Restricts the use of the FOLL_FORCE flag for /proc/*/mem access.
> > +			If restricted, the FOLL_FORCE flag will not be added to vm accesses.
> > +			Can be one of:
> > +			- 'all' restricts all access unconditionally.
> > +			- 'ptracer' allows access only for ptracer processes.
> > +			If not specified, FOLL_FORCE is always used.
> 
> bike shedding: I wonder if this should be a fake namespace (adding a dot
> just to break it up for reading more easily), and have words reordered
> to the kernel's more common subject-verb-object: proc_mem.restrict_read=...
> 
> > +
> >  	resume=		[SWSUSP]
> >  			Specify the partition device for software suspend
> >  			Format:
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 18550c071d71c..c733836c42a65 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -152,6 +152,41 @@ struct pid_entry {
> >  		NULL, &proc_pid_attr_operations,	\
> >  		{ .lsmid = LSMID })
> >  
> > +/*
> > + * each restrict_proc_mem_* param controls the following static branches:
> > + * key[0] = restrict all writes
> > + * key[1] = restrict writes except for ptracers
> > + * key[2] = restrict all reads
> > + * key[3] = restrict reads except for ptracers
> > + * key[4] = restrict all FOLL_FORCE usage
> > + * key[5] = restrict FOLL_FORCE usage except for ptracers
> > + */
> > +DEFINE_STATIC_KEY_ARRAY_FALSE_RO(restrict_proc_mem, 6);
> 
> So, I don't like having open-coded numbers. And I'm not sure there's a
> benefit to stuffing these all into an array? So:
> 
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_read);
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_write);
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_foll_force);
> 
> > +
> > +static int __init early_restrict_proc_mem(char *buf, int offset)
> > +{
> > +	if (!buf)
> > +		return -EINVAL;
> > +
> > +	if (strncmp(buf, "all", 3) == 0)
> 
> I'd use strcmp() to get exact matches. That way "allalksdjflas" doesn't
> match. :)
> 
> > +		static_branch_enable(&restrict_proc_mem[offset]);
> > +	else if (strncmp(buf, "ptracer", 7) == 0)
> > +		static_branch_enable(&restrict_proc_mem[offset + 1]);
> > +
> > +	return 0;
> > +}
> 
> Then don't bother with a common helper since you've got a macro, and
> it'll all get tossed after __init anyway.
> 
> > +
> > +#define DEFINE_EARLY_RESTRICT_PROC_MEM(name, offset)			\
> > +static int __init early_restrict_proc_mem_##name(char *buf)		\
> > +{									\
> > +	return early_restrict_proc_mem(buf, offset);			\
> > +}									\
> > +early_param("restrict_proc_mem_" #name, early_restrict_proc_mem_##name)
> > +
> > +DEFINE_EARLY_RESTRICT_PROC_MEM(write, 0);
> > +DEFINE_EARLY_RESTRICT_PROC_MEM(read, 2);
> > +DEFINE_EARLY_RESTRICT_PROC_MEM(foll_force, 4);
> 
> #define DEFINE_EARLY_PROC_MEM_RESTRICT(name)				\
> static int __init early_proc_mem_restrict_##name(char *buf)		\
> {									\
> 	if (!buf)							\
> 		return -EINVAL;						\
> 									\
> 	if (strcmp(buf, "all") == 0)					\
> 		static_branch_enable(&proc_mem_restrict_##name);	\
> 	else if (strcmp(buf, "ptracer") == 0)				\
> 		static_branch_enable(&proc_mem_restrict_##name);	\
> 									\
> 	return 0;							\
> }									\
> early_param("proc_mem_restrict_" #name, early_proc_mem_restrict_##name)
> 
> 
> > +
> >  /*
> >   * Count the number of hardlinks for the pid_entry table, excluding the .
> >   * and .. links.
> > @@ -825,9 +860,58 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> >  	return 0;
> >  }
> >  
> > +static bool __mem_open_current_is_ptracer(struct file *file)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct task_struct *task = get_proc_task(inode);
> > +	int ret = false;
> > +
> > +	if (task) {
> > +		rcu_read_lock();
> > +		if (current == ptrace_parent(task))
> > +			ret = true;
> > +		rcu_read_unlock();
> > +		put_task_struct(task);
> > +	}
> 
> This creates a ToCToU race between this check (which releases the task)
> and the later memopen which make get a different task (and mm).
> 
> To deal with this, I think you need to add a new mode flag for
> proc_mem_open(), and add the checking there.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static int __mem_open_check_access_restriction(struct file *file)
> > +{
> > +	if (file->f_mode & FMODE_WRITE) {
> > +		/* Deny if writes are unconditionally disabled via param */
> > +		if (static_branch_unlikely(&restrict_proc_mem[0]))
> > +			return -EACCES;
> > +
> > +		/* Deny if writes are allowed only for ptracers via param */
> > +		if (static_branch_unlikely(&restrict_proc_mem[1]) &&
> > +		    !__mem_open_current_is_ptracer(file))
> > +			return -EACCES;
> > +
> > +	} else if (file->f_mode & FMODE_READ) {
> 
> I think this "else" means that O_RDWR opens will only check the write
> flag, so drop the "else".
> 
> > +		/* Deny if reads are unconditionally disabled via param */
> > +		if (static_branch_unlikely(&restrict_proc_mem[2]))
> > +			return -EACCES;
> > +
> > +		/* Deny if reads are allowed only for ptracers via param */
> > +		if (static_branch_unlikely(&restrict_proc_mem[3]) &&
> > +		    !__mem_open_current_is_ptracer(file))
> > +			return -EACCES;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mem_open(struct inode *inode, struct file *file)
> >  {
> > -	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> > +	int ret;
> > +
> > +	ret = __mem_open_check_access_restriction(file);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> >  
> >  	/* OK to pass negative loff_t, we can catch out-of-range */
> >  	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> > @@ -835,6 +919,20 @@ static int mem_open(struct inode *inode, struct file *file)
> >  	return ret;
> >  }
> >  
> > +static unsigned int __mem_rw_get_foll_force_flag(struct file *file)
> > +{
> > +	/* Deny if FOLL_FORCE is disabled via param */
> > +	if (static_branch_unlikely(&restrict_proc_mem[4]))
> > +		return 0;
> > +
> > +	/* Deny if FOLL_FORCE is allowed only for ptracers via param */
> > +	if (static_branch_unlikely(&restrict_proc_mem[5]) &&
> > +	    !__mem_open_current_is_ptracer(file))
> 
> This is like the ToCToU: the task may have changed out from under us
> between the open the read/write.

But why would you care? As long as the task is the ptracer it doesn't
really matter afaict.

