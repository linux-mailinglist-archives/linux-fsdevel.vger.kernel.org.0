Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3518537300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 01:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiE2Xv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 May 2022 19:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiE2Xv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 May 2022 19:51:27 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F6345250F
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 16:51:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 64732534783;
        Mon, 30 May 2022 09:51:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvSgt-000Odq-0A; Mon, 30 May 2022 09:51:23 +1000
Date:   Mon, 30 May 2022 09:51:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "linux-ext4@vger.kernel.org Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 0/9] Convert JFS to use iomap
Message-ID: <20220529235122.GJ3923443@dread.disaster.area>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220528000216.GG3923443@dread.disaster.area>
 <YpGF3ceSLt7J/UKn@casper.infradead.org>
 <20220528053639.GI3923443@dread.disaster.area>
 <YpJxEwl+t93pSKLk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpJxEwl+t93pSKLk@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=629406fc
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=nFtKY5cEK-91eS0LWzcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 28, 2022 at 02:59:31PM -0400, Theodore Ts'o wrote:
> +linux-ext4
> 
> On Sat, May 28, 2022 at 03:36:39PM +1000, Dave Chinner wrote:
> > The other filesystem that uses nobh is the standalone ext2
> > filesystem that nobody uses anymore as the ext4 module provides ext2
> > functionality for distros these days. Hence there's an argument that
> > can be made for removing fs/ext2 as well. In which case, the whole
> > nobh problem goes away by deprecating and removing both the
> > filesysetms that use that infrastructure in 2 years time....
> 
> This got brought up at this past week's ext4 video chat, where Willy
> asked Jan (who has been maintaining ext2) whether he would be open to
> converting ext2 to use iomap.  The answer was yes.  So once jfs and
> ext2 are converted, we'll be able to nuke the nobh code.
> 
> From Willy's comments on the video chat, my understanding is that jfs
> was even simpler to convert that ext2, and this allows us to remove
> the nobh infrastructure without asking the question about whether it's
> time to remove jfs.

I disagree there - if we are changing code that has been unchanged
for a decade or more, there are very few users of that code, and
there's a good chance that data corruption regressions will result
from the changes being proposed, then asking the question "why take
the risk" is very pertinent.

"Just because we can" isn't a good answer. The best code is code we
don't have to write and maintain. If it's a burden to maintain and a
barrier to progress, then we should seriously be considering
removing it, not trying to maintain the fiction that it's a viable
supported production quality filesystem that people can rely on....

> > > We also need to convert more filesystems to use iomap.
> > 
> > We also need to deprecate and remove more largely unmaintained and
> > unused filesystems. :)
> 
> Well, Dave Kleikamp is still around and sends jfs pull requests from
> time to time, and so it's not as unmaintained as, say, fs/adfs,
> fs/freevxs, fs/hpfs, fs/minix, and fs/sysv.

Yes, but the changes that have been made over the past decade are
all small and minor - there's been no feature work, no cleanup work,
no attempt to update core infrastructure, etc. There's beeen no
serious attempts to modernise or update the code for a decade...

> As regards to minixfs, I'd argue that ext2 is a better reference file
> system than minixfs.  So..... are we ready to remove minixfs?  I could
> easily see that some folks might still have sentimental attachment to
> minixfs.  :-)

AFAIC, yes, minixfs and and those other ones should have been
deprecated long ago....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
