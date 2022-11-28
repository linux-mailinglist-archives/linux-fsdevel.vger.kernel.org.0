Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5785263B5DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 00:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiK1Xa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 18:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiK1Xa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:30:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D832065
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 15:30:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 130so12024881pfu.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 15:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IOdLakO8ABzwedxcWnJjqY7QmYuZp1ksWCsEyktvNU=;
        b=PtcaLdolfbI94PbhXibpQKT3kTDVpj5StkWff66CamClwVtgwuHdz2As4Z3QRSN282
         011VXWnFgZ/EZmSIom53Xv59tPEhC1Xwe/PFiI27cVgCQTM9T9R8mVa4vKFiJiR232Wf
         ddA8MYl4JeXZ/P+OiGT8D0Z+HbriyigoQZJIDH026ZStcEnWkmxSpfdXzVjRUb0ZoCEH
         rR01rIxT/4eNk2U4lshXGtXmlIatyPrKM0ZbYoVeAGhNz1bzqDHddu8ewFuRIkswkXIh
         5dNWDCxEdufAUoDMzYGocUV7DEf4M0pY0lWRnW55Pg2b3bLm/GVJSkq9nckhYCTPPgdf
         WqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IOdLakO8ABzwedxcWnJjqY7QmYuZp1ksWCsEyktvNU=;
        b=uzB9YbO7k2dA+OpAUv7Ei63GOJTSZiw3N4VX1oAarCxkM19+pU7geEEDDLZ2ry4K0Y
         sAptm6fp1lg8R9O3IxZQBCENW/vD+egnlC9Kbc4H0smQlFS0SKDAnQXh8V3Bcg54+lHI
         fYMpQBVWqeE/pwnN6w/S4ukciVEsKkJX1q1C3v9xm6ycsEkJ/MJPlzO+Aw7QQpsJqOMT
         f0YDtzZ3MwSEUF0fhda81Of0kAJ0HeejlSMSHJzY+PhkjO14czhn6aLSaQklg+/RwkUQ
         2Sxg9JH/XIZP5+rxTy+m9PTOWCXuTvTuOMQR9vYvWgQMk/CfDrSFcdoprlntq1SM0WYi
         oY3w==
X-Gm-Message-State: ANoB5pkKTP84hVv62v9JEjfFYMqlexcNSI17jNK1kkNyPYd0UMGP1uwE
        5khPE8vBVyujGT684GLhZ3ADsGi2hkCfhQ==
X-Google-Smtp-Source: AA0mqf4JmVyGWh8FDppfBxU7twvNjlK/KE39hRc6cK8T+LFASUKJBCiMhv/OXmjKY1hNNnnVB7Nmnw==
X-Received: by 2002:a62:e908:0:b0:574:53f4:c4d6 with SMTP id j8-20020a62e908000000b0057453f4c4d6mr28979951pfh.81.1669678224991;
        Mon, 28 Nov 2022 15:30:24 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id o25-20020aa79799000000b0056c3a0dc65fsm8501769pfp.71.2022.11.28.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:30:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oznZt-002DMH-G8; Tue, 29 Nov 2022 10:30:21 +1100
Date:   Tue, 29 Nov 2022 10:30:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/9] xfs: add debug knob to slow down writeback for fun
Message-ID: <20221128233021.GW3600936@dread.disaster.area>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3XWf5j1zVGvV4@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4U3XWf5j1zVGvV4@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:34:05PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new error injection knob so that we can arbitrarily slow down
> writeback to test for race conditions and aberrant reclaim behavior if
> the writeback mechanisms are slow to issue writeback.  This will enable
> functional testing for the ifork sequence counters introduced in commit
> 745b3f76d1c8 ("xfs: maintain a sequence count for inode fork
> manipulations").
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_errortag.h |    4 +++-
>  fs/xfs/xfs_aops.c            |   12 ++++++++++--
>  fs/xfs/xfs_error.c           |   11 +++++++++++
>  fs/xfs/xfs_error.h           |   22 ++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
> index 580ccbd5aadc..f5f629174eca 100644
> --- a/fs/xfs/libxfs/xfs_errortag.h
> +++ b/fs/xfs/libxfs/xfs_errortag.h
> @@ -61,7 +61,8 @@
>  #define XFS_ERRTAG_LARP					39
>  #define XFS_ERRTAG_DA_LEAF_SPLIT			40
>  #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
> -#define XFS_ERRTAG_MAX					42
> +#define XFS_ERRTAG_WB_DELAY_MS				42
> +#define XFS_ERRTAG_MAX					43
>  
>  /*
>   * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
> @@ -107,5 +108,6 @@
>  #define XFS_RANDOM_LARP					1
>  #define XFS_RANDOM_DA_LEAF_SPLIT			1
>  #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
> +#define XFS_RANDOM_WB_DELAY_MS				3000
>  
>  #endif /* __XFS_ERRORTAG_H_ */
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index a22d90af40c8..4a13260527b9 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -17,6 +17,8 @@
>  #include "xfs_bmap.h"
>  #include "xfs_bmap_util.h"
>  #include "xfs_reflink.h"
> +#include "xfs_errortag.h"
> +#include "xfs_error.h"
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -217,11 +219,15 @@ xfs_imap_valid(
>  	 * checked (and found nothing at this offset) could have added
>  	 * overlapping blocks.
>  	 */
> -	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq))
> +	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq)) {
> +		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WB_DELAY_MS);
>  		return false;
> +	}
>  	if (xfs_inode_has_cow_data(ip) &&
> -	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
> +	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq)) {
> +		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WB_DELAY_MS);
>  		return false;

These should be tracepoints, right?

Otherwise I don't see a problem with the delay code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
