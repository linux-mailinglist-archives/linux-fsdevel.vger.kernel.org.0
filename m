Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826CD2D03F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfE1U2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 16:28:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33550 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfE1U2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 16:28:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id q186so188128oia.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2019 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuKi0Lrj/gnlG0yDmP5W4VS4eFGCxFFAUuByGlPfpSs=;
        b=iI5DG9iWxeE1M9pmJfVu+yF+adlXWBZiCOuet8amjQHCRakSew8UmyzNxLfcTWs0O5
         5+pAhroWrf4amjs92uV/exA7axrWuWcXlQcblXsKguehgaq/Dn08XQA4gkTpClCKJJHi
         D6N/YD+6R/UjishoBN+jyU17AO6bFgyYKvfknzHz2r4FMTzm4zz+XhjJ0U+5SVgoIX4j
         9NIJE6N/q+QRWGiVObr355sSuUG9EcE3jvNROfANUvN0I3qaebeoy/XXRjPNtbQACJXa
         qT/p/PGGEx2KlSn4ym4NmZP4L8I2FdDUQeSoRwoU7c0Hz/5xDhat5IjXouCA2E8O0PFu
         MZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuKi0Lrj/gnlG0yDmP5W4VS4eFGCxFFAUuByGlPfpSs=;
        b=V9RKuVPsR3EK+zjaw6licm6v8GIMVTWhSs7ncp5PxtTFj9MojnKSFbsda5jADpmDtk
         xu2a787EHxgSI80kam63KQrNo5r+c7dAj6ZhRP7/a1AFUVB28DSQflIJWONY6G3frVlS
         TNDhUtF1Bei/Y3bpDjTU2iy+44JhIMUEnArVxDLWPKBRkeLhANV2zfnaO2MSJx3Nc2Gu
         1o6nouOfBBYiNsIDEim9QV3MOUM8iq828X+J7SbOI68WGvDKLGbglamqVDQYAMBpKWmq
         vsPELwk1yNIacY+hrZIw+wQ3GBOoGPcm6z2LLECn+3PzzI4Rd4hEi4ULmqb8n+zCAmnV
         qD9Q==
X-Gm-Message-State: APjAAAVCKxYRROuVBwOfZly9CicC/+c88Ld+X9PE8hCVEs6OLq0/Hu1H
        NvimnSHMUAZCFcS29PhrQ6xMGF3Hm9GkKab+WrVY2SD3
X-Google-Smtp-Source: APXvYqwB4RI7vavuXb65zwSeIj1m8jm/dvYVljX1lggSRCxCCeQb74jw7pKp11+LXdoXT38oZIOZuHHec3g3IQ663xM=
X-Received: by 2002:aca:5708:: with SMTP id l8mr3914451oib.68.1559075294636;
 Tue, 28 May 2019 13:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905934373.7587.10824503964531598726.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905934373.7587.10824503964531598726.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 May 2019 22:27:47 +0200
Message-ID: <CAG48ez2o1egR13FDd3=CgdXP_MbBsZM4SX=+aqvR6eheWddhFg@mail.gmail.com>
Subject: Re: [PATCH 4/7] vfs: Add superblock notifications
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
> Add a superblock event notification facility whereby notifications about
> superblock events, such as I/O errors (EIO), quota limits being hit
> (EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
> process asynchronously.  Note that this does not cover vfsmount topology
> changes.  mount_notify() is used for that.
[...]
> +#ifdef CONFIG_SB_NOTIFICATIONS
> +/*
> + * Post superblock notifications.
> + */
> +void post_sb_notification(struct super_block *s, struct superblock_notification *n)
> +{
> +       post_watch_notification(s->s_watchers, &n->watch, current_cred(),
> +                               s->s_unique_id);
> +}

You're using current_cred() here? So the idea is that if some random
process runs into a disk I/O error, the I/O error will come from that
task's credentials? In general, you're not supposed to look at task
credentials in ->read/->write handlers.

> +static void release_sb_watch(struct watch_list *wlist, struct watch *watch)
> +{
> +       struct super_block *s = watch->private;
> +
> +       put_super(s);
> +}
> +
> +/**
> + * sys_sb_notify - Watch for superblock events.
> + * @dfd: Base directory to pathwalk from or fd referring to superblock.
> + * @filename: Path to superblock to place the watch upon
> + * @at_flags: Pathwalk control flags
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + */
> +SYSCALL_DEFINE5(sb_notify,
> +               int, dfd,
> +               const char __user *, filename,
> +               unsigned int, at_flags,
> +               int, watch_fd,
> +               int, watch_id)
> +{
> +       struct watch_queue *wqueue;
> +       struct super_block *s;
> +       struct watch_list *wlist = NULL;
> +       struct watch *watch;
> +       struct path path;
> +       int ret;
> +
> +       if (watch_id < -1 || watch_id > 0xff)
> +               return -EINVAL;
> +
> +       ret = user_path_at(dfd, filename, at_flags, &path);

As in the other patch, I don't think userspace is supposed to be able
to supply user_path_at()'s third argument.

It might make sense to require that the path points to the root inode
of the superblock? That way you wouldn't be able to do this on a bind
mount that exposes part of a shared filesystem to a container.

> +       if (ret)
> +               return ret;
> +
> +       wqueue = get_watch_queue(watch_fd);
> +       if (IS_ERR(wqueue))
> +               goto err_path;
> +
> +       s = path.dentry->d_sb;
> +       if (watch_id >= 0) {
> +               if (!s->s_watchers) {
> +                       wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
> +                       if (!wlist)
> +                               goto err_wqueue;
> +                       INIT_HLIST_HEAD(&wlist->watchers);
> +                       spin_lock_init(&wlist->lock);
> +                       wlist->release_watch = release_sb_watch;
> +               }
> +
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;
> +
> +               init_watch(watch, wqueue);
> +               watch->id               = s->s_unique_id;
> +               watch->private          = s;
> +               watch->info_id          = (u32)watch_id << 24;
> +
> +               down_write(&s->s_umount);
> +               ret = -EIO;
> +               if (atomic_read(&s->s_active)) {
> +                       if (!s->s_watchers) {
> +                               s->s_watchers = wlist;
> +                               wlist = NULL;
> +                       }
> +
> +                       ret = add_watch_to_object(watch, s->s_watchers);
> +                       if (ret == 0) {
> +                               spin_lock(&sb_lock);
> +                               s->s_count++;
> +                               spin_unlock(&sb_lock);

Why do watches hold references on the superblock they're watching?

> +                       }
> +               }
> +               up_write(&s->s_umount);
> +               if (ret < 0)
> +                       kfree(watch);
> +       } else if (s->s_watchers) {

This should probably have something like a READ_ONCE() for clarity?

> +               down_write(&s->s_umount);
> +               ret = remove_watch_from_object(s->s_watchers, wqueue,
> +                                              s->s_unique_id, false);
> +               up_write(&s->s_umount);
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
> +#endif
