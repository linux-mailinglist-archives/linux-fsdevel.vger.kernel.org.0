Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518EF25F0CA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIFVkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 17:40:10 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33116 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgIFVkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 17:40:09 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DC6FE824631;
        Mon,  7 Sep 2020 07:40:03 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kF2OI-0006n6-R9; Mon, 07 Sep 2020 07:40:02 +1000
Date:   Mon, 7 Sep 2020 07:40:02 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH v2] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
Message-ID: <20200906214002.GI12131@dread.disaster.area>
References: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=VwQbUJbxAAAA:8 a=omOdbC7AAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=CYq8bQpZl3HkxBxCX-sA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=baC4JDFNLZpnPwus_NF9:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:59:39PM +0800, Hao Li wrote:
> If generic_drop_inode() returns true, it means iput_final() can evict
> this inode regardless of whether it is dirty or not. If we check
> I_DONTCACHE in generic_drop_inode(), any inode with this bit set will be
> evicted unconditionally. This is not the desired behavior because
> I_DONTCACHE only means the inode shouldn't be cached on the LRU list.
> As for whether we need to evict this inode, this is what
> generic_drop_inode() should do. This patch corrects the usage of
> I_DONTCACHE.
> 
> This patch was proposed in [1].
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/
> 
> Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> ---
> Changes in v2:
>  - Adjust code format
>  - Add Fixes tag in commit message
> 
>  fs/inode.c         | 4 +++-
>  include/linux/fs.h | 3 +--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
