Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044D8CF2CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfJHGek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 02:34:40 -0400
Received: from verein.lst.de ([213.95.11.211]:44049 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfJHGek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:34:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B73F668B20; Tue,  8 Oct 2019 08:34:36 +0200 (CEST)
Date:   Tue, 8 Oct 2019 08:34:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] iomap: copy the xfs writeback code to iomap.c
Message-ID: <20191008063436.GA30465@lst.de>
References: <20191006154608.24738-1-hch@lst.de> <20191006154608.24738-3-hch@lst.de> <20191007214353.GZ16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007214353.GZ16973@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:43:53AM +1100, Dave Chinner wrote:
> > +static int
> > +iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
> > +{
> > +	struct iomap_ioend *ia, *ib;
> > +
> > +	ia = container_of(a, struct iomap_ioend, io_list);
> > +	ib = container_of(b, struct iomap_ioend, io_list);
> > +	if (ia->io_offset < ib->io_offset)
> > +		return -1;
> > +	else if (ia->io_offset > ib->io_offset)
> > +		return 1;
> > +	return 0;
> 
> No need for the else here.

That is usually my comment :)  But in this case it is just copied over
code, so I didn't want to do cosmetic changes.

> > +	/*
> > +	 * Given that we do not allow direct reclaim to call us, we should
> > +	 * never be called while in a filesystem transaction.
> > +	 */
> > +	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > +		goto redirty;
> 
> Is this true for all expected callers of these functions rather than
> just XFS? i.e. PF_MEMALLOC_NOFS is used by transactions in XFS to
> prevent transaction context recursion, but other filesystems do not
> do this..
> 
> FWIW, I can also see that this is going to cause us problems if high
> level code starts using memalloc_nofs_save() and then calling
> filemap_datawrite() and friends...

We have the check for direct reclaim just above, so any file system
using this iomap code will not allow direct reclaim.  Which I think is
a very good idea given that direct reclaim through the file system is
a very bad idea.

That leaves with only the filemap_datawrite case, which so far is
theoretical.  If that ever becomes a think it is very obvious and we
can just remove the debug check.

> > +iomap_writepage(struct page *page, struct writeback_control *wbc,
> > +		struct iomap_writepage_ctx *wpc,
> > +		const struct iomap_writeback_ops *ops)
> > +{
> > +	int ret;
> > +
> > +	wpc->ops = ops;
> > +	ret = iomap_do_writepage(page, wbc, wpc);
> > +	if (!wpc->ioend)
> > +		return ret;
> > +	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_writepage);
> 
> Can we kill ->writepage for iomap users, please? After all, we don't
> mostly don't allow memory reclaim to do writeback of dirty pages,
> and that's the only caller of ->writepage.

I'd rather not do this as part of this move.  But if you could expedite
your patch to kill ->writepage from the large block size support patch
and submit it ASAP on top of this series I would be very much in favor.
