Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FCA4C1DC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 22:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiBWVb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 16:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiBWVb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:31:58 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEA554EF74;
        Wed, 23 Feb 2022 13:31:29 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2889E10E245E;
        Thu, 24 Feb 2022 08:31:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMzEN-00Fc9U-Tf; Thu, 24 Feb 2022 08:31:27 +1100
Date:   Thu, 24 Feb 2022 08:31:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Edward Shishkin <edward.shishkin@gmail.com>
Subject: Re: [PATCH] reiserfs: Deprecate reiserfs
Message-ID: <20220223213127.GI3061737@dread.disaster.area>
References: <20220223142653.22388-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223142653.22388-1-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6216a7b1
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=QrCbJ4dQJB4WbGYf2mcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 03:26:53PM +0100, Jan Kara wrote:
> Reiserfs is relatively old filesystem and its development has ceased
> quite some years ago. Linux distributions moved away from it towards
> other filesystems such as btrfs, xfs, or ext4. To reduce maintenance
> burden on cross filesystem changes (such as new mount API, iomap, folios
> ...) let's add a deprecation notice when the filesystem is mounted and
> schedule its removal to 2024.

Two years might be considered "short notice" for a filesystem, but I
guess that people running it because it is stable will most likely
also linger on stable kernels where it will live "maintained" for
many years after it has been removed from the upstream code base.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/reiserfs/Kconfig | 10 +++++++---
>  fs/reiserfs/super.c |  2 ++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> Here's my suggestion for deprecating reiserfs. If nobody has reasons against
> this, I'll send the patch to Linus during the next merge window.

Is there a deprecation/removal schedule somewhere that documents
stuff like this? We documented in the XFS section of the kernel
admin guide (where we also document mount option and
sysctl deprecation and removal schedules), but I don't think
anything like that exists for reiserfs or for filesystems in
general.

Other than that, the patch looks good.

Cheers,

Dave.

> 
> diff --git a/fs/reiserfs/Kconfig b/fs/reiserfs/Kconfig
> index 8fd54ed8f844..eafee53ddabc 100644
> --- a/fs/reiserfs/Kconfig
> +++ b/fs/reiserfs/Kconfig
> @@ -1,10 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config REISERFS_FS
> -	tristate "Reiserfs support"
> +	tristate "Reiserfs support (deprecated)"
>  	select CRC32
>  	help
> -	  Stores not just filenames but the files themselves in a balanced
> -	  tree.  Uses journalling.
> +	  Reiserfs is deprecated and scheduled to be removed from the kernel
> +	  in 2024. If you are still using it, please migrate to another
> +	  filesystem or tell us your usecase for reiserfs.
> +
> +	  Reiserfs stores not just filenames but the files themselves in a
> +	  balanced tree.  Uses journalling.
>  
>  	  Balanced trees are more efficient than traditional file system
>  	  architectural foundations.
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 82e09901462e..74c1cda3bc3e 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1652,6 +1652,8 @@ static int read_super_block(struct super_block *s, int offset)
>  		return 1;
>  	}
>  
> +	reiserfs_warning(NULL, "", "reiserfs filesystem is deprecated and "
> +		"scheduled to be removed from the kernel in 2024");
>  	SB_BUFFER_WITH_SB(s) = bh;
>  	SB_DISK_SUPER_BLOCK(s) = rs;
>  
> -- 
> 2.31.1
> 
> 

-- 
Dave Chinner
david@fromorbit.com
