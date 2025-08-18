Return-Path: <linux-fsdevel+bounces-58166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D206B2A4EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFC334E2719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BC340DA9;
	Mon, 18 Aug 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ljhdyG6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E831B13A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523291; cv=none; b=dxkrbyR1acBjM+kQJ+StlY2HW/lgSGFFVcu/nkc+SAvIFjwcU93LyJI0itAfHdH9BnQ9CfCRoz95RqXsoid5AP5Uudf2PyWlX4EI0ynEX4ssQN+Ph03VKqL03tV8hZIKb2g/gMromVQGG9zkXSBoAq1Tej+W8PZl7SHTZ72Ylmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523291; c=relaxed/simple;
	bh=qaO7/LW4nIZO2KsWkZ8fsW4pauRRDRk0RghLLFg/nFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN/dmZodToXGmJ4D9D1XGyW9G0K3htX4TdHp+f5D8tRhC4+zBU9Oy6ZUtBMugpnuUxCcTNJSmfA5ombKWQ3f29uWEydgAUcu3cliwGuYxHTQ0XRD6m4oEw+eLF27cJXJ538taIGQ4pdxxf4nDyHoxqBh1pXZlu0UKi69CUjz8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ljhdyG6r; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b1099192b0so68675591cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755523288; x=1756128088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9NwhuCMHlal4nfMZppJlQNqRgXzvfqaNLFUh/zX3Es=;
        b=ljhdyG6r6Y+5SowOQBrLYcSO+fgthy+a62dftPBNhB+fV/pgBO0bvzqq6Cm1kuG+Og
         6n5KLtyUr//ZEMKj38QSoIkgTIXbmXRxl3TyleC73nVFXYxc8yDqRPzuwm2q56/qaQTk
         aYNlUE3xDfUZJDzEuf3t7fQnw9S1DljCDjWus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523288; x=1756128088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9NwhuCMHlal4nfMZppJlQNqRgXzvfqaNLFUh/zX3Es=;
        b=FtngyxYNoSUCAG/wtZf+O/oVPmAzaX2uMZDjEYdlHoc5cvR1LcgH4wT2fzslkMEfrl
         YHMh1kMg1zZjYPq9O97jnP3ZjGV5xrzDocgzYJMal1/licfXQE1qdKDQg9c+UhmZOJUm
         JR6+9qGYaMRO6nV8q+IcdOFBrcFQsJstsU/aZHAGUVMaRzXPNiLJW276+j2PWMXRd3e9
         zdi6KviY1HUhiFipGLcxaZRuye3PhxkXVULBpqw2Ei1ZVi/aCxuX/avlaXJkfTK8+MGL
         6xTWsElahkF/Z4qB0rW8rbIHv6ul4j3xWghVhA/7EztvS/TJU2czj71k/Tg0mR31ctk9
         BrNw==
X-Forwarded-Encrypted: i=1; AJvYcCVzQqkV2l1oXDorfCzaqpLjKJHNJ6NuZnh9pVJ9WKdYtXaSGrzMo5vDe613/R0y+T09bANoTyDCdIhsLv1i@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UCs2WOajmqqJpAs/pJkDPijLdt1CFUhb6fqurPoaePsoal3O
	X0Npb0cQVbdOEbjWl1Q8EyxlFoY0IA62TvFcYSo/ZivMW9/k+5FLWZK+V1TVwImhwkrMgSwl4CK
	t+LlPg6cs1Zol0UmHOjLb62yfodFYsh5LpPmFkrjeEg==
X-Gm-Gg: ASbGncuq7XAf03V7mOyAKrGwf9PbGZkuJcHD0GaXfiRMaoQzO2H3JEn0N0Yd02gU8vE
	85iR9GaLuAMQO37ypFcwn0o9bqDOLJGR6IqIDc0k7my525m0xxXWF4n6x/6aYY2ixby6g33IJ/1
	ZbgQVbG4lFZe3zNsXy7KR52y5ibErcqV3lRfXxhSq8zwBN/JlrQ5nfp7T3SIJneOrYcotvfclQ1
	rtZBmQ1s5bp4nTDtO0r
X-Google-Smtp-Source: AGHT+IFutWtPlaGf9zJRjyxgTOskyeiTnXfCuYzbF7bPXJ2847nICuDSS8fP8XT3HZAnRzWBoL3h/6kgHHJI9K5SXnw=
X-Received: by 2002:a05:622a:8c:b0:4b0:6463:7d0d with SMTP id
 d75a77b69052e-4b11e337c4emr170919001cf.42.1755523287581; Mon, 18 Aug 2025
 06:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707153413.19393-1-luis@igalia.com>
