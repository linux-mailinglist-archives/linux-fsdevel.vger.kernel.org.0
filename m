Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7A153987
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEU1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 15:27:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58512 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEU1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:27:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015KNN6n086433;
        Wed, 5 Feb 2020 20:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iN7KUzieyoHaczitwJSsMhMA5vrNmTe2vU8JqpxAAJI=;
 b=laN07vt4zu1RXauLZArJVTv8WfQ0avvjfQfYDR0wcr8N9FylYNq9alu1KZlVC4oo2esv
 1hTaTZ6H5mQGB1Ic+DVXuciCsc/WGGRlDLswiUP9jKHlW2zXYy7utGwc1w9rO0MCJz2X
 NJgrb4cyj5/au6JRO0kzLbOmKwvMKGLGuVv7jn6gIfdEqaXM2vpOBn9nEl81OSXqevO+
 lNzQ2qwPtCyzrbJNUChn5sQQWWsfNO0tZnSnBlTkJJoFjMwjByiPRDXo6Wrr84tsjA4A
 ZgWtWiSWgM13Ca1sDw1wFqzX4G/c4J3H5dC3TP9GY/K9ebwtBLI7lIaNvQEq/iJ3kb2U Ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=iN7KUzieyoHaczitwJSsMhMA5vrNmTe2vU8JqpxAAJI=;
 b=LukEfQPsyebh5OqrUDNrPVE/zD9pCwsG/eE/9IPbPeF4bwOuX8nME6Eaglj6duhD19WM
 +CSYAViyrYLO0Ae3bJE6zpDexOLjgqz6OETIBjDtUVyKdhTGlNY1QfIovYlzV5bLkDv9
 TvE2R1Kga0C8WJ2nLjkZG5TB5m7SECroiV7eNE1ed5tr46OQmKHnSyp0ah3vp7M85Wiy
 CHiuWOHDUa1Ld/t+Zutc2DPpBYU3NG5/SsU22lgMWXWsvd8UoxPjC8lvMIoEryqBqQCj
 V9G7JWmNamAKG3W5jr4av20eLaDnJyWHKH1RtHa58nX1QB1rourK0/vtVR+zmj7ImOyq LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xykbp5h6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 20:26:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015KIN1V131764;
        Wed, 5 Feb 2020 20:26:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xymutjn3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 20:26:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015KQrsu030948;
        Wed, 5 Feb 2020 20:26:53 GMT
Received: from [10.132.96.37] (/10.132.96.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 12:26:52 -0800
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        vishal.l.verma@intel.com, Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
References: <20200129210337.GA13630@redhat.com>
From:   jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
Date:   Wed, 5 Feb 2020 12:26:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129210337.GA13630@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I haven't seen response to this proposal, unsure if there is a different
but related discussion ongoing...

I'd like to express my wish: please make it easier for the pmem 
applications when possible.

If kernel does not clear poison when it could legitimately do so,
applications have to go through lengths to clear poisons.
For Cloud pmem applications that have upper bound on error recovery
time, not clearing poison while zeroing-out is quite undesirable.

Thanks!
-jane

On 1/29/20 1:03 PM, Vivek Goyal wrote:
> I am looking into getting rid of dependency on block device in dax
> path. One such place is __dax_zero_page_range() which checks if
> range being zeroed is aligned to block device logical size, then
> it calls bdev_issue_zeroout() instead of doing memset(). Calling
> blkdev_issue_zeroout() also clears bad blocks and poison if any
> in that range.
> 
> This path is used by iomap_zero_range() which in-turn is being
> used by filesystems to zero partial filesystem system blocks.
> For zeroing full filesystem blocks we seem to be calling
> blkdev_issue_zeroout() which clears bad blocks and poison in that
> range.
> 
> So this code currently only seems to help with partial filesystem
> block zeroing. That too only if truncation/hole_punch happens on
> device logical block size boundary.
> 
> To avoid using blkdev_issue_zeroout() in this path, I proposed another
> patch here which adds another dax operation to zero out a rangex and
> clear poison.
> 
> https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/
> 
> Thinking more about it, it might be an overkill to solve this problem.
> 
> How about if we just not clear poison/bad blocks when a partial page
> is being zeroed. IOW, users will need to hole_punch whole filesystem
> block worth of data which will free that block and it will be zeroed
> some other time and clear poison in the process. For partial fs block
> truncation/punch_hole, we don't clear poison.
> 
> If above interface is acceptable, then we can get rid of code which
> tries to call blkdev_issue_zeroout() in iomap_zero_range() path and
> we don't have to implement another dax operation.
> 
> Looking for some feedback on this.
> 
> Vivek
>   
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>   fs/dax.c |   50 +++++++++++++++-----------------------------------
>   1 file changed, 15 insertions(+), 35 deletions(-)
> 
> Index: redhat-linux/fs/dax.c
> ===================================================================
> --- redhat-linux.orig/fs/dax.c	2020-01-29 15:19:18.551902448 -0500
> +++ redhat-linux/fs/dax.c	2020-01-29 15:40:56.584824549 -0500
> @@ -1044,47 +1044,27 @@ static vm_fault_t dax_load_hole(struct x
>   	return ret;
>   }
>   
> -static bool dax_range_is_aligned(struct block_device *bdev,
> -				 unsigned int offset, unsigned int length)
> -{
> -	unsigned short sector_size = bdev_logical_block_size(bdev);
> -
> -	if (!IS_ALIGNED(offset, sector_size))
> -		return false;
> -	if (!IS_ALIGNED(length, sector_size))
> -		return false;
> -
> -	return true;
> -}
> -
>   int __dax_zero_page_range(struct block_device *bdev,
>   		struct dax_device *dax_dev, sector_t sector,
>   		unsigned int offset, unsigned int size)
>   {
> -	if (dax_range_is_aligned(bdev, offset, size)) {
> -		sector_t start_sector = sector + (offset >> 9);
> -
> -		return blkdev_issue_zeroout(bdev, start_sector,
> -				size >> 9, GFP_NOFS, 0);
> -	} else {
> -		pgoff_t pgoff;
> -		long rc, id;
> -		void *kaddr;
> -
> -		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> -		if (rc)
> -			return rc;
> -
> -		id = dax_read_lock();
> -		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> -		if (rc < 0) {
> -			dax_read_unlock(id);
> -			return rc;
> -		}
> -		memset(kaddr + offset, 0, size);
> -		dax_flush(dax_dev, kaddr + offset, size);
> +	pgoff_t pgoff;
> +	long rc, id;
> +	void *kaddr;
> +
> +	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> +	if (rc)
> +		return rc;
> +
> +	id = dax_read_lock();
> +	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +	if (rc < 0) {
>   		dax_read_unlock(id);
> +		return rc;
>   	}
> +	memset(kaddr + offset, 0, size);
> +	dax_flush(dax_dev, kaddr + offset, size);
> +	dax_read_unlock(id);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
