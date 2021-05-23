Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC39D38D92E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 May 2021 07:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhEWFwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 01:52:40 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55329 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEWFwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 01:52:39 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 85EFB100003;
        Sun, 23 May 2021 05:51:04 +0000 (UTC)
Date:   Sat, 22 May 2021 22:51:02 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <YKntRtEUoxTEFBOM@localhost>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 11:13:28PM -0600, Andreas Dilger wrote:
> On May 17, 2021, at 9:06 AM, David Howells <dhowells@redhat.com> wrote:
> > With filesystems like ext4, xfs and btrfs, what are the limits on directory
> > capacity, and how well are they indexed?
> > 
> > The reason I ask is that inside of cachefiles, I insert fanout directories
> > inside index directories to divide up the space for ext2 to cope with the
> > limits on directory sizes and that it did linear searches (IIRC).
> > 
> > For some applications, I need to be able to cache over 1M entries (render
> > farm) and even a kernel tree has over 100k.
> > 
> > What I'd like to do is remove the fanout directories, so that for each logical
> > "volume"[*] I have a single directory with all the files in it.  But that
> > means sticking massive amounts of entries into a single directory and hoping
> > it (a) isn't too slow and (b) doesn't hit the capacity limit.
> 
> Ext4 can comfortably handle ~12M entries in a single directory, if the
> filenames are not too long (e.g. 32 bytes or so).  With the "large_dir"
> feature (since 4.13, but not enabled by default) a single directory can
> hold around 4B entries, basically all the inodes of a filesystem.

ext4 definitely seems to be able to handle it. I've seen bottlenecks in
other parts of the storage stack, though.

With a normal NVMe drive, a dm-crypt volume containing ext4, and discard
enabled (on both ext4 and dm-crypt), I've seen rm -r of a directory with
a few million entries (each pointing to a ~4-8k file) take the better
part of an hour, almost all of it system time in iowait. Also makes any
other concurrent disk writes hang, even a simple "touch x". Turning off
discard speeds it up by several orders of magnitude.

(I don't know if this is a known issue or not, so here are the details
just in case it isn't. Also, if this is already fixed in a newer kernel,
my apologies for the outdated report.)

$ uname -a
Linux s 5.10.0-6-amd64 #1 SMP Debian 5.10.28-1 (2021-04-09) x86_64 GNU/Linux

Reproducer (doesn't take *as* long but still long enough to demonstrate
the issue):
$ mkdir testdir
$ time python3 -c 'for i in range(1000000): open(f"testdir/{i}", "wb").write(b"test data")'
$ time rm -r testdir

dmesg details:

INFO: task rm:379934 blocked for more than 120 seconds.
      Not tainted 5.10.0-6-amd64 #1 Debian 5.10.28-1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rm              state:D stack:    0 pid:379934 ppid:379461 flags:0x00004000
Call Trace:
 __schedule+0x282/0x870
 schedule+0x46/0xb0
 wait_transaction_locked+0x8a/0xd0 [jbd2]
 ? add_wait_queue_exclusive+0x70/0x70
 add_transaction_credits+0xd6/0x2a0 [jbd2]
 start_this_handle+0xfb/0x520 [jbd2]
 ? jbd2__journal_start+0x8d/0x1e0 [jbd2]
 ? kmem_cache_alloc+0xed/0x1f0
 jbd2__journal_start+0xf7/0x1e0 [jbd2]
 __ext4_journal_start_sb+0xf3/0x110 [ext4]
 ext4_evict_inode+0x24c/0x630 [ext4]
 evict+0xd1/0x1a0
 do_unlinkat+0x1db/0x2f0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f088f0c3b87
RSP: 002b:00007ffc8d3a27a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 000055ffee46de70 RCX: 00007f088f0c3b87
RDX: 0000000000000000 RSI: 000055ffee46df78 RDI: 0000000000000004
RBP: 000055ffece9daa0 R08: 0000000000000100 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc8d3a2980 R14: 00007ffc8d3a2980 R15: 0000000000000002
INFO: task touch:379982 blocked for more than 120 seconds.
      Not tainted 5.10.0-6-amd64 #1 Debian 5.10.28-1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:touch           state:D stack:    0 pid:379982 ppid:379969 flags:0x00000000
Call Trace:
 __schedule+0x282/0x870
 schedule+0x46/0xb0
 wait_transaction_locked+0x8a/0xd0 [jbd2]
 ? add_wait_queue_exclusive+0x70/0x70
 add_transaction_credits+0xd6/0x2a0 [jbd2]
 ? xas_load+0x5/0x70
 ? find_get_entry+0xd1/0x170
 start_this_handle+0xfb/0x520 [jbd2]
 ? jbd2__journal_start+0x8d/0x1e0 [jbd2]
 ? kmem_cache_alloc+0xed/0x1f0
 jbd2__journal_start+0xf7/0x1e0 [jbd2]
 __ext4_journal_start_sb+0xf3/0x110 [ext4]
 __ext4_new_inode+0x721/0x1670 [ext4]
 ext4_create+0x106/0x1b0 [ext4]
 path_openat+0xde1/0x1080
 do_filp_open+0x88/0x130
 ? getname_flags.part.0+0x29/0x1a0
 ? __check_object_size+0x136/0x150
 do_sys_openat2+0x97/0x150
 __x64_sys_openat+0x54/0x90
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb2afb8fbe7
RSP: 002b:00007ffee3e287b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffee3e28a68 RCX: 00007fb2afb8fbe7
RDX: 0000000000000941 RSI: 00007ffee3e2a340 RDI: 00000000ffffff9c
RBP: 00007ffee3e2a340 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000941
R13: 00007ffee3e2a340 R14: 0000000000000000 R15: 0000000000000000


