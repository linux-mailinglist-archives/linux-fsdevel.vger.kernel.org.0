Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3741ABF3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506135AbgDPLbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 07:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632803AbgDPLbg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:31:36 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7613C208E4;
        Thu, 16 Apr 2020 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587036695;
        bh=0bFacHSoUUyGSAb90iqsd3ao3s9+E+bswGCW0hty4Dk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LZ3A3LQICzetJVIe5HgLrwrtQgQBzqC62BleZfgySPZ43cBAXOlCVfL65qWkm4Ibe
         0psmDcVqdGQR+qJoTcCgLfjXEHg6OuWO4vMBfXN1wAvy7WNEB1oivEPNia25G7lAH7
         Fo/IGfK63OILqsnj/2TPopErE8drWJYGWyZ50MVo=
Message-ID: <35d03979765b4351160086badcb59a512695493f.camel@kernel.org>
Subject: Re: [PATCH v5 2/2] buffer: record blockdev write errors in
 super_block that it backs
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        andres@anarazel.de, willy@infradead.org, dhowells@redhat.com,
        hch@infradead.org, akpm@linux-foundation.org, david@fromorbit.com
Date:   Thu, 16 Apr 2020 07:31:33 -0400
In-Reply-To: <20200416093528.GC23739@quack2.suse.cz>
References: <20200415121300.228017-1-jlayton@kernel.org>
         <20200415121300.228017-3-jlayton@kernel.org>
         <20200415140642.GK6126@quack2.suse.cz>
         <b4161f1df3436d7371ab7e88709169e9a391f15d.camel@kernel.org>
         <20200416093528.GC23739@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-04-16 at 11:35 +0200, Jan Kara wrote:
> On Wed 15-04-20 12:22:27, Jeff Layton wrote:
> > On Wed, 2020-04-15 at 16:06 +0200, Jan Kara wrote:
> > > On Wed 15-04-20 08:13:00, Jeff Layton wrote:
> > > > From: Jeff Layton <jlayton@redhat.com>
> > > > 
> > > > When syncing out a block device (a'la __sync_blockdev), any error
> > > > encountered will only be recorded in the bd_inode's mapping. When the
> > > > blockdev contains a filesystem however, we'd like to also record the
> > > > error in the super_block that's stored there.
> > > > 
> > > > Make mark_buffer_write_io_error also record the error in the
> > > > corresponding super_block when a writeback error occurs and the block
> > > > device contains a mounted superblock.
> > > > 
> > > > Since superblocks are RCU freed, hold the rcu_read_lock to ensure
> > > > that the superblock doesn't go away while we're marking it.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/buffer.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > > index f73276d746bb..2a4a5cc20418 100644
> > > > --- a/fs/buffer.c
> > > > +++ b/fs/buffer.c
> > > > @@ -1154,12 +1154,19 @@ EXPORT_SYMBOL(mark_buffer_dirty);
> > > >  
> > > >  void mark_buffer_write_io_error(struct buffer_head *bh)
> > > >  {
> > > > +	struct super_block *sb;
> > > > +
> > > >  	set_buffer_write_io_error(bh);
> > > >  	/* FIXME: do we need to set this in both places? */
> > > >  	if (bh->b_page && bh->b_page->mapping)
> > > >  		mapping_set_error(bh->b_page->mapping, -EIO);
> > > >  	if (bh->b_assoc_map)
> > > >  		mapping_set_error(bh->b_assoc_map, -EIO);
> > > > +	rcu_read_lock();
> > > > +	sb = bh->b_bdev->bd_super;
> > > 
> > > You still need READ_ONCE() here. Otherwise the dereference below can still
> > > result in refetch and NULL ptr deref.
> > > 
> > > 								Honza
> > > 
> > 
> > Huh? That seems like a really suspicious thing for the compiler/arch to
> > do. We are checking that sb isn't NULL before we dereference it. Doesn't
> > that imply a data dependency? How could the value of "sb" change after
> > that?
> 
> Because the compiler is free to optimize the local variable away and
> actually compile the dereference below as bh->b_bdev->bd_super->s_wb_err
> (from C11 standard POV such code is equivalent since in C11 memory model
> it is assumed there are no concurrent accesses). And READ_ONCE() is a way
> to forbid compiler from doing such optimization - through 'volatile'
> keyword it tells the compiler there may be concurrent accesses happening
> and makes sure the value is really fetched into the local variable and used
> from there. There are good articles about this on LWN - I'd give you a link
> but LWN seems to be down today. But the latest article is about KCSAN and
> from there are links to older articles about compiler optimizations.
> 
> > I'm also not sure I understand how using READ_ONCE really helps there if
> > we can't count on the value of a local variable not changing.
> 
> I hope I've explained this above.
> 

Got it. Thanks for the explanation. Now I'll have nightmares about all
of the race conditions I've created in the past by making this
assumption!

I'll send a v6 set in a few mins.

> > > > +	if (sb)
> > > > +		errseq_set(&sb->s_wb_err, -EIO);
> > > > +	rcu_read_unlock();
> > > >  }
> > > >  EXPORT_SYMBOL(mark_buffer_write_io_error);
> > > >  
> > > > -- 
> > > > 2.25.2
> > > > 
> > 
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> > 

-- 
Jeff Layton <jlayton@kernel.org>