In-Reply-To: <20250707153413.19393-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Aug 2025 15:21:15 +0200
X-Gm-Features: Ac12FXz8RGGwZZdP1TPdBWeRoYqviUb7NkQ1hDA4keNhLu5ofc3zlrp1Qq34z2g
Message-ID: <CAJfpeguwimZgFht9AGV+WafbMrRbLK9Cp3G4Fy4xrLbAjgGARw@mail.gmail.com>
Subject: Re: [PATCH v4] fuse: new work queue to periodically invalidate
 expired dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	Matt Harvey <mharvey@jumptrading.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 17:34, Luis Henriques <luis@igalia.com> wrote:

> I'm sending v4 without implementing your request to turn the dentries
> trees and work queues into global data structures.  After thinking about
> it a bit more, I'm not sure anymore that it makes sense.  And the reason
> is that the epoch is a per-connection attribute.  I couldn't find an
> elegant way of having a single work queue with a global tree to handle the
> fact that the epoch of a connection may have been incremented.  Any option
> to avoid walking through all the tree dentries when an epoch is
> incremented would be more complex than simply keeping it (and work queue)
> per connection.
>
> Does this make sense?

The global tree works very well for timeouts, but not for epoch.

So I wonder if we should just handle them separately.  Your original
patch dealt with the epoch within NOTIFY_INC_EPOCH, but the same thing
could be done with a workqueue started from the notification.

Thanks,
Miklos


