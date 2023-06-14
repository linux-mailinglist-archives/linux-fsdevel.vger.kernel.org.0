Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C273074C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFNSUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbjFNST7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:19:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E622125
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 11:19:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1487460276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686766797; x=1689358797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvolxFpSUd+UYjr2NPXt15fH6Ok7605pkk0GNP9SYg0=;
        b=Tgqk+w3/V1gNYoOZd83Bpn7ROrRlihlUJ+5um0iGTM5GR/cbZ9uH6LlPNLQnKfLwiK
         iFwhD7czV1ywnr2ClenU+dDWF3DutvvSZzgCAarssxiRAN47ujSFiWW7dwcNyEX0Mt5+
         /bDiG4zGwMaS9jAez89vf8DtzUbVlQ6+qL6IcyfQqx/X9P4aJkCbIumtexw7IyG/Y0yh
         9Lt8HVigSISC40kEJ9WFrGXl6nNO9K9kQ4G8Ap4gEfXD2NsvtBpyWE5Y6IfdHhOS2f/a
         gGD53f05zQSfamVYOK4VKqhTPI25fnDwP7fIQl/DuvDlUmnXLSNXLjMM1W4LW5kgHOZz
         j6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766797; x=1689358797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvolxFpSUd+UYjr2NPXt15fH6Ok7605pkk0GNP9SYg0=;
        b=IjkB4GH3NllAwz6ibSlSDft/bgN6zLU5HE59yvNgUIjkTVx4kX4Z8LvBVT7p6/aYXP
         2yCXHMwe+YZ/hLV6H/9ymVkaClZoUhG93cf4lLqf3SLr0NQIdPE3ugrOfuzw0hoZ6eRp
         WneCCuKErTFEQmusaZLworrSQWJFYlfp56UxIWvXMJNIevFAVA+jZxy5ouOSlEUD4Y6j
         BkFS34VLaRb2L6SqXrm/cLAWetUgmYyS4ly4+emGHtfBw0DI2DWlghcxRZQW23erB92Z
         L5jY+wF33dsH79eGCPKBQWrJkWjMDDoTAiPeT7yRzXUr+I3eyOc5R7kH3B1sCODDncmj
         LBgg==
X-Gm-Message-State: AC+VfDx6AGM3Vt2Zc09CdJUSWooiC8kZ6G0LS4Hr8wz88JSWPnnMYAXl
        mY+e2W9iMXpT5DMH61S9+trEkOhznx45zQJ5jEQuZQ==
X-Google-Smtp-Source: ACHHUZ71r/mO+17OUlbI/yQUvzbpW2gg0ni8VB/hBmzje4ZzR42bChGdzfywTZfHqkzTUetxHqiXOuDKkAKGfqmCYXY=
X-Received: by 2002:a25:644:0:b0:bac:bb2f:67f5 with SMTP id
 65-20020a250644000000b00bacbb2f67f5mr2938857ybg.15.1686766796537; Wed, 14 Jun
 2023 11:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230614070733.113068-1-lujialin4@huawei.com> <20230614174004.GC1146@sol.localdomain>
