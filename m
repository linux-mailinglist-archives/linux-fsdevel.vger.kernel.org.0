Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D555459CC44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 01:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiHVXep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiHVXeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:34:44 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91E68564E0;
        Mon, 22 Aug 2022 16:34:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DFAB310E8EE0;
        Tue, 23 Aug 2022 09:34:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oQGwK-00GLjR-2u; Tue, 23 Aug 2022 09:34:40 +1000
Date:   Tue, 23 Aug 2022 09:34:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        David Wysochanski <dwysocha@redhat.com>
Subject: Re: [PATCH v2] xfs: don't bump the i_version on an atime update in
 xfs_vn_update_time
Message-ID: <20220822233440.GK3600936@dread.disaster.area>
References: <20220822134011.86558-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822134011.86558-1-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=63041292
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8 a=SEtKQCMJAAAA:8
        a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=QkFuO-hpO70cwR4qdtIA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=kyTSok1ft720jgMXX5-3:22
        a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:40:11AM -0400, Jeff Layton wrote:
> xfs will update the i_version when updating only the atime value, which
> is not desirable for any of the current consumers of i_version. Doing so
> leads to unnecessary cache invalidations on NFS and extra measurement
> activity in IMA.
> 
> Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> transaction should not update the i_version. Set that value in
> xfs_vn_update_time if we're only updating the atime.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: David Wysochanski <dwysocha@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

NACK.

We need to define exactly what iversion covers first before we go
changing how filesystems update it. We only want to change iversion
behaviour once, and we want it done right the first time.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
