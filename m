Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE72E9FBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 23:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbhADV6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 16:58:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41566 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbhADV6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:58:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104Lt2kc096523;
        Mon, 4 Jan 2021 21:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=V+CUrFr4mW/1XT7WQ/YgM8kb/PMEg0asCXwJnBfnzNo=;
 b=wwLoqCS+XRftPUX+Fveqar7Ub9ON00ewuHHSxjD//OUg8V8X7+5X76TiwDAsxnob2Bki
 L1IYSKazCgPptnExjAvgrkVP4a6q9qoViUilszR9uPuwTbsjxikmQrSm6twS9sFSf7bW
 GN3QH2UokSZ5+mIpha1rbHDl+6zqsZ9DzrZ5kfrWIGyljirlgbZELcXlVYCOlYCsoAOD
 NZNxSe6U97iS4hxQ4ezLvi6rMbUJeB/YTYOGDQKv5mulsbAV62QD3ULkAbSeYun9LWfJ
 BBg9TsptObqzLpiCEDT3bDMN+cn6wj7JGD34izgAAmT5e6Qacr62icHNMV0z3UGfNcs6 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgskpcb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 21:58:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104LoJa7081307;
        Mon, 4 Jan 2021 21:58:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35uxnrsd2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 21:58:06 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104Lw5XL018028;
        Mon, 4 Jan 2021 21:58:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 13:58:05 -0800
Date:   Mon, 4 Jan 2021 13:58:02 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
Message-ID: <20210104215802.GC6911@magnolia>
References: <20201224044954.1349459-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224044954.1349459-1-satyat@google.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040131
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 24, 2020 at 04:49:54AM +0000, Satya Tangirala wrote:
> freeze/thaw_bdev() currently use bdev->bd_fsfreeze_count to infer
> whether or not bdev->bd_fsfreeze_sb is valid (it's valid iff
> bd_fsfreeze_count is non-zero). thaw_bdev() doesn't nullify
> bd_fsfreeze_sb.
> 
> But this means a freeze_bdev() call followed by a thaw_bdev() call can
> leave bd_fsfreeze_sb with a non-null value, while bd_fsfreeze_count is
> zero. If freeze_bdev() is called again, and this time
> get_active_super() returns NULL (e.g. because the FS is unmounted),
> we'll end up with bd_fsfreeze_count > 0, but bd_fsfreeze_sb is
> *untouched* - it stays the same (now garbage) value. A subsequent
> thaw_bdev() will decide that the bd_fsfreeze_sb value is legitimate
> (since bd_fsfreeze_count > 0), and attempt to use it.
> 
> Fix this by always setting bd_fsfreeze_sb to NULL when
> bd_fsfreeze_count is successfully decremented to 0 in thaw_sb().
> Alternatively, we could set bd_fsfreeze_sb to whatever
> get_active_super() returns in freeze_bdev() whenever bd_fsfreeze_count
> is successfully incremented to 1 from 0 (which can be achieved cleanly
> by moving the line currently setting bd_fsfreeze_sb to immediately
> after the "sync:" label, but it might be a little too subtle/easily
> overlooked in future).
> 
> This fixes the currently panicking xfstests generic/085.
> 
> Fixes: 040f04bd2e82 ("fs: simplify freeze_bdev/thaw_bdev")
> Signed-off-by: Satya Tangirala <satyat@google.com>

I came up with the same solution to the same crash, so:

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/block_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e56ee1f2652..12a811a9ae4b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -606,6 +606,8 @@ int thaw_bdev(struct block_device *bdev)
>  		error = thaw_super(sb);
>  	if (error)
>  		bdev->bd_fsfreeze_count++;
> +	else
> +		bdev->bd_fsfreeze_sb = NULL;
>  out:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
