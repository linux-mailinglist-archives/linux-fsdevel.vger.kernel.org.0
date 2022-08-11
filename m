Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7A58F518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 02:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiHKAJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 20:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiHKAJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:09:50 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE58886C18;
        Wed, 10 Aug 2022 17:09:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E20DA10E85DB;
        Thu, 11 Aug 2022 10:09:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLvlh-00BcqS-GB; Thu, 11 Aug 2022 10:09:45 +1000
Date:   Thu, 11 Aug 2022 10:09:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Subject: Re: [PATCH 03/14] xfs: document the testing plan for online fsck
Message-ID: <20220811000945.GN3600936@dread.disaster.area>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
 <165989702236.2495930.5556030223682318775.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165989702236.2495930.5556030223682318775.stgit@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62f448cb
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=BTSg5ZHukb25rdNlwT0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 07, 2022 at 11:30:22AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Start the third chapter of the online fsck design documentation.  This
> covers the testing plan to make sure that both online and offline fsck
> can detect arbitrary problems and correct them without making things
> worse.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  .../filesystems/xfs-online-fsck-design.rst         |  187 ++++++++++++++++++++
>  1 file changed, 187 insertions(+)


....
> +Stress Testing
> +--------------
> +
> +A unique requirement to online fsck is the ability to operate on a filesystem
> +concurrently with regular workloads.
> +Although it is of course impossible to run ``xfs_scrub`` with *zero* observable
> +impact on the running system, the online repair code should never introduce
> +inconsistencies into the filesystem metadata, and regular workloads should
> +never notice resource starvation.
> +To verify that these conditions are being met, fstests has been enhanced in
> +the following ways:
> +
> +* For each scrub item type, create a test to exercise checking that item type
> +  while running ``fsstress``.
> +* For each scrub item type, create a test to exercise repairing that item type
> +  while running ``fsstress``.
> +* Race ``fsstress`` and ``xfs_scrub -n`` to ensure that checking the whole
> +  filesystem doesn't cause problems.
> +* Race ``fsstress`` and ``xfs_scrub`` in force-rebuild mode to ensure that
> +  force-repairing the whole filesystem doesn't cause problems.
> +* Race ``xfs_scrub`` in check and force-repair mode against ``fsstress`` while
> +  freezing and thawing the filesystem.
> +* Race ``xfs_scrub`` in check and force-repair mode against ``fsstress`` while
> +  remounting the filesystem read-only and read-write.
> +* The same, but running ``fsx`` instead of ``fsstress``.  (Not done yet?)

I had a thought when reading this that we want to ensure that online
repair handles concurrent grow/shrink operations so that doesn't
cause problems, as well as dealing with concurrent attempts to run
independent online repair processes.

Not sure that comes under stress testing, but it was the "test while
freeze/thaw" that triggered me to think of this, so that's where I'm
commenting about it. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
