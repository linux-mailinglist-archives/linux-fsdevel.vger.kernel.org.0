Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4F77FDF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbjHQShc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354494AbjHQShJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F6430C5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692297386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11Z+nhrH4XFS60FFOphf14coFguhAqo9KWEOL7Km2pM=;
        b=aUeXOg3xOjyv5fgBCkbX4H4rblhfP3ehvvBBOLb//6NaOCH2b7weXI1+ar8QIPCOCKLxpK
        9uFO3nu5HL0HJLoHxiusyuUYQOTA9z4Nb6siAyYlbCx7456xm5DUJq2g7F7Lr8kbAoGg1G
        Me80OLtMlhYr7nYWga59ZEyEu4tS+bQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-4MV2U9oEMymOJFM8tzcDeQ-1; Thu, 17 Aug 2023 14:36:23 -0400
X-MC-Unique: 4MV2U9oEMymOJFM8tzcDeQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ba7e6c988dso830791fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 11:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297381; x=1692902181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11Z+nhrH4XFS60FFOphf14coFguhAqo9KWEOL7Km2pM=;
        b=b4PeBErHAoyf6mRmENjtz6F+adL0c9MSNA8vWTE5Oho5tq9hcdORaJfp53/nN3nKam
         XJVxknxrEfu1ri8j/O8jgQDDd+/g2CeovM1pV+yRCdC/33xMVa+awvo6BjGUqQbdiiF2
         vjCqvZQMpwIpEIOTekkFC6DKgHMofNJFNaPHcsy6JaEN0GzAOOxd0kLZmBEdzrQvT5bg
         eKTM4r8FrVs/w+eUdaMnQNZnAPTVfHx9Dc1XIAAg66C/1gq2MBtN8xAwuNSxkGpXocky
         Mgxwf6QpMy48EyJvRlHRP+sEcVho05M0vnh6udW6Eg2rbaKuYt8kowmlaJ1ZPFn7di/G
         KGhQ==
X-Gm-Message-State: AOJu0YxFGNGQ6np0xNr+u64p5ob43kM0f1CPObMW1iG9sxl2FQ3Tq66g
        cCPHMtU4lqKjIIYhWYegmnPRw1mjTA0Oq03ALTxi5ZzIPz4snxqdawapwmQdwL4974Xr4CGcM16
        QEfA/sb7EQBDHBiANef1JGloRmKtCAN915CCQc957VQ==
X-Received: by 2002:a05:6512:2017:b0:4fa:ad2d:6c58 with SMTP id a23-20020a056512201700b004faad2d6c58mr72710lfb.61.1692297381586;
        Thu, 17 Aug 2023 11:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq0uUY8u7G5Wc2EHn/sDFjawHhsQUnDT8oKLLifpvDLiJL2fcSN4WhsG7+weBoLqhuIEr230Fghf+K6gpHySY=
X-Received: by 2002:a05:6512:2017:b0:4fa:ad2d:6c58 with SMTP id
 a23-20020a056512201700b004faad2d6c58mr72698lfb.61.1692297381218; Thu, 17 Aug
 2023 11:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230814211116.3224759-1-aahringo@redhat.com> <20230814211116.3224759-2-aahringo@redhat.com>
 <c049f33344990f74c2b88cc3279a913f6ff6f498.camel@kernel.org>
