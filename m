Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBF4EEA6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiDAJbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344559AbiDAJbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2A21D59FD;
        Fri,  1 Apr 2022 02:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA565615A5;
        Fri,  1 Apr 2022 09:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98886C2BBE4;
        Fri,  1 Apr 2022 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648805362;
        bh=FBwzEB+4gX409rCGRVJalnINN4OJMy7oEoQlztqf3dE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sKolWG0qvClXy6wa8wxT4PvIzBZywk3O3vX0e3U6dlsODJdEvCfpRWY/rghCruMMk
         Fo5Zn08+7iicTQe/80dZeus/6QgBICpuFiyMnTtllfFJDhwBlwzKGzwMEDsgKZUMi/
         /jaLKZXUJFBbmSaXhEE0PUE+bYQyQJ+92lU0d34OvKaOwEAg8GOjfTIx4g8dusTz3a
         SIkF1gPbDO9qmr680s7CH4pI7dSaHWv3j0Ujq4qzyqiLb/E2xwtm8VZkSibBP1xxps
         JNzaItH0A9sMdvZ/3Uv4vLneOwRkEde89OwklTJyqlkZ2JaGEoCdbxVBLZvtSm3KTL
         8qZz9vOFwBPFw==
Message-ID: <db6e44833b795051ce612ce26bed38a75bc7623a.camel@kernel.org>
Subject: Re: [PATCH] fs: change test in inode_insert5 for adding to the sb
 list
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     viro@zeniv.linux.org.uk, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Apr 2022 05:29:20 -0400
In-Reply-To: <20220401035321.GR1609613@dread.disaster.area>
References: <20220331225632.247244-1-jlayton@kernel.org>
         <20220401035321.GR1609613@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-04-01 at 14:53 +1100, Dave Chinner wrote:
> On Thu, Mar 31, 2022 at 06:56:32PM -0400, Jeff Layton wrote:
> > The inode_insert5 currently looks at I_CREATING to decide whether to
> > insert the inode into the sb list. This test is a bit ambiguous though
> > as I_CREATING state is not directly related to that list.
> > 
> > This test is also problematic for some upcoming ceph changes to add
> > fscrypt support. We need to be able to allocate an inode using new_inode
> > and insert it into the hash later if we end up using it, and doing that
> > now means that we double add it and corrupt the list.
> > 
> > What we really want to know in this test is whether the inode is already
> > in its superblock list, and then add it if it isn't. Have it test for
> > list_empty instead and ensure that we always initialize the list by
> > doing it in inode_init_once. It's only ever removed from the list with
> > list_del_init, so that should be sufficient.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/inode.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > This is the alternate approach that Al suggested to me on IRC. I think
> > this is likely to be more robust in the long run, and we can avoid
> > exporting another symbol.
> 
> Looks good to me.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> FWIW, I'm getting ready to resend patches originally written by
> Waiman Long years ago to convert the inode sb list to a different
> structure (per-cpu lists) for scalability reasons, but is still
> allows using list-empty() to check if the inode is on the list or
> not so I dont' see a problem with this change at all.
> 

Thanks, Dave.

> > Al, if you're ok with this, would you mind taking this in via your tree?
> > I'd like to see this in sit in linux-next for a bit so we can see if any
> > benchmarks get dinged.
> 
> I think that is unlikely - the sb inode list just doesn't show up in
> profiles until you are pushing several hundred thousand inodes a
> second through the inode cache and there really aren't a lot of
> worklaods out there that do that. At that point, sb list lock
> contention becomes the issue, not the requirement to add in-use
> inodes to the sb list...
> 

My (minor) concern was that since we're now initializing this list for
all allocations, not just in new_inode, it could potentially slow down
some callers. I agree that it seems pretty unlikely to be an issue
though.

> e.g. concurrent 'find <...> -ctime' operations on XFS hit sb list
> lock contention limits at about 600,000 inodes/s being,
> instantiated, stat()d and reclaimed from memory. With
> Waiman's dlist code I mention above, it'll do 1.5 million inodes/s
> for the same CPU usage.  And a concurrent bulkstat workload goes
> from 600,000 inodes/s to over 6 million inodes/s for the same
> CPU usage.  That bulkstat workload is hitting memory reclaim
> scalability limits as I'm turning over ~12GB/s of cached memory on a
> machine with only 16GB RAM...
> 
> Cheers,
> 
> Dave.

-- 
Jeff Layton <jlayton@kernel.org>
