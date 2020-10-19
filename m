Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E2292D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgJSSB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 14:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbgJSSB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603130515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZRhVayc2gwj9c+mByvsT99OLPdz2/IY1oQ3zLgfgHU=;
        b=dW4Xtc/j7nIDsuBSGMmrf0k7KPqw8NhDsArqXjxDkAcH22jXuDheDfuXk5+KcNAA0+5JBb
        JJ9n41pe+N8Dv4pnRJY/SQOZNbsPFt6DI92MJ6Ac3aktkhcnt7V9+CeyHToQQFMeAbVkNL
        ZRdQfsJYraidvCFsvmLT5WH34MEbAYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-7HpEU7DdOLGhX7ZiDHCvIA-1; Mon, 19 Oct 2020 14:01:53 -0400
X-MC-Unique: 7HpEU7DdOLGhX7ZiDHCvIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D62108BBE2;
        Mon, 19 Oct 2020 18:01:52 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 833F75D9EF;
        Mon, 19 Oct 2020 18:01:51 +0000 (UTC)
Date:   Mon, 19 Oct 2020 14:01:44 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: zero cached pages over unwritten extents on
 zero range
Message-ID: <20201019180144.GC1232435@bfoster>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-3-bfoster@redhat.com>
 <20201015094901.GC21420@infradead.org>
 <20201019165519.GB1232435@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019165519.GB1232435@bfoster>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:55:19PM -0400, Brian Foster wrote:
> On Thu, Oct 15, 2020 at 10:49:01AM +0100, Christoph Hellwig wrote:
> > > +iomap_zero_range_skip_uncached(struct inode *inode, loff_t *pos,
> > > +		loff_t *count, loff_t *written)
> > > +{
> > > +	unsigned dirty_offset, bytes = 0;
> > > +
> > > +	dirty_offset = page_cache_seek_hole_data(inode, *pos, *count,
> > > +				SEEK_DATA);
> > > +	if (dirty_offset == -ENOENT)
> > > +		bytes = *count;
> > > +	else if (dirty_offset > *pos)
> > > +		bytes = dirty_offset - *pos;
> > > +
> > > +	if (bytes) {
> > > +		*pos += bytes;
> > > +		*count -= bytes;
> > > +		*written += bytes;
> > > +	}
> > 
> > I find the calling conventions weird.  why not return bytes and
> > keep the increments/decrements of the three variables in the caller?
> > 
> 
> No particular reason. IIRC I had it both ways and just landed on this.
> I'd change it, but as mentioned in the patch 1 thread I don't think this
> patch is sufficient (with or without patch 1) anyways because the page
> can also have been reclaimed before we get here.
> 

Christoph,

What do you think about introducing behavior specific to
iomap_truncate_page() to unconditionally write zeroes over unwritten
extents? AFAICT that addresses the race and was historical XFS behavior
(via block_truncate_page()) before iomap, so is not without precedent.
What I'd probably do is bury the caller's did_zero parameter into a new
internal struct iomap_zero_data to pass down into
iomap_zero_range_actor(), then extend that structure with a
'zero_unwritten' field such that iomap_zero_range_actor() can do this:

        if (srcmap->type == IOMAP_HOLE ||
            (srcmap->type == IOMAP_UNWRITTEN && !zdata->zero_unwritten))
                return count;

iomap_truncate_page() would set that flag either via open coding
iomap_zero_range() or creating a new internal wrapper. Hm?

Brian

> Brian
> 

