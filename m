Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCB413D18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhIUV5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235742AbhIUV5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632261334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nqGPuTR9hV9/gQK1uW2ilKva+/0/oNAJ6QmcB3GkWT8=;
        b=eVMwuvU1lamyhbUBNTfUibcJGCFp+Sag7Fn1Zd2q/uLeyQQ2TD2XV2Yi3qFHpgmW99oGax
        WQkehY4Z8xxOJTdUZ5Lj9m/c5O0QqTDpxpbpgLPq5ICSoX/okHBY9Ugh+EfhpBFzP/JyKu
        fTetpfJzqsXCQuxFOxKuVZwB3SqXZpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-mWz36W7_MmOwbVYA7Je0Ig-1; Tue, 21 Sep 2021 17:55:33 -0400
X-MC-Unique: mWz36W7_MmOwbVYA7Je0Ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC7CA19200D8;
        Tue, 21 Sep 2021 21:55:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF1618B5E;
        Tue, 21 Sep 2021 21:55:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jan Kara <jack@suse.cz>
cc:     dhowells@redhat.com, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: The new invalidate_lock seems to cause a potential deadlock with fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3439798.1632261329.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Sep 2021 22:55:29 +0100
Message-ID: <3439799.1632261329@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

It seems the new mapping invalidate_lock causes a potential deadlock with
fscache (see attached trace), though the system didn't actually deadlock.

It's quite possible that it's actually a false positive, since chain #1 be=
low
is holding locks in two different filesystems.

Note that this was with my fscache-iter-2 branch, but the I/O paths in use=
 are
mostly upstream and not much affected by that.

This was found whilst running xfstests over afs with a cache, and I'd reac=
hed
generic/346 when it tripped, so it seems to happen under very specific
circumstances.  Rerunning generic/346 by itself does reproduce the problem=
.

I'm wondering if I'm going to need to offload netfs_rreq_do_write_to_cache=
(),
which initiates the write to the cache, to a worker thread.

David
---

WARNING: possible circular locking dependency detected
5.15.0-rc1-build2+ #292 Not tainted
------------------------------------------------------
holetest/65517 is trying to acquire lock:
ffff88810c81d730 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_faul=
t+0x276/0x7a5

but task is already holding lock:
ffff8881595b53e8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x=
28d/0x59c

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mm->mmap_lock#2){++++}-{3:3}:
       validate_chain+0x3c4/0x4a8
       __lock_acquire+0x89d/0x949
       lock_acquire+0x2dc/0x34b
       __might_fault+0x87/0xb1
       strncpy_from_user+0x25/0x18c
       removexattr+0x7c/0xe5
       __do_sys_fremovexattr+0x73/0x96
       do_syscall_64+0x67/0x7a
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (sb_writers#10){.+.+}-{0:0}:
       validate_chain+0x3c4/0x4a8
       __lock_acquire+0x89d/0x949
       lock_acquire+0x2dc/0x34b
       cachefiles_write+0x2b3/0x4bb
       netfs_rreq_do_write_to_cache+0x3b5/0x432
       netfs_readpage+0x2de/0x39d
       filemap_read_page+0x51/0x94
       filemap_get_pages+0x26f/0x413
       filemap_read+0x182/0x427
       new_sync_read+0xf0/0x161
       vfs_read+0x118/0x16e
       ksys_read+0xb8/0x12e
       do_syscall_64+0x67/0x7a
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (mapping.invalidate_lock#3){.+.+}-{3:3}:
       check_noncircular+0xe4/0x129
       check_prev_add+0x16b/0x3a4
       validate_chain+0x3c4/0x4a8
       __lock_acquire+0x89d/0x949
       lock_acquire+0x2dc/0x34b
       down_read+0x40/0x4a
       filemap_fault+0x276/0x7a5
       __do_fault+0x96/0xbf
       do_fault+0x262/0x35a
       __handle_mm_fault+0x171/0x1b5
       handle_mm_fault+0x12a/0x233
       do_user_addr_fault+0x3d2/0x59c
       exc_page_fault+0x85/0xa5
       asm_exc_page_fault+0x1e/0x30

other info that might help us debug this:

Chain exists of:
  mapping.invalidate_lock#3 --> sb_writers#10 --> &mm->mmap_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock#2);
                               lock(sb_writers#10);
                               lock(&mm->mmap_lock#2);
  lock(mapping.invalidate_lock#3);

 *** DEADLOCK ***

1 lock held by holetest/65517:
 #0: ffff8881595b53e8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fau=
lt+0x28d/0x59c

stack backtrace:
CPU: 0 PID: 65517 Comm: holetest Not tainted 5.15.0-rc1-build2+ #292
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
Call Trace:
 dump_stack_lvl+0x45/0x59
 check_noncircular+0xe4/0x129
 ? print_circular_bug+0x207/0x207
 ? validate_chain+0x461/0x4a8
 ? add_chain_block+0x88/0xd9
 ? hlist_add_head_rcu+0x49/0x53
 check_prev_add+0x16b/0x3a4
 validate_chain+0x3c4/0x4a8
 ? check_prev_add+0x3a4/0x3a4
 ? mark_lock+0xa5/0x1c6
 __lock_acquire+0x89d/0x949
 lock_acquire+0x2dc/0x34b
 ? filemap_fault+0x276/0x7a5
 ? rcu_read_unlock+0x59/0x59
 ? add_to_page_cache_lru+0x13c/0x13c
 ? lock_is_held_type+0x7b/0xd3
 down_read+0x40/0x4a
 ? filemap_fault+0x276/0x7a5
 filemap_fault+0x276/0x7a5
 ? pagecache_get_page+0x2dd/0x2dd
 ? __lock_acquire+0x8bc/0x949
 ? pte_offset_kernel.isra.0+0x6d/0xc3
 __do_fault+0x96/0xbf
 ? do_fault+0x124/0x35a
 do_fault+0x262/0x35a
 ? handle_pte_fault+0x1c1/0x20d
 __handle_mm_fault+0x171/0x1b5
 ? handle_pte_fault+0x20d/0x20d
 ? __lock_release+0x151/0x254
 ? mark_held_locks+0x1f/0x78
 ? rcu_read_unlock+0x3a/0x59
 handle_mm_fault+0x12a/0x233
 do_user_addr_fault+0x3d2/0x59c
 ? pgtable_bad+0x70/0x70
 ? rcu_read_lock_bh_held+0xab/0xab
 exc_page_fault+0x85/0xa5
 ? asm_exc_page_fault+0x8/0x30
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x40192f
Code: ff 48 89 c3 48 8b 05 50 28 00 00 48 85 ed 7e 23 31 d2 4b 8d 0c 2f eb=
 0a 0f 1f 00 48 8b 05 39 28 00 00 48 0f af c2 48 83 c2 01 <48> 89 1c 01 48=
 39 d5 7f e8 8b 0d f2 27 00 00 31 c0 85 c9 74 0e 8b
RSP: 002b:00007f9931867eb0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 00007f9931868700 RCX: 00007f993206ac00
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00007ffc13e06ee0
RBP: 0000000000000100 R08: 0000000000000000 R09: 00007f9931868700
R10: 00007f99318689d0 R11: 0000000000000202 R12: 00007ffc13e06ee0
R13: 0000000000000c00 R14: 00007ffc13e06e00 R15: 00007f993206a000

