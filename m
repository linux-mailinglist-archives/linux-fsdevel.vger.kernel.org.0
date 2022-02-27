Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E808C4C5E12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiB0S1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiB0S1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:27:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F164654AC;
        Sun, 27 Feb 2022 10:27:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so20622006ejc.8;
        Sun, 27 Feb 2022 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaITKqQlKs8Dvi2ka9raa9WBcouUiK4v4BMDrrJqDw4=;
        b=HBqcb3fGjb3E4pQ24a8lNOyTf9p+E6G11XvxVYGhxPMH5pnfcq6UVFjw7liw01JrDf
         hZak6G/ZrsN4GvGjYVchXE3XG1WJTowM7u3Y1gzOv9OCEb7av6AHkY+nV3zROAK0RhHF
         YBgOimexFN31lB21Q3gV+SOFE22BhR9tojlhcozUSaAoP3EqZVpT27wVeC0hzXb/1mGH
         BM6DH8z+PoHY6fYnRjE95PUIci0jiJcCGy5FdiH3m0nqRnrV6zY71qTzeGQhFv0wg4Rg
         ur+zSiHnJj833Dazj2FsDWlks3gNEIBX1ZHxtGtS0FqVHjB9y4cLgZ4rz6je74dgrQVW
         WK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaITKqQlKs8Dvi2ka9raa9WBcouUiK4v4BMDrrJqDw4=;
        b=rOyyv13LFOIZC8e3DlBYtXvfR0Q+YkmuZNgwObvZjtOjubrRlCPuKQPrB2rKYN4DzC
         kBfq9BYuHzv9hfNei7Osi0nyOFaQ2FN4hvF3Opq3wHsyyMRHjDENAw/+idRC9g4xxjyR
         IYxfNN/oFQrZBEzXJYwEMMGaVhfw3nxlCVZqUj1fjvi5CacZfHLFCtJ5mlYc2q7r9Sgx
         ZH/SDq4TtlXRF6YT8trnSBk9e5g19SWhe5FemJL5SWSOabma1dysas9BHO4vgWxaCk+Q
         Kb2KLZs+iByZfJ+qIF/lW291DNScYd3V3EvVfa12yCHmGHaRiMszj+Elxf7bvJ8hzkee
         GVjg==
X-Gm-Message-State: AOAM531TF9E20+6OjCuzHgLyni3q7xi1XGv0GmlwO54PqfsYVBWdLEh3
        j7Kfvu4zoCsSRlNSHugfmsh/QoyoBaiStSvfGss=
X-Google-Smtp-Source: ABdhPJwJr3k+eAYTKj+UYNv9fHc1MyIvbpdh/XVqa65wpoJglM4RNdZt/ZYgae87tn8RXaDiwsP7sIr2ENfQUvxH/WY=
X-Received: by 2002:a17:906:f1cf:b0:6ae:9992:484 with SMTP id
 gx15-20020a170906f1cf00b006ae99920484mr12810591ejb.607.1645986428701; Sun, 27
 Feb 2022 10:27:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645426817.git.riteshh@linux.ibm.com> <930f35d4fd5f83e2673c868781d9ebf15e91bf4e.1645426817.git.riteshh@linux.ibm.com>
In-Reply-To: <930f35d4fd5f83e2673c868781d9ebf15e91bf4e.1645426817.git.riteshh@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:26:57 -0800
Message-ID: <CAD+ocbx2YctY5AGUO0rj0JM4AUDG9MuZz_YJ4Yhdg9viL10rbg@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] ext4: Improve fast_commit performance and scalability
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modulo a minor nit, this looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

One high level observation - all other dentry operations (link /
unlink) require inode number (fc_dentry.fcd_ino), however create
operation requires the VFS inode. So, another way to handle this could
be to move `int fcd_ino` and `struct inode *fcd_inode` into a union
and based on the op type, use one of the two fields. That would also
handle the concern you raised on the previous version about handling
corner cases wrt fcd_ino.

That said, I don't feel too strongly about it. So, I think what you
have here is fine too.

- Harshad

