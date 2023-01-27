Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248767DE22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 08:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjA0HCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 02:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjA0HCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:02:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451B1E1D2;
        Thu, 26 Jan 2023 23:02:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61E3F68D0E; Fri, 27 Jan 2023 08:02:10 +0100 (CET)
Date:   Fri, 27 Jan 2023 08:02:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: test not in the auto group, was: Re: [PATCH 23/34] btrfs: allow
 btrfs_submit_bio to split bios
Message-ID: <20230127070209.GA3810@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-24-hch@lst.de> <Y9GkVONZJFXVe8AH@localhost.localdomain> <20230126052143.GA28195@lst.de> <Y9K7pZq2h9aXiKCJ@localhost.localdomain> <20230126174611.GC15999@lst.de> <20230126183304.GZ11562@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126183304.GZ11562@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 07:33:04PM +0100, David Sterba wrote:
> > Oh, I guess the lack of auto group means I've never tested it.  But
> > it's a fairly bad bug, and I'm surprised nothing in auto hits an
> > error after a bio split.  I'll need to find out if I can find a simpler
> > reproducer as this warrants a regression test.
> 
> The 'auto' group is good for first tests, I'm running 'check -g all' on
> my VM setups. If this is enough to trigger errors then we probably don't
> need a separate regression test.

Hmm.  The xfstests README says:

"By default the tests suite will run all the tests in the auto group. These
 are the tests that are expected to function correctly as regression tests,
 and it excludes tests that exercise conditions known to cause machine
 failures (i.e. the "dangerous" tests)."

and my assumptions over decades of xfstests use has been that only tests
that are broken, non-deterministic, or cause recent upstream kernels
to crash are not in auto.

Is there some kind of different rule for btrfs?  e.g. btrfs/125
seems to complete quickly and does not actually seem to be dangerous.
Besides that there's btrfs/185, which is very quick fuzzer, and btrfs/198
which is a fairly normal test as far as I can tell.

The generic tests also have a few !auto tests that look like they
should be mostly in the auto group as well, in addition to a few broken
and dangerous ones, and the blockdev ones from Darrick that should
probably move to blktests.

XFS mostly seems to have dangerous fuzzer tests in the !auto category.
