Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567F59662F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiHPX5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHPX5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:57:11 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B261E857FF;
        Tue, 16 Aug 2022 16:57:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BC9F162D4F2;
        Wed, 17 Aug 2022 09:57:09 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oO6Qm-00DzMD-14; Wed, 17 Aug 2022 09:57:08 +1000
Date:   Wed, 17 Aug 2022 09:57:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220816235708.GY3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
 <20220816224257.GV3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816224257.GV3600936@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62fc2ed6
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=rUX31UJu9yjMAGyTwVAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:42:57AM +1000, Dave Chinner wrote:
> On Tue, Aug 16, 2022 at 11:58:06AM -0400, Jeff Layton wrote:
> > On Tue, 2022-08-16 at 08:43 -0700, Darrick J. Wong wrote:
> > > On Tue, Aug 16, 2022 at 09:17:36AM -0400, Jeff Layton wrote:
> > > > @@ -116,20 +118,7 @@ xfs_trans_log_inode(
> > > >  		spin_unlock(&inode->i_lock);
> > > >  	}
> > > >  
> > > > -	/*
> > > > -	 * First time we log the inode in a transaction, bump the inode change
> > > > -	 * counter if it is configured for this to occur. While we have the
> > > > -	 * inode locked exclusively for metadata modification, we can usually
> > > > -	 * avoid setting XFS_ILOG_CORE if no one has queried the value since
> > > > -	 * the last time it was incremented. If we have XFS_ILOG_CORE already
> > > > -	 * set however, then go ahead and bump the i_version counter
> > > > -	 * unconditionally.
> > > > -	 */
> > > > -	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> > > > -		if (IS_I_VERSION(inode) &&
> > > > -		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> > > > -			iversion_flags = XFS_ILOG_CORE;
> > > > -	}
> > > > +	set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);
> 
> .... and this removes the sweep that captures in-memory timestamp
> and i_version peeks between any persistent inode metadata
> modifications that have been made, regardless of whether i_version
> has already been bumped for them or not.

Which, BTW, breaks the iversion update for xfs_fs_commit_blocks()
which the pNFS server calls to inform the filesystem that the pNFS
client has finished writing data to a mapped region.

This function runs unwritten extent conversion (making the data
externally visible) and takes timestamps from the pNFS server. It
then persists all these changes, meaning that there will be
externally visible data, metadata and timestamp updates persisted to
disk by the pNFS server without an iversion update occurring.

This iversion stuff is .... complex. It's also really easy to get
wrong, and that's even before we start trying to optimise away stuff
like timestamp updates....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
