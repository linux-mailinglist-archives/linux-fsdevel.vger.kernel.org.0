Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA4157FC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBJQ3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 11:29:42 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:25629 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBJQ3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:29:42 -0500
Date:   Mon, 10 Feb 2020 16:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1581352179;
        bh=HaQYFeP243+jZHqXubIy8pMTeQYphN87kh+Q8EfSCug=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=aETHlAlnvTvQPVmDanVXZ67C1YxDKkAcP3yUkwrXqtxF3lYAh74Px0kK8+8KcnPps
         M3875IFSBl/WF0/86G8k8Daw98k9L2ScMN+dO1yVlSOIXSPB+Ip+88T5TTPgApmJMp
         vBN+/dE0B1lhH/ssW8qk1W0TBhTeOSX5VJqbtuLc=
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
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
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v8 08/11] proc: instantiate only pids that we can ptrace on 'hidepid=4' mount option
Message-ID: <aBJUaM4BeffJa3vj1p1rUZRN60LVv39CTN9ETLC-swk2b6CvAW8BbP6QbxK5zBGwSYOEiRgjE-auqdRo-pYXxhwuJ_h5rbZ9uyeFqLcLSJQ=@protonmail.ch>
In-Reply-To: <20200210150519.538333-9-gladkov.alexey@gmail.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-9-gladkov.alexey@gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.3 required=7.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday, February 10, 2020 3:05 PM, Alexey Gladkov <gladkov.alexey@gmail.=
com> wrote:

> If "hidepid=3D4" mount option is set then do not instantiate pids that
> we can not ptrace. "hidepid=3D4" means that procfs should only contain
> pids that the caller can ptrace.
>
> Cc: Kees Cook keescook@chromium.org
> Cc: Andy Lutomirski luto@kernel.org
> Signed-off-by: Djalal Harouni tixxdz@gmail.com
> Signed-off-by: Alexey Gladkov gladkov.alexey@gmail.com
>
> fs/proc/base.c | 15 +++++++++++++++
> fs/proc/root.c | 14 +++++++++++---
> include/linux/proc_fs.h | 1 +
> 3 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 24b7c620ded3..49937d54e745 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -699,6 +699,14 @@ static bool has_pid_permissions(struct proc_fs_info =
*fs_info,
> struct task_struct *task,
> int hide_pid_min)
> {
>
> -   /*
> -   -   If 'hidpid' mount option is set force a ptrace check,
> -   -   we indicate that we are using a filesystem syscall
> -   -   by passing PTRACE_MODE_READ_FSCREDS
> -   */
> -   if (proc_fs_hide_pid(fs_info) =3D=3D HIDEPID_NOT_PTRACABLE)
> -         return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
>
>
> -   if (proc_fs_hide_pid(fs_info) < hide_pid_min)
>     return true;
>     if (in_group_p(proc_fs_pid_gid(fs_info)))
>     @@ -3271,7 +3279,14 @@ struct dentry *proc_pid_lookup(struct dentry *=
dentry, unsigned int flags)
>     if (!task)
>     goto out;
>
> -   /* Limit procfs to only ptracable tasks */
> -   if (proc_fs_hide_pid(fs_info) =3D=3D HIDEPID_NOT_PTRACABLE) {
> -         if (!has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS))
>
>
> -         =09goto out_put_task;
>
>
> -   }
> -   result =3D proc_pid_instantiate(dentry, task, NULL);
>     +out_put_task:
>     put_task_struct(task);
>     out:
>     return result;
>     diff --git a/fs/proc/root.c b/fs/proc/root.c
>     index e2bb015da1a8..5e27bb31f125 100644
>     --- a/fs/proc/root.c
>     +++ b/fs/proc/root.c
>     @@ -52,6 +52,15 @@ static const struct fs_parameter_description proc_=
fs_parameters =3D {
>     .specs =3D proc_param_specs,
>     };
>
>     +static inline int
>     +valid_hidepid(unsigned int value)
>     +{
>
> -   return (value =3D=3D HIDEPID_OFF ||
> -         value =3D=3D HIDEPID_NO_ACCESS ||
>
>
> -         value =3D=3D HIDEPID_INVISIBLE ||
>
>
> -         value =3D=3D HIDEPID_NOT_PTRACABLE);
>
>
>
> +}
> +
> static int proc_parse_param(struct fs_context *fc, struct fs_parameter *p=
aram)
> {
> struct proc_fs_context *ctx =3D fc->fs_private;
> @@ -68,10 +77,9 @@ static int proc_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
> break;
>
> case Opt_hidepid:
>
> -         if (!valid_hidepid(result.uint_32))
>
>
> -         =09return invalf(fc, "proc: unknown value of hidepid.\\n");
>           ctx->hidepid =3D result.uint_32;
>
>
>
> -         if (ctx->hidepid < HIDEPID_OFF ||
>
>
> -             ctx->hidepid > HIDEPID_INVISIBLE)
>
>
> -         =09return invalf(fc, "proc: hidepid value must be between 0 and=
 2.\\n");
>           break;
>
>
>
> default:
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index f307940f8311..6822548405a7 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -17,6 +17,7 @@ enum {
> HIDEPID_OFF =3D 0,
> HIDEPID_NO_ACCESS =3D 1,
> HIDEPID_INVISIBLE =3D 2,
>
> -   HIDEPID_NOT_PTRACABLE =3D 4, /* Limit pids to only ptracable pids */

Is there a reason new option is "4" instead of "3"? The order 1..2..4 may b=
e
confusing for people.

Jordan
