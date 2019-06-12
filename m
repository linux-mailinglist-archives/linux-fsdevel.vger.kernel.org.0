Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5F4306E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 21:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfFLTs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 15:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfFLTs2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:48:28 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF4920866;
        Wed, 12 Jun 2019 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560368907;
        bh=wwI7SdZmd/IQDavcocBFuS/T0Hb/7yBUbnvBQNK7QzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pE8WgP+oCDzW48eYHUbA/VoCCh0hdzsMIr97KDTT3JhYdAI7AK4i+V/ZizjdjmQMK
         c0G/5JyQ6tn0Obyp9rvHi+EHjZGewh6bMj65MGePlFPOmyD9x2EEBYQeY2n99VhJt/
         WKJIR1zjvxY0d1lapcgNXFSu2mmLcuzBso071mb8=
Date:   Wed, 12 Jun 2019 12:48:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+a3accb352f9c22041cfa@syzkaller.appspotmail.com>,
        bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: possible deadlock in io_submit_one
Message-ID: <20190612194825.GH18795@gmail.com>
References: <00000000000082477205811c029c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000082477205811c029c@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bart and Christoph,

On Mon, Feb 04, 2019 at 06:03:04PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    5eeb63359b1e Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17906f64c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3accb352f9c22041cfa
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156479f8c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128c75c4c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a3accb352f9c22041cfa@syzkaller.appspotmail.com
> 
> =====================================================
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 5.0.0-rc4+ #56 Not tainted
> -----------------------------------------------------
> syz-executor263/8874 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> 00000000c469f622 (&ctx->fd_wqh){....}, at: spin_lock
> include/linux/spinlock.h:329 [inline]
> 00000000c469f622 (&ctx->fd_wqh){....}, at: aio_poll fs/aio.c:1772 [inline]
> 00000000c469f622 (&ctx->fd_wqh){....}, at: __io_submit_one fs/aio.c:1875
> [inline]
> 00000000c469f622 (&ctx->fd_wqh){....}, at: io_submit_one+0xedf/0x1cf0
> fs/aio.c:1908
> 
> and this task is already holding:
> 00000000829de875 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
> include/linux/spinlock.h:354 [inline]
> 00000000829de875 (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll
> fs/aio.c:1771 [inline]
> 00000000829de875 (&(&ctx->ctx_lock)->rlock){..-.}, at: __io_submit_one
> fs/aio.c:1875 [inline]
> 00000000829de875 (&(&ctx->ctx_lock)->rlock){..-.}, at:
> io_submit_one+0xeb6/0x1cf0 fs/aio.c:1908
> which would create a new lock dependency:
>  (&(&ctx->ctx_lock)->rlock){..-.} -> (&ctx->fd_wqh){....}
> 

This is still happening.  See
https://syzkaller.appspot.com/text?tag=CrashReport&x=129eb971a00000 for a report
on Linus' tree from 5 days ago.

I see that a few months ago there was a commit

	commit d3d6a18d7d351cbcc9b33dbedf710e65f8ce1595
	Author: Bart Van Assche <bvanassche@acm.org>
	Date:   Fri Feb 8 16:59:49 2019 -0800

	    aio: Fix locking in aio_poll()

but apparently it didn't fully fix the problem.

- Eric
