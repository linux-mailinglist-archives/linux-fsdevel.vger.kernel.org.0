Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC153705291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjEPPqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjEPPp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 11:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9393C2;
        Tue, 16 May 2023 08:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF645634FA;
        Tue, 16 May 2023 15:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E05C433EF;
        Tue, 16 May 2023 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251924;
        bh=jsW/op+oisDWGtcdd1S1pr3jXJMa5TQFW/rAifvBppI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiRSOJ3SRuh+vsAwxWSGiGyBXFFFKTLR3y3UOY7zHFwsOFtz2hnQq4O4WlbHq9y19
         sFd8XCFBAj2k7SXb5lYZTZJHbHBNmLmfOdq0ayniF8MMv9XVZVYqnkYOSFfK8jD6nE
         gwgXDmAM08S88sbePBSplgI1ga/BBbxcw8iW5Jx014fVDSzxNLzcVhCWbYFMB5C+ZJ
         D+hKy1Ut7ocGpt9qwMOEdxw5RBZcwAcMcjfbV7XUo4c9HaB7tiMZ5T3JLozq/ISLG4
         90T16ke67Ek8bhVdims/hD8Inr05JMIRFK6TN50jcziLOr+LzxMoTuZRvx8bIOH/lE
         wDCgKtmqBP0dw==
Date:   Tue, 16 May 2023 17:45:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20230516-brand-hocken-a7b5b07e406c@brauner>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230510044557.GF2651828@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230510044557.GF2651828@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 02:45:57PM +1000, Dave Chinner wrote:
> On Tue, May 09, 2023 at 12:56:47PM -0400, Kent Overstreet wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Because scalability of the global inode_hash_lock really, really
> > sucks.
> > 
> > 32-way concurrent create on a couple of different filesystems
> > before:
> > 
> > -   52.13%     0.04%  [kernel]            [k] ext4_create
> >    - 52.09% ext4_create
> >       - 41.03% __ext4_new_inode
> >          - 29.92% insert_inode_locked
> >             - 25.35% _raw_spin_lock
> >                - do_raw_spin_lock
> >                   - 24.97% __pv_queued_spin_lock_slowpath
> > 
> > -   72.33%     0.02%  [kernel]            [k] do_filp_open
> >    - 72.31% do_filp_open
> >       - 72.28% path_openat
> >          - 57.03% bch2_create
> >             - 56.46% __bch2_create
> >                - 40.43% inode_insert5
> >                   - 36.07% _raw_spin_lock
> >                      - do_raw_spin_lock
> >                           35.86% __pv_queued_spin_lock_slowpath
> >                     4.02% find_inode
> > 
> > Convert the inode hash table to a RCU-aware hash-bl table just like
> > the dentry cache. Note that we need to store a pointer to the
> > hlist_bl_head the inode has been added to in the inode so that when
> > it comes to unhash the inode we know what list to lock. We need to
> > do this because the hash value that is used to hash the inode is
> > generated from the inode itself - filesystems can provide this
> > themselves so we have to either store the hash or the head pointer
> > in the inode to be able to find the right list head for removal...
> > 
> > Same workload after:
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> I have been maintaining this patchset uptodate in my own local trees
> and the code in this patch looks the same. The commit message above,
> however, has been mangled. The full commit message should be:
> 
> vfs: inode cache conversion to hash-bl
> 
> Because scalability of the global inode_hash_lock really, really
> sucks and prevents me from doing scalability characterisation and
> analysis of bcachefs algorithms.
> 
> Profiles of a 32-way concurrent create of 51.2m inodes with fsmark
> on a couple of different filesystems on a 5.10 kernel:
> 
> -   52.13%     0.04%  [kernel]            [k] ext4_create
>    - 52.09% ext4_create
>       - 41.03% __ext4_new_inode
>          - 29.92% insert_inode_locked
>             - 25.35% _raw_spin_lock
>                - do_raw_spin_lock
>                   - 24.97% __pv_queued_spin_lock_slowpath
> 
> 
> -   72.33%     0.02%  [kernel]            [k] do_filp_open
>    - 72.31% do_filp_open
>       - 72.28% path_openat
>          - 57.03% bch2_create
>             - 56.46% __bch2_create
>                - 40.43% inode_insert5
>                   - 36.07% _raw_spin_lock
>                      - do_raw_spin_lock
>                           35.86% __pv_queued_spin_lock_slowpath
>                     4.02% find_inode
> 
> btrfs was tested but it is limited by internal lock contention at
> >=2 threads on this workload, so never hammers the inode cache lock
> hard enough for this change to matter to it's performance.
> 
> However, both bcachefs and ext4 demonstrate poor scaling at >=8
> threads on concurrent lookup or create workloads.
> 
> Hence convert the inode hash table to a RCU-aware hash-bl table just
> like the dentry cache. Note that we need to store a pointer to the
> hlist_bl_head the inode has been added to in the inode so that when
> it comes to unhash the inode we know what list to lock. We need to
> do this because, unlike the dentry cache, the hash value that is
> used to hash the inode is not generated from the inode itself. i.e.
> filesystems can provide this themselves so we have to either store
> the hashval or the hlist head pointer in the inode to be able to
> find the right list head for removal...
> 
> Concurrent create with variying thread count (files/s):
> 
>                 ext4                    bcachefs
> threads         vanilla  patched        vanilla patched
> 2               117k     112k            80k     85k
> 4               185k     190k           133k    145k
> 8               303k     346k           185k    255k
> 16              389k     465k           190k    420k
> 32              360k     437k           142k    481k
> 
> CPU usage for both bcachefs and ext4 at 16 and 32 threads has been
> halved on the patched kernel, while performance has increased
> marginally on ext4 and massively on bcachefs. Internal filesystem
> algorithms now limit performance on these workloads, not the global
> inode_hash_lock.
> 
> Profile of the workloads on the patched kernels:
> 
> -   35.94%     0.07%  [kernel]                  [k] ext4_create
>    - 35.87% ext4_create
>       - 20.45% __ext4_new_inode
> ...
>            3.36% insert_inode_locked
> 
>    - 78.43% do_filp_open
>       - 78.36% path_openat
>          - 53.95% bch2_create
>             - 47.99% __bch2_create
> ....
>               - 7.57% inode_insert5
>                     6.94% find_inode
> 
> Spinlock contention is largely gone from the inode hash operations
> and the filesystems are limited by contention in their internal
> algorithms.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
> 
> Other than that, the diffstat is the same and I don't see any obvious
> differences in the code comapred to what I've been running locally.

There's a bit of a backlog before I get around to looking at this but
it'd be great if we'd have a few reviewers for this change.
