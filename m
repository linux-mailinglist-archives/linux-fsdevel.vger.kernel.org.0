Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7192283D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGUPbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgGUPbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:31:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD5C061794;
        Tue, 21 Jul 2020 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3+Pp/3FagpQxAvNMEgqYtXBdoVkPujJ1lGmtP9vdIiU=; b=BFZGeujwgBNxHNSd3GsPXLbs2u
        0whuAeYJh8B7UmJm1CKmOH/uPtfZwcSCjo0xFvKy+Qe0rZXWVTAHVicNwUY6cVJKCd43ia3UsYiQB
        44rFLiF2gMMCJ/B8w84DXAY4I46N0iYAP4RZ59K0gMxkgINTjQ4K3pRNrGaisthtTKi8t5g8RM3iJ
        U+YnZbfG7dpY+6j12QMS5pOXVPf3b2+WY+4YAOu6cm/OSO+l31X3wTDzq+rsqa5PRWnfdHE1u3I9+
        fBK7wZqM2yjOcKdDLDA19hq1B4esBkxg0oUs/1nHdBCKcosscvXRRq/Ib/2CJNa+urQHz5GK9kXhR
        bHeRqntQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxuEy-0003u2-6C; Tue, 21 Jul 2020 15:31:36 +0000
Date:   Tue, 21 Jul 2020 16:31:36 +0100
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
Message-ID: <20200721153136.GJ15516@casper.infradead.org>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
 <20200721150432.GH15516@casper.infradead.org>
 <20200721150615.GA10330@lst.de>
 <20200721151437.GI15516@casper.infradead.org>
 <20200721151616.GA11074@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721151616.GA11074@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:16:16PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 04:14:37PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 21, 2020 at 05:06:15PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 21, 2020 at 04:04:32PM +0100, Matthew Wilcox wrote:
> > > > I thought you were going to respin this with EREMCHG changed to ENOTBLK?
> > > 
> > > Oh, true.  I'll do that ASAP.
> > 
> > Michael, could we add this to manpages?
> 
> Umm, no.  -ENOTBLK is internal - the file systems will retry using
> buffered I/O and the error shall never escape to userspace (or even the
> VFS for that matter).

Ah, I made the mistake of believing the comments that I could see in
your patch instead of reading the code.

Can I suggest deleting this comment:

        /*
         * No fallback to buffered IO on errors for XFS, direct IO will either
         * complete fully or fail.
         */

and rewording this one:

                /*
                 * Allow a directio write to fall back to a buffered
                 * write *only* in the case that we're doing a reflink
                 * CoW.  In all other directio scenarios we do not
                 * allow an operation to fall back to buffered mode.
                 */

as part of your revised patchset?
