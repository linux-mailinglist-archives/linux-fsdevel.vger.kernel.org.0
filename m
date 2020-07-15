Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B402212E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGOQpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgGOQpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:45:47 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B8C08C5DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 09:45:46 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k22so2738855oib.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TcWWArm6s2MYIjyVq/UCCy6oJdlx6ARoFnt89Ui6x0=;
        b=sV6IQzmmJdgqjSlPefWQO1LQG41ajK49ClTNxi6vcAcJc/xoMmC9RgSCHTvxuCLRvB
         6r0LmXLs0zGlQP4Bfu5p1odS+zZkvmVlrXy5fRe1JH78zAZSUu26SJ3MKgENdjkjskAq
         Lq5wuzeEDZGN5gIFi0BN/c7vv18aLxvT45YmKGMTsreDy9SmXD6Zv+PAA1RykgpGxonv
         vVEoHX+nbl2KYuqhwf72Owy17ueFZHrtvvRM15bpnFG0eOjVnZbr4Ac/WjwxjUligG13
         8hBWAK8AP557FROdKvpdTX8eLwfig/RXBN4RkmH9OBWjpstDMRsCT/SASNWzHMFt+K1W
         QG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TcWWArm6s2MYIjyVq/UCCy6oJdlx6ARoFnt89Ui6x0=;
        b=NjfT6nOaQ2PM0EN7fF8GY5w9oJowgarObld0gyc0ml5oJBffEavxsfe0FJzkgiAp8d
         8xPIfQfrIb32ju4JHbzKjFj4r277JF02cGPyY2SyAjw+XJKGQm9wmzZowR+ViQgqla93
         iCCvl2NfOaZWhSCZwlgwOnLsgX9V8XJPUwl8VjCaH9bSKoYktH5GBgDRU2GZj2YfyY1G
         iIQ9PJteLMy/5LTm7I8rWPLYnGuOGnzrjGPLhMd8JXLq/SDuhcSpexxehU0g4N+tIOy5
         V3f7ncfNjuwr2tJIRJtMelq0OzPqegwHLYnHuPpXMDZyPr5bltIx8Waw6VuIpDOZfKDp
         KKkg==
X-Gm-Message-State: AOAM531al91E1YyCSov+u4bHXvGvC0TwD5C4D5mUM1t9pIYCWkR6pYvl
        UeZWg9fHRkgZqx77/gFOBU8RbLzI6EhozGGEdj/9Iw==
X-Google-Smtp-Source: ABdhPJwssU2sgLtioAtubTRiKoa9fXpfCJPHELz4q7gRW7oXa88GnM/2/oRwHYoMQmQ5ln/cthnWT+Q2TDvVLRpl+Ag=
X-Received: by 2002:aca:cf4f:: with SMTP id f76mr510384oig.172.1594831546012;
 Wed, 15 Jul 2020 09:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004a4d6505aa7c688a@google.com> <20200715152912.GA2209203@elver.google.com>
 <20200715163256.GB1167@sol.localdomain>
In-Reply-To: <20200715163256.GB1167@sol.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Jul 2020 18:45:33 +0200
Message-ID: <CANpmjNN7GhF0e5gKPpn8mQS1Nry_8out4j_meDM0PqbZ9K5Ang@mail.gmail.com>
Subject: Re: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Jul 2020 at 18:33, Eric Biggers <ebiggers@kernel.org> wrote:
>
> [+Cc linux-fsdevel]
>
> On Wed, Jul 15, 2020 at 05:29:12PM +0200, 'Marco Elver' via syzkaller-bugs wrote:
> > On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1217a83b100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=570eb530a65cd98e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f1e470df6a4316e0a11
> > > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
> >
> > Our guess is that this is either misuse of an API from userspace, or a
> > bug. Can someone clarify?
> >
> > Below are the snippets of code around these accesses.
>
> Concurrent reads on the same file descriptor are allowed.  Not with sys_read(),
> as that implicitly uses the file position.  But it's allowed with sys_pread(),
> and also with sys_sendfile() which is the case syzbot is reporting here.
>
> >
> > > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
> > >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
> >
> >       ...
> >       would_block:
> >               error = -EAGAIN;
> >       out:
> >               ra->prev_pos = prev_index;
> >               ra->prev_pos <<= PAGE_SHIFT;
> > 2246)         ra->prev_pos |= prev_offset;
> >
> >               *ppos = ((loff_t)index << PAGE_SHIFT) + offset;
> >               file_accessed(filp);
> >               return written ? written : error;
> >       }
> >       EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> >       ...
>
> Well, it's a data race.  Each open file descriptor has just one readahead state
> (struct file_ra_state), and concurrent reads of the same file descriptor
> use/change that readahead state without any locking.
>
> Presumably this has traditionally been considered okay, since readahead is
> "only" for performance and doesn't affect correctness.  And for performance
> reasons, we want to avoid locking during file reads.
>
> So we may just need to annotate all access to file_ra_state with
> READ_ONCE() and WRITE_ONCE()...

The thing that stood out here are the multiple accesses both on the
reader and writer side. If it was only 1 access, where the race is
expected, a simple READ/WRITE_ONCE might have been OK.

But here, we actually have several writes to the same variable
'prev_pos'. The reader is also doing several reads to the same
variable. Maybe we got lucky because the compiler just turns it into 1
load, keeps it in a register and does the various modifications, and
then 1 store to write back. Similar on the reader side, we may have
gotten lucky in that the compiler just does 1 actual load. If that
behaviour is safe, it needs to be made explicit to make it impossible
for the compiler to generate anything else.

> > >  generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
> > >  ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
> > >  call_read_iter include/linux/fs.h:1902 [inline]
> > >  generic_file_splice_read+0x22a/0x310 fs/splice.c:312
> > >  do_splice_to fs/splice.c:870 [inline]
> > >  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
> > >  do_splice_direct+0xf2/0x170 fs/splice.c:1059
> > >  do_sendfile+0x562/0xb10 fs/read_write.c:1540
> > >  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
> > >  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
> > >  __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
> > >  do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > read to 0xffff8880968747b0 of 8 bytes by task 6334 on cpu 1:
> > >  generic_file_buffered_read+0x11e/0x19e0 mm/filemap.c:2011
> >
> >       ...
> >       index = *ppos >> PAGE_SHIFT;
> >       prev_index = ra->prev_pos >> PAGE_SHIFT;
> > 2011) prev_offset = ra->prev_pos & (PAGE_SIZE-1);
> >       last_index = (*ppos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
> >       offset = *ppos & ~PAGE_MASK;
> >       ...
> >
> > >  generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
> > >  ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
> > >  call_read_iter include/linux/fs.h:1902 [inline]
> > >  generic_file_splice_read+0x22a/0x310 fs/splice.c:312
> > >  do_splice_to fs/splice.c:870 [inline]
> > >  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
> > >  do_splice_direct+0xf2/0x170 fs/splice.c:1059
> > >  do_sendfile+0x562/0xb10 fs/read_write.c:1540
> > >  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
> > >  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
> > >  __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
> > >  do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 PID: 6334 Comm: syz-executor.0 Not tainted 5.8.0-rc5-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > ==================================================================
