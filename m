Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1179E2CE24F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 00:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgLCXG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 18:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgLCXG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:06:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71736C061A51
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 15:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=puzWWYxspUA+j63mBQLe2nr9JuxsS26KwrP/fNnL/r8=; b=eNrURfjmzRDtKow7czwqWudVUA
        wUEyI2WSMgHoEgFnkyz5EuewdkEirqoRPoWHjHQTx8y6wBZypCenXJMcQuRJeBHIuJqOcIwzLBPgu
        4DhAW4ca99V0MDUqxyeYn7mNHK/QFo9CtF2DVhp2CuOCTvCjdlIeJZq5hx2LKOu2GbCzTG5JAZq6Y
        pyh00cgnCUaLzghtKs9knDSK9bvFicYGy33VyveiPAqj3hZOfDLEPYk+Xi2l09pKmBj8skTrlj+a/
        6Pt/Gi+HV7Mhk5+XOv14XJhp4GKKIChuYl6ajI5JBgk9ouQXPG7vbQelir/c5G0arWWRDgAwoK/au
        fuUclOLw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkxfR-0005ae-Qa; Thu, 03 Dec 2020 23:05:41 +0000
Date:   Thu, 3 Dec 2020 23:05:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, jlayton@redhat.com,
        dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: Problems doing DIO to netfs cache on XFS from Ceph
Message-ID: <20201203230541.GL11935@casper.infradead.org>
References: <914680.1607004656@warthog.procyon.org.uk>
 <20201203221202.GA4170059@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203221202.GA4170059@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Might be a good idea to cc Yafang on this ...

On Fri, Dec 04, 2020 at 09:12:02AM +1100, Dave Chinner wrote:
> On Thu, Dec 03, 2020 at 02:10:56PM +0000, David Howells wrote:
> > Hi Christoph,
> > 
> > We're having a problem making the fscache/cachefiles rewrite work with XFS, if
> > you could have a look?  Jeff Layton just tripped the attached warning from
> > this:
> > 
> > 	/*
> > 	 * Given that we do not allow direct reclaim to call us, we should
> > 	 * never be called in a recursive filesystem reclaim context.
> > 	 */
> > 	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > 		goto redirty;
> 
> I've pointed out in other threads where issues like this have been
> raised that this check is not correct and was broken some time ago
> by the PF_FSTRANS removal. The "NOFS" case here was originally using
> PF_FSTRANS to protect against recursion from within transaction
> contexts, not recursion through memory reclaim.  Doing writeback
> from memory reclaim is caught by the preceeding PF_MEMALLOC check,
> not this one.
> 
> What it is supposed to be warning about is that writeback in XFS can
> start new transactions and nesting transactions is a guaranteed way
> to deadlock the journal. IOWs, doing writeback from an active
> transaction context is a bug in XFS.
> 
> IOWs, we are waiting on a new version of this patchset to be posted:
> 
> https://lore.kernel.org/linux-xfs/20201103131754.94949-1-laoar.shao@gmail.com/
> 
> so that we can get rid of this from iomap and check the transaction
> recursion case directly in the XFS code. Then your problem goes away
> completely....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