On Sun, 20 Feb 2022 at 23:56, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> Currently ext4_fc_commit_dentry_updates() is of quadratic time
> complexity, which is causing performance bottlenecks with high
> threads/file/dir count with fs_mark.
>
> This patch makes commit dentry updates (and hence ext4_fc_commit()) path
> to linear time complexity. Hence improves the performance of workloads
> which does fsync on multiple threads/open files one-by-one.
>
> Absolute numbers in avg file creates per sec (from fs_mark in 1K order)
> =======================================================================
> no.     Order   without-patch(K)   with-patch(K)   Diff(%)
> 1       1        16.90              17.51           +3.60
> 2       2,2      32.08              31.80           -0.87
> 3       3,3      53.97              55.01           +1.92
> 4       4,4      78.94              76.90           -2.58
> 5       5,5      95.82              95.37           -0.46
> 6       6,6      87.92              103.38          +17.58
> 7       6,10      0.73              126.13          +17178.08
> 8       6,14      2.33              143.19          +6045.49
>
> workload type
> ==============
> For e.g. 7th row order of 6,10 (2^6 == 64 && 2^10 == 1024)
> echo /run/riteshh/mnt/{1..64} |sed -E 's/[[:space:]]+/ -d /g' \
>   | xargs -I {} bash -c "sudo fs_mark -L 100 -D 1024 -n 1024 -s0 -S5 -d {}"
>
> Perf profile
> (w/o patches)
> =============================
> 87.15%  [kernel]  [k] ext4_fc_commit           --> Heavy contention/bottleneck
>  1.98%  [kernel]  [k] perf_event_interrupt
>  0.96%  [kernel]  [k] power_pmu_enable
>  0.91%  [kernel]  [k] update_sd_lb_stats.constprop.0
>  0.67%  [kernel]  [k] ktime_get
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/ext4.h        |  2 ++
>  fs/ext4/fast_commit.c | 74 ++++++++++++++++++++++++++++++++-----------
>  fs/ext4/fast_commit.h |  1 +
>  3 files changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0d4f284c0514..3f87cca49f0c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1046,6 +1046,8 @@ struct ext4_inode_info {
>
>         /* Fast commit related info */
>
> +       /* For tracking dentry create updates */
> +       struct list_head i_fc_dilist;
>         struct list_head i_fc_list;     /*
>                                          * inodes that need fast commit
>                                          * protected by sbi->s_fc_lock.
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3c5baca38767..5ac594e03402 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -199,6 +199,7 @@ void ext4_fc_init_inode(struct inode *inode)
>         ext4_fc_reset_inode(inode);
>         ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
>         INIT_LIST_HEAD(&ei->i_fc_list);
> +       INIT_LIST_HEAD(&ei->i_fc_dilist);
>         init_waitqueue_head(&ei->i_fc_wait);
>         atomic_set(&ei->i_fc_updates, 0);
>  }
> @@ -279,6 +280,8 @@ void ext4_fc_stop_update(struct inode *inode)
>  void ext4_fc_del(struct inode *inode)
>  {
>         struct ext4_inode_info *ei = EXT4_I(inode);
> +       struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +       struct ext4_fc_dentry_update *fc_dentry;
>
>         if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
>             (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> @@ -286,7 +289,7 @@ void ext4_fc_del(struct inode *inode)
>
>  restart:
>         spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> -       if (list_empty(&ei->i_fc_list)) {
> +       if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
>                 spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
>                 return;
>         }
> @@ -295,8 +298,33 @@ void ext4_fc_del(struct inode *inode)
>                 ext4_fc_wait_committing_inode(inode);
>                 goto restart;
>         }
> -       list_del_init(&ei->i_fc_list);
> -       spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +
> +       if (!list_empty(&ei->i_fc_list))
> +               list_del_init(&ei->i_fc_list);
> +
> +       /*
> +        * Since this inode is getting removed, let's also remove all FC
> +        * dentry create references, since it is not needed to log it anyways.
> +        */
> +       if (list_empty(&ei->i_fc_dilist)) {
> +               spin_unlock(&sbi->s_fc_lock);
> +               return;
> +       }
> +
> +       fc_dentry = list_first_entry(&ei->i_fc_dilist, struct ext4_fc_dentry_update, fcd_dilist);
> +       WARN_ON(fc_dentry->fcd_op != EXT4_FC_TAG_CREAT);
> +       list_del_init(&fc_dentry->fcd_list);
> +       list_del_init(&fc_dentry->fcd_dilist);
> +
> +       WARN_ON(!list_empty(&ei->i_fc_dilist));
> +       spin_unlock(&sbi->s_fc_lock);
> +
> +       if (fc_dentry->fcd_name.name &&
> +               fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> +               kfree(fc_dentry->fcd_name.name);
> +       kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> +
> +       return;
(nit) Unnecessary return

>  }
>
>  /*
> @@ -427,7 +455,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>                 node->fcd_name.name = node->fcd_iname;
>         }
>         node->fcd_name.len = dentry->d_name.len;
> -
> +       INIT_LIST_HEAD(&node->fcd_dilist);
>         spin_lock(&sbi->s_fc_lock);
>         if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>                 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
> @@ -435,6 +463,20 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>                                 &sbi->s_fc_dentry_q[FC_Q_STAGING]);
>         else
>                 list_add_tail(&node->fcd_list, &sbi->s_fc_dentry_q[FC_Q_MAIN]);
> +
> +       /*
> +        * This helps us keep a track of all fc_dentry updates which is part of
> +        * this ext4 inode. So in case the inode is getting unlinked, before
> +        * even we get a chance to fsync, we could remove all fc_dentry
> +        * references while evicting the inode in ext4_fc_del().
> +        * Also with this, we don't need to loop over all the inodes in
> +        * sbi->s_fc_q to get the corresponding inode in
> +        * ext4_fc_commit_dentry_updates().
> +        */
> +       if (dentry_update->op == EXT4_FC_TAG_CREAT) {
> +               WARN_ON(!list_empty(&ei->i_fc_dilist));
> +               list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
> +       }
>         spin_unlock(&sbi->s_fc_lock);
>         mutex_lock(&ei->i_fc_lock);
>
> @@ -954,7 +996,7 @@ __releases(&sbi->s_fc_lock)
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
>         struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
>         struct inode *inode;
> -       struct ext4_inode_info *ei, *ei_n;
> +       struct ext4_inode_info *ei;
>         int ret;
>
>         if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN]))
> @@ -970,21 +1012,16 @@ __releases(&sbi->s_fc_lock)
>                         spin_lock(&sbi->s_fc_lock);
>                         continue;
>                 }
> -
> -               inode = NULL;
> -               list_for_each_entry_safe(ei, ei_n, &sbi->s_fc_q[FC_Q_MAIN],
> -                                        i_fc_list) {
> -                       if (ei->vfs_inode.i_ino == fc_dentry->fcd_ino) {
> -                               inode = &ei->vfs_inode;
> -                               break;
> -                       }
> -               }
>                 /*
> -                * If we don't find inode in our list, then it was deleted,
> -                * in which case, we don't need to record it's create tag.
> +                * With fcd_dilist we need not loop in sbi->s_fc_q to get the
> +                * corresponding inode pointer
>                  */
> -               if (!inode)
> -                       continue;
> +               WARN_ON(list_empty(&fc_dentry->fcd_dilist));
> +               ei = list_first_entry(&fc_dentry->fcd_dilist,
> +                               struct ext4_inode_info, i_fc_dilist);
> +               inode = &ei->vfs_inode;
> +               WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
> +
>                 spin_unlock(&sbi->s_fc_lock);
>
>                 /*
> @@ -1228,6 +1265,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>                                              struct ext4_fc_dentry_update,
>                                              fcd_list);
>                 list_del_init(&fc_dentry->fcd_list);
> +               list_del_init(&fc_dentry->fcd_dilist);
>                 spin_unlock(&sbi->s_fc_lock);
>
>                 if (fc_dentry->fcd_name.name &&
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 083ad1cb705a..02afa52e8e41 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -109,6 +109,7 @@ struct ext4_fc_dentry_update {
>         struct qstr fcd_name;   /* Dirent name */
>         unsigned char fcd_iname[DNAME_INLINE_LEN];      /* Dirent name string */
>         struct list_head fcd_list;
> +       struct list_head fcd_dilist;
>  };
>
>  struct ext4_fc_stats {
> --
> 2.31.1
>
