Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7042BA16B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 05:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKTETi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 23:19:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38498 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTETh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:19:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK4EkLj001896;
        Fri, 20 Nov 2020 04:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ryz1sURI6BLaafYEVKyXm2JHXZIzFg+xwGfLOvAytbA=;
 b=isnZneMmczUkROz0ujYFSi/fsn1Advh4Rj74FfUs5RP4qJU0X3N+87rF4afkqGaYHdsp
 glctvWQTkV3lpVJQ9xhkKd6sltCa5jhoPUNLkFH+lPkvbUjR4GJRsLMz8Mvgh8KElNvx
 wSCLu0oYRUMBSuRnRp37YC5IwNttF6Xmn5H67wf2qEjGuw+hg89tIdQh/cZXXgyzFvIX
 fNSBMpgkH+aJNeDy5ZGvwB3zojcm1czfA7TbOznsolLx/323UM2Ab6SjgWi6iZWnSmfZ
 phvh6h7pS6i0LhnOQrlhFT2lMDlHqD6JHQYHknjRaqPStCmaloNyG3ZJCM0oMZNJTJSt 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76m8tuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 04:19:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK4BjFX135671;
        Fri, 20 Nov 2020 04:17:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34uspx3p2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 04:17:28 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AK4HRwf027653;
        Fri, 20 Nov 2020 04:17:27 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 20:17:27 -0800
Subject: Re: [PATCH v10 08/41] btrfs: disallow NODATACOW in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <a7debcd84dafac8b0d0f67da6b4e410ea346bffb.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <05414b36-2a3f-b2fb-a596-48cf8d59512b@oracle.com>
Date:   Fri, 20 Nov 2020 12:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a7debcd84dafac8b0d0f67da6b4e410ea346bffb.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200028
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> NODATACOW implies overwriting the file data on a device, which is
> impossible in sequential required zones. Disable NODATACOW globally with
> mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Looks good.
  Reviewed-by: Anand Jain <anand.jain@oracle.com>

A nit below.

> ---
>   fs/btrfs/ioctl.c | 13 +++++++++++++
>   fs/btrfs/zoned.c |  5 +++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ab408a23ba32..d13b522e7bb2 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -193,6 +193,15 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
>   	return 0;
>   }
>   
> +static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
> +				    unsigned int flags)
> +{
> +	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))


> +		return -EPERM;

nit:
  Should it be -EINVAL instead? I am not sure. May be David can fix 
while integrating.

Thanks.


> +
> +	return 0;
> +}
> +
>   static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>   {
>   	struct inode *inode = file_inode(file);
> @@ -230,6 +239,10 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>   	if (ret)
>   		goto out_unlock;
>   
> +	ret = check_fsflags_compatible(fs_info, fsflags);
> +	if (ret)
> +		goto out_unlock;
> +
>   	binode_flags = binode->flags;
>   	if (fsflags & FS_SYNC_FL)
>   		binode_flags |= BTRFS_INODE_SYNC;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d6b8165e2c91..bd153932606e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -290,5 +290,10 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>   		return -EINVAL;
>   	}
>   
> +	if (btrfs_test_opt(info, NODATACOW)) {
> +		btrfs_err(info, "zoned: NODATACOW not supported");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
> 

