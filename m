Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA42E41150A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhITMz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 08:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239027AbhITMzv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 982B360F6B;
        Mon, 20 Sep 2021 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632142464;
        bh=+E3USFlAlQ9wVdWsGzy+HHEZMYE6FYf6ghB1RYfKU30=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pnDSG/pHGMwB3kz5Insco1jTpQtb5uI2YUktumhZxYdKycl/gcUIXss6SiMfMPh3V
         a0fZFIxIMUW6jLSRbPmN6fkBRd38LPbdeWmcB67BOG/n+q92FiLtpfqYGqsBEkIl0s
         aoPcP9DqSPK1qP5I/P/1pAmV5gW8y9VnGcoak8bTlOdolypa2WL94JxcrqUURHJN4J
         BvSHXP3kgIcts029UoWcyLN0X/g1u3frVClgWNW7Kf3bvm+QuJWNWuwOWFnYI13a2B
         HDN/hAh53/ApveUuGLWQFVNODoZkqmVDbuc4FY8ZpTb+cqi65sicgPFfHiY+qVNSwn
         YmwX2LLIf41cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6304F5C07FE; Mon, 20 Sep 2021 05:54:24 -0700 (PDT)
Date:   Mon, 20 Sep 2021 05:54:24 -0700
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
Message-ID: <20210920125424.GG880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000423e0a05cc0ba2c4@google.com>
 <20210915161457.95ad5c9470efc70196d48410@linux-foundation.org>
 <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com>
 <87sfy07n69.ffs@tglx>
 <20210920040336.GV2361455@dread.disaster.area>
 <20210920122846.GA16661@lst.de>
 <20210920123859.GE880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920124557.GA18317@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920124557.GA18317@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:45:57PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 20, 2021 at 05:38:59AM -0700, Paul E. McKenney wrote:
> > > Well, the block code already does a bdi_unregister in del_gendisk.
> > > So if we end up freeing the whole device bdev with a registered bdi
> > > something is badly going wrong.  Unfortunately the log in this report
> > > isn't much help on how we got there.  IIRC syzbot will eventually spew
> > > out a reproducer, so it might be worth to wait for that.
> > 
> > If it does turn out that you need to block in an RCU callback,
> > queue_rcu_work() can be helpful.  This schedules a workqueue from the RCU
> > callback, allowing the function passed to the preceding INIT_RCU_WORK()
> > to block.
> 
> In this case we really should not block here.  The problem is that
> we are hitting the strange bdi auto-unregister misfeature due to a bug
> elsewhere.  Which reminds that I have a patch series to remove this
> auto unregistration which I need to bring bag once this is fixed.
> 
> That being said queue_rcu_work would have been really useful in a few
> places I touched in that past.

Glad it helped elsewhere and apologies for the noise here!

							Thanx, Paul