In-Reply-To: <c049f33344990f74c2b88cc3279a913f6ff6f498.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 17 Aug 2023 14:36:09 -0400
Message-ID: <CAK-6q+g-GAw4U+q2oqeM1gAkaZ=V0yU23r8_pxKyyvPteKvs8Q@mail.gmail.com>
Subject: Re: [RFCv2 1/7] lockd: fix race in async lock request handling
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Aug 15, 2023 at 1:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > This patch fixes a race in async lock request handling between adding
> > the relevant struct nlm_block to nlm_blocked list after the request was
> > sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of th=
e
> > nlm_block in the nlm_blocked list. It could be that the async request i=
s
> > completed before the nlm_block was added to the list. This would end
> > in a -ENOENT and a kernel log message of "lockd: grant for unknown
> > block".
> >
> > To solve this issue we add the nlm_block before the vfs_lock_file() cal=
l
> > to be sure it has been added when a possible nlmsvc_grant_deferred() is
> > called. If the vfs_lock_file() results in an case when it wouldn't be
> > added to nlm_blocked list, the nlm_block struct will be removed from
> > this list again.
> >
> > The introducing of the new B_PENDING_CALLBACK nlm_block flag will handl=
e
> > async lock requests on a pending lock requests as a retry on the caller
> > level to hit the -EAGAIN case.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/lockd/svclock.c          | 100 ++++++++++++++++++++++++++----------
> >  include/linux/lockd/lockd.h |   2 +
> >  2 files changed, 74 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index c43ccdf28ed9..7d63524bdb81 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -133,6 +133,7 @@ nlmsvc_remove_block(struct nlm_block *block)
> >  {
> >       if (!list_empty(&block->b_list)) {
> >               spin_lock(&nlm_blocked_lock);
> > +             block->b_flags &=3D ~B_PENDING_CALLBACK;
> >               list_del_init(&block->b_list);
> >               spin_unlock(&nlm_blocked_lock);
> >               nlmsvc_release_block(block);
> > @@ -232,6 +233,7 @@ nlmsvc_create_block(struct svc_rqst *rqstp, struct =
nlm_host *host,
> >       kref_init(&block->b_count);
> >       INIT_LIST_HEAD(&block->b_list);
> >       INIT_LIST_HEAD(&block->b_flist);
> > +     mutex_init(&block->b_cb_mutex);
> >
> >       if (!nlmsvc_setgrantargs(call, lock))
> >               goto failed_free;
> > @@ -289,6 +291,8 @@ static void nlmsvc_free_block(struct kref *kref)
> >
> >       dprintk("lockd: freeing block %p...\n", block);
> >
> > +     WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> > +
> >       /* Remove block from file's list of blocks */
> >       list_del_init(&block->b_flist);
> >       mutex_unlock(&file->f_mutex);
> > @@ -532,6 +536,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >               goto out;
> >       }
> >
> > +     mutex_lock(&block->b_cb_mutex);
> > +     if (block->b_flags & B_PENDING_CALLBACK)
> > +             goto pending_request;
> > +
> > +     /* Append to list of blocked */
> > +     nlmsvc_insert_block(block, NLM_NEVER);
> > +
> >       if (!wait)
> >               lock->fl.fl_flags &=3D ~FL_SLEEP;
> >       mode =3D lock_to_openmode(&lock->fl);
> > @@ -541,9 +552,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >       dprintk("lockd: vfs_lock_file returned %d\n", error);
> >       switch (error) {
> >               case 0:
> > +                     nlmsvc_remove_block(block);
> >                       ret =3D nlm_granted;
> > -                     goto out;
> > +                     goto out_cb_mutex;
> >               case -EAGAIN:
> > +                     if (!wait)
> > +                             nlmsvc_remove_block(block);
> > +pending_request:
> >                       /*
> >                        * If this is a blocking request for an
> >                        * already pending lock request then we need
> > @@ -552,26 +567,29 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >                       if (wait)
> >                               break;
> >                       ret =3D async_block ? nlm_lck_blocked : nlm_lck_d=
enied;
> > -                     goto out;
> > +                     goto out_cb_mutex;
> >               case FILE_LOCK_DEFERRED:
> > +                     block->b_flags |=3D B_PENDING_CALLBACK;
> > +
> >                       if (wait)
> >                               break;
> >                       /* Filesystem lock operation is in progress
> >                          Add it to the queue waiting for callback */
> >                       ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
> > -                     goto out;
> > +                     goto out_cb_mutex;
> >               case -EDEADLK:
> > +                     nlmsvc_remove_block(block);
> >                       ret =3D nlm_deadlock;
> > -                     goto out;
> > +                     goto out_cb_mutex;
> >               default:                        /* includes ENOLCK */
> > +                     nlmsvc_remove_block(block);
> >                       ret =3D nlm_lck_denied_nolocks;
> > -                     goto out;
> > +                     goto out_cb_mutex;
> >       }
> >
> >       ret =3D nlm_lck_blocked;
> > -
> > -     /* Append to list of blocked */
> > -     nlmsvc_insert_block(block, NLM_NEVER);
> > +out_cb_mutex:
> > +     mutex_unlock(&block->b_cb_mutex);
> >  out:
> >       mutex_unlock(&file->f_mutex);
> >       nlmsvc_release_block(block);
> > @@ -728,34 +746,60 @@ nlmsvc_update_deferred_block(struct nlm_block *bl=
ock, int result)
> >               block->b_flags |=3D B_TIMED_OUT;
> >  }
> >
> > +static int __nlmsvc_grant_deferred(struct nlm_block *block,
> > +                                struct file_lock *fl,
> > +                                int result)
> > +{
> > +     int rc =3D 0;
> > +
> > +     dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
> > +                                     block, block->b_flags);
> > +     if (block->b_flags & B_QUEUED) {
> > +             if (block->b_flags & B_TIMED_OUT) {
> > +                     rc =3D -ENOLCK;
> > +                     goto out;
> > +             }
> > +             nlmsvc_update_deferred_block(block, result);
> > +     } else if (result =3D=3D 0)
> > +             block->b_granted =3D 1;
> > +
> > +     nlmsvc_insert_block_locked(block, 0);
> > +     svc_wake_up(block->b_daemon);
> > +out:
> > +     return rc;
> > +}
> > +
> >  static int nlmsvc_grant_deferred(struct file_lock *fl, int result)
> >  {
> > -     struct nlm_block *block;
> > -     int rc =3D -ENOENT;
> > +     struct nlm_block *iter, *block =3D NULL;
> > +     int rc;
> >
> >       spin_lock(&nlm_blocked_lock);
> > -     list_for_each_entry(block, &nlm_blocked, b_list) {
> > -             if (nlm_compare_locks(&block->b_call->a_args.lock.fl, fl)=
) {
> > -                     dprintk("lockd: nlmsvc_notify_blocked block %p fl=
ags %d\n",
> > -                                                     block, block->b_f=
lags);
> > -                     if (block->b_flags & B_QUEUED) {
> > -                             if (block->b_flags & B_TIMED_OUT) {
> > -                                     rc =3D -ENOLCK;
> > -                                     break;
> > -                             }
> > -                             nlmsvc_update_deferred_block(block, resul=
t);
> > -                     } else if (result =3D=3D 0)
> > -                             block->b_granted =3D 1;
> > -
> > -                     nlmsvc_insert_block_locked(block, 0);
> > -                     svc_wake_up(block->b_daemon);
> > -                     rc =3D 0;
> > +     list_for_each_entry(iter, &nlm_blocked, b_list) {
> > +             if (nlm_compare_locks(&iter->b_call->a_args.lock.fl, fl))=
 {
> > +                     kref_get(&iter->b_count);
> > +                     block =3D iter;
> >                       break;
> >               }
> >       }
> >       spin_unlock(&nlm_blocked_lock);
> > -     if (rc =3D=3D -ENOENT)
> > -             printk(KERN_WARNING "lockd: grant for unknown block\n");
> > +
> > +     if (!block) {
> > +             pr_warn("lockd: grant for unknown pending block\n");
> > +             return -ENOENT;
> > +     }
> > +
> > +     /* don't interfere with nlmsvc_lock() */
> > +     mutex_lock(&block->b_cb_mutex);
> > +     block->b_flags &=3D ~B_PENDING_CALLBACK;
> > +
> > +     spin_lock(&nlm_blocked_lock);
> > +     WARN_ON_ONCE(list_empty(&block->b_list));
> > +     rc =3D __nlmsvc_grant_deferred(block, fl, result);
> > +     spin_unlock(&nlm_blocked_lock);
> > +     mutex_unlock(&block->b_cb_mutex);
> > +
> > +     nlmsvc_release_block(block);
> >       return rc;
> >  }
> >
> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index f42594a9efe0..91f55458f5fc 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -185,10 +185,12 @@ struct nlm_block {
> >       struct nlm_file *       b_file;         /* file in question */
> >       struct cache_req *      b_cache_req;    /* deferred request handl=
ing */
> >       struct cache_deferred_req * b_deferred_req
> > +     struct mutex            b_cb_mutex;     /* callback mutex */
>
> There is no mention at all of this new mutex in the changelog or
> comments. It's not at all clear to me what this is intended to protect.
> In general, with lockd being a single-threaded service, we want to avoid
> sleeping locks. This will need some clear justification.
>

The idea was to protect the PENDING flag and to wait until
nlmsvc_lock() is "mostly" done and then allowing lm_grant() callback
to proceed. Before the f_mutex was doing that, but since I made !wait
request (non-blocking requests) being handled synchronously there was
a deadlock because the callback can be run in an unknown order. It was
fixed by having a new mutex on a per nlm_block basis.

However I will remove those changes and try to find another way.


> At a glance, it looks like you're trying to use this to hold
> B_PENDING_CALLBACK steady while a lock request is being handled. That
> suggests that you're using this mutex to serialize access to a section
> of code and not one or more specific data structures. We usually like to
> avoid that sort of thing, since locks that protect arbitrary sections of
> code become difficult to work with over time.
>
> I'm going to go out on a limb here though and suggest that there is
> probably a way to solve this problem that doesn't involve adding new
> locks.
>

ok.

> >       unsigned int            b_flags;        /* block flags */
> >  #define B_QUEUED             1       /* lock queued */
> >  #define B_GOT_CALLBACK               2       /* got lock or conflictin=
g lock */
> >  #define B_TIMED_OUT          4       /* filesystem too slow to respond=
 */
> > +#define B_PENDING_CALLBACK   8       /* pending callback for lock requ=
est */
> >  };
> >
> >  /*
>
> Do we need this new flag at all? It seems redundant. If we have a block
> on the list, then it is sort of by definition "pending callback". If
> it's not on the list anymore, then it's not. No?
>

I will try to find another way. A pending callback is more a check on
if it's a wait request (blocking request) and is it on the list or
not.

This flag was also there to avoid multiple wait requests while a wait
request is pending. I ran into this case and the DLM implementation
was never able to handle it. I can return -EAGAIN but DLM lock() needs
to keep track of those things, I prefer to handle this situation in
the upper layer.

I am not sure why lockd do multiple wait requests for the same
nlm_block when it's pending and waiting for lm_grant() callback. I
will split this handling out of this patch as it is something what
doesn't belong to the race fix between request and lm_grant()
callback.

- Alex

