Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF104114A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhITMk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 08:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhITMk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:40:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428E76109D;
        Mon, 20 Sep 2021 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632141539;
        bh=nUAwaxsJu/Tne+3ivGEuqKG//tC46dmJUGIHdGNfH6A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HZ3UHG5HUouRVIAI3UC9PBHuEyWSxBcJ4X2yWeQl0KiUFYepijAYnrir9W1qPf51r
         35EHmmDx9RY4sc3Qh7/NOkAlE2OXIyP4oRgtq+LAHAawEQnGKXcTR9PqlpenrmTJQn
         1tSzr/ZI5VYX9QWJCkrBVc6KH4QVxaWqqXwhqAHDH5pgMluiHAoH/EziM9K9C9uHUf
         NmCE5T+HT1xw+iaFoIBOKD9JV+fj4gaaSBvzrUgjCD8mY/TGBtYNmMM///XE59HrNp
         1KOBSLxGC948xgTZafZjoMd0KGLWAJvmmskR+xO3SdfiLLoTw49sr3CeOF/F2xW1tv
         nct3tHwT2EPiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 13CCE5C07FE; Mon, 20 Sep 2021 05:38:59 -0700 (PDT)
Date:   Mon, 20 Sep 2021 05:38:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Waiman Long <llong@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] WARNING in __init_work
Message-ID: <20210920123859.GE880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000423e0a05cc0ba2c4@google.com>
 <20210915161457.95ad5c9470efc70196d48410@linux-foundation.org>
 <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com>
 <87sfy07n69.ffs@tglx>
 <20210920040336.GV2361455@dread.disaster.area>
 <20210920122846.GA16661@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920122846.GA16661@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:28:46PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 20, 2021 at 02:03:36PM +1000, Dave Chinner wrote:
> > > >> >  bdi_remove_from_list mm/backing-dev.c:938 [inline]
> > > >> >  bdi_unregister+0x177/0x5a0 mm/backing-dev.c:946
> > > >> >  release_bdi+0xa1/0xc0 mm/backing-dev.c:968
> > > >> >  kref_put include/linux/kref.h:65 [inline]
> > > >> >  bdi_put+0x72/0xa0 mm/backing-dev.c:976
> > > >> >  bdev_free_inode+0x116/0x220 fs/block_dev.c:819
> > > >> >  i_callback+0x3f/0x70 fs/inode.c:224
> > > 
> > > The inode code uses RCU for freeing an inode object which then ends up
> > > calling bdi_put() and subsequently in synchronize_rcu_expedited().
> > 
> > Commit 889c05cc5834 ("block: ensure the bdi is freed after
> > inode_detach_wb") might be a good place to start looking here. It
> > moved the release of the bdi from ->evict context to the RCU freeing
> > of the blockdev inode...
> 
> Well, the block code already does a bdi_unregister in del_gendisk.
> So if we end up freeing the whole device bdev with a registered bdi
> something is badly going wrong.  Unfortunately the log in this report
> isn't much help on how we got there.  IIRC syzbot will eventually spew
> out a reproducer, so it might be worth to wait for that.

If it does turn out that you need to block in an RCU callback,
queue_rcu_work() can be helpful.  This schedules a workqueue from the RCU
callback, allowing the function passed to the preceding INIT_RCU_WORK()
to block.

							Thanx, Paul
