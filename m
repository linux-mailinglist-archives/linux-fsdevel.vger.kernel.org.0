Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E986F1A9844
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895246AbgDOJRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:17:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895194AbgDOJRt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:17:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFB35ADBE;
        Wed, 15 Apr 2020 09:17:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6EE7B1E1250; Wed, 15 Apr 2020 11:17:46 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:17:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, akpm@linux-foundation.org,
        david@fromorbit.com
Subject: Re: [PATCH v4 RESEND 2/2] buffer: record blockdev write errors in
 super_block that it backs
Message-ID: <20200415091746.GG501@quack2.suse.cz>
References: <20200414120409.293749-1-jlayton@kernel.org>
 <20200414120409.293749-3-jlayton@kernel.org>
 <20200414162639.GK28226@quack2.suse.cz>
 <19cac5afa0496e049535f5129804b687cdf64dbb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19cac5afa0496e049535f5129804b687cdf64dbb.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-04-20 14:37:21, Jeff Layton wrote:
> On Tue, 2020-04-14 at 18:26 +0200, Jan Kara wrote:
> > On Tue 14-04-20 08:04:09, Jeff Layton wrote:
> > > From: Jeff Layton <jlayton@redhat.com>
> > > 
> > > When syncing out a block device (a'la __sync_blockdev), any error
> > > encountered will only be recorded in the bd_inode's mapping. When the
> > > blockdev contains a filesystem however, we'd like to also record the
> > > error in the super_block that's stored there.
> > > 
> > > Make mark_buffer_write_io_error also record the error in the
> > > corresponding super_block when a writeback error occurs and the block
> > > device contains a mounted superblock.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > The patch looks good to me. I'd just note that bh->b_bdev->bd_super
> > dereference is safe only because we will flush all dirty data when
> > unmounting a filesystem which is somewhat tricky. Maybe that warrants a
> > comment? Otherwise feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Oh, hmm...now that I look again, I'm not sure this is actually safe.
> 
> bh->b_bdev gets cleared out as we discard the buffer, so I don't think
> that could end up getting zeroed while we're still using it.

Correct.

> The bd_super pointer gets zeroed out in kill_block_super, and after that
> point it calls sync_blockdev(). Could writeback error processing race
> with kill_block_super such that bd_inode gets set to NULL after we test
> it but before we dereference it?

Yeah, you're right. But you can avoid the race with
READ_ONCE(bh->b_bdev->bd_super) and a big fat comment explaining why it is
safe... :)

Or you could be less daring and put rcu protection there because
superblocks are RCU freed...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
