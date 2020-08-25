Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDFA251F46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHYStt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 14:49:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgHYStt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:49:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 881EFAF67;
        Tue, 25 Aug 2020 18:50:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 77FAF1E1316; Tue, 25 Aug 2020 20:49:46 +0200 (CEST)
Date:   Tue, 25 Aug 2020 20:49:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, yebin <yebin10@huawei.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200825184946.GA24645@quack2.suse.cz>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <20200825141020.GA668551@mit.edu>
 <20200825151256.GD32298@quack2.suse.cz>
 <20200825184107.GP17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825184107.GP17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-08-20 19:41:07, Matthew Wilcox wrote:
> On Tue, Aug 25, 2020 at 05:12:56PM +0200, Jan Kara wrote:
> > On Tue 25-08-20 10:10:20, Theodore Y. Ts'o wrote:
> > > (Adding the OCFS2 maintainers, since my possibly insane idea proposed
> > > below would definitely impact them!)
> > > 
> > > On Tue, Aug 25, 2020 at 01:16:16PM +0100, Christoph Hellwig wrote:
> > > > On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> > > > > Discarding blocks and buffers under a mounted filesystem is hardly
> > > > > anything admin wants to do. Usually it will confuse the filesystem and
> > > > > sometimes the loss of buffer_head state (including b_private field) can
> > > > > even cause crashes like:
> > > > 
> > > > Doesn't work if the file system uses multiple devices.  I think we
> > > > just really need to split the fs buffer_head address space from the
> > > > block device one.  Everything else is just going to cause a huge mess.
> > > 
> > > I wonder if we should go a step further, and stop using struct
> > > buffer_head altogether in jbd2 and ext4 (as well as ocfs2).
> > 
> > What about the cache coherency issues I've pointed out in my reply to
> > Christoph?
> 
> If journal_heads pointed into the page cache as well, then you'd get
> coherency.  These new journal heads would have to be able to cope with
> the page cache being modified underneath them, of course.

I was thinking about this as well but IMHO it would be quite complex - e.g.
we could then have both buffer_heads (for block dev) and journal heads (for
fs) to have different opinions on block state (uptodate, dirty, ...) and
who now determines what the final page state is (e.g. for reclaim
purposes)? Sure we can all sort this out with various callbacks etc. but at
that point we are not really simplifying things anymore...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
