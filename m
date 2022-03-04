Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA13D4CE029
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiCDWTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 17:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDWTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:19:16 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B9C31BEB7;
        Fri,  4 Mar 2022 14:18:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6B2FC10E1C43;
        Sat,  5 Mar 2022 09:18:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nQGFl-001Zzq-Nx; Sat, 05 Mar 2022 09:18:25 +1100
Date:   Sat, 5 Mar 2022 09:18:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: do not try to evict inode when super is frozen
Message-ID: <20220304221825.GM3927073@dread.disaster.area>
References: <20220304022104.2525009-1-jaegeuk@kernel.org>
 <20220304024843.GK3927073@dread.disaster.area>
 <YiGgSmEOZUvgmSto@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiGgSmEOZUvgmSto@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62229032
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=FCBBoiUPZGnDA3Uh:21 a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=kobbvlOx0iqVO4J9MBYA:9 a=CjuIK1q_8ugA:10 a=ZXjPKerQ9QDAtgzuyCT9:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:14:50PM -0800, Jaegeuk Kim wrote:
> On 03/04, Dave Chinner wrote:
> > On Thu, Mar 03, 2022 at 06:21:04PM -0800, Jaegeuk Kim wrote:
> > > Otherwise, we will get a deadlock.
> > 
> > NACK.
> > 
> > We have to be able to evict clean inodes from memory on frozen
> > inodes because we can still instantiate inodes while the filesytem
> > is frozen. e.g. there's a find running when the filesystem is
> > frozen. What happens if we can't evict clean cached inodes from
> > memory when we run out of memory trying to instantiate new inodes?
> 
> Ok, that makes sense.
> 
> > 
> > > 
> > > [freeze test]                         shrinkder
> > > freeze_super
> > >  - pwercpu_down_write(SB_FREEZE_FS)
> > >                                        - super_cache_scan
> > >                                          - down_read(&sb->s_umount)
> > >                                            - prune_icache_sb
> > >                                             - dispose_list
> > >                                              - evict
> > >                                               - f2fs_evict_inode
> > > thaw_super
> > >  - down_write(&sb->s_umount);
> > >                                               - __percpu_down_read(SB_FREEZE_FS)
> > 
> > That seems like a f2fs bug, not a generic problem.
> > 
> > Filesystems already have to handle stuff like this if an unlinked
> > file is closed while the fs is frozen - we have to handle inode
> > eviction needing to modify the file, and different filesystems
> > handle this differently. Most filesystems simply block in
> > ->evict_inode in this case, but this never occurs from the shrinker
> > context.
> > 
> > IOWs, the shrinker should never be evicting inodes that require the
> > filesystem to immediately block on frozen filesystems. If you have
> > such inodes in cache at the time the filesystem is frozen, then they
> > should be purged from the cache as part of the freeze process so the
> > shrinker won't ever find inodes that it could deadlock on.
> 
> If so, is this a bug in drop_caches_sysctl_handler?

IMO, no.

> Or, I shouldn't have
> used "echo 3 > sysfs/drop_caches" with freezefs in xfstests?

That should just work.

As I said above - if the filesystem cannot process eviction of
certain types of inodes when the filesystem is frozen, it needs to
take steps during the freeze process to ensure they can't be evicted
when the fs is frozen....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
