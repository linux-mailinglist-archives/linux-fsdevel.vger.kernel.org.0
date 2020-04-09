Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9A81A3AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDITgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 15:36:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40547 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDITgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id w26so1418815edu.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eblJGJkw4w1UEKYnbDX6zF9V7vMEXzIi4rXWl3QDYb4=;
        b=aFdqjV4lrgBjhfSKBcQ24Rk2ZchceA5m5q7el1vKb8vpIwmKRj84DAV/TWJxkqKuFt
         O1oDJ4Ewk40ZQwG3xm9odnDd4zCB5gL0zzFEELhT1WNha0YNvAjwy4EYFJ0z68D2HWxh
         kZIC7dKMpby4y4Qsi2K8UlLLI355iNl+8KXmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eblJGJkw4w1UEKYnbDX6zF9V7vMEXzIi4rXWl3QDYb4=;
        b=DUnG3P8/lE/+8f5wv7qOyL66/iJpJ7Fe8rMQEYn4KoxGzUIy/dgToZQcZ6uO6kCGka
         ywFAeeIqUhCp9fwaHZ3All6YPHMVfLYTShmc91v3bzoVbXcAfXC5sPQgsRFijuUJI71i
         S/LVW7m6e+UivF/kUNnE+7bm69fkkJM9IYgKE90SzYBV6tOTehW3KD4mli56tJgqo+sN
         /CbOEThTwzZw4wi68nFM8LRC3wfheyBVzVVEZ4BUaDC5TdxYCK/5LTJ7KFboqeUOvxcV
         cL4YJd7blEiZnX5MqUEnplooYyisJkVk4WRuMKjXwnE3FiYpeCd3JKdbTJRzqGN7GRHV
         AUMg==
X-Gm-Message-State: AGi0PuZMkrY8V/TfXceQ7QKsEmZTjr9AX+T9vSwWJIcb1UUclOqjL1Ly
        liZtE5LlvLcKre5s7C4sf7mutq/JKWQuN7gGTkRJrQ==
X-Google-Smtp-Source: APiQypI998ICFNbqu8mR+IGJhpH4E7oQiodXgAj6x/q+EeqcZygIgn3TYK2lDJ2f8hMc30PHwHrl+Vnl0AdTLu5YFpU=
X-Received: by 2002:a17:906:35ce:: with SMTP id p14mr613564ejb.43.1586461006313;
 Thu, 09 Apr 2020 12:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
 <20200409165048.GE23230@ZenIV.linux.org.uk> <20200409165446.GF23230@ZenIV.linux.org.uk>
 <20200409183008.GG23230@ZenIV.linux.org.uk>
In-Reply-To: <20200409183008.GG23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Apr 2020 21:36:35 +0200
Message-ID: <CAJfpegtZ3T+1bN-pg-vmVvWZs-7chDWxBr0T+j4x_Lt4x0T8MQ@mail.gmail.com>
Subject: Re: [PATCH v2] proc/mounts: add cursor
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 9, 2020 at 8:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Apr 09, 2020 at 05:54:46PM +0100, Al Viro wrote:
> > On Thu, Apr 09, 2020 at 05:50:48PM +0100, Al Viro wrote:
> > > On Thu, Apr 09, 2020 at 04:16:19PM +0200, Miklos Szeredi wrote:
> > > > Solve this by adding a cursor entry for each open instance.  Taking the
> > > > global namespace_sem for write seems excessive, since we are only dealing
> > > > with a per-namespace list.  Instead add a per-namespace spinlock and use
> > > > that together with namespace_sem taken for read to protect against
> > > > concurrent modification of the mount list.  This may reduce parallelism of
> > > > is_local_mountpoint(), but it's hardly a big contention point.  We could
> > > > also use RCU freeing of cursors to make traversal not need additional
> > > > locks, if that turns out to be neceesary.
> > >
> > > Umm...  That can do more than reduction of parallelism - longer lists take
> > > longer to scan and moving cursors dirties cachelines in a bunch of struct
> > > mount instances.  And I'm not convinced that your locking in m_next() is
> > > correct.
> > >
> > > What's to stop umount_tree() from removing the next entry from the list
> > > just as your m_next() tries to move the cursor?  I don't see any common
> > > locks for those two...
> >
> > Ah, you still have namespace_sem taken (shared) by m_start().  Nevermind
> > that one, then...  Let me get through mnt_list users and see if I can
> > catch anything.
>
> OK...  Locking is safe, but it's not obvious.  And your changes do make it
> scarier.   There are several kinds of lists that can be threaded through
> ->mnt_list and your code depends upon never having those suckers appear
> in e.g. anon namespace ->list.  It is true (AFAICS), but...

See analysis below.

> Another fun question is ns->mounts rules - it used to be "the number of
> entries in ns->list", now it's "the number of non-cursor entries there".
> Incidentally, we might have a problem with that logics wrt count_mount().

Nope, count_mount() iterates through the mount tree, not through mnt_ns->list.

> Sigh...  The damn thing has grown much too convoluted over years ;-/
>
> I'm still not happy with that patch; at the very least it needs a lot more
> detailed analysis to go along with it.

Functions touching mnt_list:

In pnode.c:

umount_one:
umount_list:
propagate_umount: both of the above are indirectly called from this.
The only caller is umount_tree(), which has lots of different call
paths, but in each one has namespace_sem taken for write:

do_move_mount
  attach_recursive_mnt
    umount_tree

do_loopback
  graft_tree
    attach_recursive_mnt
      umount_tree

do_new_mount_fc
  do_add_mount
    graft_tree
      attach_recursive_mnt
        umount_tree

finish_automount
  do_add_mount
    graft_tree
      attach_recursive_mnt
        umount_tree

do_umount
  shrink_submounts
    umount_tree

namespace.c:

__is_local_mountpoint: takes namespace_sem for read

commit_tree: has namespace_sem for write (only caller being
attach_recursive_mnt, see above for call paths).

m_start:
m_next:
m_show: all have namespace_sem for read

umount_tree: all callers have namespace_sem for write (se above for call paths)

do_umount: has namespace_sem for write

copy_tree: all members are newly allocated

iterate_mounts: operates on private copy built by collect_mounts()

open_detached_copy: takes namespace_sem for write

copy_mnt_ns: takes namespace_sem for write

mount_subtree: adds onto a newly allocated mnt_namespace

sys_fsmount: ditto

init_mount_tree: ditto

mnt_already_visible: takes namespace_sem for read

Patch adds ns_lock locking to all places that only have namespace_sem
for read.  So everyone is still excluded:  those taking namespace_sem
for write against everyone else obviously, and those taking
namespace_sem for read because they take ns_lock.

Thanks,
Miklos
