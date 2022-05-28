Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37305536AED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiE1Fgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiE1Fgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:36:43 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11661248D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:36:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D1F9510C8E4E;
        Sat, 28 May 2022 15:36:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nup7v-00HIql-Hc; Sat, 28 May 2022 15:36:39 +1000
Date:   Sat, 28 May 2022 15:36:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 0/9] Convert JFS to use iomap
Message-ID: <20220528053639.GI3923443@dread.disaster.area>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220528000216.GG3923443@dread.disaster.area>
 <YpGF3ceSLt7J/UKn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpGF3ceSLt7J/UKn@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6291b4e9
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=DlPPC4AEmJpWGZdN3nAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 28, 2022 at 03:15:57AM +0100, Matthew Wilcox wrote:
> On Sat, May 28, 2022 at 10:02:16AM +1000, Dave Chinner wrote:
> > On Thu, May 26, 2022 at 08:29:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > This patchset does not work.  It will eat your filesystem.  Do not apply.
> > > 
> > > The bug starts to show up with the fourth patch ("Convert direct_IO write
> > > support to use iomap").  generic/013 creates a corrupt filesystem and
> > > fsck fails to fix it, which shows all kinds of fun places in xfstests
> > > where we neglect to check that 'mount' actually mounted the filesystem.
> > > set -x or die.
> > > 
> > > I'm hoping one of the people who knows iomap better than I do can just
> > > point at the bug and say "Duh, it doesn't work like that".
> > > 
> > > It's safe to say that every patch after patch 6 is untested.  I'm not
> > > convinced that I really tested patch 6 either.
> > 
> > So the question I have to ask here is "why even bother?".
> > 
> > JFS is a legacy filesystem, and the risk of breaking stuff or
> > corrupting data and nobody noticing is really quite high.
> > 
> > We recently deprecated reiserfs and scheduled it's removal because
> > of the burden of keeping it up to date with VFS changes, what makes
> > JFS any different in this regard?
> 
> Deprecating and scheduling removal is all well and good (and yes,
> we should probably have a serious conversation about when we should
> remove JFS), but JFS is one of the two users of the nobh infrastructure.
> If we want to get rid of the nobh infrastructure (which I do), we need
> to transition JFS to some other infrastructure.

Sure, but ... Devil's Advocate.

The other filesystem that uses nobh is the standalone ext2
filesystem that nobody uses anymore as the ext4 module provides ext2
functionality for distros these days. Hence there's an argument that
can be made for removing fs/ext2 as well. In which case, the whole
nobh problem goes away by deprecating and removing both the
filesysetms that use that infrastructure in 2 years time....

> We also need to convert more filesystems to use iomap.

We also need to deprecate and remove more largely unmaintained and
unused filesystems. :)

> I really wanted
> to NAK the ntfs3 submission on the basis that it was still BH based,
> but with so many existing filesystems using the BH infrastructure,
> that's not a credible thing to require.

Until ext4 is converted to use iomap, we realistically cannot ask
anyone to use iomap....

> So JFS stood out to me as a filesystem which uses infrastructure that we
> can remove fairly easily, one which doesn't get a whole lot of patches,
> one that doesn't really use a lot of the BH infrastructure anyway and
> one which can serve as an example for more ... relevant filesystems.

Isn't that the entire purpose of fs/ext2 still existing these days?
i.e. to be the simple "reference" filesystem for Linux?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
