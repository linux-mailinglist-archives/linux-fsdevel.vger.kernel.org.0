Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306A818BAD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCSPSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:18:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:18:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JFDuj6140199;
        Thu, 19 Mar 2020 15:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Hiy+utP9d1bGIA/9uHuNYMtZDU067rvuRxj3mpxtgA4=;
 b=KGM6txfF3YYJNZgdts0t7DrZAi5CMnKJmAoCxzzpTJYKWNa0NQ5jp8OHyF8plvBYPSY9
 +WX6CItM8u8vEoJIN9ZCJRh5Q1ruPKKMSm/CUkLvAriH8u/IKJQDOWyiTks6zUDzg6mm
 ptJHeWzoYEXZuri8jtcnrCep7YI9qYg0M9QMbhdqHS7Je3e+drTHkhZCl4CBe3wztUU+
 qaVNb+bbTj5AVmfvlxMqlg8PlZL3knYdQ1o7nVcWaUHbbKX52CrT66cQVtdJYNHx6r4n
 MCCqVf62j9xGU9IezWfhRWoXVAwsRYHuwKsC6WI1N4ZM+94GMbxhV8cCouzqwHBeyQk/ BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yub278sgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:18:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JFCc10047152;
        Thu, 19 Mar 2020 15:18:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ys8rmchj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:18:21 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JFIKXs022971;
        Thu, 19 Mar 2020 15:18:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 08:18:20 -0700
Date:   Thu, 19 Mar 2020 08:18:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit BIOs at the end of each extent
Message-ID: <20200319151819.GA1581085@magnolia>
References: <20200319150720.24622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319150720.24622-1-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190068
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:07:20AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By definition, an extent covers a range of consecutive blocks, so
> it would be quite rare to be able to just add pages to the BIO from
> a previous range.  The only case we can think of is a mapped extent
> followed by a hole extent, followed by another mapped extent which has
> been allocated immediately after the first extent.  We believe this to

Well... userspace can induce that with fallocate(INSERT_RANGE). :)

> be an unlikely layout for a filesystem to choose and, since the queue
> is plugged, those two BIOs would be merged by the block layer.
> 
> The reason we care is that ext2/ext4 choose to lay out blocks 0-11
> consecutively, followed by the indirect block, and we want to merge those
> two BIOs.  If we don't submit the data BIO before asking the filesystem
> for the next extent, then the indirect BIO will be submitted first,
> and waited for, leading to inefficient I/O patterns.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 83438b3257de..8d26920ddf00 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -388,6 +388,11 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
>  				ctx, iomap, srcmap);
>  	}
>  
> +	if (ctx->bio) {
> +		submit_bio(ctx->bio);
> +		ctx->bio = NULL;
> +	}

Makes sense, but could we have a quick comment here to capture why we're
submitting the bio here?

/*
 * Submit the bio now so that we neither combine IO requests for
 * non-adjacent ranges nor interleave data and metadata requests.
 */

--D

> +
>  	return done;
>  }
>  
> -- 
> 2.25.1
> 
