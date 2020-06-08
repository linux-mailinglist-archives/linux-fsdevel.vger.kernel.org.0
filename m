Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4571F1BA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgFHPEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgFHPEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:04:09 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEAC08C5C2;
        Mon,  8 Jun 2020 08:04:08 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c8so18999209iob.6;
        Mon, 08 Jun 2020 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKg092FM8nOBsMkoVGfOAuOoOxJvRFEOkDF1Wddgy1c=;
        b=I+tkp4GiKHrdiCOyXu4oNBzulEv0moonjmERLW2u2b/MhSFJvRNcFz1eylQ9+k3BAc
         mB5erpOVQqohtMP08ONvsuoIef0SN1Octpktf+yjojY5NGoUmnFBQHO5Xmmmf3iuyRaq
         8r+7AlF4+nHtwmAgMvZBd81ynqNM5+Tc+18uDCT9PyMcfDmHyKbbDNx/BEV48LezXCCK
         MOFQb4GJHzxYFlltzdTJb4iUemTy0s5RUFT+qcBsJuZkso+P84xTZ3eZbAgR92ATHhw+
         OozNi0x/ws4Xi99kaqxQZQAI9gQe7y1BQ0jxNm+VkcbSzvHTOAQozDyVJYCheUw5Jtwd
         XKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKg092FM8nOBsMkoVGfOAuOoOxJvRFEOkDF1Wddgy1c=;
        b=UlffUtCok5YP1KU18XBpC1Wg0jkFTjBPdWzHNrE7b2SDa9QIF2GtERbPlMacg+lwtF
         ZgOZoVnQEnqr9k6E2RpE7zZVrsYRb746ERKQ53u3JA9IBpsZdMCp2+XlWFHbeRLzXJD8
         QOMpOmjE8WWzzhIONAuKsmHFLHBrOuxCjMBoR5H6HvlRITKGYNTeqdUf05tWgg7v5JIk
         b7/JdiYTuhObQ47CNcpZCAQ+qRyH7CA+8nGYEJyY/LD+CVkyR/siXK7TcOM1YwbhYOE5
         pAcJ3Rz2pPszbZyonPqt8ovtsYsiF7deYSikYgWpcGdi73z+wIWdOVin7ND+x1CYeegF
         jl9A==
X-Gm-Message-State: AOAM531PB6IGXBMqKNbqqByzSQN+Itys5H2gufg/HHLlYT3wZ+W1CtUc
        B433bxxp7o+ppDe2uxOsWzrDY7lohLeszL9g6G4=
X-Google-Smtp-Source: ABdhPJyK+v0tWak5HsfxNui7cgsUn4EmrDiW6M5jmgP4ZFUNWcROVvTsF4mRb8R9+d7QjiRW/N0bMvmT0p17B7TXHyo=
X-Received: by 2002:a05:6638:a0a:: with SMTP id 10mr6959378jan.30.1591628647854;
 Mon, 08 Jun 2020 08:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200608140557.GG3127@techsingularity.net>
In-Reply-To: <20200608140557.GG3127@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 8 Jun 2020 18:03:56 +0300
Message-ID: <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 8, 2020 at 5:05 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The fsnotify paths are trivial to hit even when there are no watchers and
> they are surprisingly expensive. For example, every successful vfs_write()
> hits fsnotify_modify which calls both fsnotify_parent and fsnotify unless
> FMODE_NONOTIFY is set which is an internal flag invisible to userspace.
> As it stands, fsnotify_parent is a guaranteed functional call even if there
> are no watchers and fsnotify() does a substantial amount of unnecessary
> work before it checks if there are any watchers. A perf profile showed
> that applying mnt->mnt_fsnotify_mask in fnotify() was almost half of the
> total samples taken in that function during a test. This patch rearranges
> the fast paths to reduce the amount of work done when there are no watchers.
>
> The test motivating this was "perf bench sched messaging --pipe". Despite
> the fact the pipes are anonymous, fsnotify is still called a lot and
> the overhead is noticable even though it's completely pointless. It's
> likely the overhead is negligible for real IO so this is an extreme
> example. This is a comparison of hackbench using processes and pipes on
> a 1-socket machine with 8 CPU threads without fanotify watchers.
>
>                               5.7.0                  5.7.0
>                             vanilla      fastfsnotify-v1r1
> Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*
> Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)
> Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)
> Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)
> Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)
> Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)
> Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*
> Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)
> Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)
>
>                        5.7.0       5.7.0
>                      vanilla fastfsnotify-v1r1
> Duration User         157.05      152.79
> Duration System      1279.98     1219.32
> Duration Elapsed      182.81      174.52
>
> This is showing that the latencies are improved by roughly 2-9%. The
> variability is not shown but some of these results are within the noise
> as this workload heavily overloads the machine. That said, the system CPU
> usage is reduced by quite a bit so it makes sense to avoid the overhead
> even if it is a bit tricky to detect at times. A perf profile of just 1
> group of tasks showed that 5.14% of samples taken were in either fsnotify()
> or fsnotify_parent(). With the patch, 2.8% of samples were in fsnotify,
> mostly function entry and the initial check for watchers.  The check for
> watchers is complicated enough that inlining it may be controversial.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Hi Mel,

