Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721CD2CFFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfE1UGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 16:06:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32999 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfE1UGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 16:06:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id n18so1775580otq.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2019 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAY+X/6OjvH2/kHzEFaQYM5a3NfoJCjKak4WUy8WxOg=;
        b=mj3P8erc0d0J3qLuw81fmgBFRlYrDPpRlBWngBWwxfTjQLcEOuHasUrkeJiKgfTjg5
         2ihuUJHu/IhG+P2YZXmBHnC9MnJXCVgKQ9BAu8qMhaUQSP4yCiMELuVtZ5X+gznhfuM4
         v+iIvpHEHXha38/WuIY4cNU+nuFxW5oe8bpP4SRzjJ0E0+nz+L9s1upgsalq6lolvGK6
         Lc02/3qWhL+arRMo1/y0figgjb27vsMUr7Z7RIRU6pCpcWGW1dTN31k4aZ1rN3eI0HOx
         r+6bdabT+52797NZz8WLndOLD0Z4GFB/qVhoS465X1dHMaYCleB6Pby3H+oDG58E9Vvh
         24Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAY+X/6OjvH2/kHzEFaQYM5a3NfoJCjKak4WUy8WxOg=;
        b=S2Izpo2wnXsPiIIRxTzgPBCYIyuzBBx2wlrNji+f1lwovWJbc5w8GMyGqQikhH1X/q
         4tCmslLNnrgZPNpTUlLnZ6oXbIXwaYCKGsDP7FeO2ME2D5FMZg2GqzmHpfWkwz1/eg0n
         aTQjb6NNnk4M7v8fTkwxHVuZK4WEXY85nV0avHi9kJVu/pDOnzCOqjiYQYiC/MOAHHqu
         cGJjOT+KGzSOkLIZlZtM/D4wExnRhyRX+2JKvUpIjDDCsLWoBx52UC6exKnkz8qIALD9
         1BPvWuLtCqJCRkSAG/4DeRo858uEzqI+ZzezdlSPDUlAni96ETN/S00KclG+b0FjbEAe
         ncfA==
X-Gm-Message-State: APjAAAXIJEGGWZ36aFRnJIlqcLtvCwhDJKp5bvzurCa0J2IlyzdAGqEi
        aFrExJiZK+7Nz2+7HVoOUqfpDOhZXXLLs43uyxXIE2kY+fc=
X-Google-Smtp-Source: APXvYqw396edgjyJozSsCzajednRbbmIaB7gUQWyUQC+jR8mr25BB7Za7gjwtsrkkqmu/81ioRnRS6do1sBdvZD+Mmo=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr46665645otk.183.1559074010231;
 Tue, 28 May 2019 13:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 May 2019 22:06:23 +0200
