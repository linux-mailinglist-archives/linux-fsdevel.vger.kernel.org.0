Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F22ECF40A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfJHHhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:37:15 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:56771 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730367AbfJHHhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:37:14 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E108143E00B;
        Tue,  8 Oct 2019 18:37:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iHk3Q-0005PG-T7; Tue, 08 Oct 2019 18:37:08 +1100
Date:   Tue, 8 Oct 2019 18:37:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] iomap: copy the xfs writeback code to iomap.c
Message-ID: <20191008073708.GG16973@dread.disaster.area>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-3-hch@lst.de>
 <20191007214353.GZ16973@dread.disaster.area>
 <20191008063436.GA30465@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008063436.GA30465@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=C152E18BS4FYMT0GleMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:34:36AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 08:43:53AM +1100, Dave Chinner wrote:
> > > +static int
> > > +iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
> > > +{
> > > +	struct iomap_ioend *ia, *ib;
> > > +
> > > +	ia = container_of(a, struct iomap_ioend, io_list);
> > > +	ib = container_of(b, struct iomap_ioend, io_list);
> > > +	if (ia->io_offset < ib->io_offset)
> > > +		return -1;
> > > +	else if (ia->io_offset > ib->io_offset)
> > > +		return 1;
> > > +	return 0;
> > 
> > No need for the else here.
> 
> That is usually my comment :)  But in this case it is just copied over
> code, so I didn't want to do cosmetic changes.

*nod*

> > > +	/*
> > > +	 * Given that we do not allow direct reclaim to call us, we should
> > > +	 * never be called while in a filesystem transaction.
> > > +	 */
> > > +	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > > +		goto redirty;
> > 
> > Is this true for all expected callers of these functions rather than
> > just XFS? i.e. PF_MEMALLOC_NOFS is used by transactions in XFS to
> > prevent transaction context recursion, but other filesystems do not
> > do this..
> > 
> > FWIW, I can also see that this is going to cause us problems if high
> > level code starts using memalloc_nofs_save() and then calling
> > filemap_datawrite() and friends...
> 
> We have the check for direct reclaim just above, so any file system
> using this iomap code will not allow direct reclaim.  Which I think is
> a very good idea given that direct reclaim through the file system is
> a very bad idea.

*nod*

> That leaves with only the filemap_datawrite case, which so far is
> theoretical.  If that ever becomes a think it is very obvious and we
> can just remove the debug check.

I expect it will be a thing sooner rather than later...

> > > +iomap_writepage(struct page *page, struct writeback_control *wbc,
> > > +		struct iomap_writepage_ctx *wpc,
> > > +		const struct iomap_writeback_ops *ops)
> > > +{
> > > +	int ret;
> > > +
> > > +	wpc->ops = ops;
> > > +	ret = iomap_do_writepage(page, wbc, wpc);
> > > +	if (!wpc->ioend)
> > > +		return ret;
> > > +	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> > > +}
> > > +EXPORT_SYMBOL_GPL(iomap_writepage);
> > 
> > Can we kill ->writepage for iomap users, please? After all, we don't
> > mostly don't allow memory reclaim to do writeback of dirty pages,
> > and that's the only caller of ->writepage.
> 
> I'd rather not do this as part of this move.  But if you could expedite
> your patch to kill ->writepage from the large block size support patch
> and submit it ASAP on top of this series I would be very much in favor.

Ok, looks like the usual of more follow up patches on top of these.
I'm kinda waiting for these to land before porting the large block
size stuff on top of it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
