Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55D929E2EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgJ1Vdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgJ1VdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603920790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRxckUNRLC0IZ+zYMP2AzU6qzBRsyuZ6desZQcjX5/o=;
        b=TbVopAXJm2Yj+NC+3/+gFi23lJsV7vvTxslZqV3QsBvdT1v/a/klOoXkRMW+Qz8+Ik5ztd
        HVJWSVxsB8xIJZcGOcbL+r5+AMo7shS4iDc5Scf824Zoql9YpsR6YWrZnap/4STrc9QG+T
        kMiZEJhMg5O6r0B3e6VpFo1dGQ9EVpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-czQ5cbKoPkestDaF3LltuQ-1; Wed, 28 Oct 2020 07:31:39 -0400
X-MC-Unique: czQ5cbKoPkestDaF3LltuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3BBD8070F2;
        Wed, 28 Oct 2020 11:31:38 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F7DA10013C4;
        Wed, 28 Oct 2020 11:31:38 +0000 (UTC)
Date:   Wed, 28 Oct 2020 07:31:36 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: zero cached pages over unwritten extents on
 zero range
Message-ID: <20201028113136.GB1610972@bfoster>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-3-bfoster@redhat.com>
 <20201015094901.GC21420@infradead.org>
 <20201019165519.GB1232435@bfoster>
 <20201019180144.GC1232435@bfoster>
 <20201020162150.GB1272590@bfoster>
 <20201027181552.GB32577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027181552.GB32577@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 06:15:52PM +0000, Christoph Hellwig wrote:
> On Tue, Oct 20, 2020 at 12:21:50PM -0400, Brian Foster wrote:
> > Ugh, so the above doesn't quite describe historical behavior.
> > block_truncate_page() converts an unwritten block if a page exists
> > (dirty or not), but bails out if a page doesn't exist. We could still do
> > the above, but if we wanted something more intelligent I think we need
> > to check for a page before we get the mapping to know whether we can
> > safely skip an unwritten block or need to write over it. Otherwise if we
> > check for a page within the actor, we have no way of knowing whether
> > there was a (possibly dirty) page that had been written back and/or
> > reclaimed since ->iomap_begin(). If we check for the page first, I think
> > that the iolock/mmaplock in the truncate path ensures that a page can't
> > be added before we complete. We might be able to take that further and
> > check for a dirty || writeback page, but that might be safer as a
> > separate patch. See the (compile tested only) diff below for an idea of
> > what I was thinking.
> 
> The idea looks reasonable, but a few comment below:
> 

JFYI, I had posted an implementation of this idea here[1] and followed
up with some details on a similar COW related issue that was exposed
once the unwritten variant was addressed. I was reasoning about a
slightly different approach that might more clearly facilitate handling
both scenarios, but I think I mentioned to Darrick offline that this all
has me back to preferring the original patch to flush the new EOF block
first, at least as a first step.

I have a couple other fixes (one being the discard_page() patch you've
already commented on) related to iomap and I'm going to be offline for a
few weeks after this week so I'll try to collect them in a series and
get them posted together soon..

Brian

[1] https://lore.kernel.org/linux-fsdevel/20201021133329.1337689-1-bfoster@redhat.com/

> > +struct iomap_trunc_priv {
> > +	bool *did_zero;
> 
> I don't think there is any point on using a pointer here, when we
> can trivially copy out the scalar value.
> 
> > +	bool has_page;
> 
> The naming of this flag really confuses me.  Maybe has_data or
> in_pagecache might be better options?
> 
> > +static loff_t
> > +iomap_truncate_page_actor(struct inode *inode, loff_t pos, loff_t count,
> > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +	struct iomap_trunc_priv	*priv = data;
> > +	unsigned offset;
> > +	int status;
> > +
> > +	if (srcmap->type == IOMAP_HOLE)
> > +		return count;
> > +	if (srcmap->type == IOMAP_UNWRITTEN && !priv->has_page)
> > +		return count;
> 
> Maybe add a comment here to explain why priv->has_page matters?
> 
> > +
> > +	offset = offset_in_page(pos);
> 
> I'd move this on the initialization line.
> 
> > +	ret = iomap_apply(inode, pos, blocksize - off, IOMAP_ZERO, ops, &priv,
> > +			  iomap_truncate_page_actor);
> > +	if (ret <= 0)
> > +		return ret;
> 
> The check could just be < 0 and would be a little more obvious.
> 

