Return-Path: <linux-fsdevel+bounces-58276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C398B2BD6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D62E1889A3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9731AF21;
	Tue, 19 Aug 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D8mH9bjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4231197E;
	Tue, 19 Aug 2025 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595577; cv=none; b=KoErrd1JTsuO9JwoXRw4kd4gcCq8LcTEZTjPWZx3pCqZBFMlH677MYOlXg1zwsQ8S96PoEH6tn++s4AhXM6Bmtxhnt2i+0nraO+asM25V8AnXmH3d+rcaANgCIQBHBx0Ha+9a+5j5FK2omeP3o4gbWCcrGrwwZ69g/IlPgYHF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595577; c=relaxed/simple;
	bh=4GwmBnPqB/PGnCFzDZO12gRctlMgtf7it7HqILyV+FM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4adzVvR9vRGNnPtj1H9y78ZvFuJLTmzXqnXn+Zf589JVltZlqXu+DrQfvmYsb5/GcJOy9yTAaVQlMmAA3jNAsM9PYeEscvVyrNSQMERhqasCBqus2lvq9TAaAiTDbGabvOvTLCy4qEzhHFHNeHM782jmqnPmZnMuCFyjeAqw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=D8mH9bjX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hql6HSGwYtvg/l/Qdezie2eec6ZlnF/G9RfuJh72+9o=; b=D8mH9bjXseUkG5TEnrlqdAj4+c
	47oV/y04eZ/XA5dDMEwLog4u5djzKQyOiiN761OXU08/H5+3G4MMV6urjzmNQqOrsT6GXjtKpGaE+
	PCY9uE+/VeDmrL1Xha/IBsuSuiNzxT2pJdxEeDFTj56pxZEUg+LitbxAv9DJIJtbrLyHiTR48x0VD
	6oh27dJ1nSecLChGJaRVEmUJKtaZ4rYMuo6UQmFA6ApMISHEkEm3h4nakBIHHk4dkXwhM3iMVo9ey
	PSSXAHgz83kWMNg5XcNhuWKzhFFBcHBasDZTQL3h8TViKOpo6ujXFeP3AYvQdjWwXe3GXxqbpEa0X
	D03BQs0g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uoIbV-00GEFO-9R; Tue, 19 Aug 2025 11:26:05 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel-dev@igalia.com,  Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [PATCH v4] fuse: new work queue to periodically invalidate
 expired dentries
In-Reply-To: <CAJfpeguwimZgFht9AGV+WafbMrRbLK9Cp3G4Fy4xrLbAjgGARw@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 18 Aug 2025 15:21:15 +0200")
References: <20250707153413.19393-1-luis@igalia.com>
	<CAJfpeguwimZgFht9AGV+WafbMrRbLK9Cp3G4Fy4xrLbAjgGARw@mail.gmail.com>
Date: Tue, 19 Aug 2025 10:26:04 +0100
Message-ID: <87plcrmzmb.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18 2025, Miklos Szeredi wrote:

> On Mon, 7 Jul 2025 at 17:34, Luis Henriques <luis@igalia.com> wrote:
>
>> I'm sending v4 without implementing your request to turn the dentries
>> trees and work queues into global data structures.  After thinking about
>> it a bit more, I'm not sure anymore that it makes sense.  And the reason
>> is that the epoch is a per-connection attribute.  I couldn't find an
>> elegant way of having a single work queue with a global tree to handle t=
he
>> fact that the epoch of a connection may have been incremented.  Any opti=
on
>> to avoid walking through all the tree dentries when an epoch is
>> incremented would be more complex than simply keeping it (and work queue)
>> per connection.
>>
>> Does this make sense?
>
> The global tree works very well for timeouts, but not for epoch.

Right.

> So I wonder if we should just handle them separately.  Your original
> patch dealt with the epoch within NOTIFY_INC_EPOCH, but the same thing
> could be done with a workqueue started from the notification.

