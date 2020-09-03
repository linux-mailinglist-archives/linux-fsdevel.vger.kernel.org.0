Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1025CCF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 23:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgICV6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 17:58:39 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39033 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729088AbgICV6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:58:37 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EE70D823972;
        Fri,  4 Sep 2020 07:58:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kDxFY-0005SA-Sa; Fri, 04 Sep 2020 07:58:32 +1000
Date:   Fri, 4 Sep 2020 07:58:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     viro@zeniv.linux.org.uk, ira.weiny@intel.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
Message-ID: <20200903215832.GF12131@dread.disaster.area>
References: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=VwQbUJbxAAAA:8 a=omOdbC7AAAAA:8
        a=7-415B0cAAAA:8 a=Tsq6mdsxXYZ7ypGp8CAA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=baC4JDFNLZpnPwus_NF9:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:13:13PM +0800, Hao Li wrote:
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
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> ---
>  fs/inode.c         | 3 ++-
>  include/linux/fs.h | 3 +--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c347afb7..4e45d5ea3d0f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1625,7 +1625,8 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = generic_drop_inode(inode);
>  
> -	if (!drop && (sb->s_flags & SB_ACTIVE)) {
> +	if (!drop && !(inode->i_state & I_DONTCACHE) &&
> +			(sb->s_flags & SB_ACTIVE)) {

FWIW, the format used in fs/inode.c is to align the logic
statements, not tab indent the additional lines in the statement.
i.e.

	if (!drop &&
	    !(inode->i_state & I_DONTCACHE) &&
	    (sb->s_flags & SB_ACTIVE)) {

Which gives a clear indication that there are all at the same
precedence and separate logic statements...

Otherwise the change looks good.

Probably best to resend with the fixes tag :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
