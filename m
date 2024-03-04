Return-Path: <linux-fsdevel+bounces-13475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F087038F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB362827A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29603F9F5;
	Mon,  4 Mar 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASVbVfeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA03F9CB;
	Mon,  4 Mar 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561162; cv=none; b=jRT53Vy2TdusBgsPNdFI25dwvtST3VJjbLsyd7jbHJ05OXghq/oLbgMVh/RK6UwPVTPXLfJ7ryGW4KiOF0RGsmX/9KBYOPLXJk4LnEtckCD3uJAsTKbc95P8u6myPKFMQOAQCh1JspHn74MPZHuL5KpdeU4c+5DWG41bO3Q/4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561162; c=relaxed/simple;
	bh=s1zQ71bLde/eKiV6DypERODOwCYcGUlkgXu0fdjnFB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2eeBEuiNCwAVQrCrJT6WX6w6ufNLRNSyvXJRLG6fN7dHawm8TMTxHJqSZV0/V3lT8SK16Y/htJ4pZ02XKNrubaGudnJlV4PlLqu//Rcrk+EqrlFjtnGIZ+CM2t+NkE0bGAJ19Oha8SdigZbk8GJw8bC1MgbrO/GTnq4ZQqQF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASVbVfeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81610C433C7;
	Mon,  4 Mar 2024 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709561161;
	bh=s1zQ71bLde/eKiV6DypERODOwCYcGUlkgXu0fdjnFB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASVbVfeBUX2kc+fQgsWLOBYMMk4uCVBFKDhLlkoXEXB7BtvDESGdut+IbP4D4ar0v
	 zwJld4LUHk8tTXgvC5eWqdpXP+iXBs5WoH/s1UUhKhWdc8H1e6tOrJK5t9EEL7fpZI
	 1v4KBEofRqOxh3TEazHmIu0QORmT3KjPEOzbovmhLU3kX2ev3m3kkSmRdpW1VX/IsT
	 3mFD+yY8J/7N9Z1MTU0X7XQnFEGSBlbElTMyDJEQk6LLcIJdTimxYgSBJpMSwpwFv3
	 C4GsS5a4UmssM/jKNl8x4xx1WivCXePeT5rzca3eCLrvoIZqRCjb9q1uYgnD/hCtFm
	 V4Q2ik2ppZxlw==
Date: Mon, 4 Mar 2024 15:05:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Guenter Roeck <groeck@chromium.org>, Doug Anderson <dianders@chromium.org>, 
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <20240304-legten-pelzmantel-1dca3659a892@brauner>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <39e47-65e5d100-1-5e37bd0@176022561>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39e47-65e5d100-1-5e37bd0@176022561>

