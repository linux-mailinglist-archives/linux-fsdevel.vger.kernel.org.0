Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4324F29B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 02:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVAVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 20:21:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfFVAVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:21:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0Jmsb067607;
        Sat, 22 Jun 2019 00:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OZgG/+PaNSzFNI+C1G5b5d9WJiVZ3f7Dm0+3X0L7Kck=;
 b=KVCFf6+fIDHVu0LkAq5W2GOo5Zt0679ULfV96BrRNdcRvbtDn9wyOe0lWFpIniqRSufz
 sd4cyWp+WYCKEcJSVKFjIDKLTsNXlyloWyBGdsMy+eD8M9MF+C0jDbg9rKA1XgznRl2f
 m6VRPUMcKb14Bo5VxmnmSf0xteGmn6GCXb7rxw1k3aNsclQBP7IJMlQ/Seee+ClC2WPg
 rxyWcV9s0WlNLYF8hypuJo7NSig+eXfOTt/3JDNO8HBepFW7eXDI+Q4jKv+R4tleBlba
 RN3j9ambUocWsZsDyQM/7abT+OdBeLekQyfeS/lRjs4e4cZCJ3HZ++kLKAItYOeyDOiF /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t7809ru61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 00:21:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0JPBT150148;
        Sat, 22 Jun 2019 00:21:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77ypf1jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 00:21:10 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5M0L8CR012074;
        Sat, 22 Jun 2019 00:21:08 GMT
Received: from localhost (/10.159.131.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 17:21:08 -0700
Date:   Fri, 21 Jun 2019 17:21:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, david@fromorbit.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/6] iomap: Check iblocksize before transforming
 page->private
Message-ID: <20190622002107.GA1611011@magnolia>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621192828.28900-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 02:28:25PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs uses page->private as well to store extent_buffer. Make
> the check stricter to make sure we are using page->private for iop by
> comparing iblocksize < PAGE_SIZE.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

/me wonders what will happen when btrfs decides to support blocksize !=
pagesize... will we have to add a pointer to struct iomap_page so that
btrfs can continue to associate an extent_buffer with a page?

--D

> ---
>  include/linux/iomap.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f49767c7fd83..6511124e58b6 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -128,7 +128,8 @@ struct iomap_page {
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
>  {
> -	if (page_has_private(page))
> +	if (i_blocksize(page->mapping->host) < PAGE_SIZE &&
> +			page_has_private(page))
>  		return (struct iomap_page *)page_private(page);
>  	return NULL;
>  }
> -- 
> 2.16.4
> 
