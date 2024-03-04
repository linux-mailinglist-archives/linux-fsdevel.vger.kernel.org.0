Return-Path: <linux-fsdevel+bounces-13501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C74870898
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DE228391A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350561674;
	Mon,  4 Mar 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LcNpUT5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652061690
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574573; cv=none; b=fwpxw2vWyLxfi/OWIUBI4XR9NVbA6n1R/pgoKcTp2sNBbkpbvmyi/LtkCKDKxB090KsU4HYIeKJWtzlnLDdbur2YHD67axOOjeZ7qeXCYpmODJLvOV1Jco910btR5rI/eqVmO+Gcm68/I6fQbmp3swIH0QarlyUBBcIgtRByQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574573; c=relaxed/simple;
	bh=zdTEaw9T7h7KKb/FCbMoa2+071RKeoxzQlinEWJBGng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj63LBEUtr1pPhDmH0rd/qMhTmXqOWi1i9hhprA166W/u5dYYse0qNOsvKhgV90HE8pf8/re4KDwhpMpgSvEVoHhXCE3EGHEvyZkR3xmVXRQ4PTtAvJEIVoFjvCuSfPRhOGdsyJVYqZ7LhnwkqnXiTlgt4ZJ856T5u2UnuiUbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LcNpUT5T; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd72353d9fso3264010b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 09:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709574570; x=1710179370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0OztaGbMZ7aWtS2y221bDuOAJINGRHlKVzLSgmVqyg=;
        b=LcNpUT5TeoYNki8Zo1dxogcA3T5Nh0Ektp+4BnLRlj02ZK6ZS2h8GzWSaEkH8blDqK
         Zi0xsQuNsc7tnJVTtLXkAKd33ZaMPFy8gcZCp3hymVCQUSfz47rIGko/HnxmmSVDTZBB
         KP5i2wuKgjreFX0cQkzLKjS6hMCZiV1eiClDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574570; x=1710179370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0OztaGbMZ7aWtS2y221bDuOAJINGRHlKVzLSgmVqyg=;
        b=bPd6mdBoJGM48xGPVz88JJxU4iaI52u853UXZHRQ1e/G2Tj8HvxwWIABdv0+GTl6Uu
         Jy8aqC6vasGliTrGGwdoa5O4GNb6W0XBjDygjs/a066Cwl0AcNFH4ghcIKCLsdWYQ662
         Y65c6SqeZfc/y3prUlC+Y+qsJUr/VoG1GfY6POnNjNo/V7cRz8pV+t16SkMEjtde99ho
         xtkNojo2y4D7dUvizOS4lQwZKl/oFonEtnO53hv0BTekjCSEz9I+eRaOXDtLxmiWSxBN
         cvj0hWkaVhbCTnEo/K7NughEEuYebw3iYynJM2Yx5ifUOBr6HQD0IocIYMvoemDQ+GV3
         lOCg==
X-Forwarded-Encrypted: i=1; AJvYcCVW/+E6rJJi3zD0auWu9obgbMaGieM7ZHjSpfbfAwqKz5Ozw+J0llPOXCMnBawpRmJ0B9A9LRURW92djKCGhQKQSfxcVZrc9SfVqfhZHw==
X-Gm-Message-State: AOJu0YxUqwxVo636pwvX74wU9J8EKurfm4KklNmEaUZftciFegl1bd4N
	8HKVrRT0WvyTKXSQPYN4X+bJBb9jWRcNIAga/39l4orxbUfvJFx7QBXlIhddvQ==
X-Google-Smtp-Source: AGHT+IE5UXzafgs5ZqOhhEOyHjqEtIZx5EQHovgLPO7CtySoq7EEdCLa6x1u5g847haF0Q6eFf/3Sw==
X-Received: by 2002:aca:1917:0:b0:3c1:f395:9d0f with SMTP id l23-20020aca1917000000b003c1f3959d0fmr1952140oii.45.1709574570326;
        Mon, 04 Mar 2024 09:49:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 3-20020a631543000000b005dcbb699abfsm7691281pgv.34.2024.03.04.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:49:29 -0800 (PST)
Date: Mon, 4 Mar 2024 09:49:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403040943.9545EBE5@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-zugute-abtragen-d499556390b3@brauner>

