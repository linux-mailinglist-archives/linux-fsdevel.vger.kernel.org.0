Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147CC2992CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780372AbgJZQs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 12:48:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781112AbgJZQsM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D56F5ACF5;
        Mon, 26 Oct 2020 16:48:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E3A81E10F5; Mon, 26 Oct 2020 17:48:10 +0100 (CET)
Date:   Mon, 26 Oct 2020 17:48:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: Strange SEEK_HOLE / SEEK_DATA behavior
Message-ID: <20201026164810.GI28769@quack2.suse.cz>
References: <20201026145710.GF28769@quack2.suse.cz>
 <20201026151404.GR20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026151404.GR20115@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-10-20 15:14:04, Matthew Wilcox wrote:
> On Mon, Oct 26, 2020 at 03:57:10PM +0100, Jan Kara wrote:
> > Hello!
> > 
> > When reviewing Matthew's THP patches I've noticed one odd behavior which
> > got copied from current iomap seek hole/data helpers. Currently we have:
> > 
> > # fallocate -l 4096 testfile
> > # xfs_io -x -c "seek -h 0" testfile
> > Whence	Result
> > HOLE	0
> > # dd if=testfile bs=4096 count=1 of=/dev/null
> > # xfs_io -x -c "seek -h 0" testfile
> > Whence	Result
> > HOLE	4096
> > 
> > So once we read from an unwritten extent, the areas with cached pages
> > suddently become treated as data. Later when pages get evicted, they become
> > treated as holes again. Strictly speaking I wouldn't say this is a bug
> > since nobody promises we won't treat holes as data but it looks weird.
> > Shouldn't we treat clean pages over unwritten extents still as holes and
> > only once the page becomes dirty treat is as data? What do other people
> > think?
> 
> I think we actually discussed this recently.  Unless I misunderstood
> one or both messages:
> 
> https://lore.kernel.org/linux-fsdevel/20201014223743.GD7391@dread.disaster.area/

Thanks for the link. That indeed explains it, the concern is that if we'd
check for PageDirty like I suggested, then it would be racy (page could
have been written out just before we found it but after we've received
block mapping from the filesystem). So using PageUptodate is less racy
(although still somewhat racy because page could be also reclaimed).

> I agree it's not great, but I'm not sure it's worth getting it "right"
> by tracking whether a page contains only zeroes.

Yeah, I don't think it's worth it just for this.

> I have been vaguely thinking about optimising for read-mostly workloads
> on sparse files by storing a magic entry that means "use the zero
> page" in the page cache instead of a page, like DAX does (only better).
> It hasn't risen to the top of my list yet.  Does anyone have a workload
> that would benefit from it?
> 
> (I don't mean "can anybody construct one"; that's trivially possible.
> I mean, do any customers care about the performance of that workload?)

No workload comes to my mind now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
