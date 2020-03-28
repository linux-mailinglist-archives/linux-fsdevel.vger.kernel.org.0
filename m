Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D1196972
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 22:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgC1VXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 17:23:47 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:56566 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgC1VXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:23:46 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id A2501209BD;
        Sat, 28 Mar 2020 21:23:41 +0000 (UTC)
Date:   Sat, 28 Mar 2020 22:23:36 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 4/9] proc: instantiate only pids that we can ptrace
 on 'hidepid=4' mount option
Message-ID: <20200328212336.zyj5naxz4jc64tgp@comp-core-i7-2640m-0182e6>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-5-gladkov.alexey@gmail.com>
 <202003281336.8354DB74@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281336.8354DB74@keescook>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sat, 28 Mar 2020 21:23:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:40:03PM -0700, Kees Cook wrote:
> On Fri, Mar 27, 2020 at 06:23:26PM +0100, Alexey Gladkov wrote:
> > If "hidepid=4" mount option is set then do not instantiate pids that
> > we can not ptrace. "hidepid=4" means that procfs should only contain
> > pids that the caller can ptrace.
> > 
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> > Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  fs/proc/base.c          | 15 +++++++++++++++
> >  fs/proc/root.c          | 13 ++++++++++---
> >  include/linux/proc_fs.h |  1 +
> >  3 files changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 43a28907baf9..1ebe9eba48ea 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -701,6 +701,14 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
> >  				 struct task_struct *task,
> >  				 int hide_pid_min)
> >  {
> > +	/*
> > +	 * If 'hidpid' mount option is set force a ptrace check,
> > +	 * we indicate that we are using a filesystem syscall
> > +	 * by passing PTRACE_MODE_READ_FSCREDS
> > +	 */
> > +	if (fs_info->hide_pid == HIDEPID_NOT_PTRACEABLE)
> > +		return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > +
> >  	if (fs_info->hide_pid < hide_pid_min)
> >  		return true;
> >  	if (in_group_p(fs_info->pid_gid))
> > @@ -3319,7 +3327,14 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
> >  	if (!task)
> >  		goto out;
> >  
> > +	/* Limit procfs to only ptraceable tasks */
> > +	if (fs_info->hide_pid == HIDEPID_NOT_PTRACEABLE) {
> > +		if (!has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS))
> > +			goto out_put_task;
> > +	}
> > +
> >  	result = proc_pid_instantiate(dentry, task, NULL);
> > +out_put_task:
> >  	put_task_struct(task);
> >  out:
> >  	return result;
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index 616e8976185c..62eae22403d2 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -47,6 +47,14 @@ static const struct fs_parameter_spec proc_fs_parameters[] = {
> >  	{}
> >  };
> >  
> > +static inline int valid_hidepid(unsigned int value)
> > +{
> > +	return (value == HIDEPID_OFF ||
> > +		value == HIDEPID_NO_ACCESS ||
> > +		value == HIDEPID_INVISIBLE ||
> > +		value == HIDEPID_NOT_PTRACEABLE);
> 
> This likely easier to do with a ...MAX value? i.e.
> 
> 	return (value < HIDEPID_OFF || value >= HIDEPID_MAX);
> 
> > +}
> > +
> >  static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  {
> >  	struct proc_fs_context *ctx = fc->fs_private;
> > @@ -63,10 +71,9 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  		break;
> >  
> >  	case Opt_hidepid:
> > +		if (!valid_hidepid(result.uint_32))
> > +			return invalf(fc, "proc: unknown value of hidepid.\n");
> >  		ctx->hidepid = result.uint_32;
> > -		if (ctx->hidepid < HIDEPID_OFF ||
> > -		    ctx->hidepid > HIDEPID_INVISIBLE)
> > -			return invalfc(fc, "hidepid value must be between 0 and 2.\n");
> >  		break;
> >  
> >  	default:
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index 7d852dbca253..21d19353fdc7 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -32,6 +32,7 @@ enum {
> >  	HIDEPID_OFF	  = 0,
> >  	HIDEPID_NO_ACCESS = 1,
> >  	HIDEPID_INVISIBLE = 2,
> > +	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
> 
> This isn't a bit field -- shouldn't this be "3"?
> 
> 	...
> 	HIDEPID_NOT_PTRACEABLE = 3,
> 	HIDEPID_MAX
> 
> etc?

I decided to choose 4 so that if later we need to be able to make a mask.
I am not sure that this parameter will not have values that cannot be used
together. Since now these parameters are becoming part of the public api,
I decided to add flexibility.

-- 
Rgrds, legion

