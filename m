Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8791DE39A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgEVJ55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgEVJ5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 05:57:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24782C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 02:57:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so11922958ljc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 02:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zTT4v84DbNJrNGuRg9j5/ODbFJsAM/aU00CkLjhVRhU=;
        b=SwpRkcvJmno5jAejAy/rhvSBb67O1fb5ck7ZPITWACBKuY9dpmznRXbj6jV1lekY2q
         N3y3TEcMQaTRCUQd0wMizTnCZ/W0jJmaumg9DQSv1B7GhIOA3frDFwUSdnwO/ib//uEV
         gfXFaoyRbDESPUPkeH8vag9sW6FMD7WBTuNAVpJlfTik7ZlJdJo5uNm0yHjzQrCZrjl7
         3JnPblH7u3dStOMDUYpN4H+DDqKdw5ghXFIKrkn3Jw+/cNNvKOGSv4ShhU5Y6T50nkwF
         CaPntV9EMDk2coTroj+KBdScfrKZKVFDI1m9iKxOxfERt0u/vRmiy8BW5uaYlHF8pj+v
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zTT4v84DbNJrNGuRg9j5/ODbFJsAM/aU00CkLjhVRhU=;
        b=m3kmTSOrbnhR5hKhFFY5E2e0Yp071SDCXVGx5rsP8378UBuMbg/D7eH/Cqlmv4v4zw
         eJBtv/UOq7N0JL/2CWJbFPpcoptTnmV28h3eDfbV4m4j0AZVzs+Jn6VBld9GIGsNklZn
         DTX3LyhKk5t9wLg6ekOImduzRPqju3mafVo0yI6dGZxn3/snhEZva2JEroTtUANTFf4+
         eLNhk6ID4x0M6d8QLCUMnNE9GUvL9tDPFhYPK9REQVhcBarA9bdNW6sTXyWHxCUCBSIR
         BbtpTawg8SpGTuO9+1kMUCunJHZzo2f8TfNCGK7b8glYupSUEnR9rqQFUkRdQvZDcO3L
         anlQ==
X-Gm-Message-State: AOAM530ih2Mcektu3rFWXMYH9bcxCgNiMYdcd+JP8ItkRbt4KnMbUe4v
        db3/WsCAVgImIG6ln7oQvRCm2AlASfMUglOQzNVscQ==
X-Google-Smtp-Source: ABdhPJwvWpHdh12TXJb5Ol2McEEtJCHFS5m/5WUTO909JKTAY8DS+sYl6Sva05hNjkBeAQy4DdsXOSk/koy0cqXwe7I=
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr6908884ljo.227.1590141473342;
 Fri, 22 May 2020 02:57:53 -0700 (PDT)
