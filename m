Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356DC1F9B7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgFOPHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFOPHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:07:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55916C061A0E;
        Mon, 15 Jun 2020 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=D9f5Mi6L2QV4D+1O3yqVfrh3RLhrtNFUT6np/JE/KSY=; b=ZdV7+HejkWrYxGvOxYruUhoeUu
        oxY5bTcqQ3cKMz5uGbWWbBUqjD+vFfUMpFhw6r3k4PqjLvJkQ/t9Nswq4pybAJOLQnGWvZJLcjLRu
        pd2wJHkzxgSBbbH9zCzPZ5AWeFITpIA6CpCEZNYBdffHotj+ReUvVg+gLJcTL4McaB1cQqoKhlJ3t
        qv+SvrjtNRooNnkVU6azlaotQh+IOhJMvF0RAk/TAnPIpdnlJILXZyHXO58geBTnoWNcu7ZJtA44w
        hGXk2ZbzhVXcrQu0M+DGDJEPTLd+JQs6wSvwxojTxnKLXdQgBddd+1Y/KUJqYUejFmFAOLnXHaDiX
        CMIGrjfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkqi0-0003AR-Ae; Mon, 15 Jun 2020 15:07:36 +0000
Date:   Mon, 15 Jun 2020 08:07:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200615150736.GU8681@bombadil.infradead.org>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
 <20200615145331.GK25296@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615145331.GK25296@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:53:31PM +0200, Michal Hocko wrote:
> On Mon 15-06-20 16:25:52, Holger Hoffstätte wrote:
> > On 2020-06-15 13:56, Yafang Shao wrote:
> [...]
> > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > index b356118..1ccfbf2 100644
> > > --- a/fs/xfs/xfs_aops.c
> > > +++ b/fs/xfs/xfs_aops.c
> > > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> > >   	struct writeback_control *wbc)
> > >   {
> > >   	struct xfs_writepage_ctx wpc = { };
> > > +	unsigned int nofs_flag;
> > > +	int ret;
> > >   	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > > -	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > +
> > > +	/*
> > > +	 * We can allocate memory here while doing writeback on behalf of
> > > +	 * memory reclaim.  To avoid memory allocation deadlocks set the
> > > +	 * task-wide nofs context for the following operations.
> > > +	 */
> > > +	nofs_flag = memalloc_nofs_save();
> > > +	ret = iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > +	memalloc_nofs_restore(nofs_flag);
> > > +
> > > +	return ret;
> > >   }
> > >   STATIC int
> > > 
> > 
> > Not sure if I did something wrong, but while the previous version of this patch
> > worked fine, this one gave me (with v2 removed obviously):
> > 
> > [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 iomap_do_writepage+0x6b4/0x780
> 
> This corresponds to
>         /*
>          * Given that we do not allow direct reclaim to call us, we should
>          * never be called in a recursive filesystem reclaim context.
>          */
>         if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
>                 goto redirty;
> 
> which effectivelly says that memalloc_nofs_save/restore cannot be used
> for that code path. Your stack trace doesn't point to a reclaim path
> which shows that this path is shared and also underlines that this is
> not really an intended use of the api. Please refer to
> Documentation/core-api/gfp_mask-from-fs-io.rst for more details but
> shortly the API should be used at the layer which defines a context
> which shouldn't allow to recurse. E.g. a lock which would be problematic
> in the reclaim recursion path.

I'm concerned that this might not be the correct approach.  Generally we
have the rule that freeing memory should not require allocating memory
to succeed.  Since XFS obviously does need to allocate memory to start
a transaction, this allocation should normally be protected by a mempool
or similar.

XFS is subtle and has its own rules around memory allocation and
writeback, so I don't want to say this is definitely wrong.  I'm just
saying that I have concerns it might not be right.