>
> Changes since v3:
>
> - Use of need_resched() instead of limiting the work queue to run for 5
>   seconds
> - Restore usage of union with rcu_head, in struct fuse_dentry
> - Minor changes in comments (e.g. s/workqueue/work queue/)
>
> Changes since v2:
>
> - Major rework, the dentries tree nodes are now in fuse_dentry and they are
>   tied to the actual dentry lifetime
> - Mount option is now a module parameter
> - workqueue now runs for at most 5 seconds before rescheduling
>
>  fs/fuse/dev.c    |   2 -
>  fs/fuse/dir.c    | 179 +++++++++++++++++++++++++++++++++++++++++------
>  fs/fuse/fuse_i.h |  12 ++++
>  fs/fuse/inode.c  |  21 ++++++
>  4 files changed, 189 insertions(+), 25 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f2c049..2ec7fefcc1a1 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2034,8 +2034,6 @@ static int fuse_notify_resend(struct fuse_conn *fc)
>  /*
>   * Increments the fuse connection epoch.  This will result of dentries from
>   * previous epochs to be invalidated.
> - *
> - * XXX optimization: add call to shrink_dcache_sb()?
>   */
>  static int fuse_notify_inc_epoch(struct fuse_conn *fc)
>  {
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 45b4c3cc1396..7eba86fe52d6 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -34,33 +34,152 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>  }
>
> -#if BITS_PER_LONG >= 64
> -static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
> +struct fuse_dentry {
> +       u64 time;
> +       union {
> +               struct rcu_head rcu;
> +               struct rb_node node;
> +       };
> +       struct dentry *dentry;
> +};
> +
> +static void __fuse_dentry_tree_del_node(struct fuse_conn *fc,
> +                                       struct fuse_dentry *fd)
>  {
> -       entry->d_fsdata = (void *) time;
> +       if (!RB_EMPTY_NODE(&fd->node)) {
> +               rb_erase(&fd->node, &fc->dentry_tree);
> +               RB_CLEAR_NODE(&fd->node);
> +       }
>  }
>
> -static inline u64 fuse_dentry_time(const struct dentry *entry)
> +static void fuse_dentry_tree_del_node(struct dentry *dentry)
>  {
> -       return (u64)entry->d_fsdata;
> +       struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
> +       struct fuse_dentry *fd = dentry->d_fsdata;
> +
> +       if (!fc->inval_wq)
> +               return;
> +
> +       spin_lock(&fc->dentry_tree_lock);
> +       __fuse_dentry_tree_del_node(fc, fd);
> +       spin_unlock(&fc->dentry_tree_lock);
>  }
>
> -#else
> -union fuse_dentry {
> -       u64 time;
> -       struct rcu_head rcu;
> -};
> +static void fuse_dentry_tree_add_node(struct dentry *dentry)
> +{
> +       struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
> +       struct fuse_dentry *fd = dentry->d_fsdata;
> +       struct fuse_dentry *cur;
> +       struct rb_node **p, *parent = NULL;
> +       bool start_work = false;
> +
> +       if (!fc->inval_wq)
> +               return;
> +
> +       spin_lock(&fc->dentry_tree_lock);
> +
> +       if (!fc->inval_wq) {
> +               spin_unlock(&fc->dentry_tree_lock);
> +               return;
> +       }
> +
> +       start_work = RB_EMPTY_ROOT(&fc->dentry_tree);
> +       __fuse_dentry_tree_del_node(fc, fd);
> +
> +       p = &fc->dentry_tree.rb_node;
> +       while (*p) {
> +               parent = *p;
> +               cur = rb_entry(*p, struct fuse_dentry, node);
> +               if (fd->time > cur->time)
> +                       p = &(*p)->rb_left;
> +               else
> +                       p = &(*p)->rb_right;
> +       }
> +       rb_link_node(&fd->node, parent, p);
> +       rb_insert_color(&fd->node, &fc->dentry_tree);
> +       spin_unlock(&fc->dentry_tree_lock);
> +
> +       if (start_work)
> +               schedule_delayed_work(&fc->dentry_tree_work,
> +                                     secs_to_jiffies(fc->inval_wq));
> +}
> +
> +void fuse_dentry_tree_prune(struct fuse_conn *fc)
> +{
> +       struct rb_node *n;
> +
> +       if (!fc->inval_wq)
> +               return;
> +
> +       fc->inval_wq = 0;
> +       cancel_delayed_work_sync(&fc->dentry_tree_work);
> +
> +       spin_lock(&fc->dentry_tree_lock);
> +       while (!RB_EMPTY_ROOT(&fc->dentry_tree)) {
> +               n = rb_first(&fc->dentry_tree);
> +               rb_erase(n, &fc->dentry_tree);
> +               RB_CLEAR_NODE(&rb_entry(n, struct fuse_dentry, node)->node);
> +       }
> +       spin_unlock(&fc->dentry_tree_lock);
> +}
> +
> +/*
> + * work queue that, when enabled, will periodically check for expired dentries
> + * in the dentries tree.
> + *
> + * A dentry has expired if:
> + *
> + *   1) it has been around for too long (timeout) or if
> + *
> + *   2) the connection epoch has been incremented.
> + *
> + * The work queue will be rescheduled itself as long as the dentries tree is not
> + * empty.
> + */
> +void fuse_dentry_tree_work(struct work_struct *work)
> +{
> +       struct fuse_conn *fc = container_of(work, struct fuse_conn,
> +                                           dentry_tree_work.work);
> +       struct fuse_dentry *fd;
> +       struct rb_node *node;
> +       u64 start;
> +       int epoch;
> +       bool reschedule;
> +
> +       spin_lock(&fc->dentry_tree_lock);
> +       start = get_jiffies_64();
> +       epoch = atomic_read(&fc->epoch);
> +
> +       node = rb_first(&fc->dentry_tree);
> +       while (node && !need_resched()) {
> +               fd = rb_entry(node, struct fuse_dentry, node);
> +               if ((fd->dentry->d_time < epoch) || (fd->time < start)) {
> +                       rb_erase(&fd->node, &fc->dentry_tree);
> +                       RB_CLEAR_NODE(&fd->node);
> +                       spin_unlock(&fc->dentry_tree_lock);
> +                       d_invalidate(fd->dentry);
> +                       spin_lock(&fc->dentry_tree_lock);
> +               } else
> +                       break;
> +               node = rb_first(&fc->dentry_tree);
> +       }
> +       reschedule = !RB_EMPTY_ROOT(&fc->dentry_tree);
> +       spin_unlock(&fc->dentry_tree_lock);
> +
> +       if (reschedule)
> +               schedule_delayed_work(&fc->dentry_tree_work,
> +                                     secs_to_jiffies(fc->inval_wq));
> +}
>
>  static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
>  {
> -       ((union fuse_dentry *) dentry->d_fsdata)->time = time;
> +       ((struct fuse_dentry *) dentry->d_fsdata)->time = time;
>  }
>
>  static inline u64 fuse_dentry_time(const struct dentry *entry)
>  {
> -       return ((union fuse_dentry *) entry->d_fsdata)->time;
> +       return ((struct fuse_dentry *) entry->d_fsdata)->time;
>  }
> -#endif
>
>  static void fuse_dentry_settime(struct dentry *dentry, u64 time)
>  {
> @@ -81,6 +200,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
>         }
>
>         __fuse_dentry_settime(dentry, time);
> +       fuse_dentry_tree_add_node(dentry);
>  }
>
>  /*
> @@ -283,21 +403,36 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
>         goto out;
>  }
>
> -#if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
> -       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
> -                                  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
> +       struct fuse_dentry *fd;
> +
> +       fd = kzalloc(sizeof(struct fuse_dentry),
> +                         GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
> +       if (!fd)
> +               return -ENOMEM;
> +
> +       fd->dentry = dentry;
> +       RB_CLEAR_NODE(&fd->node);
> +       dentry->d_fsdata = fd;
> +
> +       return 0;
> +}
> +
> +static void fuse_dentry_prune(struct dentry *dentry)
> +{
> +       struct fuse_dentry *fd = dentry->d_fsdata;
>
> -       return dentry->d_fsdata ? 0 : -ENOMEM;
> +       if (!RB_EMPTY_NODE(&fd->node))
> +               fuse_dentry_tree_del_node(dentry);
>  }
> +
>  static void fuse_dentry_release(struct dentry *dentry)
>  {
> -       union fuse_dentry *fd = dentry->d_fsdata;
> +       struct fuse_dentry *fd = dentry->d_fsdata;
>
>         kfree_rcu(fd, rcu);
>  }
> -#endif
>
>  static int fuse_dentry_delete(const struct dentry *dentry)
>  {
> @@ -331,18 +466,16 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
>  const struct dentry_operations fuse_dentry_operations = {
>         .d_revalidate   = fuse_dentry_revalidate,
>         .d_delete       = fuse_dentry_delete,
> -#if BITS_PER_LONG < 64
>         .d_init         = fuse_dentry_init,
> +       .d_prune        = fuse_dentry_prune,
>         .d_release      = fuse_dentry_release,
> -#endif
>         .d_automount    = fuse_dentry_automount,
>  };
>
>  const struct dentry_operations fuse_root_dentry_operations = {
> -#if BITS_PER_LONG < 64
>         .d_init         = fuse_dentry_init,
> +       .d_prune        = fuse_dentry_prune,
>         .d_release      = fuse_dentry_release,
> -#endif
>  };
>
>  int fuse_valid_type(int m)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b54f4f57789f..638d62d995a2 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -975,6 +975,15 @@ struct fuse_conn {
>                 /* Request timeout (in jiffies). 0 = no timeout */
>                 unsigned int req_timeout;
>         } timeout;
> +
> +       /** Cache dentries tree */
> +       struct rb_root dentry_tree;
> +       /** Look to protect dentry_tree access */
> +       spinlock_t dentry_tree_lock;
> +       /** Periodic delayed work to invalidate expired dentries */
> +       struct delayed_work dentry_tree_work;
> +       /** Period for the invalidation work queue */
> +       unsigned int inval_wq;
>  };
>
>  /*
> @@ -1259,6 +1268,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
>
> +void fuse_dentry_tree_prune(struct fuse_conn *fc);
> +void fuse_dentry_tree_work(struct work_struct *work);
> +
>  /**
>   * Invalidate inode attributes
>   */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9572bdef49ee..df20ff91898f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -58,6 +58,20 @@ MODULE_PARM_DESC(max_user_congthresh,
>   "Global limit for the maximum congestion threshold an "
>   "unprivileged user can set");
>
> +static unsigned __read_mostly inval_wq;
> +static int inval_wq_set(const char *val, const struct kernel_param *kp)
> +{
> +       return param_set_uint_minmax(val, kp, 5, (unsigned int)(-1));
> +}
> +static const struct kernel_param_ops inval_wq_ops = {
> +       .set = inval_wq_set,
> +       .get = param_get_uint,
> +};
> +module_param_cb(inval_wq, &inval_wq_ops, &inval_wq, 0644);
> +__MODULE_PARM_TYPE(inval_wq, "uint");
> +MODULE_PARM_DESC(inval_wq,
> +                "Dentries invalidation work queue period in secs (>= 5).");
> +
>  #define FUSE_DEFAULT_BLKSIZE 512
>
>  /** Maximum number of outstanding background requests */
> @@ -963,6 +977,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>         memset(fc, 0, sizeof(*fc));
>         spin_lock_init(&fc->lock);
>         spin_lock_init(&fc->bg_lock);
> +       spin_lock_init(&fc->dentry_tree_lock);
>         init_rwsem(&fc->killsb);
>         refcount_set(&fc->count, 1);
>         atomic_set(&fc->dev_count, 1);
> @@ -972,6 +987,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>         INIT_LIST_HEAD(&fc->bg_queue);
>         INIT_LIST_HEAD(&fc->entry);
>         INIT_LIST_HEAD(&fc->devices);
> +       fc->dentry_tree = RB_ROOT;
> +       fc->inval_wq = 0;
>         atomic_set(&fc->num_waiting, 0);
>         fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
>         fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
> @@ -1848,6 +1865,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>         fc->group_id = ctx->group_id;
>         fc->legacy_opts_show = ctx->legacy_opts_show;
>         fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
> +       fc->inval_wq = inval_wq;
> +       if (fc->inval_wq > 0)
> +               INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tree_work);
>         fc->destroy = ctx->destroy;
>         fc->no_control = ctx->no_control;
>         fc->no_force_umount = ctx->no_force_umount;
> @@ -2052,6 +2072,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>
>         fuse_abort_conn(fc);
>         fuse_wait_aborted(fc);
> +       fuse_dentry_tree_prune(fc);
>
>         if (!list_empty(&fc->entry)) {
>                 mutex_lock(&fuse_mutex);

