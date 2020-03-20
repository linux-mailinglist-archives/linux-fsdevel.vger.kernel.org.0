Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6518D35A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 16:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCTPwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 11:52:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36726 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCTPwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:52:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KFfR2Z059120;
        Fri, 20 Mar 2020 15:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9Nmn0D0otCSC8FyIPmpHy5LNVxBSd2s/E1au52CwaRs=;
 b=OY2GfF07gzpE3SmmdiyNNPwtM1T+kjxgD8ng5/en3wXHofSJhXJlc/8QUuHBdbS/0eAh
 wcq41kdth5S40QwKHIEKTYA4meCEzVM8J2G8VlVH7T+TrMQ6SppEwlc+wOpg3qe2kP3G
 LWAGQZ7s6GuuXpPrQ3YlgTXVcD8qT7EoZCJwA9YpH139q5Xsq4l0rCfvZcTvykXNh8Rc
 XIf+PhIRQyQBX5JsgPq6ij5vedE0BaoTtGxlyuyukxsi68vOCHeQOIB1VCqUbDirugEl
 duodgQi4qNMKcgRW6eexaRugSWoAwFOIWyyp3uhfITiOXtxhKLF6wZ1QGedY73dbSzwb lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yrpprpg9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 15:52:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KFnt54183006;
        Fri, 20 Mar 2020 15:50:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ys92quwge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 15:50:24 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02KFoNOm024863;
        Fri, 20 Mar 2020 15:50:23 GMT
Received: from localhost (/10.159.129.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 08:50:22 -0700
Date:   Fri, 20 Mar 2020 08:50:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit the BIO at the end of each extent
Message-ID: <20200320155020.GB6812@magnolia>
References: <20200320144014.3276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320144014.3276-1-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200064
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:40:14AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By definition, an extent covers a range of consecutive blocks, so
> it would be quite rare to be able to just add pages to the BIO from
> a previous range.  The only case we can think of is a mapped extent
> followed by a hole extent, followed by another mapped extent which has
> been allocated immediately after the first extent.  We believe this to
> be an unlikely layout for a filesystem to choose and, since the queue
> is plugged, those two BIOs would be merged by the block layer.
> 
> The reason we care is that ext2/ext4 choose to lay out blocks 0-11
> consecutively, followed by the indirect block, and we want to merge those
> two BIOs.  If we don't submit the data BIO before asking the filesystem
> for the next extent, then the indirect BIO will be submitted first,
> and waited for, leading to inefficient I/O patterns.  Buffer heads solve
> this with the BH_boundary flag, but iomap doesn't need that as long as
> we submit the bio here.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f080f542911b..417115bfaf6b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,16 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  				ctx, iomap, srcmap);
>  	}
>  
> +	/*
> +	 * Submitting the bio here leads to better I/O patterns for
> +	 * filesystems which need to do metadata reads to find the
> +	 * next extent.
> +	 */
> +	if (ctx->bio) {
> +		submit_bio(ctx->bio);
> +		ctx->bio = NULL;
> +	}
> +
>  	return done;
>  }
>  
> @@ -449,8 +459,6 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	}
>  	ret = 0;
>  done:
> -	if (ctx.bio)
> -		submit_bio(ctx.bio);
>  	if (ctx.cur_page) {
>  		if (!ctx.cur_page_in_bio)
>  			unlock_page(ctx.cur_page);
> -- 
> 2.25.1
> 
