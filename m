Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B063B60F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 00:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiK1Xjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 18:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiK1Xjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:39:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71A186E9;
        Mon, 28 Nov 2022 15:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD6E6126D;
        Mon, 28 Nov 2022 23:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3ACC433D6;
        Mon, 28 Nov 2022 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669678788;
        bh=0fTYGhNX3ugTtLYLVq5oHYj+A1qDs0fJ8qrs1EFEBY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMc66HiiN4a7E9Tm9cVo4XydfdgVvx9TMvV3Ae6pas0D/06HXVPGCdYSMfjv+F1j1
         W9VBwt4zwLs4XXKy8BN4Gc4pWb0/7qVUVanZLyJi0ObvwGmSC3aGtIrqEO01d2aFdj
         pXeqeOjAgYNbFKLVNQsxWle/f1nX38+P+FhYl7JVcOmP9HQ82RVFwuoS5TjkNbZfhp
         7ZAgjGnrNW1KJezoyFyTGU89XAzw17IeUFAsg1ztsd1hOVssXxNemFx5iWIEm1rlqZ
         ZpidpCxWQh6wLN5q321h2YxoIk6OFMEUBhy0y4GPZ/fTP5z0mTYq8rVvkGNTT5Weme
         Uu1ri/Cdd6JIw==
Date:   Mon, 28 Nov 2022 15:39:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/9] xfs: add debug knob to slow down writeback for fun
Message-ID: <Y4VGw38+m3+e/wpO@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3XWf5j1zVGvV4@magnolia>
 <20221128233021.GW3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128233021.GW3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:30:21AM +1100, Dave Chinner wrote:
> On Mon, Nov 28, 2022 at 02:34:05PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new error injection knob so that we can arbitrarily slow down
> > writeback to test for race conditions and aberrant reclaim behavior if
> > the writeback mechanisms are slow to issue writeback.  This will enable
> > functional testing for the ifork sequence counters introduced in commit
> > 745b3f76d1c8 ("xfs: maintain a sequence count for inode fork
> > manipulations").
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_errortag.h |    4 +++-
> >  fs/xfs/xfs_aops.c            |   12 ++++++++++--
> >  fs/xfs/xfs_error.c           |   11 +++++++++++
> >  fs/xfs/xfs_error.h           |   22 ++++++++++++++++++++++
> >  4 files changed, 46 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
> > index 580ccbd5aadc..f5f629174eca 100644
> > --- a/fs/xfs/libxfs/xfs_errortag.h
> > +++ b/fs/xfs/libxfs/xfs_errortag.h
> > @@ -61,7 +61,8 @@
> >  #define XFS_ERRTAG_LARP					39
> >  #define XFS_ERRTAG_DA_LEAF_SPLIT			40
> >  #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
> > -#define XFS_ERRTAG_MAX					42
> > +#define XFS_ERRTAG_WB_DELAY_MS				42
> > +#define XFS_ERRTAG_MAX					43
> >  
> >  /*
> >   * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
> > @@ -107,5 +108,6 @@
> >  #define XFS_RANDOM_LARP					1
> >  #define XFS_RANDOM_DA_LEAF_SPLIT			1
> >  #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
> > +#define XFS_RANDOM_WB_DELAY_MS				3000
> >  
> >  #endif /* __XFS_ERRORTAG_H_ */
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index a22d90af40c8..4a13260527b9 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -17,6 +17,8 @@
> >  #include "xfs_bmap.h"
> >  #include "xfs_bmap_util.h"
> >  #include "xfs_reflink.h"
> > +#include "xfs_errortag.h"
> > +#include "xfs_error.h"
> >  
> >  struct xfs_writepage_ctx {
> >  	struct iomap_writepage_ctx ctx;
> > @@ -217,11 +219,15 @@ xfs_imap_valid(
> >  	 * checked (and found nothing at this offset) could have added
> >  	 * overlapping blocks.
> >  	 */
> > -	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq))
> > +	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq)) {
> > +		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WB_DELAY_MS);
> >  		return false;
> > +	}
> >  	if (xfs_inode_has_cow_data(ip) &&
> > -	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
> > +	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq)) {
> > +		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WB_DELAY_MS);
> >  		return false;
> 
> These should be tracepoints, right?
> 
> Otherwise I don't see a problem with the delay code.

Yeah.  I suppose this'll be the first fstest that has to go wrangle with
setting up its own tracepoint filtering.  :)

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
