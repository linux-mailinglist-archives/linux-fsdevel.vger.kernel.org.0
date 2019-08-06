Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC20831F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfHFM5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 08:57:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfHFM5a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03C8D30031AD;
        Tue,  6 Aug 2019 12:57:30 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78A7C5D784;
        Tue,  6 Aug 2019 12:57:29 +0000 (UTC)
Date:   Tue, 6 Aug 2019 08:57:27 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] xfs: eagerly free shadow buffers to reduce CIL
 footprint
Message-ID: <20190806125727.GD2979@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-16-david@fromorbit.com>
 <20190805180300.GE14760@bfoster>
 <20190805233326.GA7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805233326.GA7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 06 Aug 2019 12:57:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:33:26AM +1000, Dave Chinner wrote:
> On Mon, Aug 05, 2019 at 02:03:01PM -0400, Brian Foster wrote:
> > On Thu, Aug 01, 2019 at 12:17:43PM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > The CIL can pin a lot of memory and effectively defines the lower
> > > free memory boundary of operation for XFS. The way we hang onto
> > > log item shadow buffers "just in case" effectively doubles the
> > > memory footprint of the CIL for dubious reasons.
> > > 
> > > That is, we hang onto the old shadow buffer in case the next time
> > > we log the item it will fit into the shadow buffer and we won't have
> > > to allocate a new one. However, we only ever tend to grow dirty
> > > objects in the CIL through relogging, so once we've allocated a
> > > larger buffer the old buffer we set as a shadow buffer will never
> > > get reused as the amount we log never decreases until the item is
> > > clean. And then for buffer items we free the log item and the shadow
> > > buffers, anyway. Inode items will hold onto their shadow buffer
> > > until they are reclaimed - this could double the inode's memory
> > > footprint for it's lifetime...
> > > 
> > > Hence we should just free the old log item buffer when we replace it
> > > with a new shadow buffer rather than storing it for later use. It's
> > > not useful, get rid of it as early as possible.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_log_cil.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> > > index fa5602d0fd7f..1863a9bdf4a9 100644
> > > --- a/fs/xfs/xfs_log_cil.c
> > > +++ b/fs/xfs/xfs_log_cil.c
> > > @@ -238,9 +238,7 @@ xfs_cil_prepare_item(
> > >  	/*
> > >  	 * If there is no old LV, this is the first time we've seen the item in
> > >  	 * this CIL context and so we need to pin it. If we are replacing the
> > > -	 * old_lv, then remove the space it accounts for and make it the shadow
> > > -	 * buffer for later freeing. In both cases we are now switching to the
> > > -	 * shadow buffer, so update the the pointer to it appropriately.
> > > +	 * old_lv, then remove the space it accounts for and free it.
> > >  	 */
> > 
> > The comment above xlog_cil_alloc_shadow_bufs() needs a similar update
> > around how we handle the old buffer when the shadow buffer is used.
> 
> *nod*
> 
> > 
> > >  	if (!old_lv) {
> > >  		if (lv->lv_item->li_ops->iop_pin)
> > > @@ -251,7 +249,8 @@ xfs_cil_prepare_item(
> > >  
> > >  		*diff_len -= old_lv->lv_bytes;
> > >  		*diff_iovecs -= old_lv->lv_niovecs;
> > > -		lv->lv_item->li_lv_shadow = old_lv;
> > > +		kmem_free(old_lv);
> > > +		lv->lv_item->li_lv_shadow = NULL;
> > >  	}
> > 
> > So IIUC this is the case where we allocated a shadow buffer, the item
> > was already pinned (so old_lv is still around) but we ended up using the
> > shadow buffer for this relog. Instead of keeping the old buffer around
> > as a new shadow, we toss it. That makes sense, but if the objective is
> > to not leave dangling shadow buffers around as such, what about the case
> > where we allocated a shadow buffer but didn't end up using it because
> > old_lv was reusable? It looks like we still keep the shadow buffer
> > around in that scenario with a similar lifetime as the swapout scenario
> > this patch removes. Hm?
> 
> Of the top of my head, we shouldn't allocate a new shadow buffer in
> that case (see xlog_cil_alloc_shadow_bufs()). i.e. we check up front
> if the formatted size of the item will fit in the existing buffer,
> and if it does we do not allocate a new shadow buffer as we just
> reuse the existing one. SO we should only have to free a shadow
> buffer when we switch them, not when we overwrite.
> 

We have such a check in xlog_cil_insert_format_items(), so we'd reuse
->li_lv if it will suffice even if we have a shadow buffer available.

> I'll recheck this, but I'm pretty sure overwrite won't leave a
> shadow buffer around.
> 

But before that we have the following logic:

static void
xlog_cil_alloc_shadow_bufs(
	...

	if (!lip->li_lv_shadow ||
	    buf_size > lip->li_lv_shadow->lv_size) {
		...
		lv = kmem_alloc_large(buf_size, KM_SLEEP | KM_NOFS);
		...
		lip->li_lv_shadow = lv;
	} else {
		<reuse shadow>
	}
	...
}

... which always allocates a shadow buffer if one doesn't exist. We
don't look at the currently used (lip->li_lv) buffer at all here. IIUC,
that has to do with the TOCTOU race described in the big comment above
the function.. hm?

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
