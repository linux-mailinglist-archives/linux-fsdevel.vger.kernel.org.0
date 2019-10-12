Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6CD4CF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 06:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfJLEaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 00:30:01 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55910 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfJLEaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 00:30:01 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 452B243E9F5;
        Sat, 12 Oct 2019 15:29:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ92R-0001HB-Rh; Sat, 12 Oct 2019 15:29:55 +1100
Date:   Sat, 12 Oct 2019 15:29:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191012042955.GG15134@dread.disaster.area>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
 <20191011183253.GV32665@bombadil.infradead.org>
 <6e67a39c-88ed-f6a9-16a7-6ae9560a1112@redhat.com>
 <02e4b6c3-1ec8-8adf-93a0-ebf2a7820d65@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e4b6c3-1ec8-8adf-93a0-ebf2a7820d65@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=E2jZ3k1vpqApnXpNljMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:14:02PM -0500, Eric Sandeen wrote:
> 
> 
> On 10/11/19 1:45 PM, Eric Sandeen wrote:
> > On 10/11/19 1:32 PM, Matthew Wilcox wrote:
> >> On Fri, Oct 11, 2019 at 11:49:38AM -0500, Eric Sandeen wrote:
> >>> @@ -698,6 +699,13 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
> >>>  		inode_lru_list_del(inode);
> >>>  		spin_unlock(&inode->i_lock);
> >>>  		list_add(&inode->i_lru, &dispose);
> >>> +
> >>> +		if (need_resched()) {
> >>> +			spin_unlock(&sb->s_inode_list_lock);
> >>> +			cond_resched();
> >>> +			dispose_list(&dispose);
> >>> +			goto again;
> >>> +		}
> >>>  	}
> >>>  	spin_unlock(&sb->s_inode_list_lock);
> >>>  
> >>
> >> Is this equivalent to:
> >>
> >> +		cond_resched_lock(&sb->s_inode_list_lock));
> >>
> >> or is disposing of the list a crucial part here?
> > 
> > I think we need to dispose, or we'll start with the entire ~unmodified list again after the goto:
> 
> Oh, if you meant in lieu of the goto, we can't drop that lock and
> expect to pick up our traversal where we left off, can we?

No, we can't. Unless you're doing the iget/iput game (which we can't
here!) the moment the s_inode_list_lock is dropped we cannot rely on
the inode or it's next pointer to still be valid. Hence we have to
restart the traversal. And we dispose of the list before restarting
because there's nothing to gain by waiting until we've done the
entire sb inode list walk (could be hundreds of millions of inodes)
before we start actually freeing them....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
