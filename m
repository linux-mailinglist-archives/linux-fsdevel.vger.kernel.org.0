Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5A58B24A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbiHEWCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiHEWCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:02:06 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89869C56;
        Fri,  5 Aug 2022 15:01:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F185C10C8D49;
        Sat,  6 Aug 2022 08:01:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oK5Nw-009cbF-Vo; Sat, 06 Aug 2022 08:01:37 +1000
Date:   Sat, 6 Aug 2022 08:01:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        lczerner@redhat.com, bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
Message-ID: <20220805220136.GG3600936@dread.disaster.area>
References: <20220805183543.274352-1-jlayton@kernel.org>
 <20220805183543.274352-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805183543.274352-2-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62ed9344
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=eNa5g1wEO3mvbst8HCwA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:35:40PM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Claim one of the spare fields in struct statx to hold a 64-bit change
> attribute. When statx requests this attribute, do an
> inode_query_iversion and fill the result in the field.
> 
> Also update the test-statx.c program to fetch the change attribute as
> well.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/stat.c                 | 7 +++++++
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 3 ++-
>  samples/vfs/test-statx.c  | 4 +++-
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 9ced8860e0f3..976e0a59ab23 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -17,6 +17,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/pagemap.h>
>  #include <linux/compat.h>
> +#include <linux/iversion.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
>  				  STATX_ATTR_DAX);
>  
> +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> +		stat->result_mask |= STATX_CHGATTR;
> +		stat->chgattr = inode_query_iversion(inode);
> +	}

If you're going to add generic support for it, shouldn't there be a
generic test in fstests that ensures that filesystems that advertise
STATX_CHGATTR support actually behave correctly? Including across
mounts, and most importantly, that it is made properly stable by
fsync?

i.e. what good is this if different filesystems have random quirks
that mean it can't be relied on by userspace to tell it changes have
occurred?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