On Mon, Mar 04, 2024 at 02:20:22PM +0100, Christian Brauner wrote:
> On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> > 
> > Afterwards exploits appeared started causing drama like [1]. The
> > /proc/*/mem exploits can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> > 
> > As part of hardening against these types of attacks, distrbutions
> > can restrict /proc/*/mem to only allow writes when they makes sense,
> > like in case of debuggers which have ptrace permissions, as they
> > are able to access memory anyway via PTRACE_POKEDATA and friends.
> > 
> > Dropping the mode bits disables write access for non-root users.
> > Trying to `chmod` the paths back fails as the kernel rejects it.
> > 
> > For users with CAP_DAC_OVERRIDE (usually just root) we have to
> > disable the mem_write callback to avoid bypassing the mode bits.
> > 
> > Writes can be used to bypass permissions on memory maps, even if a
> > memory region is mapped r-x (as is a program's executable pages),
> > the process can open its own /proc/self/mem file and write to the
> > pages directly.
> > 
> > Even if seccomp filters block mmap/mprotect calls with W|X perms,
> > they often cannot block open calls as daemons want to read/write
> > their own runtime state and seccomp filters cannot check file paths.
> > Write calls also can't be blocked in general via seccomp.
> > 
> > Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> > 
> > SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case on layer fails.
> > 
> > [1] https://lwn.net/Articles/476947/
> > [2] https://issues.chromium.org/issues/40089045
> > 
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> > 
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
> > Changes in v2:
> >  * Added boot time parameter with default kconfig option
> >  * Moved check earlier in mem_open() instead of mem_write()
> >  * Simplified implementation branching
> >  * Removed dependency on CONFIG_MEMCG
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 ++
> >  fs/proc/base.c                                | 47 ++++++++++++++++++-
> >  security/Kconfig                              | 22 +++++++++
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 460b97a1d0da..0647e2f54248 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5618,6 +5618,10 @@
> >  	reset_devices	[KNL] Force drivers to reset the underlying device
> >  			during initialization.
> >  
> > +	restrict_proc_mem_write= [KNL]
> > +			Enable or disable write access to /proc/*/mem files.
> > +			Default is SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON.
> > +
> >  	resume=		[SWSUSP]
> >  			Specify the partition device for software suspend
> >  			Format:
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 98a031ac2648..92f668191312 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -152,6 +152,30 @@ struct pid_entry {
> >  		NULL, &proc_pid_attr_operations,	\
> >  		{ .lsmid = LSMID })
> >  
> > +#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE
> > +DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> > +			   restrict_proc_mem_write);
> > +static int __init early_restrict_proc_mem_write(char *buf)
> > +{
> > +	int ret;
> > +	bool bool_result;
> > +
> > +	ret = kstrtobool(buf, &bool_result);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (bool_result)
> > +		static_branch_enable(&restrict_proc_mem_write);
> > +	else
> > +		static_branch_disable(&restrict_proc_mem_write);
> > +	return 0;
> > +}
> > +early_param("restrict_proc_mem_write", early_restrict_proc_mem_write);
> > +# define PROC_PID_MEM_MODE S_IRUSR
> > +#else
> > +# define PROC_PID_MEM_MODE (S_IRUSR|S_IWUSR)
> > +#endif
> > +
> >  /*
> >   * Count the number of hardlinks for the pid_entry table, excluding the .
> >   * and .. links.
> > @@ -829,6 +853,25 @@ static int mem_open(struct inode *inode, struct file *file)
> >  {
> >  	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> >  
> > +#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE
> > +	struct mm_struct *mm = file->private_data;
> > +	struct task_struct *task = get_proc_task(inode);
> > +
> > +	if (mm && task) {
> > +		/* Only allow writes by processes already ptracing the target task */
> > +		if (file->f_mode & FMODE_WRITE &&
> > +		    static_branch_maybe(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> > +					&restrict_proc_mem_write)) {
> > +			rcu_read_lock();
> > +			if (!ptracer_capable(current, mm->user_ns) ||
> > +			    current != ptrace_parent(task))
> > +				ret = -EACCES;
> 
> Uhm, this will break the seccomp notifier, no? So you can't turn on
> SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the seccomp
> notifier to do system call interception and rewrite memory locations of
> the calling task, no? Which is very much relied upon in various
> container managers and possibly other security tools.
> 
> Which means that you can't turn this on in any of the regular distros.

FWIW, it's a run-time toggle, but yes, let's make sure this works
correctly.

> So you need to either account for the calling task being a seccomp
> supervisor for the task whose memory it is trying to access or you need
> to provide a migration path by adding an api that let's caller's perform
> these writes through the seccomp notifier.

How do seccomp supervisors that use USER_NOTIF do those kinds of
memory writes currently? I thought they were actually using ptrace?
Everything I'm familiar with is just using SECCOMP_IOCTL_NOTIF_ADDFD,
and not doing fancy memory pokes.

-Kees

-- 
Kees Cook

