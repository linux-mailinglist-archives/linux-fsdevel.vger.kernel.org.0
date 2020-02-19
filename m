Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BDB163A4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 03:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgBSCgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 21:36:22 -0500
Received: from mail.hallyn.com ([178.63.66.53]:49514 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgBSCgW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:36:22 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id E304F1090; Tue, 18 Feb 2020 20:36:19 -0600 (CST)
Date:   Tue, 18 Feb 2020 20:36:19 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 07/25] proc: task_state(): use from_kfs{g,u}id_munged
Message-ID: <20200219023619.GE19144@mail.hallyn.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-8-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143411.2389182-8-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:33:53PM +0100, Christian Brauner wrote:
> If fsid mappings have been written, this will cause proc to look at fsid
> mappings for the user namespace. If no fsid mappings have been written the
> behavior is as before.
> 
> Here is part of the output from /proc/<pid>/status from the initial user
> namespace for systemd running in an unprivileged container as user namespace
> root with id mapping 0 100000 100000 and fsid mapping 0 300000 100000:
> 
> Name:   systemd
> Umask:  0000
> State:  S (sleeping)
> Tgid:   13023
> Ngid:   0
> Pid:    13023
> PPid:   13008
> TracerPid:      0
> Uid:    100000  100000  100000  300000
> Gid:    100000  100000  100000  300000
> FDSize: 64
> Groups:
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
> /* v2 */
> unchanged
> 
> /* v3 */
> unchanged
> ---
>  fs/proc/array.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 5efaf3708ec6..d4a04f85a67e 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -91,6 +91,7 @@
>  #include <linux/string_helpers.h>
>  #include <linux/user_namespace.h>
>  #include <linux/fs_struct.h>
> +#include <linux/fsuidgid.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> @@ -193,11 +194,11 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
>  	seq_put_decimal_ull(m, "\nUid:\t", from_kuid_munged(user_ns, cred->uid));
>  	seq_put_decimal_ull(m, "\t", from_kuid_munged(user_ns, cred->euid));
>  	seq_put_decimal_ull(m, "\t", from_kuid_munged(user_ns, cred->suid));
> -	seq_put_decimal_ull(m, "\t", from_kuid_munged(user_ns, cred->fsuid));
> +	seq_put_decimal_ull(m, "\t", from_kfsuid_munged(user_ns, cred->fsuid));
>  	seq_put_decimal_ull(m, "\nGid:\t", from_kgid_munged(user_ns, cred->gid));
>  	seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->egid));
>  	seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->sgid));
> -	seq_put_decimal_ull(m, "\t", from_kgid_munged(user_ns, cred->fsgid));
> +	seq_put_decimal_ull(m, "\t", from_kfsgid_munged(user_ns, cred->fsgid));
>  	seq_put_decimal_ull(m, "\nFDSize:\t", max_fds);
>  
>  	seq_puts(m, "\nGroups:\t");
> -- 
> 2.25.0
