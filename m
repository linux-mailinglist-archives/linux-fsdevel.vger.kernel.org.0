Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7343E16529A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 23:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBSWk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 17:40:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39949 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgBSWk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:40:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so1804856otr.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 14:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBxCdi3L8aoOa1V78TxaCs1jwLDS9b9YVxFO0d+RY8c=;
        b=t12J5Wbmu20TwAN7nQacF0tWVhUKmTUJpIf5w7rrNuso8Q4Y8gZitvIX0VK7UHY2lp
         nB0nCvVrS+xdqZ/bxW7RnvvT2aVJkTCopxRY4vl+3yrg9xbWRIszIZkNi3opmDZ27Yd6
         8LHFGO48gyKi2S/oh1+HSR+7hK0Ug8ysBSu5j/kwxkNAbRXdYKmx+IJHuFLIIyQKiYQq
         rpOoQCQ2gMcx2KTV1klaMK+O3oituKncvOct1vc9Z/SgFXDZcWt6JzIoSmyKpZMXBigl
         yxQIxRSVrTbkr7HyYNFNzzwfA25Z/rya+pqTkoUJ/nOCM31g1g3CRlerAcI6rbTknQb4
         WIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBxCdi3L8aoOa1V78TxaCs1jwLDS9b9YVxFO0d+RY8c=;
        b=hZXdWSafsKohCfm8WouUBdxYD9nnmRhSx/Reei58Qv5ooq37oLNGNZKklYhkcAE3KN
         JJoA3TtLA/0MxfWwaMO+lbIChv2+q2rTBs4wp1D2uafNI9GiDQ4ztk/fATlM4sxHGuqO
         BpzNmm+Hm+o2Qe5QONW746OZyg4N5jWZM/VqIxA2sJxPjnRPHAzOx3a0N9a7U9zgg1ih
         nv2o6vwQhEEqWB+JdXwxo0N4x+Brxr7Yqri4I5Dvsf4Xw0bh2VGHbuQZ04JcmGkzQ9gS
         3ZLx+NTFNOy6z5mSIXx6H3RAFWFwNOap34emoLC4PwuYjTAEHszsGHZB7FnWO8RNerom
         nf3Q==
X-Gm-Message-State: APjAAAXNcsUDGON5dMu9urUVWxG4aixW7VyEXwpfJhIiDPGylPHSgKmW
        lzafwG9pO+1/DbvJ108r1hFarWYtlWYDVjp6zj31sw==
X-Google-Smtp-Source: APXvYqwDzIK8CwA42369kNWdccV2lBZQvxbaqLa7dEqyLvsXTePxB1Z+7n3/98HFTV732n+LrcdLOFWufC2PTXAz0Bg=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr20773553oti.32.1582152027974;
 Wed, 19 Feb 2020 14:40:27 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 23:40:01 +0100
Message-ID: <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com>
Subject: Re: [PATCH 13/19] vfs: Add a mount-notification facility [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
> Add a mount notification facility whereby notifications about changes in
> mount topology and configuration can be received.  Note that this only
> covers vfsmount topology changes and not superblock events.  A separate
> facility will be added for that.
[...]
> @@ -70,9 +71,13 @@ struct mount {
>         int mnt_id;                     /* mount identifier */
>         int mnt_group_id;               /* peer group identifier */
>         int mnt_expiry_mark;            /* true if marked for expiry */
> +       int mnt_nr_watchers;            /* The number of subtree watches tracking this */

You're never referencing this variable elsewhere in the patch, and it
also isn't gated by #ifdef.

>         struct hlist_head mnt_pins;
>         struct hlist_head mnt_stuck_children;
>         atomic_t mnt_change_counter;    /* Number of changed applied */
> +#ifdef CONFIG_MOUNT_NOTIFICATIONS
> +       struct watch_list *mnt_watchers; /* Watches on dentries within this mount */

Please document lifetime semantics. Something like "This pointer can't
change once it has been set to a non-NULL value".

> +#endif
>  } __randomize_layout;
>
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
> @@ -155,18 +160,8 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
>         return ns->seq == 0;
>  }
>
> -/*
> - * Type of mount topology change notification.
> - */
> -enum mount_notification_subtype {
> -       NOTIFY_MOUNT_NEW_MOUNT  = 0, /* New mount added */
> -       NOTIFY_MOUNT_UNMOUNT    = 1, /* Mount removed manually */
> -       NOTIFY_MOUNT_EXPIRY     = 2, /* Automount expired */
> -       NOTIFY_MOUNT_READONLY   = 3, /* Mount R/O state changed */
> -       NOTIFY_MOUNT_SETATTR    = 4, /* Mount attributes changed */
> -       NOTIFY_MOUNT_MOVE_FROM  = 5, /* Mount moved from here */
> -       NOTIFY_MOUNT_MOVE_TO    = 6, /* Mount moved to here (compare op_id) */
> -};

