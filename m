Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0E22843D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGUPwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUPwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:52:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82FC061794;
        Tue, 21 Jul 2020 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CmlEdM9mHmEYsnkNRDmtewDs+LTuThNYW1KeG9HP9QA=; b=RyAh1b+Aew+y8wPFyVvKx99p4o
        7LllldkBFIeFA/7lpj4qE89gQWwfUtJzVTUyprOec/KJ7Orn8V2fo1kYc44pMh6XskT/tbs5S3mhT
        ke5HgkEX7NuIqfCeVZzvhGugdguxIRFc5l7O1rkzh6CBGGu6Rsk4Dc/MatzZIsphuKpwBCCWzyZBD
        kayZ1Pd1P23pCWewHEm0Gz1yywn76NKHLMik4zLhCY7Nrcaiz3jpyj5qSSOIk9ACUDApGX1nCiXPl
        HfShmHDDH5e1hx6MIq6NzR5vxxJH9BRKV4y0VplaZ6m//vUwYdXFL4yQncyLwbQXcH7zeojPyQlVx
        EAc+PtFA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxuYj-00054a-SC; Tue, 21 Jul 2020 15:52:02 +0000
Date:   Tue, 21 Jul 2020 16:52:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721155201.GL15516@casper.infradead.org>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
 <20200721150432.GH15516@casper.infradead.org>
 <20200721150615.GA10330@lst.de>
 <20200721151437.GI15516@casper.infradead.org>
 <20200721151616.GA11074@lst.de>
 <20200721153136.GJ15516@casper.infradead.org>
 <20200721154240.GB11652@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721154240.GB11652@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:42:40PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 04:31:36PM +0100, Matthew Wilcox wrote:
> > > Umm, no.  -ENOTBLK is internal - the file systems will retry using
> > > buffered I/O and the error shall never escape to userspace (or even the
> > > VFS for that matter).
> > 
> > Ah, I made the mistake of believing the comments that I could see in
> > your patch instead of reading the code.
> > 
> > Can I suggest deleting this comment:
> > 
> >         /*
> >          * No fallback to buffered IO on errors for XFS, direct IO will either
> >          * complete fully or fail.
> >          */
> > 
> > and rewording this one:
> > 
> >                 /*
> >                  * Allow a directio write to fall back to a buffered
> >                  * write *only* in the case that we're doing a reflink
> >                  * CoW.  In all other directio scenarios we do not
> >                  * allow an operation to fall back to buffered mode.
> >                  */
> > 
> > as part of your revised patchset?
> 
> That isn't actually true.  In current mainline we only fallback on
> reflink RMW cases, but with this series we also fall back for
> invalidation failures.

... that's why I'm suggesting that you delete the first one and rewrite
the second one.  Because they aren't true.
