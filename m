Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E149146C14D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhLGRIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbhLGRIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:08:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585EC061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 09:04:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so30913171wrn.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 09:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8eF5Cm7NpdqCyk/v+5ozHvBNPRK3ZZovGuWeGlLnro=;
        b=GyZAIf7sxlpA27BvC5e9ZJbLsqMtDBz6rej2U4LCoYzmvO2ViNdqI1QjFFhifL4AbY
         GXcLogtZwAXDOMXAZdJBoNFn+BMI/jtmtzQ2OC63iCd9DXfiNX7Pg7sTPeNftBniSOU3
         fYk49pqCidTZ5Kjx/eh/v65mhIEUjSk6aK8S+mcEXBpoDwijkcXKzr7igUnKkOJJjU3O
         2AGV38OeiTlZXt15OxJKooPz5pTT/fctZ+1fSmov6/bDnWoLiIvrP1xNksRd6MoqVnmh
         xeqk1uQzRrDxVEDn35KGa2b6B9BG5pZ/brtT/zEPCY+lepyikgZkR7yGmLJrIH1vFXhU
         mWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8eF5Cm7NpdqCyk/v+5ozHvBNPRK3ZZovGuWeGlLnro=;
        b=GKGkFRwi/abSgR3duhHAHPbVRxRSNajuBkAEdzahMfs4Bp8oALmmN4x3ttYY9KyWzi
         YzAIfdN+m+sniJ4sArEyn+VVAE8AwPeb/Qxl9CG0h6H8ZO8k+UCbDrHTo9imgZ64xXiw
         1YjC5rLqy75BhEcr6HyAD1SQ1csz+sFiefj/a1TD1bXG8KYacfSqanGH6W/dvJ3x8sg3
         TCAtHzUQuQ9Zv55S1O9+e0XdIO7OW5oTcF7AS0vvSP2/OODckUXiNh0DtXVTHS6Fues3
         WNj+lIIyjXN2LihLXddB08dqRjJH4rkZo4RSegNspDOnhUaqZa7n3Ntt5N6glGAV7BT9
         OF+g==
X-Gm-Message-State: AOAM5321EZ9XsvIOo3cIN/BHpP76gPZ0k7gPYzLW336gsV4CzyJ8PjTm
        KpXPv8uCMkvZNtOi7zNDyH1XwocyYCyMqg5JrdeZYQ==
X-Google-Smtp-Source: ABdhPJwIETaZPWETnwifeaLgE8/4vE84mq3whBqpCvFBTnHFeSusueUBDqgttIzMRNvh0UnWKTzCH7xVpDeMW14eukQ=
X-Received: by 2002:a05:6000:47:: with SMTP id k7mr51292153wrx.485.1638896681406;
 Tue, 07 Dec 2021 09:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20211206211219.3eff99c9@gandalf.local.home>
In-Reply-To: <20211206211219.3eff99c9@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 7 Dec 2021 09:04:30 -0800
Message-ID: <CAC_TJve8MMAv+H_NdLSJXZUSoxOEq2zB_pVaJ9p=7H6Bu3X76g@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracefs: Set all files to the same group ownership
 as the mount option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 6, 2021 at 6:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> As people have been asking to allow non-root processes to have access to
