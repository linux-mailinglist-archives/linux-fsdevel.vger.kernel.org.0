Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F12C6026
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 07:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbgK0G1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 01:27:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35340 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392664AbgK0G1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:27:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AR6P0ui173696;
        Fri, 27 Nov 2020 06:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jqR0+hFjy6us0rFueMf7xrXQDqaC76ImRn5+T4ZDJdI=;
 b=MTLWWFJRS2WqPAsJnX3msMlRtnIoccARjcmVSgEqkz4cVm/uj5+VPE3a3ox3HJWEOvXb
 IGIj2oiFwP8oPWUYwTO4kh6tLr2eueiyVb3IjIBMeVlHM+pFMUIsAdcAtlo1kcxxDogv
 siTcjhJ6cdYWVmmc2Uunrhd/b8dtm88Ws3JTCn13ZFjHWZJRhKrAPgF+KQLRtxIJz25p
 pXXEZjBkeOeysuISDwy4Z0OZiOFnXTGg4Pxt/CO5oOBWhkLY7QhaG97MUeHQua0Sd8uQ
 GRtYr27G9DbMqlLUhlVYbZljMkUHK0nynjkS/IIQnnla4Gh4g7Q48lz4xHXY19JBrIeV WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 351kwhg148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 06:27:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AR6P5Om120667;
        Fri, 27 Nov 2020 06:27:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 351kwgxf1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 06:27:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AR6RODo009270;
        Fri, 27 Nov 2020 06:27:26 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Nov 2020 22:27:23 -0800
Subject: Re: [PATCH v10 13/41] btrfs: verify device extent is aligned to zone
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <f1cfa63dd372df107ef954e90ca2e58b2ecf0a67.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <40a366fd-1872-346f-8468-3e4b9d054a06@oracle.com>
Date:   Fri, 27 Nov 2020 14:27:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f1cfa63dd372df107ef954e90ca2e58b2ecf0a67.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=2 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=2 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270037
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> Add a check in verify_one_dev_extent() to check if a device extent on a
> zoned block device is aligned to the respective zone boundary.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7831cf6c6da4..c0e27c1e2559 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7783,6 +7783,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>   		ret = -EUCLEAN;
>   		goto out;
>   	}
> +
> +	if (dev->zone_info) {
> +		u64 zone_size = dev->zone_info->zone_size;
> +
> +		if (!IS_ALIGNED(physical_offset, zone_size) ||
> +		    !IS_ALIGNED(physical_len, zone_size)) {
> +			btrfs_err(fs_info,
> +"zoned: dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
> +				  devid, physical_offset, physical_len);
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +	}
> +
>   out:
>   	free_extent_map(em);
>   	return ret;
> 


Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