MIME-Version: 1.0
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 22 May 2020 11:57:42 +0200
Message-ID: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
Subject: Writeback bug causing writeback stalls
To:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        android-storage-core@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We've been working on implementing a FUSE filesystem in Android, and have
run into what appears to be a bug in the kernel writeback code. The problem
that we observed is that an inode in the filesystem is on the b_dirty_time list,
but its i_state field does have I_DIRTY_PAGES set, which I think means that
the inode is on the wrong list. This condition doesn't appear to fix itself even
as new pages are dirtied, because __mark_inode_dirty() has this check:

    if ((inode->i_state & flags) != flags) {

before considering moving the inode to another list. Since the inode already
has I_DIRTY_PAGES set, we're not going to move it to the dirty list. I *think*
the only way the inode gets out of this condition is whenever we handle the
b_dirty_time list, which can take a while.

The reason we even noticed this bug in the first place is that FUSE has a very
low wb max_ratio by default (1), and so at some point processes get stuck in
balance_dirty_pages_ratelimited(), waiting for pages to be written. They hold
the inode's write lock, and when other processes try to acquire it, they get
stuck. We have a watchdog that reboots the device after ~10 mins of a task
being stuck in D state, and this triggered regularly in some tests.

After careful studying of the kernel code, I found a reliable repro scenario
for this condition, which is described in more detail below. But essentially
what I think is happening is this:

__mark_inode_dirty() has an early return condition for when a sync is in
progress, where it updates the inode i_state but not the writeback list:

    inode->i_state |= flags;

    /*
    * If the inode is being synced, just update its dirty state.
    * The unlocker will place the inode on the appropriate
    * superblock list, based upon its state.
    */
    if (inode->i_state & I_SYNC)
        goto out_unlock_inode;

now this comment is true for the generic flusher threads, which run
writeback_sb_inodes(), which calls requeue_inode() to move the inode back to the
correct wb list when the sync is done. However, there is another
function that uses
I_SYNC: writeback_single_inode(). This function has some comments saying it
prefers not to touch writeback lists, and in fact only removes it if the inode
is clean:

    /*
    * Skip inode if it is clean and we have no outstanding writeback in
    * WB_SYNC_ALL mode. We don't want to mess with writeback lists in this
    * function since flusher thread may be doing for example sync in
    * parallel and if we move the inode, it could get skipped. So here we
    * make sure inode is on some writeback list and leave it there unless
    * we have completely cleaned the inode.
    */

writeback_single_inode() is called from a few functions, in particular
write_inode_now(). write_inode_now() is called by FUSE's flush() f_ops.

So, the sequence of events is something like this. Let's assume the inode is
already on b_dirty_time for valid reasons. Then:

CPU1                                          CPU2
fuse_flush()
  write_inode_now()
    writeback_single_inode()
      sets I_SYNC
        __writeback_single_inode()
          writes back data
          clears inode dirty flags
          unlocks inode
          calls mark_inode_dirty_sync()
            sets I_DIRTY_SYNC, but doesn't
            update wb list because I_SYNC is
            still set
                                              write() // somebody else writes
                                              mark_inode_dirty(I_DIRTY_PAGES)
                                              sets I_DIRTY_PAGES on i_state
                                              doesn't update wb list,
                                              because I_SYNC set
      locks inode again
      sees inode is still dirty,
      doesn't touch WB list
      clears I_SYNC

So now we have an inode on b_dirty_time with I_DIRTY_PAGES | I_DIRTY_SYNC set,
and subsequent calls to mark_inode_dirty() with either I_DIRTY_PAGES or
I_DIRTY_SYNC will do nothing to change that. The flusher won't touch
the inode either,
because it's not on a b_dirty or b_io list.

The easiest way to fix this, I think, is to call requeue_inode() at the end of
writeback_single_inode(), much like it is called from writeback_sb_inodes().
However, requeue_inode() has the following ominous warning:

/*
 * Find proper writeback list for the inode depending on its current state and
 * possibly also change of its state while we were doing writeback.  Here we
 * handle things such as livelock prevention or fairness of writeback among
 * inodes. This function can be called only by flusher thread - noone else
 * processes all inodes in writeback lists and requeueing inodes behind flusher
 * thread's back can have unexpected consequences.
 */

Obviously this is very critical code both from a correctness and a performance
point of view, so I wanted to run this by the maintainers and folks who have
contributed to this code first.

The way I got to reproduce this reliably was by using what is pretty much a
pass-through FUSE filesystem, and the following two commands run in parallel:

[1] fio --rw=write --size=5G -blocksize=80000 --name=test --directory=/sdcard/

[2] while true; do echo flushme >> /sdcard/test.0.0; sleep 0.1; done

I doubt the blocksize matters, it's just the blocksize that I observed being
used in one of our testruns that hit this. [2] essentially calls fuse_flush()
every 100ms, which is often enough to reproduce this problem within seconds;
FIO will stall and enter balance_dirty_pages_ratelimited(), and [2] will hang
because it needs the inode write lock.

Other filesystems may hit the same problem, though write_inode_now() is usually
only used when no more dirty pages are expected (eg in final iput()). There are
some other functions that call writeback_single_inode() that are more
widely used,
like sync_inode() and sync_inode_metadata().

Curious to hear your thoughts on this. I'm happy to provide more info
or traces if
needed.

Thanks,
Martijn
