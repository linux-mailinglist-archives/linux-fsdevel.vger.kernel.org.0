Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B2250FF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHYD0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYD0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:26:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17774C061574;
        Mon, 24 Aug 2020 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J3dfycSxBtZRRvSDChUUWzn3te0iYIcwnr26lQHaR+E=; b=ULMpSqB6Oij/9EGSyEkn6+4Du2
        PPoYEiX0RKE/qIcll9dylpz6U2JZh7oCGw2IKVWGhCyvTG0ApKN121pQO07g11Fg3/YLn6hYjcaHJ
        KrG0seHxTLitIu8XbVtDfSEw6z78nWtqTYh487X73b4gHnMVZa4oKNZz9DYobYWzhqyveob4NxMcR
        tzoPnZWv35smU13HYzt2hkrQJjrLEMpINThn9wP/9ZSE2eMZPQVtlB/eQozpbs6b/U1oRC2NgIFkg
        ftqUlPiS59N4CrekqrBmC9NAVI19cAGyJgZXFMHHtg9Kp6A2RKSOwcAZDeG7U4PwVuciLI4Q7r5ns
        WkBBCmTw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAPb1-0007Fw-Qk; Tue, 25 Aug 2020 03:26:03 +0000
Date:   Tue, 25 Aug 2020 04:26:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200825032603.GL17456@casper.infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
 <20200825002735.GI12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825002735.GI12131@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:27:35AM +1000, Dave Chinner wrote:
> >  	do {
> > -		unsigned offset, bytes;
> > -
> > -		offset = offset_in_page(pos);
> > -		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
> > +		loff_t bytes;
> >  
> >  		if (IS_DAX(inode))
> > -			status = dax_iomap_zero(pos, offset, bytes, iomap);
> > +			bytes = dax_iomap_zero(pos, length, iomap);
> 
> Hmmm. everything is loff_t here, but the callers are defining length
> as u64, not loff_t. Is there a potential sign conversion problem
> here? (sure 64 bit is way beyond anything we'll pass here, but...)

I've gone back and forth on the correct type for 'length' a few times.
size_t is too small (not for zeroing, but for seek()).  An unsigned type
seems right -- a length can't be negative, and we don't want to give
the impression that it can.  But the return value from these functions
definitely needs to be signed so we can represent an error.  So a u64
length with an loff_t return type feels like the best solution.  And
the upper layers have to promise not to pass in a length that's more
than 2^63-1.

I have a patch set which starts the conversion process for all the actors
over to using u64 for the length.  Obviously, that's not mixed in with
the THP patchset.

