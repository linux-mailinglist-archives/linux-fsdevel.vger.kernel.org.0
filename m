Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EA128D3C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbgJMSkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 14:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388132AbgJMSkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602614439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACbogWayPjxuroTC3rujC4ds8n4525cUMjBmRTXxGNo=;
        b=VhZ38HRj1ymBnxVmRn8iwHpQi6KK7xL50npninE813tNZ6kkDQrC45bXUVEJJi9VB3IFC2
        InnCmVnT6lOBJj/8h99K3oZH+mU9T15nIRA8PKl8rEOuPwl0037cRGAVV4nY9OxJN9Zf8G
        0UoWBpq49nBlFcZE4BPPSVEecfNIhMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-4gMiCSthM7C7ISxJt2_xXA-1; Tue, 13 Oct 2020 14:40:37 -0400
X-MC-Unique: 4gMiCSthM7C7ISxJt2_xXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDEC64091;
        Tue, 13 Oct 2020 18:40:35 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-207.rdu2.redhat.com [10.10.115.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 036FD60BF3;
        Tue, 13 Oct 2020 18:40:27 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AE841223D0F; Tue, 13 Oct 2020 14:40:26 -0400 (EDT)
Date:   Tue, 13 Oct 2020 14:40:26 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Qian Cai <cai@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: Unbreakable loop in fuse_fill_write_pages()
Message-ID: <20201013184026.GC142988@redhat.com>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:11:05PM -0400, Qian Cai wrote:
> Running some fuzzing on virtiofs with an unprivileged user on today's linux-next 
> could trigger soft-lockups below.
> 
> # virtiofsd --socket-path=/tmp/vhostqemu -o source=$TESTDIR -o cache=always -o no_posix_lock
> 
> Basically, everything was blocking on inode_lock(inode) because one thread
> (trinity-c33) was holding it but stuck in the loop in fuse_fill_write_pages()
> and unable to exit for more than 10 minutes before I executed sysrq-t.
> Afterwards, the systems was totally unresponsive:
> 
> kernel:NMI watchdog: Watchdog detected hard LOCKUP on cpu 8
> 
> To exit the loop, it needs,
> 
> iov_iter_advance(ii, tmp) to set "tmp" to non-zero for each iteration.
> 
> and
> 
> 	} while (iov_iter_count(ii) && count < fc->max_write &&
> 		 ap->num_pages < max_pages && offset == 0);
> 
> == the thread is stuck in the loop ==
> [10813.290694] task:trinity-c33     state:D stack:25888 pid:254219 ppid: 87180
> flags:0x00004004
> [10813.292671] Call Trace:
> [10813.293379]  __schedule+0x71d/0x1b50
> [10813.294182]  ? __sched_text_start+0x8/0x8
> [10813.295146]  ? mark_held_locks+0xb0/0x110
> [10813.296117]  schedule+0xbf/0x270
> [10813.296782]  ? __lock_page_killable+0x276/0x830
> [10813.297867]  io_schedule+0x17/0x60
> [10813.298772]  __lock_page_killable+0x33b/0x830

This seems to suggest that filemap_fault() is blocked on page lock and
is sleeping. For some reason it never wakes up. Not sure why.

And this will be called from.

fuse_fill_write_pages()
   iov_iter_fault_in_readable()

So fuse code will take inode_lock() and then looks like same process
is sleeping waiting on page lock. And rest of the processes get blocked
behind inode lock.

If we are woken up (while waiting on page lock), we should make forward
progress. Question is what page it is and why the entity which is
holding lock is not releasing lock.

Thanks
Vivek

> [10813.299695]  ? wait_on_page_bit+0x710/0x710
> [10813.300609]  ? __lock_page_or_retry+0x3c0/0x3c0
> [10813.301894]  ? up_read+0x1a3/0x730
> [10813.302791]  ? page_cache_free_page.isra.45+0x390/0x390
> [10813.304077]  filemap_fault+0x2bd/0x2040
> [10813.305019]  ? read_cache_page_gfp+0x10/0x10
> [10813.306041]  ? lock_downgrade+0x700/0x700
> [10813.306958]  ? replace_page_cache_page+0x1130/0x1130
> [10813.308124]  __do_fault+0xf5/0x530
> [10813.308968]  handle_mm_fault+0x1c0e/0x25b0
> [10813.309955]  ? copy_page_range+0xfe0/0xfe0
> [10813.310895]  do_user_addr_fault+0x383/0x820
> [10813.312084]  exc_page_fault+0x56/0xb0
> [10813.312979]  asm_exc_page_fault+0x1e/0x30
> [10813.313978] RIP: 0010:iov_iter_fault_in_readable+0x271/0x350
> fault_in_pages_readable at include/linux/pagemap.h:745
> (inlined by) iov_iter_fault_in_readable at lib/iov_iter.c:438
> [10813.315293] Code: 48 39 d7 0f 82 1a ff ff ff 0f 01 cb 0f ae e8 44 89 c0 8a 0a
> 0f 01 ca 88 4c 24 70 85 c0 74 da e9 f8 fe ff ff 0f 01 cb 0f ae e8 <8a> 11 0f 01
> ca 88 54 24 30 85 c0 0f 85 04 ff ff ff 48 29 ee e9
>  45
> [10813.319196] RSP: 0018:ffffc90017ccf830 EFLAGS: 00050246
> [10813.320446] RAX: 0000000000000000 RBX: 1ffff92002f99f08 RCX: 00007fe284f1004c
> [10813.322202] RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffff8887a7664000
> [10813.323729] RBP: 0000000000001000 R08: 0000000000000000 R09: 0000000000000000
> [10813.325282] R10: ffffc90017ccfd48 R11: ffffed102789d5ff R12: ffff8887a7664020
> [10813.326898] R13: ffffc90017ccfd40 R14: dffffc0000000000 R15: 0000000000e0df6a
> [10813.328456]  ? iov_iter_revert+0x8e0/0x8e0
> [10813.329404]  ? copyin+0x96/0xc0
> [10813.330230]  ? iov_iter_copy_from_user_atomic+0x1f0/0xa40
> [10813.331742]  fuse_perform_write+0x3eb/0xf20 [fuse]
> fuse_fill_write_pages at fs/fuse/file.c:1150
> (inlined by) fuse_perform_write at fs/fuse/file.c:1226
> [10813.332880]  ? fuse_file_fallocate+0x5f0/0x5f0 [fuse]
> [10813.334090]  fuse_file_write_iter+0x6b7/0x900 [fuse]
> [10813.335191]  do_iter_readv_writev+0x42b/0x6d0
> [10813.336161]  ? new_sync_write+0x610/0x610
> [10813.337194]  do_iter_write+0x11f/0x5b0
> [10813.338177]  ? __sb_start_write+0x229/0x2d0
> [10813.339169]  vfs_writev+0x16d/0x2d0
> [10813.339973]  ? vfs_iter_write+0xb0/0xb0
> [10813.340950]  ? __fdget_pos+0x9c/0xb0
> [10813.342039]  ? rcu_read_lock_sched_held+0x9c/0xd0
> [10813.343120]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [10813.344104]  ? find_held_lock+0x33/0x1c0
> [10813.345050]  do_writev+0xfb/0x1e0
> [10813.345920]  ? vfs_writev+0x2d0/0x2d0
> [10813.346802]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
> [10813.348026]  ? syscall_enter_from_user_mode+0x1c/0x50
> [10813.349197]  do_syscall_64+0x33/0x40
> [10813.350026]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 

