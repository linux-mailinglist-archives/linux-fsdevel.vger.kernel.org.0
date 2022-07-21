Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C857D6E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 00:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiGUWcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 18:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGUWct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:32:49 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC06B3CBC6;
        Thu, 21 Jul 2022 15:32:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7B39262C98A;
        Fri, 22 Jul 2022 08:32:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oEeiq-003igO-TD; Fri, 22 Jul 2022 08:32:44 +1000
Date:   Fri, 22 Jul 2022 08:32:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com, Benjamin Coddington <bcodding@redhat.com>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Message-ID: <20220721223244.GP3600936@dread.disaster.area>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62d9d410
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=Lx-3n2rmoQlJ83VUWZIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:51:33AM -0400, Jeff Layton wrote:
> Back in 2018, I did a patchset [1] to rework the inode->i_version
> counter handling to be much less expensive, particularly when no-one is
> querying for it.

Yup, there's zero additional overhead for maintaining i_version in
XFS when nothing is monitoring it. Updating it comes for free in any
transaction that modifies the inode, so when writes
occur i_version gets bumped if timestamps change or allocation is
required.

And when something is monitoring it, the overhead is effectively a
single "timestamp" update for each peek at i_version the monitoring
agent makes. This is also largely noise....

> Testing at the time showed that the cost of enabling i_version on ext4
> was close to 0 when nothing is querying it, but I stopped short of
> trying to make it the default at the time (mostly out of an abundance of
> caution). Since then, we still see a steady stream of cache-coherency
> problems with NFSv4 on ext4 when this option is disabled (e.g. [2]).
> 
> Is it time to go ahead and make this option the default on ext4? I don't
> see a real downside to doing so, though I'm unclear on how we should
> approach this. Currently the option is twiddled using MS_I_VERSION flag,
> and it's unclear to me how we can reverse the sense of such a flag.

XFS only enables SB_I_VERSION based on an on disk format flag - you
can't turn it on or off by mount options, so it completely ignores
MS_I_VERSION.

> Thoughts?

My 2c is to behave like XFS: ignore the mount option and always turn
it on.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