Message-ID: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 6:05 PM David Howells <dhowells@redhat.com> wrote:
> Add a mount notification facility whereby notifications about changes in
> mount topology and configuration can be received.  Note that this only
> covers vfsmount topology changes and not superblock events.  A separate
> facility will be added for that.
[...]
> @@ -172,4 +167,18 @@ static inline void notify_mount(struct mount *changed,
>                                 u32 info_flags)
>  {
>         atomic_inc(&changed->mnt_notify_counter);
> +
> +#ifdef CONFIG_MOUNT_NOTIFICATIONS
> +       {
> +               struct mount_notification n = {
> +                       .watch.type     = WATCH_TYPE_MOUNT_NOTIFY,
> +                       .watch.subtype  = subtype,
> +                       .watch.info     = info_flags | sizeof(n),
> +                       .triggered_on   = changed->mnt_id,
> +                       .changed_mount  = aux ? aux->mnt_id : 0,
> +               };
> +
> +               post_mount_notification(changed, &n);
> +       }
> +#endif
>  }
[...]
> +void post_mount_notification(struct mount *changed,
> +                            struct mount_notification *notify)
> +{
> +       const struct cred *cred = current_cred();

This current_cred() looks bogus to me. Can't mount topology changes
come from all sorts of places? For example, umount_mnt() from
umount_tree() from dissolve_on_fput() from __fput(), which could
happen pretty much anywhere depending on where the last reference gets
dropped?

> +       struct path cursor;
> +       struct mount *mnt;
> +       unsigned seq;
> +
> +       seq = 0;
> +       rcu_read_lock();
> +restart:
> +       cursor.mnt = &changed->mnt;
> +       cursor.dentry = changed->mnt.mnt_root;
> +       mnt = real_mount(cursor.mnt);
> +       notify->watch.info &= ~WATCH_INFO_IN_SUBTREE;
> +
> +       read_seqbegin_or_lock(&rename_lock, &seq);
> +       for (;;) {
> +               if (mnt->mnt_watchers &&
> +                   !hlist_empty(&mnt->mnt_watchers->watchers)) {
> +                       if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
> +                               post_watch_notification(mnt->mnt_watchers,
> +                                                       &notify->watch, cred,
> +                                                       (unsigned long)cursor.dentry);
> +               } else {
> +                       cursor.dentry = mnt->mnt.mnt_root;
> +               }
> +               notify->watch.info |= WATCH_INFO_IN_SUBTREE;
> +
> +               if (cursor.dentry == cursor.mnt->mnt_root ||
> +                   IS_ROOT(cursor.dentry)) {
> +                       struct mount *parent = READ_ONCE(mnt->mnt_parent);
> +
> +                       /* Escaped? */
> +                       if (cursor.dentry != cursor.mnt->mnt_root)
> +                               break;
> +
> +                       /* Global root? */
> +                       if (mnt != parent) {
> +                               cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
> +                               mnt = parent;
> +                               cursor.mnt = &mnt->mnt;
> +                               continue;
> +                       }
> +                       break;

(nit: this would look clearer if you inverted the condition and wrote
it as "if (mnt == parent) break;", then you also wouldn't need that
"continue" or the braces)

> +               }
> +
> +               cursor.dentry = cursor.dentry->d_parent;
> +       }
> +
> +       if (need_seqretry(&rename_lock, seq)) {
> +               seq = 1;
> +               goto restart;
> +       }
> +
> +       done_seqretry(&rename_lock, seq);
> +       rcu_read_unlock();
> +}
[...]
> +SYSCALL_DEFINE5(mount_notify,
> +               int, dfd,
> +               const char __user *, filename,
> +               unsigned int, at_flags,
> +               int, watch_fd,
> +               int, watch_id)
> +{
> +       struct watch_queue *wqueue;
> +       struct watch_list *wlist = NULL;
> +       struct watch *watch;
> +       struct mount *m;
> +       struct path path;
> +       int ret;
> +
> +       if (watch_id < -1 || watch_id > 0xff)
> +               return -EINVAL;
> +
> +       ret = user_path_at(dfd, filename, at_flags, &path);

The third argument of user_path_at() contains kernel-private lookup
flags, I'm pretty sure userspace isn't supposed to be able to control
these directly.

> +       if (ret)
> +               return ret;
> +
> +       wqueue = get_watch_queue(watch_fd);
> +       if (IS_ERR(wqueue))
> +               goto err_path;
> +
> +       m = real_mount(path.mnt);
> +
> +       if (watch_id >= 0) {
> +               if (!m->mnt_watchers) {
> +                       wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
> +                       if (!wlist)
> +                               goto err_wqueue;
> +                       INIT_HLIST_HEAD(&wlist->watchers);
> +                       spin_lock_init(&wlist->lock);
> +                       wlist->release_watch = release_mount_watch;
> +               }
> +
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;
> +
> +               init_watch(watch, wqueue);
> +               watch->id               = (unsigned long)path.dentry;
> +               watch->private          = path.mnt;
> +               watch->info_id          = (u32)watch_id << 24;
> +
> +               down_write(&m->mnt.mnt_sb->s_umount);
> +               if (!m->mnt_watchers) {
> +                       m->mnt_watchers = wlist;
> +                       wlist = NULL;
> +               }
> +
> +               ret = add_watch_to_object(watch, m->mnt_watchers);
> +               if (ret == 0) {
> +                       spin_lock(&path.dentry->d_lock);
> +                       path.dentry->d_flags |= DCACHE_MOUNT_WATCH;
> +                       spin_unlock(&path.dentry->d_lock);
> +                       path_get(&path);

So... the watches on a mountpoint create references back to the
mountpoint? Is your plan that umount_tree() breaks the loop by getting
rid of the watches?

If so: Is there anything that prevents installing new watches after
umount_tree()? Because I don't see anything.

It might make sense to redesign this stuff so that watches don't hold
references on the object being watched.

> +               }
> +               up_write(&m->mnt.mnt_sb->s_umount);
> +               if (ret < 0)
> +                       kfree(watch);
> +       } else if (m->mnt_watchers) {
> +               down_write(&m->mnt.mnt_sb->s_umount);
> +               ret = remove_watch_from_object(m->mnt_watchers, wqueue,
> +                                              (unsigned long)path.dentry,
> +                                              false);
> +               up_write(&m->mnt.mnt_sb->s_umount);
> +       } else {
> +               ret = -EBADSLT;
> +       }
> +
> +err_wlist:
> +       kfree(wlist);
> +err_wqueue:
> +       put_watch_queue(wqueue);
> +err_path:
> +       path_put(&path);
> +       return ret;
> +}
