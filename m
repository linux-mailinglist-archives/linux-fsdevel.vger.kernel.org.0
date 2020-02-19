Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D624163B9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBSDsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:48:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSDsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=P0Aqnmh/ude15oZ9+jBKMekOeIkaNHoxHvgKFKL94mA=; b=FSoLGQMrnCic9sH2LnjBTVvXkY
        cR8rxIORXfKa4enzs9Cs2GXR0z+rIuK88JgQsM8DtS928q38iVLZIXEqIQc8q+6qXpA+vPjP2afdW
        JtadyP4iMVqVGAS5bem1ldbKGp0NNtsOSoR55HFUXZe2bqClYtvXkf0CTJALcTtf1fLUKAyYAxfFK
        uIGYTiCemjUsA7zZ2KRiYHV+n6nadA3f8CiLvC9UwXrmwnutB8y991dzJSvNTqvLXt/c12hRzyk+z
        l09uLVtA1n5dG8voulxeaN4r82ntGQnLY0NInwJabn4DZp6u6QQSpP+7/aa9cy5PT2a7MgjX4wADX
        Z5fiC2XA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4GLg-00024B-95; Wed, 19 Feb 2020 03:48:32 +0000
Date:   Tue, 18 Feb 2020 19:48:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 00/19] Change readahead API
Message-ID: <20200219034832.GL24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200218045633.GH10776@dread.disaster.area>
 <20200218134230.GN7778@bombadil.infradead.org>
 <20200218212652.GR10776@dread.disaster.area>
 <20200219034525.GH10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200219034525.GH10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:45:25PM +1100, Dave Chinner wrote:
> On Wed, Feb 19, 2020 at 08:26:52AM +1100, Dave Chinner wrote:
> > On Tue, Feb 18, 2020 at 05:42:30AM -0800, Matthew Wilcox wrote:
> > > On Tue, Feb 18, 2020 at 03:56:33PM +1100, Dave Chinner wrote:
> > > > Latest version in your git tree:
> > > > 
> > > > $ ▶ glo -n 5 willy/readahead
> > > > 4be497096c04 mm: Use memalloc_nofs_save in readahead path
> > > > ff63497fcb98 iomap: Convert from readpages to readahead
> > > > 26aee60e89b5 iomap: Restructure iomap_readpages_actor
> > > > 8115bcca7312 fuse: Convert from readpages to readahead
> > > > 3db3d10d9ea1 f2fs: Convert from readpages to readahead
> > > > $
> > > > 
> > > > merged into a 5.6-rc2 tree fails at boot on my test vm:
> > > > 
> > > > [    2.423116] ------------[ cut here ]------------
> > > > [    2.424957] list_add double add: new=ffffea000efff4c8, prev=ffff8883bfffee60, next=ffffea000efff4c8.
> > > > [    2.428259] WARNING: CPU: 4 PID: 1 at lib/list_debug.c:29 __list_add_valid+0x67/0x70
> > > > [    2.457484] Call Trace:
> > > > [    2.458171]  __pagevec_lru_add_fn+0x15f/0x2c0
> > > > [    2.459376]  pagevec_lru_move_fn+0x87/0xd0
> > > > [    2.460500]  ? pagevec_move_tail_fn+0x2d0/0x2d0
> > > > [    2.461712]  lru_add_drain_cpu+0x8d/0x160
> > > > [    2.462787]  lru_add_drain+0x18/0x20
> > > 
> > > Are you sure that was 4be497096c04 ?  I ask because there was a
> > 
> > Yes, because it's the only version I've actually merged into my
> > working tree, compiled and tried to run. :P
> > 
> > > version pushed to that git tree that did contain a list double-add
> > > (due to a mismerge when shuffling patches).  I noticed it and fixed
> > > it, and 4be497096c04 doesn't have that problem.  I also test with
> > > CONFIG_DEBUG_LIST turned on, but this problem you hit is going to be
> > > probabilistic because it'll depend on the timing between whatever other
> > > list is being used and the page actually being added to the LRU.
> > 
> > I'll see if I can reproduce it.
> 
> Just updated to a current TOT Linus kernel and your latest branch,
> and so far this is 100% reproducable.
> 
> Not sure how I'm going to debug it yet, because it's init that is
> triggering it....

Eric found it ... still not sure why I don't see it.
