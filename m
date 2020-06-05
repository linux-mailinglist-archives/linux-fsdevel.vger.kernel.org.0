Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA11F031C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgFEWtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 18:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEWtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:49:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012CC08C5C2;
        Fri,  5 Jun 2020 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5+QSp9FxZx6w37Efho0ZuA0OLC0Q8MzF1U5wiPS+9g=; b=bexLYMDESxBJvl0hE48+nhfe/h
        OOpgfz0Xn2XePGAbsb4wkQF4EWGNZyOLG+x3jZiI2a0KpNT9YKlIStMb9h+edJvz38beNb8XkVQwO
        ys3Ek6xIxvQFS8yeofmifaobbF3rT5Qrt6Bewfdd/5ndHtDYMahSJ6RIQv5bTr+DVBFtAuiC1zZ9a
        OAydW6O+IE4b2zVR4R7be4ms9eKQRTBOJgqisFe6OjWNRHxjDh4xJmpQR/go9AybXe5Xhs7EtwhYe
        pshJcswRdnOdT7++r8OjxaoFrCKyzoLX8iX6skJtgTlfhUOauEkS8yaqf+stRTQKtqkPJxCoP9rPa
        umlss9Lw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhL9p-0002pa-Dy; Fri, 05 Jun 2020 22:49:49 +0000
Date:   Fri, 5 Jun 2020 15:49:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200605224949.GK19604@bombadil.infradead.org>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
 <20200604235050.GX19604@bombadil.infradead.org>
 <20200605003159.GX2040@dread.disaster.area>
 <20200605022451.GZ19604@bombadil.infradead.org>
 <20200605030758.GB2040@dread.disaster.area>
 <20200605124826.GF19604@bombadil.infradead.org>
 <20200605214841.GF2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605214841.GF2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 07:48:41AM +1000, Dave Chinner wrote:
> On Fri, Jun 05, 2020 at 05:48:26AM -0700, Matthew Wilcox wrote:
> > ... I don't think that's the interesting path.  I mean, that's
> > the submission path, and usually we discover errors in the completion
> > path, not the submission path.
> 
> Where in the iomap write IO completion path do we call
> ClearPageUptodate()?

Oh, I misread.  You're right, I was looking at the read completion path.

So, this is also inconsistent.  We clear PageUptodate on errors we
discover during submission, but not for errors we discover during
completion.  That doesn't make sense.

> This comes back to my original, underlying worry about the fragility
> of the page fault path: the page fault path is not even checking for
> PageError during faults, and I'm betting that almost no
> ->page_mkwrite implementation is checking it, either....

I think it's a reasonable assumption that user page tables should never
contain a PTE for a page which is !Uptodate.  Otherwise the user can
read stale data.

> > I don't see why it can't be done from the submission path.
> > unmap_mapping_range() calls i_mmap_lock_write(), which is
> > down_write(i_mmap_rwsem) in drag.  There might be a lock ordering
> > issue there, although lockdep should find it pretty quickly.
> > 
> > The bigger problem is the completion path.  We're in softirq context,
> > so that will have to punt to a thread that can take mutexes.
> 
> Punt to workqueue if we aren't already in a workqueue context -
> for a lot of writes on XFS we already will be running completion in
> a workqueue context....

Yep.