> the tracefs directory, it was considered best to only allow groups to have
> access to the directory, where it is easier to just set the tracefs file
> system to a specific group (as other would be too dangerous), and that way
> the admins could pick which processes would have access to tracefs.
>
> Unfortunately, this broke tooling on Android that expected the other bit
> to be set. For some special cases, for non-root tools to trace the system,
> tracefs would be mounted and change the permissions of the top level
> directory which gave access to all running tasks permission to the
> tracing directory. Even though this would be dangerous to do in a
> production environment, for testing environments this can be useful.
>
> Now with the new changes to not allow other (which is still the proper
> thing to do), it breaks the testing tooling. Now more code needs to be
> loaded on the system to change ownership of the tracing directory.
>
> The real solution is to have tracefs honor the gid=xxx option when
> mounting. That is,
>
> (tracing group tracing has value 1003)
>
>  mount -t tracefs -o gid=1003 tracefs /sys/kernel/tracing
>
> should have it that all files in the tracing directory should be of the
> given group.
>
> Copy the logic from d_walk() from dcache.c and simplify it for the mount
> case of tracefs if gid is set. All the files in tracefs will be walked and
> their group will be set to the value passed in.
>
> Reported-by: Kalesh Singh <kaleshsingh@google.com>
> Reported-by: Yabin Cui <yabinc@google.com>
> Fixes: 49d67e445742 ("tracefs: Have tracefs directories not set OTH permission bits by default")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>
>   I'm posting this as an RFC as I want to make sure this is the proper way
>   to handle this. It really makes sense. As tracefs is simply a file system
>   with a bunch of control knobs to control tracing, if you mount it with
>   gid=xxx then the control knobs should be controlled by group xxx.
>
>
>  fs/tracefs/inode.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 925a621b432e..f20f575cdaef 100644
> +++ b/fs/tracefs/inode.c
> @@ -161,6 +161,79 @@ struct tracefs_fs_info {
>         struct tracefs_mount_opts mount_opts;
>  };
>
> +static void change_gid(struct dentry *dentry, kgid_t gid)
> +{
> +       if (!dentry->d_inode)
> +               return;
> +       dentry->d_inode->i_gid = gid;
> +}
> +
> +/*
> + * Taken from d_walk, but without he need for handling renames.
> + * Nothing can be renamed while walking the list, as tracefs
> + * does not support renames. This is only called when mounting
> + * or remounting the file system, to set all the files to
> + * the given gid.
> + */

Hi Steve,

One thing that I missed before: There are files that can be generated
after the mount, for instance when a new synthetic event is added new
entries for that event are created under events/synthetic/ and when a
new instance is created the new entries generated under instances/.
These new entries don't honor the gid specified when mounting. Could
we make it so that they also respect the specified gid?

Thanks,
Kalesh

> +static void set_gid(struct dentry *parent, kgid_t gid)
> +{
> +       struct dentry *this_parent;
> +       struct list_head *next;
> +
> +       this_parent = parent;
> +       spin_lock(&this_parent->d_lock);
> +
> +       change_gid(this_parent, gid);
> +repeat:
> +       next = this_parent->d_subdirs.next;
> +resume:
> +       while (next != &this_parent->d_subdirs) {
> +               struct list_head *tmp = next;
> +               struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
> +               next = tmp->next;
> +
> +               spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> +
> +               change_gid(dentry, gid);
> +
> +               if (!list_empty(&dentry->d_subdirs)) {
> +                       spin_unlock(&this_parent->d_lock);
> +                       spin_release(&dentry->d_lock.dep_map, _RET_IP_);
> +                       this_parent = dentry;
> +                       spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
> +                       goto repeat;
> +               }
> +               spin_unlock(&dentry->d_lock);
> +       }
> +       /*
> +        * All done at this level ... ascend and resume the search.
> +        */
> +       rcu_read_lock();
> +ascend:
> +       if (this_parent != parent) {
> +               struct dentry *child = this_parent;
> +               this_parent = child->d_parent;
> +
> +               spin_unlock(&child->d_lock);
> +               spin_lock(&this_parent->d_lock);
> +
> +               /* go into the first sibling still alive */
> +               do {
> +                       next = child->d_child.next;
> +                       if (next == &this_parent->d_subdirs)
> +                               goto ascend;
> +                       child = list_entry(next, struct dentry, d_child);
> +               } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
> +               rcu_read_unlock();
> +               goto resume;
> +       }
> +       rcu_read_unlock();
> +
> +out_unlock:
> +       spin_unlock(&this_parent->d_lock);
> +       return;
> +}
> +
>  static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
>  {
>         substring_t args[MAX_OPT_ARGS];
> @@ -193,6 +266,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
>                         if (!gid_valid(gid))
>                                 return -EINVAL;
>                         opts->gid = gid;
> +                       set_gid(tracefs_mount->mnt_root, gid);
>                         break;
>                 case Opt_mode:
>                         if (match_octal(&args[0], &option))
> --
> 2.31.1
>
