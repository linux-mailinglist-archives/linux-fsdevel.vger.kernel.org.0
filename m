Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7DD56435D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 02:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiGCAGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 20:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGCAGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 20:06:54 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C5B7642E
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 17:06:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0FB7F10E79CD;
        Sun,  3 Jul 2022 10:06:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o7n8S-00DqbA-PA; Sun, 03 Jul 2022 10:06:48 +1000
Date:   Sun, 3 Jul 2022 10:06:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH] fs: allow inode time modification with IOCB_NOWAIT
Message-ID: <20220703000648.GA3237952@dread.disaster.area>
References: <39f8b446-dce3-373f-eb86-e3333b31122c@kernel.dk>
 <Yr/gFLRLBE76enwG@infradead.org>
 <5cfdd462-d21b-cb62-3ad3-3ecd8cbc0a31@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cfdd462-d21b-cb62-3ad3-3ecd8cbc0a31@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62c0dd9b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=e4BO1kgAVSZzEjnUxwkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 02, 2022 at 09:45:23AM -0600, Jens Axboe wrote:
> On 7/2/22 12:05 AM, Christoph Hellwig wrote:
> > On Fri, Jul 01, 2022 at 02:09:32PM -0600, Jens Axboe wrote:
> >> generic/471 complains because it expects any write done with RWF_NOWAIT
> >> to succeed as long as the blocks for the write are already instantiated.
> >> This isn't necessarily a correct assumption, as there are other conditions
> >> that can cause an RWF_NOWAIT write to fail with -EAGAIN even if the range
> >> is already there.
> >>
> >> Since the risk of blocking off this path is minor, just allow inode
> >> time updates with IOCB_NOWAIT set. Then we can later decide if we should
> >> catch this further down the stack.
> > 
> > I think this is broken.  Please just drop the test, the non-blocking
> > behavior here makes a lot of sense.  At least for XFS, the update
> > will end up allocating and commit a transaction which involves memory
> > allocation, a blocking lock and possibly waiting for lock space.
> 
> I'm fine with that, I've made my opinions on that test case clear in
> previous emails. I'll drop the patch for now.
> 
> I will say though that even in low memory testing, I never saw XFS block
> off the inode time update. So at least we have room for future
> improvements here, it's wasteful to return -EAGAIN here when the vast
> majority of time updates don't end up blocking.

It's not low memory testing that you should be concerned about -
it's when the journal runs out of space that you'll get long,
unbound latencies waiting for timestamp updates. Waiting for journal
space to become available could, in the worst case, entail waiting
for tens of thousands of small random metadata IOs to be submitted
and completed....

> One issue there too is that, by default, XFS uses a high granularity
> threshold for when the time should be updated, making the problem worse.

That's not an XFS issue - we're just following the VFS rules for
when mtime needs to be changed. If you want to avoid frequent
transactional (on-disk) mtime updates, then use the lazytime mount
option to limit on-disk mtime updates to once per day.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
