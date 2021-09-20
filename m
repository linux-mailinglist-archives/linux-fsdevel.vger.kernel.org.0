Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43E6410EDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 06:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhITEFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 00:05:08 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39656 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhITEFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 00:05:08 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B46AA88257E;
        Mon, 20 Sep 2021 14:03:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mSAWm-00EWYg-DZ; Mon, 20 Sep 2021 14:03:36 +1000
Date:   Mon, 20 Sep 2021 14:03:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Waiman Long <llong@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [syzbot] WARNING in __init_work
Message-ID: <20210920040336.GV2361455@dread.disaster.area>
References: <000000000000423e0a05cc0ba2c4@google.com>
 <20210915161457.95ad5c9470efc70196d48410@linux-foundation.org>
 <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com>
 <87sfy07n69.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfy07n69.ffs@tglx>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=hSkVLCK3AAAA:8 a=7-415B0cAAAA:8
        a=TsGWvwOLv-xfsXIyvSQA:9 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 19, 2021 at 02:41:18PM +0200, Thomas Gleixner wrote:
> Stephen,
> 
> On Wed, Sep 15 2021 at 19:29, Stephen Boyd wrote:
> > Quoting Andrew Morton (2021-09-15 16:14:57)
> >> On Wed, 15 Sep 2021 10:00:22 -0700 syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com> wrote:
> >> > 
> >> > ODEBUG: object ffffc90000fd8bc8 is NOT on stack ffffc900022a0000, but annotated.
> >
> > This is saying that the object was supposed to be on the stack because
> > debug objects was told that, but it isn't on the stack per the
> > definition of object_is_on_stack().
> 
> Correct.
> 
> >> >  <IRQ>
> >> >  __init_work+0x2d/0x50 kernel/workqueue.c:519
> >> >  synchronize_rcu_expedited+0x392/0x620 kernel/rcu/tree_exp.h:847
> >
> > This line looks like
> >
> >   INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
> >
> > inside synchronize_rcu_expedited(). The rew structure is declared on the
> > stack
> >
> >    struct rcu_exp_work rew;
> 
> Yes, but object_is_on_stack() checks for task stacks only. And the splat
> here is entirely correct:
> 
> softirq()
>   ...
>   synchronize_rcu_expedited()
>      INIT_WORK_ONSTACK()
>      queue_work()
>      wait_event()
> 
> is obviously broken. You cannot wait in soft irq context.
> 
> synchronize_rcu_expedited() should really have a might_sleep() at the
> beginning to make that more obvious.
> 
> The splat is clobbered btw:
> 
> [  416.415111][    C1] ODEBUG: object ffffc90000fd8bc8 is NOT on stack ffffc900022a0000, but annotated.
> [  416.423424][T14850] truncated
> [  416.431623][    C1] ------------[ cut here ]------------
> [  416.438913][T14850] ------------[ cut here ]------------
> [  416.440189][    C1] WARNING: CPU: 1 PID: 2971 at lib/debugobjects.c:548 __debug_object_init.cold+0x252/0x2e5
> [  416.455797][T14850] refcount_t: addition on 0; use-after-free.
> 
> So there is a refcount_t violation as well.
> 
> Nevertheless a hint for finding the culprit is obviously here in that
> call chain:
> 
> >> >  bdi_remove_from_list mm/backing-dev.c:938 [inline]
> >> >  bdi_unregister+0x177/0x5a0 mm/backing-dev.c:946
> >> >  release_bdi+0xa1/0xc0 mm/backing-dev.c:968
> >> >  kref_put include/linux/kref.h:65 [inline]
> >> >  bdi_put+0x72/0xa0 mm/backing-dev.c:976
> >> >  bdev_free_inode+0x116/0x220 fs/block_dev.c:819
> >> >  i_callback+0x3f/0x70 fs/inode.c:224
> 
> The inode code uses RCU for freeing an inode object which then ends up
> calling bdi_put() and subsequently in synchronize_rcu_expedited().

Commit 889c05cc5834 ("block: ensure the bdi is freed after
inode_detach_wb") might be a good place to start looking here. It
moved the release of the bdi from ->evict context to the RCU freeing
of the blockdev inode...

Christoph?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
