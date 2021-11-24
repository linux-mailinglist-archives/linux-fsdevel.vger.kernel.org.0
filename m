Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496045D09C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbhKXW6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 17:58:42 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:42553 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242823AbhKXW6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:58:41 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 9C8C8A6B49;
        Thu, 25 Nov 2021 09:55:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mq1Ak-00CqMK-G6; Thu, 25 Nov 2021 09:55:26 +1100
Date:   Thu, 25 Nov 2021 09:55:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/4] extend vmalloc support for constrained allocations
Message-ID: <20211124225526.GM418105@dread.disaster.area>
References: <20211122153233.9924-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122153233.9924-1-mhocko@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=619ec2e1
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=DsItmR9x4NrZRhuf3zYA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:32:29PM +0100, Michal Hocko wrote:
> Hi,
> The previous version has been posted here [1] 
> 
> I hope I have addressed all the feedback. There were some suggestions
> for further improvements but I would rather make this smaller as I
> cannot really invest more time and I believe further changes can be done
> on top.
> 
> This version is a rebase on top of the current Linus tree. Except for
> the review feedback and conflicting changes in the area there is only
> one change to filter out __GFP_NOFAIL from the bulk allocator. This is
> not necessary strictly speaking AFAICS but I found it less confusing
> because vmalloc has its fallback strategy and the bulk allocator is
> meant only for the fast path.
> 
> Original cover:
> Based on a recent discussion with Dave and Neil [2] I have tried to
> implement NOFS, NOIO, NOFAIL support for the vmalloc to make
> life of kvmalloc users easier.
> 
> A requirement for NOFAIL support for kvmalloc was new to me but this
> seems to be really needed by the xfs code.
> 
> NOFS/NOIO was a known and a long term problem which was hoped to be
> handled by the scope API. Those scope should have been used at the
> reclaim recursion boundaries both to document them and also to remove
> the necessity of NOFS/NOIO constrains for all allocations within that
> scope. Instead workarounds were developed to wrap a single allocation
> instead (like ceph_kvmalloc).
> 
> First patch implements NOFS/NOIO support for vmalloc. The second one
> adds NOFAIL support and the third one bundles all together into kvmalloc
> and drops ceph_kvmalloc which can use kvmalloc directly now.
> 
> I hope I haven't missed anything in the vmalloc allocator.

Correct __GFP_NOLOCKDEP support is also needed. See:

https://lore.kernel.org/linux-mm/20211119225435.GZ449541@dread.disaster.area/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