In-Reply-To: <20230614174004.GC1146@sol.localdomain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 14 Jun 2023 11:19:45 -0700
Message-ID: <CAJuCfpFROxDn-Yv48zKw5PuiLd_LQ5+b1Nt4+jEw8wHMWcRDWw@mail.gmail.com>
Subject: Re: [PATCH v2] poll: Fix use-after-free in poll_freewait()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Lu Jialin <lujialin4@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:40=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Wed, Jun 14, 2023 at 03:07:33PM +0800, Lu Jialin wrote:
> > We found a UAF bug in remove_wait_queue as follows:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
> > Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/15306
> > Call Trace:
> >  dump_stack+0x9c/0xd3
> >  print_address_description.constprop.0+0x19/0x170
> >  __kasan_report.cold+0x6c/0x84
> >  kasan_report+0x3a/0x50
> >  check_memory_region+0xfd/0x1f0
> >  _raw_spin_lock_irqsave+0x71/0xe0
> >  remove_wait_queue+0x26/0xc0
> >  poll_freewait+0x6b/0x120
> >  do_sys_poll+0x305/0x400
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > Allocated by task 15306:
> >  kasan_save_stack+0x1b/0x40
> >  __kasan_kmalloc.constprop.0+0xb5/0xe0
> >  psi_trigger_create.part.0+0xfc/0x450
> >  cgroup_pressure_write+0xfc/0x3b0
> >  cgroup_file_write+0x1b3/0x390
> >  kernfs_fop_write_iter+0x224/0x2e0
> >  new_sync_write+0x2ac/0x3a0
> >  vfs_write+0x365/0x430
> >  ksys_write+0xd5/0x1b0
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > Freed by task 15850:
> >  kasan_save_stack+0x1b/0x40
> >  kasan_set_track+0x1c/0x30
> >  kasan_set_free_info+0x20/0x40
> >  __kasan_slab_free+0x151/0x180
> >  kfree+0xba/0x680
> >  cgroup_file_release+0x5c/0xe0
> >  kernfs_drain_open_files+0x122/0x1e0
> >  kernfs_drain+0xff/0x1e0
> >  __kernfs_remove.part.0+0x1d1/0x3b0
> >  kernfs_remove_by_name_ns+0x89/0xf0
> >  cgroup_addrm_files+0x393/0x3d0
> >  css_clear_dir+0x8f/0x120
> >  kill_css+0x41/0xd0
> >  cgroup_destroy_locked+0x166/0x300
> >  cgroup_rmdir+0x37/0x140
> >  kernfs_iop_rmdir+0xbb/0xf0
> >  vfs_rmdir.part.0+0xa5/0x230
> >  do_rmdir+0x2e0/0x320
> >  __x64_sys_unlinkat+0x99/0xc0
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > If using epoll(), wake_up_pollfree will empty waitqueue and set
> > wait_queue_head is NULL before free waitqueue of psi trigger. But is
> > doesn't work when using poll(), which will lead a UAF problem in
> > poll_freewait coms as following:
> >
> > (cgroup_rmdir)                      |
> > psi_trigger_destroy                 |
> >   wake_up_pollfree(&t->event_wait)  |
> >    synchronize_rcu();               |
> >     kfree(t)                        |
> >                                   |   (poll_freewait)
> >                                   |     free_poll_entry(pwq->inline_ent=
ries + i)
> >                                   |       remove_wait_queue(entry->wait=
_address)
> >                                   |         spin_lock_irqsave(&wq_head-=
>lock)
> >
> > entry->wait_address in poll_freewait() is t->event_wait in cgroup_rmdir=
().
> > t->event_wait is free in psi_trigger_destroy before call poll_freewait(=
),
> > therefore wq_head in poll_freewait() has been already freed, which woul=
d
> > lead to a UAF.
> >
> > similar problem for epoll() has been fixed commit c2dbe32d5db5
> > ("sched/psi: Fix use-after-free in ep_remove_wait_queue()").
> > epoll wakeup function ep_poll_callback() will empty waitqueue and set
> > wait_queue_head is NULL when pollflags is POLLFREE and judge pwq->whead
> > is NULL or not before remove_wait_queue in ep_remove_wait_queue(),
> > which will fix the UAF bug in ep_remove_wait_queue.
> >
> > But poll wakeup function pollwake() doesn't do that. To fix the
> > problem, we empty waitqueue and set wait_address is NULL in pollwake() =
when
> > key is POLLFREE. otherwise in remove_wait_queue, which is similar to
> > epoll().
> >
> > Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Link: https://lore.kernel.org/all/CAJuCfpEoCRHkJF-=3D1Go9E94wchB4BzwQ1E=
3vHGWxNe+tEmSJoA@mail.gmail.com/#t
> > Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> > ---
> > v2: correct commit msg and title suggested by Suren Baghdasaryan
> > ---
> >  fs/select.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/select.c b/fs/select.c
> > index 0ee55af1a55c..e64c7b4e9959 100644
> > --- a/fs/select.c
> > +++ b/fs/select.c
> > @@ -132,7 +132,17 @@ EXPORT_SYMBOL(poll_initwait);
> >
> >  static void free_poll_entry(struct poll_table_entry *entry)
> >  {
> > -     remove_wait_queue(entry->wait_address, &entry->wait);
> > +     wait_queue_head_t *whead;
> > +
> > +     rcu_read_lock();
> > +     /* If it is cleared by POLLFREE, it should be rcu-safe.
> > +      * If we read NULL we need a barrier paired with smp_store_releas=
e()
> > +      * in pollwake().
> > +      */
> > +     whead =3D smp_load_acquire(&entry->wait_address);
> > +     if (whead)
> > +             remove_wait_queue(whead, &entry->wait);
> > +     rcu_read_unlock();
> >       fput(entry->filp);
> >  }
> >
> > @@ -215,6 +225,14 @@ static int pollwake(wait_queue_entry_t *wait, unsi=
gned mode, int sync, void *key
> >       entry =3D container_of(wait, struct poll_table_entry, wait);
> >       if (key && !(key_to_poll(key) & entry->key))
> >               return 0;
> > +     if (key_to_poll(key) & POLLFREE) {
> > +             list_del_init(&wait->entry);
> > +             /* wait_address !=3DNULL protects us from the race with
> > +              * poll_freewait().
> > +              */
> > +             smp_store_release(&entry->wait_address, NULL);
> > +             return 0;
> > +     }
> >       return __pollwake(wait, mode, sync, key);
>
> I don't understand why this patch is needed.
>
> The last time I looked at POLLFREE, it is only needed because of asynchro=
nous
> polls.  See my explanation in the commit message of commit 50252e4b5e989c=
e6.

Ah, I missed that. Thanks for the correction.

>
> In summary, POLLFREE solves the problem of polled waitqueues whose lifeti=
me is
> tied to the current task rather than to the file being polled.  Also refe=
r to
> the comment above wake_up_pollfree(), which mentions this.
>
> fs/select.c is synchronous polling, not asynchronous.  Therefore, it shou=
ld not
> need to handle POLLFREE.
>
> If there's actually a bug here, most likely it's a bug in psi_trigger_pol=
l()
> where it is using a waitqueue whose lifetime is tied to neither the curre=
nt task
> nor the file being polled.  That needs to be fixed.

Yeah. We discussed this issue in
https://lore.kernel.org/all/CAJuCfpFb0J5ZwO6kncjRG0_4jQLXUy-_dicpH5uGiWP8aK=
YEJQ@mail.gmail.com
and the root cause is that cgroup_file_release() where
psi_trigger_destroy() is called is not tied to the cgroup file's real
lifetime (see my analysis here:
https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru=3D=
=3DMdEHQg@mail.gmail.com/#t).
I guess it's time to do a deeper surgery and figure out a way to call
psi_trigger_destroy() when the polled cgroup file is actually being
destroyed. I'll take a closer look into this later today.
A fix will likely require some cgroup or kernfs code changes, so
CC'ing Tejun for visibility.
Thanks,
Suren.

>
> - Eric
