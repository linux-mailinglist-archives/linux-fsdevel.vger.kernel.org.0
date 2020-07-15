Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43491221267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGOQc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgGOQc7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:32:59 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E7B2065E;
        Wed, 15 Jul 2020 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594830778;
        bh=+uLAH+itPHjULQo5bhc9wBdg14YcpBPRvVPHuJLv89A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukkkW0oKG0GURJFDKRMzbyKsogkYQmCeI1TEvWWl1+j//ZTxqMkMsGYLq398xpv/s
         rVKY8OOlB5Ma2lU5ghN/RkGQOzs7r6fBZb7aMkZhDJtQj9aHN9ySP4pS/2OcJJMC3x
         5OQiTXEtmNsbAqYuXjeGkvKbKMeCCYBAVnZxr7Z0=
Date:   Wed, 15 Jul 2020 09:32:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
Message-ID: <20200715163256.GB1167@sol.localdomain>
References: <0000000000004a4d6505aa7c688a@google.com>
 <20200715152912.GA2209203@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715152912.GA2209203@elver.google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc linux-fsdevel]

On Wed, Jul 15, 2020 at 05:29:12PM +0200, 'Marco Elver' via syzkaller-bugs wrote:
> On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1217a83b100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=570eb530a65cd98e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0f1e470df6a4316e0a11
> > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
> 
> Our guess is that this is either misuse of an API from userspace, or a
> bug. Can someone clarify?
> 
> Below are the snippets of code around these accesses.

Concurrent reads on the same file descriptor are allowed.  Not with sys_read(),
as that implicitly uses the file position.  But it's allowed with sys_pread(),
and also with sys_sendfile() which is the case syzbot is reporting here.

> 
> > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
> >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
> 
> 	...
> 	would_block:
> 		error = -EAGAIN;
> 	out:
> 		ra->prev_pos = prev_index;
> 		ra->prev_pos <<= PAGE_SHIFT;
> 2246)		ra->prev_pos |= prev_offset;
> 
> 		*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
> 		file_accessed(filp);
> 		return written ? written : error;
> 	}
> 	EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> 	...

Well, it's a data race.  Each open file descriptor has just one readahead state
(struct file_ra_state), and concurrent reads of the same file descriptor
use/change that readahead state without any locking.

Presumably this has traditionally been considered okay, since readahead is
"only" for performance and doesn't affect correctness.  And for performance
reasons, we want to avoid locking during file reads.

So we may just need to annotate all access to file_ra_state with
READ_ONCE() and WRITE_ONCE()...

> 
> >  generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
> >  ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
> >  call_read_iter include/linux/fs.h:1902 [inline]
> >  generic_file_splice_read+0x22a/0x310 fs/splice.c:312
> >  do_splice_to fs/splice.c:870 [inline]
> >  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
> >  do_splice_direct+0xf2/0x170 fs/splice.c:1059
> >  do_sendfile+0x562/0xb10 fs/read_write.c:1540
> >  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
> >  __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
> >  do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > read to 0xffff8880968747b0 of 8 bytes by task 6334 on cpu 1:
> >  generic_file_buffered_read+0x11e/0x19e0 mm/filemap.c:2011
> 
> 	...
> 	index = *ppos >> PAGE_SHIFT;
> 	prev_index = ra->prev_pos >> PAGE_SHIFT;
> 2011)	prev_offset = ra->prev_pos & (PAGE_SIZE-1);
> 	last_index = (*ppos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
> 	offset = *ppos & ~PAGE_MASK;
> 	...
> 
> >  generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
> >  ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
> >  call_read_iter include/linux/fs.h:1902 [inline]
> >  generic_file_splice_read+0x22a/0x310 fs/splice.c:312
> >  do_splice_to fs/splice.c:870 [inline]
> >  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
> >  do_splice_direct+0xf2/0x170 fs/splice.c:1059
> >  do_sendfile+0x562/0xb10 fs/read_write.c:1540
> >  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
> >  __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
> >  do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 6334 Comm: syz-executor.0 Not tainted 5.8.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > ==================================================================
> 
> Thanks,
> -- Marco
