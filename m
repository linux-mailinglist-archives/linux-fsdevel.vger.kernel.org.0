Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949596C6C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCWPaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjCWPau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:30:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440B34C2E;
        Thu, 23 Mar 2023 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eeOG5CigAADDhpiWzbHe93M8aJDDgCUGp/z1aQBsav4=; b=XP940pVAUyP7Thq6nocMQueT0P
        vDcKjK5NtAZ3V18MnVXY3gmuO1GUEaN+iWy1ZK0K3SHEw8qar7B9cx6PxP0FOUu8Oox/JCnAvIDUB
        393SoMsSZ+bXIrK2X9VE00xgrhDJSCBdjM7uVR81onvctRZqeoG3hAwvFTzWC+9/pI4bztXd4H1lT
        PUtO2p08y5GpBNutKUHXZ2jPLNGjAdegsS5ttXEYy70LHMaFc6FIt4hoyrh6bd57GM5WJpiWqwkyK
        OjYNRw7VOVfrMQDQaAJrlTFxUAPPj/TTep2x40iMrCOCgnEp0OPjyJOxNJZGa7jeyNJrHx+pwjYQW
        sq6mVCZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfMti-0042lO-Ra; Thu, 23 Mar 2023 15:30:38 +0000
Date:   Thu, 23 Mar 2023 15:30:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
Message-ID: <ZBxwnlKOZxHmLtdR@casper.infradead.org>
References: <20230126202415.1682629-5-willy@infradead.org>
 <87ttyy1bz4.fsf@doe.com>
 <ZBvG8xbGHwQ+PPQa@casper.infradead.org>
 <20230323145109.GA466457@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323145109.GA466457@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:51:09AM -0700, Darrick J. Wong wrote:
> On Thu, Mar 23, 2023 at 03:26:43AM +0000, Matthew Wilcox wrote:
> > On Mon, Mar 06, 2023 at 02:40:55PM +0530, Ritesh Harjani wrote:
> > > "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> > > 
> > > > Prepare ext4 to support large folios in the page writeback path.
> > > 
> > > Sure. I am guessing for ext4 to completely support large folio
> > > requires more work like fscrypt bounce page handling doesn't
> > > yet support folios right?
> > > 
> > > Could you please give a little background on what all would be required
> > > to add large folio support in ext4 buffered I/O path?
> > > (I mean ofcourse other than saying move ext4 to iomap ;))
> > > 
> > > What I was interested in was, what other components in particular for
> > > e.g. fscrypt, fsverity, ext4's xyz component needs large folio support?
> > > 
> > > And how should one go about in adding this support? So can we move
> > > ext4's read path to have large folio support to get started?
> > > Have you already identified what all is missing from this path to
> > > convert it?
> > 
> > Honestly, I don't know what else needs to be done beyond this patch
> > series.  I can point at some stuff and say "This doesn't work", but in
> > general, you have to just enable it and see what breaks.  A lot of the
> > buffer_head code is not large-folio safe right now, so that's somewhere
> > to go and look.  Or maybe we "just" convert to iomap, and never bother
> > fixing the bufferhead code for large folios.
> 
> Yes.  Let's leave bufferheads in the legacy doo-doo-dooooo basement
> instead of wasting more time on them.  Ideally we'd someday run all the
> filesystems through:
> 
> bufferheads -> iomap with bufferheads -> iomap with folios -> iomap with
> large folios -> retire to somewhere cheaper than Hawaii

Places cheaper than Hawaii probably aren't as pretty as Hawaii though :-(

XFS is fine because it uses xfs_buf, but if we don't add support for
large folios to bufferheads, we can't support LBA size > PAGE_SIZE even
to read the superblock.  Maybe that's fine ... only filesystems which
don't use sb_bread() get to support LBA size > PAGE_SIZE.

I really want to see a cheaper abstraction for accessing the block device
than BHs.  Or xfs_buf for that matter.
