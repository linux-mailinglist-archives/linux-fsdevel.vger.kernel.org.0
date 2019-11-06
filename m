Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F172F1E77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 20:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfKFTRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 14:17:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKFTRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:17:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6JD34e057478;
        Wed, 6 Nov 2019 19:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=8Yh1KuLs+cjoPiXs+ulIFCtp/zGoRnvCASlft22/8eU=;
 b=oqb6YNzvhAg27vIF2aBPBT7FJwW5avf0qKYDrwXtLSE8W/B34ZnnQ2IeYzXR0F0k9ECV
 V2EJiVryYBeAfHQtxsy1fNlBYOuwHJJ2r/cGzsoloxIYMOo+Lm/1kQcJVK84gMXIx9v/
 n5t3rxXHT4V5Kr7SuHQxiM7+Pj2reLNe7MoyWRwUcV80ynbYWGWUr8ZFbfV9VchtyUGc
 E2SDUT04/6of6R/vUrM2coZtb+an/bw7j2fkAcj2fG0awpvHdJmvEnIDqN2PDxrTHS9U
 V6y95sByEKChRSIBDpYKhRIFlLF+eIPwX1EKAIRfQdM9rU2yEdwvRjJ3VdUEbNWD7Xl6 Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w41w0s3rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 19:17:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6JBRFG186174;
        Wed, 6 Nov 2019 19:17:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w41wf8x8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 19:17:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA6JGvCU020219;
        Wed, 6 Nov 2019 19:16:58 GMT
Received: from localhost (/10.159.234.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 11:16:57 -0800
Date:   Wed, 6 Nov 2019 11:16:56 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iomap: Fix overflow in iomap_page_mkwrite
Message-ID: <20191106191656.GC15212@magnolia>
References: <20191106190400.20969-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106190400.20969-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911060187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911060187
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:04:00PM +0100, Andreas Gruenbacher wrote:
> On architectures where ssize_t is wider than pgoff_t, the expression

ssize_t?  But you're changing @offset, which is loff_t.   I'm confused.

Also, which architectures are you talking about here?

--D

> ((page->index + 1) << PAGE_SHIFT) can overflow.  Rewrite to use the page
> offset, which we already compute here anyway.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..a30ea7ecb790 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1040,20 +1040,19 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  
>  	lock_page(page);
>  	size = i_size_read(inode);
> -	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> +	offset = page_offset(page);
> +	if (page->mapping != inode->i_mapping || offset > size) {
>  		/* We overload EFAULT to mean page got truncated */
>  		ret = -EFAULT;
>  		goto out_unlock;
>  	}
>  
>  	/* page is wholly or partially inside EOF */
> -	if (((page->index + 1) << PAGE_SHIFT) > size)
> +	if (offset > size - PAGE_SIZE)
>  		length = offset_in_page(size);
>  	else
>  		length = PAGE_SIZE;
>  
> -	offset = page_offset(page);
>  	while (length > 0) {
>  		ret = iomap_apply(inode, offset, length,
>  				IOMAP_WRITE | IOMAP_FAULT, ops, page,
> -- 
> 2.20.1
> 
