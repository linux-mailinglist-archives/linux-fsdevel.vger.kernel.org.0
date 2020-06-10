Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409431F58EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFJQUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 12:20:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgFJQUZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:20:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73FC6AC79;
        Wed, 10 Jun 2020 16:20:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6D3651E1283; Wed, 10 Jun 2020 18:20:23 +0200 (CEST)
Date:   Wed, 10 Jun 2020 18:20:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Martijn Coenen <maco@android.com>,
        tj@kernel.org
Subject: Re: [PATCH 3/3] writeback: Drop I_DIRTY_TIME_EXPIRE
Message-ID: <20200610162023.GC20677@quack2.suse.cz>
References: <20200601091202.31302-1-jack@suse.cz>
 <20200601091904.4786-3-jack@suse.cz>
 <20200610151141.GC21733@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610151141.GC21733@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-06-20 08:11:41, Christoph Hellwig wrote:
> On Mon, Jun 01, 2020 at 11:18:57AM +0200, Jan Kara wrote:
> > The only use of I_DIRTY_TIME_EXPIRE is to detect in
> > __writeback_single_inode() that inode got there because flush worker
> > decided it's time to writeback the dirty inode time stamps (either
> > because we are syncing or because of age). However we can detect this
> > directly in __writeback_single_inode() and there's no need for the
> > strange propagation with I_DIRTY_TIME_EXPIRE flag.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> One nit below:
> 
> >  	if (inode->i_state & I_DIRTY_TIME) {
> >  		if ((dirty & I_DIRTY_INODE) ||
> > -		    wbc->sync_mode == WB_SYNC_ALL ||
> > -		    unlikely(inode->i_state & I_DIRTY_TIME_EXPIRED) ||
> > +		    wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
> >  		    unlikely(time_after(jiffies,
> >  					(inode->dirtied_time_when +
> >  					 dirtytime_expire_interval * HZ)))) {
> > -			dirty |= I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED;
> > +			dirty |= I_DIRTY_TIME;
> >  			trace_writeback_lazytime(inode);
> >  		}
> > -	} else
> > -		inode->i_state &= ~I_DIRTY_TIME_EXPIRED;
> > +	}
> 
> We can also drop some indentation here.  And remove the totally silly
> unlikely, something like:
> 
> 	if ((inode->i_state & I_DIRTY_TIME) &&
> 	    ((dirty & I_DIRTY_INODE) ||
> 	     wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
> 	     time_after(jiffies, inode->dirtied_time_when +
> 			dirtytime_expire_interval * HZ)))) {
> 		dirty |= I_DIRTY_TIME;
> 		trace_writeback_lazytime(inode);
> 	}

Sure, I've done this. Once fstests run passes, I'll send v2 (likely
tomorrow).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
