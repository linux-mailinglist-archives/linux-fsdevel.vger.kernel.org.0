Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD54EE6F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 05:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiDADzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 23:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbiDADzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:55:15 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD7C12E155;
        Thu, 31 Mar 2022 20:53:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9AC735341BF;
        Fri,  1 Apr 2022 14:53:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1na8Lh-00CLCZ-Mx; Fri, 01 Apr 2022 14:53:21 +1100
Date:   Fri, 1 Apr 2022 14:53:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: change test in inode_insert5 for adding to the sb
 list
Message-ID: <20220401035321.GR1609613@dread.disaster.area>
References: <20220331225632.247244-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331225632.247244-1-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62467734
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=ke8cdjoDFq0_I0rIqSUA:9
        a=CjuIK1q_8ugA:10 a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:56:32PM -0400, Jeff Layton wrote:
> The inode_insert5 currently looks at I_CREATING to decide whether to
> insert the inode into the sb list. This test is a bit ambiguous though
> as I_CREATING state is not directly related to that list.
> 
> This test is also problematic for some upcoming ceph changes to add
> fscrypt support. We need to be able to allocate an inode using new_inode
> and insert it into the hash later if we end up using it, and doing that
> now means that we double add it and corrupt the list.
> 
> What we really want to know in this test is whether the inode is already
> in its superblock list, and then add it if it isn't. Have it test for
> list_empty instead and ensure that we always initialize the list by
> doing it in inode_init_once. It's only ever removed from the list with
> list_del_init, so that should be sufficient.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> This is the alternate approach that Al suggested to me on IRC. I think
> this is likely to be more robust in the long run, and we can avoid
> exporting another symbol.

Looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

FWIW, I'm getting ready to resend patches originally written by
Waiman Long years ago to convert the inode sb list to a different
structure (per-cpu lists) for scalability reasons, but is still
allows using list-empty() to check if the inode is on the list or
not so I dont' see a problem with this change at all.

> Al, if you're ok with this, would you mind taking this in via your tree?
> I'd like to see this in sit in linux-next for a bit so we can see if any
> benchmarks get dinged.

I think that is unlikely - the sb inode list just doesn't show up in
profiles until you are pushing several hundred thousand inodes a
second through the inode cache and there really aren't a lot of
worklaods out there that do that. At that point, sb list lock
contention becomes the issue, not the requirement to add in-use
inodes to the sb list...

e.g. concurrent 'find <...> -ctime' operations on XFS hit sb list
lock contention limits at about 600,000 inodes/s being,
instantiated, stat()d and reclaimed from memory. With
Waiman's dlist code I mention above, it'll do 1.5 million inodes/s
for the same CPU usage.  And a concurrent bulkstat workload goes
from 600,000 inodes/s to over 6 million inodes/s for the same
CPU usage.  That bulkstat workload is hitting memory reclaim
scalability limits as I'm turning over ~12GB/s of cached memory on a
machine with only 16GB RAM...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
