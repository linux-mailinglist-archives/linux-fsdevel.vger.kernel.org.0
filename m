Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8808F1A6908
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgDMPmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 11:42:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50214 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgDMPmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:42:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFfQA2159209;
        Mon, 13 Apr 2020 15:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=M+fw6loVbLw+pCfTuALSNfRjDhUb4+yvgsGLlCVk5Fs=;
 b=zDJ+M4Tw9m/l22rkzmZsDkRUxK87Wux34oSU0QkE6E1xZzS3Z5KlscvzW/MzAYuuywDT
 QA2KdS3PSns31YJpkMTOPDLvwwiD4GLw2yBu14VvLX17delmSsaEHe4CO5rBhXrRAGa4
 4BktgErvib3Xq13XidEfUsYf17LQiBsh6AZ8sQqATVfdJrWre8tIwSv0rcknWC+3a2jU
 DiCNktnL17F/2X9n3olA/T+mgF6JkrbDmybQ/Zb9VQGkBeR2ejjXBh01kAuSY5Lpmfh7
 QhGVWm+b5HGq00USdAVEhdhyelvoUQYGfQBRG3yhmbzRw0xTvAJ/zJJq0Si7MTkEL27O jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30b5aqy8mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 15:41:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFb4A0072355;
        Mon, 13 Apr 2020 15:41:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30bqkxjkx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 15:41:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03DFfirl012491;
        Mon, 13 Apr 2020 15:41:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 08:41:43 -0700
Date:   Mon, 13 Apr 2020 08:41:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 1/9] fs/xfs: Remove unnecessary initialization of
 i_rwsem
Message-ID: <20200413154142.GS6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-2-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:38PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> An earlier call of xfs_reinit_inode() from xfs_iget_cache_hit() already
> handles initialization of i_rwsem.
> 
> Doing so again is unneeded.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Seems reasonable to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Changes from V4:
> 	Update commit message to make it clear the xfs_iget_cache_hit()
> 	is actually doing the initialization via xfs_reinit_inode()
> 
> New for V4:
> 
> NOTE: This was found while ensuring the new i_aops_sem was properly
> handled.  It seems like this is a layering violation so I think it is
> worth cleaning up so as to not confuse others.
> ---
>  fs/xfs/xfs_icache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 8dc2e5414276..836a1f09be03 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -419,6 +419,7 @@ xfs_iget_cache_hit(
>  		spin_unlock(&ip->i_flags_lock);
>  		rcu_read_unlock();
>  
> +		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
>  		error = xfs_reinit_inode(mp, inode);
>  		if (error) {
>  			bool wake;
> @@ -452,9 +453,6 @@ xfs_iget_cache_hit(
>  		ip->i_sick = 0;
>  		ip->i_checked = 0;
>  
> -		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> -		init_rwsem(&inode->i_rwsem);
> -
>  		spin_unlock(&ip->i_flags_lock);
>  		spin_unlock(&pag->pag_ici_lock);
>  	} else {
> -- 
> 2.25.1
> 
