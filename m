Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69BF6ED29A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDXQhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXQhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A783A8C
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 09:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900A561EF7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 16:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC090C4339B;
        Mon, 24 Apr 2023 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682354272;
        bh=cGbeNAccoSO90UoZhchcy7oVqTIJOEUQ/nmBz8uEKL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDWuJ8LG4P0/NcjHrZGbkSQySkNL1vXdnEmXBBGK1zLRCe9Q5OU+qYUP6gMaUK+qw
         KKVG9tUrnvoBJTdvJqYNTim7a2NVL/VCdVf7huFC76OgAUJJGzpXE3cqeOcXziUTHF
         xidN3spbx9qfXQzduSWC93gKSUS4iNyHZKk3cIa6qei1lfDnrBCtTbQx6vobSEJSNy
         E7Yrh4547E0BEKblRhCGFFFCZ4uiZGorMk1Sp/bK0NSj8ZRLSe/TjyhmU4wWP9rcPC
         95BJPUCAN/ghni6hfcDHg940DhdymVnjfiLj1oxWvZveSLRudQGEBnTUCkZIHeE0bp
         2OpFpiNZfIxHg==
Date:   Mon, 24 Apr 2023 18:37:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/5] fs: fix __lookup_mnt() documentation
Message-ID: <20230424-wertminderung-primitiv-114cb1409828@brauner>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
 <20230202-fs-move-mount-replace-v1-3-9b73026d5f10@kernel.org>
 <20230421062838.GD3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421062838.GD3390869@ZenIV>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:28:38AM +0100, Al Viro wrote:
> On Sat, Mar 18, 2023 at 04:51:59PM +0100, Christian Brauner wrote:
> > The comment on top of __lookup_mnt() states that it finds the first
> > mount implying that there could be multiple mounts mounted at the same
> > dentry with the same parent.
> > 
> > This was true on old kernels where __lookup_mnt() could encounter a
> > stack of child mounts such that each child had the same parent mount and
> > was mounted at the same dentry. These were called "shadow mounts" and
> > were created during mount propagation. So back then if a mount @m in the
> > destination propagation tree already had a child mount @p mounted at
> > @mp then any mount @n we propagated to @m at the same @mp would be
> > appended after the preexisting mount @p in @mount_hashtable.
> > 
> > This hasn't been the case for quite a while now and I don't see an
> > obvious way how such mount stacks could be created in another way.
> 
> Not quite, actually - there's a nasty corner case where mnt_change_mountpoint()
> would create those.  And your subsequent patch steps into the same fun.
> Look: suppose the root of the tree you are feeding to attach_recursive_mnt()
> has managed to grow a mount right on top of its root.  The same will be
> reproduced in all its copies created by propagate_mnt().  Now, suppose
> one of the slaves of the place where we are trying to mount it on already
> has something mounted on it.  Well, we hit this:
>                 q = __lookup_mnt(&child->mnt_parent->mnt,
> 				 child->mnt_mountpoint);
> 		if (q)
> 			mnt_change_mountpoint(child, smp, q);
> which will tuck the child (a copy we'd made) under q (existing mount on
> top of the place that copy is for).  Result: 'q' overmounts the root of
> 'child' now.  So does the copy of whatever had been overmounting the
> root of 'source_mnt'...
> 
> And yes, it can happen.  Consider e.g. do_loopback(); we have looked
> up the mountpoint ('path'), we have looked up the subtree to copy
> ('old_path'), we had lock_mount(path) made sure that namespace_sem
> is held *and* path is not overmounted (followed into whatever
> overmounts that might have happened since we looked the mountpoint
> up).  Now, think what happens if 'old_path' is also overmounted while
> we are trying to get namespace_sem...

So I think I understand what you're saying and here's one example:

        (1) mount --bind /mnt /opt
        (2) fd_from = open_tree("/opt", OPEN_TREE_CLONE)
        (3) mount --bind /tmp /opt
        (4) mount_move(fd_from, fd_somewhere_else, ...)

Where the mount of (3) happens:

* after path lookup for fd_from in (2)
* before namespace_lock() is acquired by (2) and open_detached_copy()
  is called

So then open_detached_copy() and consequently __do_loopack() will see
and copy both (1) and (3) mounted on top of it. So roughly:

           (0) mnt->mnt_root                   = "/"
            |  real_mount(mnt)->mnt_mountpoint = "/"
            |  real_mount(mnt)->mnt_id         = 10
            |
fd_from ----└─ (1) mnt->mnt_root                       = "/mnt"
                |  real_mount(mnt)->mnt_mountpoint     = "/opt"
                |  real_mount(mnt)->mnt_id             = 20
                |  real_mount(mnt)->mnt_parent->mnt_id = 10
                |
                |      /* overmounted */
                └─ (3) mnt->mnt_root                       = "/tmp"
                       real_mount(mnt)->mnt_mountpoint     = "/mnt"
                       real_mount(mnt)->mnt_id             = 30
                       real_mount(mnt)->mnt_parent->mnt_id = 20