Oh! I see, I guess that could work -- having an optional periodic work
queue for timeouts and another one that would run only once when the epoch
is incremented.  Thanks for the suggestion, I'll work on implementing this
in v5 of this patch.

Cheers,
--=20
Lu=C3=ADs

> Thanks,
> Miklos
>
>
>>
>> Changes since v3:
>>
>> - Use of need_resched() instead of limiting the work queue to run for 5
>>   seconds
>> - Restore usage of union with rcu_head, in struct fuse_dentry
>> - Minor changes in comments (e.g. s/workqueue/work queue/)
>>
>> Changes since v2:
>>
>> - Major rework, the dentries tree nodes are now in fuse_dentry and they =
are
>>   tied to the actual dentry lifetime
>> - Mount option is now a module parameter
>> - workqueue now runs for at most 5 seconds before rescheduling
>>
>>  fs/fuse/dev.c    |   2 -
>>  fs/fuse/dir.c    | 179 +++++++++++++++++++++++++++++++++++++++++------
>>  fs/fuse/fuse_i.h |  12 ++++
>>  fs/fuse/inode.c  |  21 ++++++
>>  4 files changed, 189 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index e80cd8f2c049..2ec7fefcc1a1 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -2034,8 +2034,6 @@ static int fuse_notify_resend(struct fuse_conn *fc)
>>  /*
>>   * Increments the fuse connection epoch.  This will result of dentries =
from
>>   * previous epochs to be invalidated.
>> - *
>> - * XXX optimization: add call to shrink_dcache_sb()?
>>   */
>>  static int fuse_notify_inc_epoch(struct fuse_conn *fc)
>>  {
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 45b4c3cc1396..7eba86fe52d6 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -34,33 +34,152 @@ static void fuse_advise_use_readdirplus(struct inod=
e *dir)
>>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>>  }
>>
>> -#if BITS_PER_LONG >=3D 64
>> -static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
>> +struct fuse_dentry {
>> +       u64 time;
>> +       union {
>> +               struct rcu_head rcu;
>> +               struct rb_node node;
>> +       };
>> +       struct dentry *dentry;
>> +};
>> +
>> +static void __fuse_dentry_tree_del_node(struct fuse_conn *fc,
>> +                                       struct fuse_dentry *fd)
>>  {
>> -       entry->d_fsdata =3D (void *) time;
>> +       if (!RB_EMPTY_NODE(&fd->node)) {
>> +               rb_erase(&fd->node, &fc->dentry_tree);
>> +               RB_CLEAR_NODE(&fd->node);
>> +       }
>>  }
>>
>> -static inline u64 fuse_dentry_time(const struct dentry *entry)
>> +static void fuse_dentry_tree_del_node(struct dentry *dentry)
>>  {
>> -       return (u64)entry->d_fsdata;
>> +       struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
>> +       struct fuse_dentry *fd =3D dentry->d_fsdata;
>> +
>> +       if (!fc->inval_wq)
>> +               return;
>> +
>> +       spin_lock(&fc->dentry_tree_lock);
>> +       __fuse_dentry_tree_del_node(fc, fd);
>> +       spin_unlock(&fc->dentry_tree_lock);
>>  }
>>
>> -#else
>> -union fuse_dentry {
>> -       u64 time;
>> -       struct rcu_head rcu;
>> -};
>> +static void fuse_dentry_tree_add_node(struct dentry *dentry)
>> +{
>> +       struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
>> +       struct fuse_dentry *fd =3D dentry->d_fsdata;
>> +       struct fuse_dentry *cur;
>> +       struct rb_node **p, *parent =3D NULL;
>> +       bool start_work =3D false;
>> +
>> +       if (!fc->inval_wq)
>> +               return;
>> +
>> +       spin_lock(&fc->dentry_tree_lock);
>> +
>> +       if (!fc->inval_wq) {
>> +               spin_unlock(&fc->dentry_tree_lock);
>> +               return;
>> +       }
>> +
>> +       start_work =3D RB_EMPTY_ROOT(&fc->dentry_tree);
>> +       __fuse_dentry_tree_del_node(fc, fd);
>> +
>> +       p =3D &fc->dentry_tree.rb_node;
>> +       while (*p) {
>> +               parent =3D *p;
>> +               cur =3D rb_entry(*p, struct fuse_dentry, node);
>> +               if (fd->time > cur->time)
>> +                       p =3D &(*p)->rb_left;
>> +               else
>> +                       p =3D &(*p)->rb_right;
>> +       }
>> +       rb_link_node(&fd->node, parent, p);
>> +       rb_insert_color(&fd->node, &fc->dentry_tree);
>> +       spin_unlock(&fc->dentry_tree_lock);
>> +
>> +       if (start_work)
>> +               schedule_delayed_work(&fc->dentry_tree_work,
>> +                                     secs_to_jiffies(fc->inval_wq));
>> +}
>> +
>> +void fuse_dentry_tree_prune(struct fuse_conn *fc)
>> +{
>> +       struct rb_node *n;
>> +
>> +       if (!fc->inval_wq)
>> +               return;
>> +
>> +       fc->inval_wq =3D 0;
>> +       cancel_delayed_work_sync(&fc->dentry_tree_work);
>> +
>> +       spin_lock(&fc->dentry_tree_lock);
>> +       while (!RB_EMPTY_ROOT(&fc->dentry_tree)) {
>> +               n =3D rb_first(&fc->dentry_tree);
>> +               rb_erase(n, &fc->dentry_tree);
>> +               RB_CLEAR_NODE(&rb_entry(n, struct fuse_dentry, node)->no=
de);
>> +       }
>> +       spin_unlock(&fc->dentry_tree_lock);
>> +}
>> +
>> +/*
>> + * work queue that, when enabled, will periodically check for expired d=
entries
>> + * in the dentries tree.
>> + *
>> + * A dentry has expired if:
>> + *
>> + *   1) it has been around for too long (timeout) or if
>> + *
>> + *   2) the connection epoch has been incremented.
>> + *
>> + * The work queue will be rescheduled itself as long as the dentries tr=
ee is not
>> + * empty.
>> + */
>> +void fuse_dentry_tree_work(struct work_struct *work)
>> +{
>> +       struct fuse_conn *fc =3D container_of(work, struct fuse_conn,
>> +                                           dentry_tree_work.work);
>> +       struct fuse_dentry *fd;
>> +       struct rb_node *node;
>> +       u64 start;
>> +       int epoch;
>> +       bool reschedule;
>> +
>> +       spin_lock(&fc->dentry_tree_lock);
>> +       start =3D get_jiffies_64();
>> +       epoch =3D atomic_read(&fc->epoch);
>> +
>> +       node =3D rb_first(&fc->dentry_tree);
>> +       while (node && !need_resched()) {
>> +               fd =3D rb_entry(node, struct fuse_dentry, node);
>> +               if ((fd->dentry->d_time < epoch) || (fd->time < start)) {
>> +                       rb_erase(&fd->node, &fc->dentry_tree);
>> +                       RB_CLEAR_NODE(&fd->node);
>> +                       spin_unlock(&fc->dentry_tree_lock);
>> +                       d_invalidate(fd->dentry);
>> +                       spin_lock(&fc->dentry_tree_lock);
>> +               } else
>> +                       break;
>> +               node =3D rb_first(&fc->dentry_tree);
>> +       }
>> +       reschedule =3D !RB_EMPTY_ROOT(&fc->dentry_tree);
>> +       spin_unlock(&fc->dentry_tree_lock);
>> +
>> +       if (reschedule)
>> +               schedule_delayed_work(&fc->dentry_tree_work,
>> +                                     secs_to_jiffies(fc->inval_wq));
>> +}
>>
>>  static inline void __fuse_dentry_settime(struct dentry *dentry, u64 tim=
e)
>>  {
>> -       ((union fuse_dentry *) dentry->d_fsdata)->time =3D time;
>> +       ((struct fuse_dentry *) dentry->d_fsdata)->time =3D time;
>>  }
>>
>>  static inline u64 fuse_dentry_time(const struct dentry *entry)
>>  {
>> -       return ((union fuse_dentry *) entry->d_fsdata)->time;
>> +       return ((struct fuse_dentry *) entry->d_fsdata)->time;
>>  }
>> -#endif
>>
>>  static void fuse_dentry_settime(struct dentry *dentry, u64 time)
>>  {
>> @@ -81,6 +200,7 @@ static void fuse_dentry_settime(struct dentry *dentry=
, u64 time)
>>         }
>>
>>         __fuse_dentry_settime(dentry, time);
>> +       fuse_dentry_tree_add_node(dentry);
>>  }
>>
>>  /*
>> @@ -283,21 +403,36 @@ static int fuse_dentry_revalidate(struct inode *di=
r, const struct qstr *name,
>>         goto out;
>>  }
>>
>> -#if BITS_PER_LONG < 64
>>  static int fuse_dentry_init(struct dentry *dentry)
>>  {
>> -       dentry->d_fsdata =3D kzalloc(sizeof(union fuse_dentry),
>> -                                  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABL=
E);
>> +       struct fuse_dentry *fd;
>> +
>> +       fd =3D kzalloc(sizeof(struct fuse_dentry),
>> +                         GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>> +       if (!fd)
>> +               return -ENOMEM;
>> +
>> +       fd->dentry =3D dentry;
>> +       RB_CLEAR_NODE(&fd->node);
>> +       dentry->d_fsdata =3D fd;
>> +
>> +       return 0;
>> +}
>> +
>> +static void fuse_dentry_prune(struct dentry *dentry)
>> +{
>> +       struct fuse_dentry *fd =3D dentry->d_fsdata;
>>
>> -       return dentry->d_fsdata ? 0 : -ENOMEM;
>> +       if (!RB_EMPTY_NODE(&fd->node))
>> +               fuse_dentry_tree_del_node(dentry);
>>  }
>> +
>>  static void fuse_dentry_release(struct dentry *dentry)
>>  {
>> -       union fuse_dentry *fd =3D dentry->d_fsdata;
>> +       struct fuse_dentry *fd =3D dentry->d_fsdata;
>>
>>         kfree_rcu(fd, rcu);
>>  }
>> -#endif
>>
>>  static int fuse_dentry_delete(const struct dentry *dentry)
>>  {
>> @@ -331,18 +466,16 @@ static struct vfsmount *fuse_dentry_automount(stru=
ct path *path)
>>  const struct dentry_operations fuse_dentry_operations =3D {
>>         .d_revalidate   =3D fuse_dentry_revalidate,
>>         .d_delete       =3D fuse_dentry_delete,
>> -#if BITS_PER_LONG < 64
>>         .d_init         =3D fuse_dentry_init,
>> +       .d_prune        =3D fuse_dentry_prune,
>>         .d_release      =3D fuse_dentry_release,
>> -#endif
>>         .d_automount    =3D fuse_dentry_automount,
>>  };
>>
>>  const struct dentry_operations fuse_root_dentry_operations =3D {
>> -#if BITS_PER_LONG < 64
>>         .d_init         =3D fuse_dentry_init,
>> +       .d_prune        =3D fuse_dentry_prune,
>>         .d_release      =3D fuse_dentry_release,
>> -#endif
>>  };
>>
>>  int fuse_valid_type(int m)
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index b54f4f57789f..638d62d995a2 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -975,6 +975,15 @@ struct fuse_conn {
>>                 /* Request timeout (in jiffies). 0 =3D no timeout */
>>                 unsigned int req_timeout;
>>         } timeout;
>> +
>> +       /** Cache dentries tree */
>> +       struct rb_root dentry_tree;
>> +       /** Look to protect dentry_tree access */
>> +       spinlock_t dentry_tree_lock;
>> +       /** Periodic delayed work to invalidate expired dentries */
>> +       struct delayed_work dentry_tree_work;
>> +       /** Period for the invalidation work queue */
>> +       unsigned int inval_wq;
>>  };
>>
>>  /*
>> @@ -1259,6 +1268,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
>>  /* Check if any requests timed out */
>>  void fuse_check_timeout(struct work_struct *work);
>>
>> +void fuse_dentry_tree_prune(struct fuse_conn *fc);
>> +void fuse_dentry_tree_work(struct work_struct *work);
>> +
>>  /**
>>   * Invalidate inode attributes
>>   */
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 9572bdef49ee..df20ff91898f 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -58,6 +58,20 @@ MODULE_PARM_DESC(max_user_congthresh,
>>   "Global limit for the maximum congestion threshold an "
>>   "unprivileged user can set");
>>
>> +static unsigned __read_mostly inval_wq;
>> +static int inval_wq_set(const char *val, const struct kernel_param *kp)
>> +{
>> +       return param_set_uint_minmax(val, kp, 5, (unsigned int)(-1));
>> +}
>> +static const struct kernel_param_ops inval_wq_ops =3D {
>> +       .set =3D inval_wq_set,
>> +       .get =3D param_get_uint,
>> +};
>> +module_param_cb(inval_wq, &inval_wq_ops, &inval_wq, 0644);
>> +__MODULE_PARM_TYPE(inval_wq, "uint");
>> +MODULE_PARM_DESC(inval_wq,
>> +                "Dentries invalidation work queue period in secs (>=3D =
5).");
>> +
>>  #define FUSE_DEFAULT_BLKSIZE 512
>>
>>  /** Maximum number of outstanding background requests */
>> @@ -963,6 +977,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fus=
e_mount *fm,
>>         memset(fc, 0, sizeof(*fc));
>>         spin_lock_init(&fc->lock);
>>         spin_lock_init(&fc->bg_lock);
>> +       spin_lock_init(&fc->dentry_tree_lock);
>>         init_rwsem(&fc->killsb);
>>         refcount_set(&fc->count, 1);
>>         atomic_set(&fc->dev_count, 1);
>> @@ -972,6 +987,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fus=
e_mount *fm,
>>         INIT_LIST_HEAD(&fc->bg_queue);
>>         INIT_LIST_HEAD(&fc->entry);
>>         INIT_LIST_HEAD(&fc->devices);
>> +       fc->dentry_tree =3D RB_ROOT;
>> +       fc->inval_wq =3D 0;
>>         atomic_set(&fc->num_waiting, 0);
>>         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
>>         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOLD;
>> @@ -1848,6 +1865,9 @@ int fuse_fill_super_common(struct super_block *sb,=
 struct fuse_fs_context *ctx)
>>         fc->group_id =3D ctx->group_id;
>>         fc->legacy_opts_show =3D ctx->legacy_opts_show;
>>         fc->max_read =3D max_t(unsigned int, 4096, ctx->max_read);
>> +       fc->inval_wq =3D inval_wq;
>> +       if (fc->inval_wq > 0)
>> +               INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tre=
e_work);
>>         fc->destroy =3D ctx->destroy;
>>         fc->no_control =3D ctx->no_control;
>>         fc->no_force_umount =3D ctx->no_force_umount;
>> @@ -2052,6 +2072,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>>
>>         fuse_abort_conn(fc);
>>         fuse_wait_aborted(fc);
>> +       fuse_dentry_tree_prune(fc);
>>
>>         if (!list_empty(&fc->entry)) {
>>                 mutex_lock(&fuse_mutex);

