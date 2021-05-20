Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B921389F67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhETIEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 04:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhETIEp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 04:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FFEB61001;
        Thu, 20 May 2021 08:03:21 +0000 (UTC)
Date:   Thu, 20 May 2021 10:03:18 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v4 3/3] audit: add OPENAT2 record to list how
Message-ID: <20210520080318.owvsvvhh5qdhyzhk@wittgenstein>
References: <cover.1621363275.git.rgb@redhat.com>
 <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 04:00:22PM -0400, Richard Guy Briggs wrote:
> Since the openat2(2) syscall uses a struct open_how pointer to communicate
> its parameters they are not usefully recorded by the audit SYSCALL record's
> four existing arguments.
> 
> Add a new audit record type OPENAT2 that reports the parameters in its
> third argument, struct open_how with fields oflag, mode and resolve.
> 
> The new record in the context of an event would look like:
> time->Wed Mar 17 16:28:53 2021
> type=PROCTITLE msg=audit(1616012933.531:184): proctitle=73797363616C6C735F66696C652F6F70656E617432002F746D702F61756469742D7465737473756974652D737641440066696C652D6F70656E617432
> type=PATH msg=audit(1616012933.531:184): item=1 name="file-openat2" inode=29 dev=00:1f mode=0100600 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> type=PATH msg=audit(1616012933.531:184): item=0 name="/root/rgb/git/audit-testsuite/tests" inode=25 dev=00:1f mode=040700 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> type=CWD msg=audit(1616012933.531:184): cwd="/root/rgb/git/audit-testsuite/tests"
> type=OPENAT2 msg=audit(1616012933.531:184): oflag=0100302 mode=0600 resolve=0xa
> type=SYSCALL msg=audit(1616012933.531:184): arch=c000003e syscall=437 success=yes exit=4 a0=3 a1=7ffe315f1c53 a2=7ffe315f1550 a3=18 items=2 ppid=528 pid=540 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyS0 ses=1 comm="openat2" exe="/root/rgb/git/audit-testsuite/tests/syscalls_file/openat2" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="testsuite-1616012933-bjAUcEPO"
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com
> ---
>  fs/open.c                  |  2 ++
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.h             |  2 ++
>  kernel/auditsc.c           | 18 +++++++++++++++++-
>  5 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..2a15bec0cf6d 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1235,6 +1235,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
>  	if (err)
>  		return err;
>  
> +	audit_openat2_how(&tmp);
> +
>  	/* O_LARGEFILE is only allowed for non-O_PATH. */
>  	if (!(tmp.flags & O_PATH) && force_o_largefile())
>  		tmp.flags |= O_LARGEFILE;
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 283bc91a6932..580a52caf16f 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -399,6 +399,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  				  const struct cred *old);
>  extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
> +extern void __audit_openat2_how(struct open_how *how);
>  extern void __audit_log_kern_module(char *name);
>  extern void __audit_fanotify(unsigned int response);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
> @@ -495,6 +496,12 @@ static inline void audit_mmap_fd(int fd, int flags)
>  		__audit_mmap_fd(fd, flags);
>  }
>  
> +static inline void audit_openat2_how(struct open_how *how)
> +{
> +	if (unlikely(!audit_dummy_context()))
> +		__audit_openat2_how(how);
> +}
> +
>  static inline void audit_log_kern_module(char *name)
>  {
>  	if (!audit_dummy_context())
> @@ -646,6 +653,9 @@ static inline void audit_log_capset(const struct cred *new,
>  static inline void audit_mmap_fd(int fd, int flags)
>  { }
>  
> +static inline void audit_openat2_how(struct open_how *how)
> +{ }
> +
>  static inline void audit_log_kern_module(char *name)
>  {
>  }
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index cd2d8279a5e4..67aea2370c6d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -118,6 +118,7 @@
>  #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
>  #define AUDIT_BPF		1334	/* BPF subsystem */
>  #define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
> +#define AUDIT_OPENAT2		1336	/* Record showing openat2 how args */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 1522e100fd17..c5af17905976 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -11,6 +11,7 @@
>  #include <linux/skbuff.h>
>  #include <uapi/linux/mqueue.h>
>  #include <linux/tty.h>
> +#include <uapi/linux/openat2.h> // struct open_how
>  
>  /* AUDIT_NAMES is the number of slots we reserve in the audit_context
>   * for saving names from getname().  If we get more names we will allocate
> @@ -185,6 +186,7 @@ struct audit_context {
>  			int			fd;
>  			int			flags;
>  		} mmap;
> +		struct open_how openat2;
>  		struct {
>  			int			argc;
>  		} execve;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 3f59ab209dfd..faf2485323a9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -76,7 +76,7 @@
>  #include <linux/fsnotify_backend.h>
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
> -#include <uapi/linux/openat2.h>
> +#include <uapi/linux/openat2.h> // struct open_how
>  
>  #include "audit.h"
>  
> @@ -1319,6 +1319,12 @@ static void show_special(struct audit_context *context, int *call_panic)
>  		audit_log_format(ab, "fd=%d flags=0x%x", context->mmap.fd,
>  				 context->mmap.flags);
>  		break;
> +	case AUDIT_OPENAT2:
> +		audit_log_format(ab, "oflag=0%llo mode=0%llo resolve=0x%llx",

Hm, should we maybe follow the struct member names for all entries, i.e.
replace s/oflag/flags? 

Otherwise
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> +				 context->openat2.flags,
> +				 context->openat2.mode,
> +				 context->openat2.resolve);
> +		break;
>  	case AUDIT_EXECVE:
>  		audit_log_execve_info(context, &ab);
>  		break;
> @@ -2549,6 +2555,16 @@ void __audit_mmap_fd(int fd, int flags)
>  	context->type = AUDIT_MMAP;
>  }
>  
> +void __audit_openat2_how(struct open_how *how)
> +{
> +	struct audit_context *context = audit_context();
> +
> +	context->openat2.flags = how->flags;
> +	context->openat2.mode = how->mode;
> +	context->openat2.resolve = how->resolve;
> +	context->type = AUDIT_OPENAT2;
> +}
> +
>  void __audit_log_kern_module(char *name)
>  {
>  	struct audit_context *context = audit_context();
> -- 
> 2.27.0
> 
