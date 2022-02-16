Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EC4B9473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 00:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiBPXZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 18:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiBPXZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:25:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691742AAB34;
        Wed, 16 Feb 2022 15:25:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so2725736ejc.9;
        Wed, 16 Feb 2022 15:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8nMguw8+586rlhrHbAKDxkwrGMZhMjYDkRLZTvLtHs=;
        b=UXPPrFMr/1EjEJdjiaSXxI6w5/BvO9z3gx4teXuHC5WP42mwX6rlfmt8iWNlqsi1YQ
         5g8i9ctbSEpe5oH8/jyU7Ijj9Rrm+EKDEUwP486/vwWofrp1PYyMl+0w/9bceUFqcPY3
         FGYzu5vR6CGHMz87ECioPSYNKIR9+jQGwcfWxk/JKW+5v/0S3an6zS7nrHpm3t8M8V8s
         iwA3B+0AMngDJcBKVTZWZQ5slWYdQDGpy8+74IJ3t//QdSutKj8DkBf+lAq4PLZfupCv
         RjP1AMKkVG3SZKtY4lEbjtt0xdg8768N3xz2bNXZyx4g7OHelcacTDTPe6/N97vk0VTL
         Yh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8nMguw8+586rlhrHbAKDxkwrGMZhMjYDkRLZTvLtHs=;
        b=UYM4GOvF9IufJFBqfHnEEq2pGm9nFD3gTtCE2hT0lW9Tb3PbBbupSqzDl4MThB/sJQ
         En6TO2VmN/4jSYDZJMh8D1dF0o2uB4AIdYgYB7LMKq38ZMsD/kcjHue13QWk4wtqmNt2
         7jFodgJiaN4idHhk46ZT2+cEsm+5tfXJ4OqGgJa/Ra9TXTBfgvpG+0gVSy493nk4WLcL
         LKMSMHuuY4iPUKjrYnfuYUSWid9x8Hh325J5e1qHzJqdUSBKuHluxSvHQSlFcH+fzn6+
         C43VgwG2bRUDKYTIUVSJGyL2VtgVzBEDg9LIX+fihLM4thsBfYzT6zwKTq+40WePDXb6
         Nq8w==
X-Gm-Message-State: AOAM532h5AoXu+qaS2k33mlpp1jTjDvxDfenKO+2Zv4EEF3g4mOxXxkA
        aqjVLW8J6qVm8B7sMJcZb8djkxLlDxJBYh8TgfXDufVt
X-Google-Smtp-Source: ABdhPJxtF21ukqHfOZMSIaiWXkL4eQZJOxGYUIka65KoN/mSZ3+eLx1izvX0evkHnlkHhYZmmbHLHFh/uYBmvaKAToE=
X-Received: by 2002:a17:907:68f:b0:6cd:3843:508 with SMTP id
 wn15-20020a170907068f00b006cd38430508mr286111ejb.156.1645053934650; Wed, 16
 Feb 2022 15:25:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644809996.git.riteshh@linux.ibm.com> <a2dcc8dbedfd221b90ff02cdb0dfb3c6a7ef2ae9.1644809996.git.riteshh@linux.ibm.com>
In-Reply-To: <a2dcc8dbedfd221b90ff02cdb0dfb3c6a7ef2ae9.1644809996.git.riteshh@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 16 Feb 2022 15:25:23 -0800
Message-ID: <CAD+ocbzzUXJ7qk7Yx2NGuXVKOAKv0yyxo+95o5+6krcAsGmOpA@mail.gmail.com>
Subject: Re: [RFC 1/1] ext4: Improve fast_commit performance and scalability
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
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

Thanks for the patch Ritesh. Some questions / comments inlined:

On Sun, 13 Feb 2022 at 19:57, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
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
>  fs/ext4/fast_commit.c | 64 +++++++++++++++++++++++++++++++------------
>  fs/ext4/fast_commit.h |  1 +
>  3 files changed, 50 insertions(+), 17 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bcd3b9bf8069..25242648d8c9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1046,6 +1046,8 @@ struct ext4_inode_info {
>
>         /* Fast commit related info */
>
> +       /* For tracking dentry create updates */
> +       struct list_head i_fc_dilist;
The only case in which this list will have multiple entries if hard
links are created on this inode right? I think that's probably a very
rare scenario and we can just fallback to full commits. That might
simplify this patch a bit. Basically if you do that then fc_dentry
would directly store a pointer to the inode and the inode can store a
pointer to the "CREAT" fc_dentry object. That way we don't have to do
list traversals in fc_del and fc_commit. But barring a few fixes, what
you have here is fine too. So I'll leave it up to you to decide what
you want to do.
>         struct list_head i_fc_list;     /*
>                                          * inodes that need fast commit
>                                          * protected by sbi->s_fc_lock.
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 7964ee34e322..f2bee4cf5648 100644
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
> +       struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
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
> @@ -295,7 +298,26 @@ void ext4_fc_del(struct inode *inode)
>                 ext4_fc_wait_committing_inode(inode);
>                 goto restart;
>         }
> -       list_del_init(&ei->i_fc_list);
> +
> +       if (!list_empty(&ei->i_fc_list))
> +               list_del_init(&ei->i_fc_list);
> +
> +       /*
> +        * Since this inode is getting removed, let's also remove all FC
> +        * dentry create references, since it is not needed to log it anyways.
> +        */
> +       list_for_each_entry_safe(fc_dentry, fc_dentry_n, &ei->i_fc_dilist, fcd_dilist) {
> +               WARN_ON(fc_dentry->fcd_op != EXT4_FC_TAG_CREAT);
> +               list_del_init(&fc_dentry->fcd_list);
> +               list_del_init(&fc_dentry->fcd_dilist);
> +               spin_unlock(&sbi->s_fc_lock);
> +
> +               if (fc_dentry->fcd_name.name &&
> +                       fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> +                       kfree(fc_dentry->fcd_name.name);
> +               kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> +               return;
Shouldn't we continue and remove all nodes in ei->i_fc_dilist?
> +       }
>         spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
>  }
>
> @@ -427,7 +449,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>                 node->fcd_name.name = node->fcd_iname;
>         }
>         node->fcd_name.len = dentry->d_name.len;
> -
> +       INIT_LIST_HEAD(&node->fcd_dilist);
>         spin_lock(&sbi->s_fc_lock);
>         if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>                 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
> @@ -435,6 +457,18 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
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
> +       if (dentry_update->op == EXT4_FC_TAG_CREAT)
> +               list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
>         spin_unlock(&sbi->s_fc_lock);
>         mutex_lock(&ei->i_fc_lock);
>
> @@ -954,7 +988,7 @@ __releases(&sbi->s_fc_lock)
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
>         struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
>         struct inode *inode;
> -       struct ext4_inode_info *ei, *ei_n;
> +       struct ext4_inode_info *ei;
>         int ret;
>
>         if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN]))
> @@ -970,21 +1004,16 @@ __releases(&sbi->s_fc_lock)
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
> +               ei = list_entry(fc_dentry->fcd_dilist.next,
> +                               struct ext4_inode_info, i_fc_dilist);
I think we want "fc_dentry->fcd_ilist.prev" here right? We are
sequentially traversing all the nodes in the list from first to last.
Given that I think the inode is the prev of any node that you
encounter in the list.

- Harshad
> +               inode = &ei->vfs_inode;
> +               WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
> +
>                 spin_unlock(&sbi->s_fc_lock);
>
>                 /*
> @@ -1228,6 +1257,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
