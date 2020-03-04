Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADC1793F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbgCDPsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:48:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgCDPsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:48:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Fd1U0136814;
        Wed, 4 Mar 2020 15:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4pIPpk9UM2GlyA237h0AGb6LahzrQQPr44APCEOTTpQ=;
 b=LFhKRlBGN+2VcurWuONe3fjFrn0Trzk3NVNEMsdjo2Iy9ob04uv9sWAmzjIVLl9k/i/9
 4yZcWainsZHYjc1VfuEyjFDG3nRRnyj59HfRPXZNp8QlMpIVQdHtEaEgd0HFWiblO5AI
 o4JSYxnqM0DTbuUidqo/DLxYlPLLFtDMyjZi4wdfSDwhcKkMTFRE/inOPw+PP2O7fPQG
 kl6wVkHPzZHuCqcPVrYY7EdHP8vdgz/oS6bSGT7rrsdp5hjVwKJFK2qmHITmX5rFtnaP
 Bj4xePR+ZvcEO8JgRIvIJkTk9Davk40Rxj5x+vlt5qpAyX2A9U8Hv45Nf5LCxTM7p4Py mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yghn3awr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:48:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Fiipj086123;
        Wed, 4 Mar 2020 15:48:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2yg1p7s7bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:48:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024Fm2n9006238;
        Wed, 4 Mar 2020 15:48:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 07:48:02 -0800
Date:   Wed, 4 Mar 2020 07:48:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     akpm@linux-foundation.org
Cc:     linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially revert "don't allow writes to swap files"
Message-ID: <20200304154801.GE8037@magnolia>
References: <20200303191023.GD8037@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303191023.GD8037@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040115
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:10:23AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> In commit dc617f29dbe5 we tried to prevent userspace programs from
> writing to active swap devices.  However, it turns out that userspace
> hibernation requires the ability to write the hibernation image to a
> swap device, so revert the write path checks.
> 
> Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
> Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Reported-by: Marian Klein <mkleinsoft@gmail.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

self-NAK, Domenico Andreoli has taken this on.  Andrew, could you please
drop this patch from your queue?

--D

> ---
>  fs/block_dev.c |    3 ---
>  mm/filemap.c   |    3 ---
>  mm/memory.c    |    4 ----
>  mm/mmap.c      |    8 ++------
>  4 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 69bf2fb6f7cd..08b088dac1f0 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -2001,9 +2001,6 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (bdev_read_only(I_BDEV(bd_inode)))
>  		return -EPERM;
>  
> -	if (IS_SWAPFILE(bd_inode))
> -		return -ETXTBSY;
> -
>  	if (!iov_iter_count(from))
>  		return 0;
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1784478270e1..d1b8cd15b2bf 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2920,9 +2920,6 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t count;
>  	int ret;
>  
> -	if (IS_SWAPFILE(inode))
> -		return -ETXTBSY;
> -
>  	if (!iov_iter_count(from))
>  		return 0;
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 0bccc622e482..e908490f7034 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2357,10 +2357,6 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>  
>  	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
>  
> -	if (vmf->vma->vm_file &&
> -	    IS_SWAPFILE(vmf->vma->vm_file->f_mapping->host))
> -		return VM_FAULT_SIGBUS;
> -
>  	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
>  	/* Restore original flags so that caller is not surprised */
>  	vmf->flags = old_flags;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d681a20eb4ea..77d086139e13 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1461,12 +1461,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		case MAP_SHARED_VALIDATE:
>  			if (flags & ~flags_mask)
>  				return -EOPNOTSUPP;
> -			if (prot & PROT_WRITE) {
> -				if (!(file->f_mode & FMODE_WRITE))
> -					return -EACCES;
> -				if (IS_SWAPFILE(file->f_mapping->host))
> -					return -ETXTBSY;
> -			}
> +			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))
> +				return -EACCES;
>  
>  			/*
>  			 * Make sure we don't allow writing to an append-only
