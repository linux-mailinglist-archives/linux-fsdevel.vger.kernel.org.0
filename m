Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE74CCBFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 03:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiCDCti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 21:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiCDCth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:49:37 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2936617E368;
        Thu,  3 Mar 2022 18:48:47 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 22A845303F6;
        Fri,  4 Mar 2022 13:48:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nPxzn-001G5M-KT; Fri, 04 Mar 2022 13:48:43 +1100
Date:   Fri, 4 Mar 2022 13:48:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: do not try to evict inode when super is frozen
Message-ID: <20220304024843.GK3927073@dread.disaster.area>
References: <20220304022104.2525009-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304022104.2525009-1-jaegeuk@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62217e0e
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=FCBBoiUPZGnDA3Uh:21 a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=f26EzWiRBdu2aCluGM4A:9 a=CjuIK1q_8ugA:10 a=ZXjPKerQ9QDAtgzuyCT9:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 06:21:04PM -0800, Jaegeuk Kim wrote:
> Otherwise, we will get a deadlock.

NACK.

We have to be able to evict clean inodes from memory on frozen
inodes because we can still instantiate inodes while the filesytem
is frozen. e.g. there's a find running when the filesystem is
frozen. What happens if we can't evict clean cached inodes from
memory when we run out of memory trying to instantiate new inodes?

> 
> [freeze test]                         shrinkder
> freeze_super
>  - pwercpu_down_write(SB_FREEZE_FS)
>                                        - super_cache_scan
>                                          - down_read(&sb->s_umount)
>                                            - prune_icache_sb
>                                             - dispose_list
>                                              - evict
>                                               - f2fs_evict_inode
> thaw_super
>  - down_write(&sb->s_umount);
>                                               - __percpu_down_read(SB_FREEZE_FS)

That seems like a f2fs bug, not a generic problem.

Filesystems already have to handle stuff like this if an unlinked
file is closed while the fs is frozen - we have to handle inode
eviction needing to modify the file, and different filesystems
handle this differently. Most filesystems simply block in
->evict_inode in this case, but this never occurs from the shrinker
context.

IOWs, the shrinker should never be evicting inodes that require the
filesystem to immediately block on frozen filesystems. If you have
such inodes in cache at the time the filesystem is frozen, then they
should be purged from the cache as part of the freeze process so the
shrinker won't ever find inodes that it could deadlock on.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
