Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC71004D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 12:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfKRL6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 06:58:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:36096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfKRL6g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:58:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8773EABBD;
        Mon, 18 Nov 2019 11:58:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E31B1E422A; Mon, 18 Nov 2019 10:35:44 +0100 (CET)
Date:   Mon, 18 Nov 2019 10:35:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular
 spinlock_t
Message-ID: <20191118093544.GA17319@quack2.suse.cz>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de>
 <20190820171721.GA4949@bombadil.infradead.org>
 <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
 <20191011112525.7dksg6ixb5c3hxn5@linutronix.de>
 <20191115145638.GA5461@quack2.suse.cz>
 <20191115173634.GC23689@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115173634.GC23689@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 15-11-19 12:36:34, Theodore Y. Ts'o wrote:
> On Fri, Nov 15, 2019 at 03:56:38PM +0100, Jan Kara wrote:
> > With some effort, we could even shrink struct buffer_head from 104 bytes
> > (on x86_64) to 96 bytes but I don't think that effort is worth it (I'd find
> > it better use of time to actually work on getting rid of buffer heads
> > completely).
> 
> Is that really realistic?  All aside from the very large number of
> file systems which use buffer_heads that would have to be reworked,
> the concept of buffer heads is pretty fundamental to how jbd2 is
> architected.

I think it is reasonably possible to remove buffer_heads from data path
(including direct IO path) of all filesystems. That way memory consumption
of buffer_heads becomes mostly irrelevant and we can have a look how much
from the current bh framework still makes sense...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