Is there a reason why you introduce these in "vfs: Add mount change
counter", then in this patch move them elsewhere?

[...]
> @@ -174,4 +169,18 @@ static inline void notify_mount(struct mount *changed,
>                                 u32 info_flags)
>  {
>         atomic_inc(&changed->mnt_change_counter);
> +
> +#ifdef CONFIG_MOUNT_NOTIFICATIONS
> +       {
> +               struct mount_notification n = {
> +                       .watch.type     = WATCH_TYPE_MOUNT_NOTIFY,
> +                       .watch.subtype  = subtype,
> +                       .watch.info     = info_flags | watch_sizeof(n),
> +                       .triggered_on   = changed->mnt_id,
> +                       .changed_mount  = aux ? aux->mnt_id : 0,
> +               };
> +
> +               post_mount_notification(changed, &n);
> +       }
> +#endif
[...]
> +/*
> + * Post mount notifications to all watches going rootwards along the tree.
> + *
> + * Must be called with the mount_lock held.

Please put such constraints into lockdep assertions instead of
comments; that way, violations can actually be detected.

> + */
> +void post_mount_notification(struct mount *changed,
> +                            struct mount_notification *notify)
> +{
> +       const struct cred *cred = current_cred();
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
> +       notify->watch.info &= ~NOTIFY_MOUNT_IN_SUBTREE;
> +
> +       read_seqbegin_or_lock(&rename_lock, &seq);
> +       for (;;) {
> +               if (mnt->mnt_watchers &&

unlocked test should use READ_ONCE() to document that the read value
can concurrently change

> +                   !hlist_empty(&mnt->mnt_watchers->watchers)) {
> +                       if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
> +                               post_watch_notification(mnt->mnt_watchers,
> +                                                       &notify->watch, cred,
> +                                                       (unsigned long)cursor.dentry);
> +               } else {
> +                       cursor.dentry = mnt->mnt.mnt_root;
> +               }
> +               notify->watch.info |= NOTIFY_MOUNT_IN_SUBTREE;
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
> +                       if (mnt == parent)
> +                               break;
> +
> +                       cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
> +                       mnt = parent;
> +                       cursor.mnt = &mnt->mnt;
> +               } else {
> +                       cursor.dentry = cursor.dentry->d_parent;
> +               }
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
> +
> +static void release_mount_watch(struct watch *watch)
> +{
> +       struct dentry *dentry = (struct dentry *)(unsigned long)watch->id;
> +
> +       dput(dentry);
> +}
> +
> +/**
> + * sys_watch_mount - Watch for mount topology/attribute changes
> + * @dfd: Base directory to pathwalk from or fd referring to mount.
> + * @filename: Path to mount to place the watch upon
> + * @at_flags: Pathwalk control flags
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + */
> +SYSCALL_DEFINE5(watch_mount,
> +               int, dfd,
> +               const char __user *, filename,
> +               unsigned int, at_flags,
> +               int, watch_fd,
> +               int, watch_id)
> +{
> +       struct watch_queue *wqueue;
> +       struct watch_list *wlist = NULL;
> +       struct watch *watch = NULL;
> +       struct mount *m;
> +       struct path path;
> +       unsigned int lookup_flags =
> +               LOOKUP_DIRECTORY | LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
> +       int ret;
> +
> +       if (watch_id < -1 || watch_id > 0xff)
> +               return -EINVAL;
> +       if ((at_flags & ~(AT_NO_AUTOMOUNT | AT_EMPTY_PATH)) != 0)
> +               return -EINVAL;
> +       if (at_flags & AT_NO_AUTOMOUNT)
> +               lookup_flags &= ~LOOKUP_AUTOMOUNT;
> +       if (at_flags & AT_EMPTY_PATH)
> +               lookup_flags |= LOOKUP_EMPTY;
> +
> +       ret = user_path_at(dfd, filename, lookup_flags, &path);
> +       if (ret)
> +               return ret;
> +
> +       ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
> +       if (ret)
> +               goto err_path;
> +
> +       wqueue = get_watch_queue(watch_fd);
> +       if (IS_ERR(wqueue))
> +               goto err_path;
> +
> +       m = real_mount(path.mnt);
> +
> +       if (watch_id >= 0) {
> +               ret = -ENOMEM;
> +               if (!m->mnt_watchers) {

unlocked test should use READ_ONCE

> +                       wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
> +                       if (!wlist)
> +                               goto err_wqueue;
> +                       init_watch_list(wlist, release_mount_watch);
> +               }
> +
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;
> +
> +               init_watch(watch, wqueue);
> +               watch->id               = (unsigned long)path.dentry;
> +               watch->info_id          = (u32)watch_id << 24;
> +
> +               ret = security_watch_mount(watch, &path);
> +               if (ret < 0)
> +                       goto err_watch;
> +
> +               down_write(&m->mnt.mnt_sb->s_umount);
> +               if (!m->mnt_watchers) {
> +                       m->mnt_watchers = wlist;
> +                       wlist = NULL;
> +               }
> +
> +               ret = add_watch_to_object(watch, m->mnt_watchers);

If another thread concurrently runs close(watch_fd) at this point,
pipe_release -> put_pipe_info -> free_pipe_info -> watch_queue_clear
will run, correct? And then watch_queue_clear() will find the watch
that we've just created and call its ->release_watch() handler, which
causes dput() on path.dentry? At that point, we no longer hold any
reference to the dentry...

> +               if (ret == 0) {
> +                       spin_lock(&path.dentry->d_lock);
> +                       path.dentry->d_flags |= DCACHE_MOUNT_WATCH;
> +                       spin_unlock(&path.dentry->d_lock);
> +                       dget(path.dentry);

... but then here we call dget() on it?


In general, the following pattern indicates a bug unless a surrounding
lock provides the necessary protection:

ret = operation_that_hands_off_the_reference_on_success(ptr);
if (ret == SUCCESS) {
  increment_refcount(ptr);
}

and should be replaced with the following pattern:

increment_refcount(ptr);
ret = operation_that_hands_off_the_reference_on_success(ptr);
if (ret == FAILURE) {
  decrement_refcount(ptr);
}

> +                       watch = NULL;
> +               }
> +               up_write(&m->mnt.mnt_sb->s_umount);
> +       } else {
> +               ret = -EBADSLT;
> +               if (m->mnt_watchers) {
> +                       down_write(&m->mnt.mnt_sb->s_umount);
> +                       ret = remove_watch_from_object(m->mnt_watchers, wqueue,
> +                                                      (unsigned long)path.dentry,
> +                                                      false);

What exactly is the implication of only using the dentry as key here
(and not the mount)? Does this mean that if you watch install watches
on two bind mounts of the same underlying filesystem, the notification
mechanism gets confused?

> +                       up_write(&m->mnt.mnt_sb->s_umount);
> +               }
> +       }
> +
> +err_watch:
> +       kfree(watch);
> +err_wlist:
> +       kfree(wlist);
> +err_wqueue:
> +       put_watch_queue(wqueue);
> +err_path:
> +       path_put(&path);
> +       return ret;
> +}
[...]
