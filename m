Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B03794296
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbjIFR7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjIFR7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085B1BEC;
        Wed,  6 Sep 2023 10:58:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADFBC433C7;
        Wed,  6 Sep 2023 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694023046;
        bh=T+JeBsQMgoMoI7Z9ii2a1ZJMhG7TMCLD0rxSwh0+Fyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3TojB3HlAsvztCJe887XS0zMGeyr7noAfkBlSx0A4VSFsD2ztyxcuVOKTCZ5oZ6p
         q9eqBtx18x/V6OoLylL7dKmBeNSXPtHkmCW2BYfCVOrxNwDjDq6VoHz9e+ib7XtbYt
         MqLxpJ8Vvx9jprTZaxqKccvsQNgrlPFM2h8E5i2BIyqn/lHhlw05gYRsmVDlwjfqPz
         bLFeNr+IlL3/24OSf9JC1PJgCNjDvxSOO2Hh5bZYLrdXz2dN2cranztji539T5HghI
         1CBHjHbanR1m0y8BVYsd90hHn0kCaGYSxmeEyeRz6cRtqxVHdCU79NmZ9IQv24vNtq
         Yehp7o8EzlLog==
Date:   Wed, 6 Sep 2023 10:57:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230906175725.GF28160@frogsfrogsfrogs>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <ZPcsHyWOHGJid82J@infradead.org>
 <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
 <ZPfKsp9/LVHbk4Px@casper.infradead.org>
 <20230906161002.2ztelmyzgy3pbmcd@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906161002.2ztelmyzgy3pbmcd@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:10:02PM -0400, Kent Overstreet wrote:
> On Wed, Sep 06, 2023 at 01:41:22AM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 05, 2023 at 08:00:07PM -0400, Kent Overstreet wrote:
> > > On Tue, Sep 05, 2023 at 06:24:47AM -0700, Christoph Hellwig wrote:
> > > > Hi Kent,
> > > > 
> > > > I thought you'd follow Christians proposal to actually work with
> > > > people to try to use common APIs (i.e. to use iomap once it's been
> > > > even more iter-like, for which I'm still waiting for suggestions),
> > > > and make your new APIs used more widely if they are a good idea
> > > > (which also requires explaining them better) and aim for 6.7 once
> > > > that is done.
> > > 
> > > Christoph, I get that iomap is your pet project and you want to make it
> > > better and see it more widely used.

Christoph quit as maintainer 78 days ago.

> > > But the reasons bcachefs doesn't use iomap have been discussed at
> > > length, and I've posted and talked about the bcachefs equivalents of
> > > that code. You were AWOL on those discussions; you consistently say
> > > "bcachefs should use iomap" and then walk away, so those discussions
> > > haven't moved forwards.
> > > 
> > > To recap, besides being more iterator like (passing data structures
> > > around with iterators, vs. indirect function calls into the filesystem),
> > > bcachefs also hangs a bit more state off the pagecache, due to being
> > > multi device and also using the same data structure for tracking disk
> > > reservations (because why make the buffered write paths look that up
> > > separately?).
> > 
> > I /thought/ the proposal was to use iomap for bcachefs DIO and leave

I wasn't aware of /any/ active effort to make bcachefs use iomap for any
purpose.

> > buffered writes for a different day.  I agree the iomap buffered write
> > path is inappropriate for bcachefs today.  I'd like that to change,
> > but there's a lot of functionality that it would need to support.
> 
> No, I'm not going to convert the bcachefs DIO path to iomap; not as it
> exitss now.
> 
> Right now I've got a clean separation between the VFS level DIO code,
> and the lower level bcachefs code that walks the extents btree and
> issues IOs. I have to consider the iomap approach where the
> loop-up-mappings-and-issue loop is in iomap code but calling into
> filesystem code pretty gross.
> 
> I was talking about this /years/ ago when I did the work to make it
> possible to efficiently split bios - iomap could have taken the approach
> bcachefs did, the prereqs were in place when iomap was started, but it
> didn't happen - iomap ended up being a more conservative approach, a
> cleaned up version of buffer heads and fs/direct-IO.c.

<shrug> iirc the genesis of xfs "iomap" was that it was created to
supply space mappings to pnfs, and then got reused for directio and
pagecache operations.  Later that was hoisted wholesale to the vfs.
Then spectre/meltdown happened and our indirect function call toy got
taken away, and now we're stuck figuring out how to remove them all.

IOWs, individual tactics that each made sense for maintaining the
overall stability of xfs, but overall didn't amount to anything
ambitious.

In the end I'd probably rather do something like this to eliminate all
the indirect function calls:

int
xfs_zero_range(
	struct xfs_inode	*ip,
	loff_t			pos,
	loff_t			len,
	bool			*did_zero)
{
	struct iomap_iter	iter = { };
	struct inode		*inode = VFS_I(ip);
	int			ret = 0;

	iomap_start_zero_range(&iter, inode, pos, len);
	while (iter.len > 0) {
		ret = xfs_buffered_write_iomap_begin(&iter, &iter.write_map,
				&iter.read_map);
		if (ret)
			break;
		len = iomap_zero_range_iter(&iter, did_zero);
		if (len < 0) {
			ret = len;
			break;
		}
		ret = xfs_buffered_write_iomap_end(&iter, len, &iter.write_map);
		if (ret)
			break;
		iomap_iter_advance(&iter, len);
	}
	iomap_end_zero_range(&iter);

	return iter.write > 0 ? iter.write : ret;
}

(I would also rename iter.iomap and iter.srcmap to make it more obvious
which ones get filled out under what circumstances.)

> That's fine, iomap is certainly an improvement over what it was
> replacing, but it would not be an improvement for bcachefs.

Filesystems are free to implement read_ and write_iter as they choose,
whether or not that involves iomap.

> I think it might be more fruitful to look at consolidating the buffered
> IO code in bcachefs and iomap. The conceptual models are a bit closer,
> bcachefs's buffered IO code is just a bit more fully-featured in that it
> does the dirty block tracking in a unified way. That was a project that
> turned out pretty nicely.

I think I'd much rather gradually revise iomap for everyone and cut
bcachefs over when its ready.  I don't think revising iomap is a
reasonable precondition for merging bcachefs, nor do I think it's a good
idea to risk destabilizing bcachefs just to hack in a new dependency
that won't even fit well.

--D
