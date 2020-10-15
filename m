Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE028EA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgJOBsL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:48:11 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:38410 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727440AbgJOBsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:48:11 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-fE4Qn9W2MI6HBaeZ70ZikA-1; Wed, 14 Oct 2020 21:48:06 -0400
X-MC-Unique: fE4Qn9W2MI6HBaeZ70ZikA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D6091007464;
        Thu, 15 Oct 2020 01:48:04 +0000 (UTC)
Received: from ovpn-112-155.rdu2.redhat.com (ovpn-112-155.rdu2.redhat.com [10.10.112.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2009476669;
        Thu, 15 Oct 2020 01:48:02 +0000 (UTC)
Message-ID: <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
Subject: Re: [PATCH 0/4] Some more lock_page work..
From:   Qian Cai <cai@lca.pw>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Date:   Wed, 14 Oct 2020 21:48:02 -0400
In-Reply-To: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cai@lca.pw
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: lca.pw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-10-13 at 12:59 -0700, Linus Torvalds wrote:
> So this is all just preliminary, but I'd really like to have people
> think more about the page fault handling of the page lock, and I have
> a small experimental series of patches for people to look at and maybe
> get the discussion started.
> 
> The three first patches are really just fairly trivial cleanups. They
> also likely don't really matter, because the *bulk* of all faults -
> particularly the ones that really shouldn't need any page locking
> games - should be all about just "filemap_map_pages()". Which is that
> optimistic "let's insert pages from the page cache as efficiently as
> possible" case.
> 
> That's how all the normal private pages that don't actually get
> modified (so executables, but also any load that uses mmap as a
> zero-copy read) should generally get populated.
> 
> That code doesn't actually do "lock_page()" itself (because it all
> runs under the RCU read lock), but it does to do a trylock, and give
> up if the page was locked. Which is fine as long as you don't get any
> contention, but any concurrent faults of the same page in different
> address spaces will then just mess with other faulters and cause it to
> fall out of the fast path.
> 
> And looking at that code, I'm pretty sure it doesn't actually *need*
> the page lock. It wants the page lock for two reasons:
> 
>  - the truncation worries (which may or may not be relevant - xfs
> wraps the map_pages with xfs_ilock)
> 
>  - compound page worries (sub-page mapcount updates and page splitting issues)
> 
> The compound page case I'm not sure about, but it's probably fine to
> just lock the page in that case - once we end up actually just mapping
> a hugepage, the number of page faults should be small enough that it
> probably doesn't matter.
> 
> The truncation thing could be handled like xfs does, but honestly, I
> think it can equally well be handled by just doing some operations in
> the right order, and double-checking that we don't race with truncate.
> IOW, first increasing the page mapcount, and then re-checking that the
> page still isn't locked and the mapping is still valid, and reachable
> in the xarray.
> 
> Because we can still just drop out of this loop and not populate the
> page table if we see anything odd going on, but if *this* code doesn't
> bother getting the page lock (and we make the COW code not do it
> either), then in all the normal cases you will never have that "fall
> out of the common case".
> 
> IOW, I think right now the thing that makes us fall back to the actual
> page lock is this code itself: by doing the 'trylock", it will make
> other users of the same page not able to do the fast-case. And I think
> the trylock is unnecessary.
> 
> ANYWAY. The patch I have here isn't actually that "just do the checks
> in the right order" patch. No, it's a dirty nasty "a private mapping
> doesn't need to be so careful" patch. Ugly, brutish and nasty. Not the
> right thing at all. But I'm doing it here simply because I wanted to
> test it out and get people to look at this.
> 
> This code is "tested" in the sense that it builds for me, and I'm
> actually running it right now. But I haven't actually stress-tested it
> or tried to see if it gets rid of some page lock heavy cases.
> 
> Comments?
While on this topic, I just want to bring up a bug report that we are chasing an
issue that a process is stuck in the loop of wait_on_page_bit_common() for more
than 10 minutes before I gave up. Vivek did some instrumentation of code and can
confirm that there are no pending requests at virtiofs level. IOW, all requests
which have been issued, have completed, so this sounds more like a case of
missed wakup or some race in kernel. This can be reproduced on both the mainline
and linux-next by running syscall fuzzing on virtiofs by an unprivileged user. I
did also try to revert two recent commits from Linus touched
wait_on_page_bit_common(), but did not help.

The whole soft-lockups traces and sysrq-t can be found at:

https://caiqian.fedorapeople.org/files/dmesg.txt

[10813.290694] task:trinity-c33     state:D stack:25888 pid:254219 ppid: 87180 flags:0x00004004
[10813.292671] Call Trace:
[10813.293379]  __schedule+0x71d/0x1b50
[10813.294182]  ? __sched_text_start+0x8/0x8
[10813.295146]  ? mark_held_locks+0xb0/0x110
[10813.296117]  schedule+0xbf/0x270
[10813.296782]  ? __lock_page_killable+0x276/0x830
[10813.297867]  io_schedule+0x17/0x60
[10813.298772]  __lock_page_killable+0x33b/0x830
wait_on_page_bit_common at mm/filemap.c:1262
(inlined by) __lock_page_killable at mm/filemap.c:1540
[10813.299695]  ? wait_on_page_bit+0x710/0x710
[10813.300609]  ? __lock_page_or_retry+0x3c0/0x3c0
[10813.301894]  ? up_read+0x1a3/0x730
[10813.302791]  ? page_cache_free_page.isra.45+0x390/0x390
[10813.304077]  filemap_fault+0x2bd/0x2040
lock_page_maybe_drop_mmap at mm/filemap.c:2562
(inlined by) filemap_fault at mm/filemap.c:2727
[10813.305019]  ? read_cache_page_gfp+0x10/0x10
[10813.306041]  ? lock_downgrade+0x700/0x700
[10813.306958]  ? replace_page_cache_page+0x1130/0x1130
[10813.308124]  __do_fault+0xf5/0x530
[10813.308968]  handle_mm_fault+0x1c0e/0x25b0
[10813.309955]  ? copy_page_range+0xfe0/0xfe0
[10813.310895]  do_user_addr_fault+0x383/0x820
[10813.312084]  exc_page_fault+0x56/0xb0
[10813.312979]  asm_exc_page_fault+0x1e/0x30
[10813.313978] RIP: 0010:iov_iter_fault_in_readable+0x271/0x350
fault_in_pages_readable at include/linux/pagemap.h:745
(inlined by) iov_iter_fault_in_readable at lib/iov_iter.c:438
[10813.315293] Code: 48 39 d7 0f 82 1a ff ff ff 0f 01 cb 0f ae e8 44 89 c0 8a 0a 0f 01 ca 88 4c 24 70 85 c0 74 da e9 f8 fe ff ff 0f 01 cb 0f ae e8 <8a> 11 0f 01 ca 88 54 24 30 85 c0 0f 85 04 ff ff ff 48 29 ee e9
 45
[10813.319196] RSP: 0018:ffffc90017ccf830 EFLAGS: 00050246
[10813.320446] RAX: 0000000000000000 RBX: 1ffff92002f99f08 RCX: 00007fe284f1004c
[10813.322202] RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffff8887a7664000
[10813.323729] RBP: 0000000000001000 R08: 0000000000000000 R09: 0000000000000000
[10813.325282] R10: ffffc90017ccfd48 R11: ffffed102789d5ff R12: ffff8887a7664020
[10813.326898] R13: ffffc90017ccfd40 R14: dffffc0000000000 R15: 0000000000e0df6a
[10813.328456]  ? iov_iter_revert+0x8e0/0x8e0
[10813.329404]  ? copyin+0x96/0xc0
[10813.330230]  ? iov_iter_copy_from_user_atomic+0x1f0/0xa40
[10813.331742]  fuse_perform_write+0x3eb/0xf20 [fuse]
fuse_fill_write_pages at fs/fuse/file.c:1150
(inlined by) fuse_perform_write at fs/fuse/file.c:1226
[10813.332880]  ? fuse_file_fallocate+0x5f0/0x5f0 [fuse]
[10813.334090]  fuse_file_write_iter+0x6b7/0x900 [fuse]
[10813.335191]  do_iter_readv_writev+0x42b/0x6d0
[10813.336161]  ? new_sync_write+0x610/0x610
[10813.337194]  do_iter_write+0x11f/0x5b0
[10813.338177]  ? __sb_start_write+0x229/0x2d0
[10813.339169]  vfs_writev+0x16d/0x2d0
[10813.339973]  ? vfs_iter_write+0xb0/0xb0
[10813.340950]  ? __fdget_pos+0x9c/0xb0
[10813.342039]  ? rcu_read_lock_sched_held+0x9c/0xd0
[10813.343120]  ? rcu_read_lock_bh_held+0xb0/0xb0
[10813.344104]  ? find_held_lock+0x33/0x1c0
[10813.345050]  do_writev+0xfb/0x1e0
[10813.345920]  ? vfs_writev+0x2d0/0x2d0
[10813.346802]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[10813.348026]  ? syscall_enter_from_user_mode+0x1c/0x50
[10813.349197]  do_syscall_64+0x33/0x40
[10813.350026]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

