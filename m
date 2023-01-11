Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2C665FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjAKQCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjAKQCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:02:34 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61190DFAD;
        Wed, 11 Jan 2023 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=efDFlg+yOf7f+QHekxkFqaFu7IzDmipcTvP18voo0xg=; b=nHk3+6DFrTjYJgpsa2PRe+SndN
        2Myzd1x/o3p9Pf7L2wTiQNAjYFoax1Rq7pyfPXMbw0+iibH4f2SjU/FFASPVl2Y7+tIcleGBq1ONa
        HEfgv4sHB4WpSnbp8RavAMELKr7lyo4S0QJL/EggtAPGXCZ7drhgOI2Y/Xx4R/CpwCIcojqCXo4C+
        kzXs3CT6dO/uEAnekZMwqoKpSisDWZP+EX+gFcdMYcIwUmAG8QEJhVelh/ChTqzzQ5gzVOfccpiOi
        ssEUOomxggY4Wi6+/yxcp7htPEH9xvxTVsv0E6GN6RitOxAJWq3irOOes+P/s6OQ6umf5d8E1usGP
        2vn6PKYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFdYY-001KCi-12;
        Wed, 11 Jan 2023 16:02:26 +0000
Date:   Wed, 11 Jan 2023 16:02:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] fs/aio: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <Y77dkghufF6GVq1Y@ZenIV>
References: <20230109175629.9482-1-fmdefrancesco@gmail.com>
 <Y73+xKXDELSd14p1@ZenIV>
 <x498ri9ma5n.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x498ri9ma5n.fsf@segfault.boston.devel.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:13:40AM -0500, Jeff Moyer wrote:
> Hi, Al,
> 
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Mon, Jan 09, 2023 at 06:56:29PM +0100, Fabio M. De Francesco wrote:
> >
> >> -	ring = kmap_atomic(ctx->ring_pages[0]);
> >> +	ring = kmap_local_page(ctx->ring_pages[0]);
> >>  	ring->nr = nr_events;	/* user copy */
> >>  	ring->id = ~0U;
> >>  	ring->head = ring->tail = 0;
> >> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
> >>  	ring->compat_features = AIO_RING_COMPAT_FEATURES;
> >>  	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
> >>  	ring->header_length = sizeof(struct aio_ring);
> >> -	kunmap_atomic(ring);
> >> +	kunmap_local(ring);
> >>  	flush_dcache_page(ctx->ring_pages[0]);
> >
> > I wonder if it would be more readable as memcpy_to_page(), actually...
> 
> I'm not sure I understand what you're suggesting.

	memcpy_to_page(ctx->ring_pages[0], 0, &(struct aio_ring){
			.nr = nr_events, .id = ~0U, .magic = AIO_RING_MAGIC,
			.compat_features = AIO_RING_COMPAT_FEATURES,
			.in_compat_features = AIO_RING_INCOMPAT_FEATURES,
			.header_length = sizeof(struct aio_ring)},
			sizeof(struct aio_ring));

instead of the lines from kmap_atomic to flush_dcache_page...

> 
> >>  
> >>  	return 0;
> >> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
> >>  					 * we are protected from page migration
> >>  					 * changes ring_pages by ->ring_lock.
> >>  					 */
> >> -					ring = kmap_atomic(ctx->ring_pages[0]);
> >> +					ring = kmap_local_page(ctx->ring_pages[0]);
> >>  					ring->id = ctx->id;
> >> -					kunmap_atomic(ring);
> >> +					kunmap_local(ring);
> >
> > Incidentally, does it need flush_dcache_page()?
> 
> Yes, good catch.
