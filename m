Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9E1ABCE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503818AbgDPJff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 05:35:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503615AbgDPJfc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:35:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7BC9AD0E;
        Thu, 16 Apr 2020 09:35:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D25621E1250; Thu, 16 Apr 2020 11:35:28 +0200 (CEST)
Date:   Thu, 16 Apr 2020 11:35:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, akpm@linux-foundation.org,
        david@fromorbit.com
Subject: Re: [PATCH v5 2/2] buffer: record blockdev write errors in
 super_block that it backs
Message-ID: <20200416093528.GC23739@quack2.suse.cz>
References: <20200415121300.228017-1-jlayton@kernel.org>
 <20200415121300.228017-3-jlayton@kernel.org>
 <20200415140642.GK6126@quack2.suse.cz>
 <b4161f1df3436d7371ab7e88709169e9a391f15d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4161f1df3436d7371ab7e88709169e9a391f15d.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-04-20 12:22:27, Jeff Layton wrote:
> On Wed, 2020-04-15 at 16:06 +0200, Jan Kara wrote:
> > On Wed 15-04-20 08:13:00, Jeff Layton wrote:
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
> > > Since superblocks are RCU freed, hold the rcu_read_lock to ensure
> > > that the superblock doesn't go away while we're marking it.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/buffer.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > index f73276d746bb..2a4a5cc20418 100644
> > > --- a/fs/buffer.c
> > > +++ b/fs/buffer.c
> > > @@ -1154,12 +1154,19 @@ EXPORT_SYMBOL(mark_buffer_dirty);
> > >  
> > >  void mark_buffer_write_io_error(struct buffer_head *bh)
> > >  {
> > > +	struct super_block *sb;
> > > +
> > >  	set_buffer_write_io_error(bh);
> > >  	/* FIXME: do we need to set this in both places? */
> > >  	if (bh->b_page && bh->b_page->mapping)
> > >  		mapping_set_error(bh->b_page->mapping, -EIO);
> > >  	if (bh->b_assoc_map)
> > >  		mapping_set_error(bh->b_assoc_map, -EIO);
> > > +	rcu_read_lock();
> > > +	sb = bh->b_bdev->bd_super;
> > 
> > You still need READ_ONCE() here. Otherwise the dereference below can still
> > result in refetch and NULL ptr deref.
> > 
> > 								Honza
> > 
> 
> Huh? That seems like a really suspicious thing for the compiler/arch to
> do. We are checking that sb isn't NULL before we dereference it. Doesn't
> that imply a data dependency? How could the value of "sb" change after
> that?

Because the compiler is free to optimize the local variable away and
actually compile the dereference below as bh->b_bdev->bd_super->s_wb_err
(from C11 standard POV such code is equivalent since in C11 memory model
it is assumed there are no concurrent accesses). And READ_ONCE() is a way
to forbid compiler from doing such optimization - through 'volatile'
keyword it tells the compiler there may be concurrent accesses happening
and makes sure the value is really fetched into the local variable and used
from there. There are good articles about this on LWN - I'd give you a link
but LWN seems to be down today. But the latest article is about KCSAN and
from there are links to older articles about compiler optimizations.

> I'm also not sure I understand how using READ_ONCE really helps there if
> we can't count on the value of a local variable not changing.

I hope I've explained this above.

								Honza

> > > +	if (sb)
> > > +		errseq_set(&sb->s_wb_err, -EIO);
> > > +	rcu_read_unlock();
> > >  }
> > >  EXPORT_SYMBOL(mark_buffer_write_io_error);
> > >  
> > > -- 
> > > 2.25.2
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