On Mon, Mar 04, 2024 at 01:48:19PM +0000, Adrian Ratiu wrote:
> On Monday, March 04, 2024 15:20 EET, Christian Brauner <brauner@kernel.org> wrote:
> 
> > On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > "no longer a security hazard". :)
> > > 
> > > Afterwards exploits appeared started causing drama like [1]. The
> > > /proc/*/mem exploits can be rather sophisticated like [2] which
> > > installed an arbitrary payload from noexec storage into a running
> > > process then exec'd it, which itself could include an ELF loader
> > > to run arbitrary code off noexec storage.
> > > 
> > > As part of hardening against these types of attacks, distrbutions
> > > can restrict /proc/*/mem to only allow writes when they makes sense,
> > > like in case of debuggers which have ptrace permissions, as they
> > > are able to access memory anyway via PTRACE_POKEDATA and friends.
> > > 
> > > Dropping the mode bits disables write access for non-root users.
> > > Trying to `chmod` the paths back fails as the kernel rejects it.
> > > 
> > > For users with CAP_DAC_OVERRIDE (usually just root) we have to
> > > disable the mem_write callback to avoid bypassing the mode bits.
> > > 
> > > Writes can be used to bypass permissions on memory maps, even if a
> > > memory region is mapped r-x (as is a program's executable pages),
> > > the process can open its own /proc/self/mem file and write to the
> > > pages directly.
> > > 
> > > Even if seccomp filters block mmap/mprotect calls with W|X perms,
> > > they often cannot block open calls as daemons want to read/write
> > > their own runtime state and seccomp filters cannot check file paths.
> > > Write calls also can't be blocked in general via seccomp.
> > > 
> > > Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > > can't run chmod once at boot to restrict it (and trying to react
> > > to every process and run chmod doesn't scale, and the kernel no
> > > longer allows chmod on any of these paths).
> > > 
> > > SELinux could be used with a rule to cover all /proc/*/mem files,
> > > but even then having multiple ways to deny an attack is useful in
> > > case on layer fails.
> > > 
> > > [1] https://lwn.net/Articles/476947/
> > > [2] https://issues.chromium.org/issues/40089045
> > > 
> > > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> > > 
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > > ---
> > > Changes in v2:
> > >  * Added boot time parameter with default kconfig option
> > >  * Moved check earlier in mem_open() instead of mem_write()
> > >  * Simplified implementation branching
> > >  * Removed dependency on CONFIG_MEMCG
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  4 ++
> > >  fs/proc/base.c                                | 47 ++++++++++++++++++-
> > >  security/Kconfig                              | 22 +++++++++
> > >  3 files changed, 71 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 460b97a1d0da..0647e2f54248 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5618,6 +5618,10 @@
> > >  	reset_devices	[KNL] Force drivers to reset the underlying device
> > >  			during initialization.
> > >  
> > > +	restrict_proc_mem_write= [KNL]
> > > +			Enable or disable write access to /proc/*/mem files.
> > > +			Default is SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON.
> > > +
> > >  	resume=		[SWSUSP]
> > >  			Specify the partition device for software suspend
> > >  			Format:
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index 98a031ac2648..92f668191312 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -152,6 +152,30 @@ struct pid_entry {
> > >  		NULL, &proc_pid_attr_operations,	\
> > >  		{ .lsmid = LSMID })
> > >  
> > > +#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE
> > > +DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> > > +			   restrict_proc_mem_write);
> > > +static int __init early_restrict_proc_mem_write(char *buf)
> > > +{
> > > +	int ret;
> > > +	bool bool_result;
> > > +
> > > +	ret = kstrtobool(buf, &bool_result);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (bool_result)
> > > +		static_branch_enable(&restrict_proc_mem_write);
> > > +	else
> > > +		static_branch_disable(&restrict_proc_mem_write);
> > > +	return 0;
> > > +}
> > > +early_param("restrict_proc_mem_write", early_restrict_proc_mem_write);
> > > +# define PROC_PID_MEM_MODE S_IRUSR
> > > +#else
> > > +# define PROC_PID_MEM_MODE (S_IRUSR|S_IWUSR)
> > > +#endif
> > > +
> > >  /*
> > >   * Count the number of hardlinks for the pid_entry table, excluding the .
> > >   * and .. links.
> > > @@ -829,6 +853,25 @@ static int mem_open(struct inode *inode, struct file *file)
> > >  {
> > >  	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> > >  
> > > +#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE
> > > +	struct mm_struct *mm = file->private_data;
> > > +	struct task_struct *task = get_proc_task(inode);
> > > +
> > > +	if (mm && task) {
> > > +		/* Only allow writes by processes already ptracing the target task */
> > > +		if (file->f_mode & FMODE_WRITE &&
> > > +		    static_branch_maybe(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> > > +					&restrict_proc_mem_write)) {
> > > +			rcu_read_lock();
> > > +			if (!ptracer_capable(current, mm->user_ns) ||
> > > +			    current != ptrace_parent(task))
> > > +				ret = -EACCES;
> > 
> > Uhm, this will break the seccomp notifier, no? So you can't turn on
> > SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the seccomp
> > notifier to do system call interception and rewrite memory locations of
> > the calling task, no? Which is very much relied upon in various
> > container managers and possibly other security tools.
> > 
> > Which means that you can't turn this on in any of the regular distros.
> > 
> > So you need to either account for the calling task being a seccomp
> > supervisor for the task whose memory it is trying to access or you need
> > to provide a migration path by adding an api that let's caller's perform
> > these writes through the seccomp notifier.
> 
> Thanks for raising this!
> 
> I did test seccomp filtering/blocking functionality which seemed to
> work but I'll make sure to also test syscall interception before
> sending v3, to confirm whether it breaks.
> 
> The simplest solution is to add an exception for seccomp supervisors
> just like we did for tracers, yes, so I'm inclined to go with that if
> needed. :)

Ok. Note that your patch also doesn't cover process_vm_writev() which
means that you can still use that as an alternative to write to memory -
albeit with a lote more raciness. IOW, a seccomp notifier can do the
dance of:

pidfd = clone3(CLONE_PIDFD)
// handle error
int fd_mem = open("/proc/$pid/mem", O_RDWR);:
// handle error
if (pidfd_send_signal(pidfd, 0, ...) == 0)
        write(fd_mem, ...);

which lets it avoid the raciness. That's not possible with
process_vm_writev() especially if it's received via AF_UNIX sockets
which happens if the seccomp notifier lives in a proxy process. I know
that happens in the wild.

So overall, it seems a bit odd to me because why block /proc/<pid>/mem
specifically and not also cover process_vm_writev()? Because that's easy
to block via regular seccomp system call filtering?

