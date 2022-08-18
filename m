Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14883597B21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 03:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiHRBfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 21:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiHRBfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:35:51 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A4B6A0262;
        Wed, 17 Aug 2022 18:35:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6B06862D952;
        Thu, 18 Aug 2022 11:35:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOURo-00EPXL-MQ; Thu, 18 Aug 2022 11:35:48 +1000
Date:   Thu, 18 Aug 2022 11:35:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] xfs: don't bump the i_version on an atime update in
 xfs_vn_update_time
Message-ID: <20220818013548.GD3600936@dread.disaster.area>
References: <20220817130002.93592-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817130002.93592-1-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62fd9776
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=NkgNjqECM6Bzkx66WxwA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:00:02AM -0400, Jeff Layton wrote:
> xfs will update the i_version when updating only the atime value, which
> is not desirable for any of the current consumers of i_version. Doing so
> leads to unnecessary cache invalidations on NFS and extra measurement
> activity in IMA.
> 
> Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> transaction should not update the i_version. Set that value in
> xfs_vn_update_time if we're only updating the atime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
>  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
>  fs/xfs/xfs_iops.c               | 10 +++++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> Dave,
> 
> How about this for an alternate approach? This just explicitly ensures
> that we don't bump the i_version on an atime-only update, and seems to
> fix the testcase I have.

This just duplicates lazytime functionality, only now users
can't opt-in or out.

atime update filtering is a VFS function so behaviour is common
across all filesystems. Deficiencies in VFS filtering behaviour
should not be hacked around by individual filesystems, the VFS
filtering should be fixed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