Then, if mount propagation were to happen into e.g., another mount
namespace as part of (4) where there's another mount (5) already mounted
at our mountpoint:

        (5) mount --bind /mnt /opt

        (0') mnt->mnt_root                  = "/"
         |  real_mount(mnt)->mnt_mountpoint = "/"
         |  real_mount(mnt)->mnt_id         = 100
         |
         └─ (5) mnt->mnt_root                       = "/mnt";
                real_mount(mnt)->mnt_mountpoint     = "/opt";
                real_mount(mnt)->mnt_id             = 50
                real_mount(mnt)->mnt_parent->mnt_id = 100

then we'd create a new copy (1') of the mount tree at (1):

        (0') mnt->mnt_root                   = "/"
         |   real_mount(mnt)->mnt_mountpoint = "/"
         |   real_mount(mnt)->mnt_id         = 100
         |                                               
         └─ (1') mnt->mnt_root                        = "/mnt"
             ||   real_mount(mnt)->mnt_mountpoint     = "/opt"
             ||   real_mount(mnt)->mnt_id             = 200
             ||   real_mount(mnt)->mnt_parent->mnt_id = 100
             ||                                              
             |└─ (3') mnt->mnt_root                       = "/tmp"
             |        real_mount(mnt)->mnt_mountpoint     = "/mnt"
             |        real_mount(mnt)->mnt_id             = 300
             |        real_mount(mnt)->mnt_parent->mnt_id = 200
             |                                               
             └─- (5)  mnt->mnt_root                       = "/mnt";
                      real_mount(mnt)->mnt_mountpoint     = "/mnt";
                      real_mount(mnt)->mnt_id             = 50
                      real_mount(mnt)->mnt_parent->mnt_id = 200

So remounting (5) on top of (1') aka tucking (1') beneath (5).
Afterwards we will have both (3') and (5) with (1') as parent at the
same mountpoint. Ugh...

However, I think that this is only possible with attached source mounts
that get moved? For anonymous mounts we know that there cannot be any
mounts on top of them since neither direct mounts nor indirect mounts
aka mount propagation onto anonymous mounts is possible unless you have
automounts triggered on them, I think.

> 
> A similar scenario exists for do_move_mount(), and there it's in
> a sense worse - there we have to cope with the possibility that
> from_dfd is an O_PATH descriptor created by fsmount().  And I'm
> not at all convinced that we can't arrange for automount point
> to be there and be triggered by the time of move_mount(2)...

Thanks for the pointers about automounts. That was very helpful.

So right now, any file descriptor returned from fsmount() will refer to
an anonymous mount and will thus have an anonymous mount namespace
attached to mnt->mnt_ns.

Any explicit attempt to use move_mount(2) or mount(2) to add a mount on
top of an O_PATH file descriptor gotten from fsmount() will fail in
check_mnt(). And any implicit attempt to add a mount on top of an
anonymous mount
file descriptor/mount via mount propagation will fail as well on
anonymous mounts.

This is behavior that userspace explicitly relies upon (I know of at
least 4 big projects.) as they use fsmount() and
open_tree(OPEN_TREE_CLONE) file descriptors in security sensitive
contexts where they can't risk suddenly have mounts appear in locations
where they don't expect them.

Reading through the code right now, I think it's clear that automounts
can be triggered on fsmount() or open_tree(OPEN_TREE_CLONE) fds even
before such mounts have been attached via move_mount(2).

So when we stumble upon an automount point that is located in an
anonymous mount we call finish_automount(->d_automount(), path).

So we end up in do_add_mount():

        struct mount *parent = real_mount(path->mnt);

(Ignoring for a second that "parent" is a misleading name here...)
and we know that parent->mnt_ns is an anonymous mount namespace, so we
fail:

          if (unlikely(!check_mnt(parent))) {

but then succeed and get past the next check:

                  /* ... and for those we'd better have mountpoint still alive */
                  if (!parent->mnt_ns)
                          return -EINVAL;

I'm not sure if that's intentional.

In any case, I would very much prefer if we were to simply refuse
automounts on top of anonymous mounts as well.

Not just is it extremly unlikely to be a use-case but it would also be
consistent in refusing mounting on top of anonymous mounts as mentioned
above:

diff --git a/fs/namespace.c b/fs/namespace.c
index 6836e937ee61..bf9f4d36ab98 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3095,6 +3095,11 @@ int finish_automount(struct vfsmount *m, const struct path *path)
                goto discard_locked;
        }

+       if (!is_anon_ns(real_mount(path->mnt)->mnt_ns)) {
+               err = -EINVAL;
+               goto discard_locked;
+       }
+
        err = do_add_mount(mnt, mp, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
        unlock_mount(mp);
        if (unlikely(err))

So we would require that automounts can only be triggered if the mount
they'll be mounted upon has been made visible in the filesystem.

This would also continue to provide guarantees to userspace when
operating on private mounts. What do you think?

> The reason it's worse is that here we can't just follow mounts
> all the way down - we want to take the entire mount tree associated
> with that descriptor.

I'm not clear yet why this is an issue. finish_automount() will call
__lookup_mount() and if anything is mounted on top path->mnt,dentry then
the automount is silently discarded under namespace_lock(), no? So there
should be mutual exclusion here, between move_mount(2) and
finish_automount().

> 
> > And
> > if that's possible it would invalidate assumptions made in other parts
> > of the code.
> 
> Details?  I'm not saying it's impossible - we might have a real bug in
> that area.
