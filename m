Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B397113C57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 08:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLEH2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 02:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfLEH2k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:28:40 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876C6224F8;
        Thu,  5 Dec 2019 07:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575530920;
        bh=x8bHAUnz0R3/GitIgg/ToKGaqtqdGUV9Oi9tiwAOjtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xz//TJ305frNklRa1ZV+Mhp3iTtkOlksOw9Z30c1wp0MmVxXRDia+4RvVejgYvd60
         ott5zfb61mUUQN1vv1EwU02oqEkle49POxcVasLGt2DzbMcpl1sezDc7b7w/odhpJW
         /zsETnzTaaFanVBDunSR7UyAD+4Pqew09C6x53f8=
Date:   Wed, 4 Dec 2019 23:28:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     dhowells@redhat.com
Cc:     amit@kernel.org, arnd@arndb.de,
        syzbot <syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jannh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        virtualization@lists.linux-foundation.org, willy@infradead.org
Subject: Re: kernel BUG at fs/pipe.c:LINE!
Message-ID: <20191205072838.GA3237@sol.localdomain>
References: <000000000000a376820598b2eb97@google.com>
 <20191205054023.GA772@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205054023.GA772@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:40:23PM -0800, Eric Biggers wrote:
> David,
> 
> On Sun, Dec 01, 2019 at 10:45:08PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1387ab12e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d37abaade33a934f16f2
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12945c41e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161e202ee00000
> > 
> > The bug was bisected to:
> > 
> > commit 8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Fri Nov 15 13:30:32 2019 +0000
> > 
> >     pipe: Use head and tail pointers for the ring, not cursor and length
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118cce96e00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=138cce96e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=158cce96e00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com
> > Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not
> > cursor and length")
> > 
> > ------------[ cut here ]------------
> > kernel BUG at fs/pipe.c:582!
> 
> This same BUG_ON() crashed my system during normal use, no syzkaller involved at
> all, on mainline 937d6eefc7.  Can you please take a look?  This syzbot report
> has a reproducer so that might be the easiest place to start.
> 
> - Eric

Code is:

static __poll_t
pipe_poll(struct file *filp, poll_table *wait)
{
        __poll_t mask;
        struct pipe_inode_info *pipe = filp->private_data;
        unsigned int head = READ_ONCE(pipe->head);
        unsigned int tail = READ_ONCE(pipe->tail);

        poll_wait(filp, &pipe->wait, wait);

        BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);

It's not holding the pipe mutex, right?  So 'head', 'tail' and 'ring_size' can
all be changed concurrently, and they aren't read atomically with respect to
each other.

How do you propose to implement poll() correctly with the new head + tail
approach?  Just take the mutex?

- Eric
