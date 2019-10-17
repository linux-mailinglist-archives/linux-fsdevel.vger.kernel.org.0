Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FCDB67B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437936AbfJQSlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 14:41:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406702AbfJQSlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:41:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIe1Oi191239;
        Thu, 17 Oct 2019 18:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=iYr+RkFrcZuWgQ1ne8vBmSzPST8gKEQ3JN/fp2+IPTQ=;
 b=OFxuw2iyzM9XEdd7/Iscl3SSNLY+m27O6ljqG1OE988Qgu7VkfH32zlfU4py66s4xmLI
 A4Rgo+25RBo5yC8Erjuzjy58ghS1vmQ0OfTEvP8v2n/qX9V/rhZdA9CTK4jOKJaNDm97
 vOFchT7abGSs0r5eKX4hD4EdjNVr61yyGaCzZy+UI+lPLinmu1opYhwJrQ7ezcVkFx3t
 vRY4UqcK1Lox559ZnPPV7/yUcJYDDzTzEunA5e1OC86GVgcKwSbOPIePR8QeYEfYfC/n
 t8bJEE6nBmkT6J4qsloQPhVd4d95NFQUxPlxPi3/ymZgjPwMf2B/PuUpKwwu7wKOUaM5 Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68v0arg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:41:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIXI8q050397;
        Thu, 17 Oct 2019 18:41:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vpvtm3j3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:41:34 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HIfXoC009140;
        Thu, 17 Oct 2019 18:41:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:41:33 +0000
Date:   Thu, 17 Oct 2019 11:41:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] iomap: pass a struct page to
 iomap_finish_page_writeback
Message-ID: <20191017184128.GN13108@magnolia>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017175624.30305-15-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170167
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:56:24PM +0200, Christoph Hellwig wrote:
> No need to pass the full bio_vec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bb96499c352f..755b75424a97 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1110,13 +1110,13 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
>  
>  static void
> -iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
> +iomap_finish_page_writeback(struct inode *inode, struct page *page,
>  		int error)
>  {
> -	struct iomap_page *iop = to_iomap_page(bvec->bv_page);
> +	struct iomap_page *iop = to_iomap_page(page);
>  
>  	if (error) {
> -		SetPageError(bvec->bv_page);
> +		SetPageError(page);
>  		mapping_set_error(inode->i_mapping, -EIO);
>  	}
>  
> @@ -1124,7 +1124,7 @@ iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
>  
>  	if (!iop || atomic_dec_and_test(&iop->write_count))
> -		end_page_writeback(bvec->bv_page);
> +		end_page_writeback(page);
>  }
>  
>  /*
> @@ -1156,7 +1156,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  		/* walk each page on bio, ending page IO on them */
>  		bio_for_each_segment_all(bv, bio, iter_all)
> -			iomap_finish_page_writeback(inode, bv, error);
> +			iomap_finish_page_writeback(inode, bv->bv_page, error);
>  		bio_put(bio);
>  	}
>  
> -- 
> 2.20.1
> 
