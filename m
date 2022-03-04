Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490D74CCCDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 06:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiCDFPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 00:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiCDFPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:15:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C42E793A2;
        Thu,  3 Mar 2022 21:14:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B0661B51;
        Fri,  4 Mar 2022 05:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8F4C340E9;
        Fri,  4 Mar 2022 05:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646370892;
        bh=ODU2AzuMqeCYdLnYB8MUUu6xqoN8AmqM383XcKtwS3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKidgxBuYTJtU+NFI88zD5utn/8x4AjSa/T8H+Ywpy1UrrQWRG2S8dF5lVHi3Pso0
         P1N/tPC+cp9YUqrQO7NBC0Us5Px+bO5i+bNPooAa72r0QarAI7Im0AHRvzfqNQeoGZ
         45qMP/AcW9XsiEfBr6EFyE+UuSs05yQP+Tn233f124AfXsrno3tJ7oC/UTfopKtVUU
         9+70THeWVaMQxSkff2/XA4JPxmLsBZfPlb9rA9yENE+e6hf36xQiKgsVT4YA6Wwqde
         OIJA1vjhSn+8mYiNZ6aHLpC5geRTI8dj4cD1VgCnIKE+RuCi5ts4rX6mOKodONkVp/
         MA7Dx1fqTWsCw==
Date:   Thu, 3 Mar 2022 21:14:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: do not try to evict inode when super is frozen
Message-ID: <YiGgSmEOZUvgmSto@google.com>
References: <20220304022104.2525009-1-jaegeuk@kernel.org>
 <20220304024843.GK3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304024843.GK3927073@dread.disaster.area>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/04, Dave Chinner wrote:
> On Thu, Mar 03, 2022 at 06:21:04PM -0800, Jaegeuk Kim wrote:
> > Otherwise, we will get a deadlock.
> 
> NACK.
> 
> We have to be able to evict clean inodes from memory on frozen
> inodes because we can still instantiate inodes while the filesytem
> is frozen. e.g. there's a find running when the filesystem is
> frozen. What happens if we can't evict clean cached inodes from
> memory when we run out of memory trying to instantiate new inodes?

Ok, that makes sense.

> 
> > 
> > [freeze test]                         shrinkder
> > freeze_super
> >  - pwercpu_down_write(SB_FREEZE_FS)
> >                                        - super_cache_scan
> >                                          - down_read(&sb->s_umount)
> >                                            - prune_icache_sb
> >                                             - dispose_list
> >                                              - evict
> >                                               - f2fs_evict_inode
> > thaw_super
> >  - down_write(&sb->s_umount);
> >                                               - __percpu_down_read(SB_FREEZE_FS)
> 
> That seems like a f2fs bug, not a generic problem.
> 
> Filesystems already have to handle stuff like this if an unlinked
> file is closed while the fs is frozen - we have to handle inode
> eviction needing to modify the file, and different filesystems
> handle this differently. Most filesystems simply block in
> ->evict_inode in this case, but this never occurs from the shrinker
> context.
> 
> IOWs, the shrinker should never be evicting inodes that require the
> filesystem to immediately block on frozen filesystems. If you have
> such inodes in cache at the time the filesystem is frozen, then they
> should be purged from the cache as part of the freeze process so the
> shrinker won't ever find inodes that it could deadlock on.

If so, is this a bug in drop_caches_sysctl_handler? Or, I shouldn't have
used "echo 3 > sysfs/drop_caches" with freezefs in xfstests?

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