Thanks for looking into this

> ---
>  fs/notify/fsnotify.c             | 25 +++++++++++++++----------
>  include/linux/fsnotify.h         | 10 ++++++++++
>  include/linux/fsnotify_backend.h |  4 ++--
>  3 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 72d332ce8e12..de7bbfd973c0 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -143,7 +143,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  }
>
>  /* Notify this dentry's parent about a child's events. */
> -int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> +int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>                     int data_type)
>  {
>         struct dentry *parent;
> @@ -174,7 +174,7 @@ int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(fsnotify_parent);
> +EXPORT_SYMBOL_GPL(__fsnotify_parent);
>
>  static int send_to_group(struct inode *to_tell,
>                          __u32 mask, const void *data,
> @@ -315,17 +315,12 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
>         struct fsnotify_iter_info iter_info = {};
>         struct super_block *sb = to_tell->i_sb;
>         struct mount *mnt = NULL;
> -       __u32 mnt_or_sb_mask = sb->s_fsnotify_mask;
> +       __u32 mnt_or_sb_mask;
>         int ret = 0;
> -       __u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> +       __u32 test_mask;
>
> -       if (path) {
> +       if (path)
>                 mnt = real_mount(path->mnt);
> -               mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> -       }
> -       /* An event "on child" is not intended for a mount/sb mark */
> -       if (mask & FS_EVENT_ON_CHILD)
> -               mnt_or_sb_mask = 0;
>
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
> @@ -337,11 +332,21 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
>         if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
>             (!mnt || !mnt->mnt_fsnotify_marks))
>                 return 0;
> +
> +       /* An event "on child" is not intended for a mount/sb mark */
> +       mnt_or_sb_mask = 0;
> +       if (!(mask & FS_EVENT_ON_CHILD)) {
> +               mnt_or_sb_mask = sb->s_fsnotify_mask;
> +               if (path)
> +                       mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> +       }
> +

Are you sure that loading ->_fsnotify_mask is so much more expensive
than only checking ->_fsnotify_marks? They are surely on the same cache line.
Isn't it possible that you just moved the penalty to ->_fsnotify_marks check
with this change?
Did you test performance with just the fsnotify_parent() change alone?

In any case, this hunk seriously conflicts with a patch set I am working on,
so I would rather not merging this change as is.

If you provide me the feedback that testing ->_fsnotify_marks before loading
->_fsnotify_mask is beneficial on its own, then I will work this change into
my series.

>         /*
>          * if this is a modify event we may need to clear the ignored masks
>          * otherwise return if neither the inode nor the vfsmount/sb care about
>          * this type of event.
>          */
> +       test_mask = (mask & ALL_FSNOTIFY_EVENTS);
>         if (!(mask & FS_MODIFY) &&
>             !(test_mask & (to_tell->i_fsnotify_mask | mnt_or_sb_mask)))
>                 return 0;
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 5ab28f6c7d26..508f6bb0b06b 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -44,6 +44,16 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>         fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
>  }
>
> +/* Notify this dentry's parent about a child's events. */
> +static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
> +                                 const void *data, int data_type)
> +{
> +       if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> +               return 0;
> +
> +       return __fsnotify_parent(dentry, mask, data, data_type);
> +}
> +

This change looks good as is, but I'm afraid my series is going to
make it obsolete.
It may very well be that my series will introduce more performance
penalty to your workload.

It would be very much appreciated if you could run a test for me.
I will gladly work in some more optimizations into my series.

You can find the relevant part of my work at:
https://github.com/amir73il/linux/commits/fsnotify_name

What this work does essentially is two things:
1. Call backend once instead of twice when both inode and parent are
    watching.
2. Snapshot name and parent inode to pass to backend not only when
    parent is watching, but also when an sb/mnt mark exists which
    requests to get file names with events.

Compared to the existing implementation of fsnotify_parent(),
my code needs to also test bits in inode->i_fsnotify_mask,
inode->i_sb->s_fsnotify_mask and mnt->mnt_fsnotify_mask
before the fast path can be taken.
So its back to square one w.r.t your optimizations.

I could add the same optimization as in fsnotify() to check
->_fsnotify_marks before ->_fsnotify_mask if you can provide
me some concrete numbers.

Thanks,
Amir.
