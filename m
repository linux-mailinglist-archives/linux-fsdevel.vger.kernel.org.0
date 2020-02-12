Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB315AB0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBLOeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:34:08 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:60116 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgBLOeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:34:08 -0500
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 940A0C61AB0;
        Wed, 12 Feb 2020 14:34:03 +0000 (UTC)
Date:   Wed, 12 Feb 2020 15:34:01 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
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
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v8 08/11] proc: instantiate only pids that we can ptrace
 on 'hidepid=4' mount option
Message-ID: <20200212143401.vjiqsdmf55e7wsdc@comp-core-i7-2640m-0182e6>
Mail-Followup-To: Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-9-gladkov.alexey@gmail.com>
 <aBJUaM4BeffJa3vj1p1rUZRN60LVv39CTN9ETLC-swk2b6CvAW8BbP6QbxK5zBGwSYOEiRgjE-auqdRo-pYXxhwuJ_h5rbZ9uyeFqLcLSJQ=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBJUaM4BeffJa3vj1p1rUZRN60LVv39CTN9ETLC-swk2b6CvAW8BbP6QbxK5zBGwSYOEiRgjE-auqdRo-pYXxhwuJ_h5rbZ9uyeFqLcLSJQ=@protonmail.ch>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:29:31PM +0000, Jordan Glover wrote:
> On Monday, February 10, 2020 3:05 PM, Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> 
> > If "hidepid=4" mount option is set then do not instantiate pids that
> > we can not ptrace. "hidepid=4" means that procfs should only contain
> > pids that the caller can ptrace.
> >
> > Cc: Kees Cook keescook@chromium.org
> > Cc: Andy Lutomirski luto@kernel.org
> > Signed-off-by: Djalal Harouni tixxdz@gmail.com
> > Signed-off-by: Alexey Gladkov gladkov.alexey@gmail.com
> >
> > fs/proc/base.c | 15 +++++++++++++++
> > fs/proc/root.c | 14 +++++++++++---
> > include/linux/proc_fs.h | 1 +
> > 3 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 24b7c620ded3..49937d54e745 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -699,6 +699,14 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
> > struct task_struct *task,
> > int hide_pid_min)
> > {
> >
> > -   /*
> > -   -   If 'hidpid' mount option is set force a ptrace check,
> > -   -   we indicate that we are using a filesystem syscall
> > -   -   by passing PTRACE_MODE_READ_FSCREDS
> > -   */
> > -   if (proc_fs_hide_pid(fs_info) == HIDEPID_NOT_PTRACABLE)
> > -         return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> >
> >
> > -   if (proc_fs_hide_pid(fs_info) < hide_pid_min)
> >     return true;
> >     if (in_group_p(proc_fs_pid_gid(fs_info)))
> >     @@ -3271,7 +3279,14 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
> >     if (!task)
> >     goto out;
> >
> > -   /* Limit procfs to only ptracable tasks */
> > -   if (proc_fs_hide_pid(fs_info) == HIDEPID_NOT_PTRACABLE) {
> > -         if (!has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS))
> >
> >
> > -         	goto out_put_task;
> >
> >
> > -   }
> > -   result = proc_pid_instantiate(dentry, task, NULL);
> >     +out_put_task:
> >     put_task_struct(task);
> >     out:
> >     return result;
> >     diff --git a/fs/proc/root.c b/fs/proc/root.c
> >     index e2bb015da1a8..5e27bb31f125 100644
> >     --- a/fs/proc/root.c
> >     +++ b/fs/proc/root.c
> >     @@ -52,6 +52,15 @@ static const struct fs_parameter_description proc_fs_parameters = {
> >     .specs = proc_param_specs,
> >     };
> >
> >     +static inline int
> >     +valid_hidepid(unsigned int value)
> >     +{
> >
> > -   return (value == HIDEPID_OFF ||
> > -         value == HIDEPID_NO_ACCESS ||
> >
> >
> > -         value == HIDEPID_INVISIBLE ||
> >
> >
> > -         value == HIDEPID_NOT_PTRACABLE);
> >
> >
> >
> > +}
> > +
> > static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > {
> > struct proc_fs_context *ctx = fc->fs_private;
> > @@ -68,10 +77,9 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > break;
> >
> > case Opt_hidepid:
> >
> > -         if (!valid_hidepid(result.uint_32))
> >
> >
> > -         	return invalf(fc, "proc: unknown value of hidepid.\\n");
> >           ctx->hidepid = result.uint_32;
> >
> >
> >
> > -         if (ctx->hidepid < HIDEPID_OFF ||
> >
> >
> > -             ctx->hidepid > HIDEPID_INVISIBLE)
> >
> >
> > -         	return invalf(fc, "proc: hidepid value must be between 0 and 2.\\n");
> >           break;
> >
> >
> >
> > default:
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index f307940f8311..6822548405a7 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -17,6 +17,7 @@ enum {
> > HIDEPID_OFF = 0,
> > HIDEPID_NO_ACCESS = 1,
> > HIDEPID_INVISIBLE = 2,
> >
> > -   HIDEPID_NOT_PTRACABLE = 4, /* Limit pids to only ptracable pids */
> 
> Is there a reason new option is "4" instead of "3"? The order 1..2..4 may be
> confusing for people.

This is just mask. For now hidepid values are mutually exclusive, but
since it moved to uapi, I thought it would be good if there was an
opportunity to combine values.

-- 
Rgrds, legion

