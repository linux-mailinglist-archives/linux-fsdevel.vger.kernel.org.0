Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39D2D3A75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 06:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgLIF2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 00:28:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLIF2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:28:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B95A0q9105596;
        Wed, 9 Dec 2020 05:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qzyRrI3IH/2QxeO7RQKqcBtsmjnFq4qnaFTyNmMyzMU=;
 b=amBzzgyLlfCa02zHEyp9XAR4VGXZTKgFy72hZz/ZsQLMiPoI7YcaivX2KctFgZZedUMm
 zu021tXs+mc+NRaxgk5TACKxR0C4VnNyCRgN1wKCoY1SGusg7Y6cN/08f16YqRZHelOl
 hR9sZLVuWbQEyZrMrN4rOGVGoiaeuVtUKjdc0kS1NmDgnKgK6MpXMTgKtRpW1awiZJND
 KTBv+j3xSBNl0+Av6bopvGfAvGnvAlu+J+nO4FS6y53M3GvSJGo9DVftY9odZBoPwGOG
 8OwWDC9ue/tv8kyzWCieBQd/TF/v852ZfErLI8yAY2NXvvltaLlcezK2p64LxuE4meM7 Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825m69vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 05:27:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B95AWH9082424;
        Wed, 9 Dec 2020 05:27:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 358m3yr718-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 05:27:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B95RdaG028987;
        Wed, 9 Dec 2020 05:27:39 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 21:27:38 -0800
Subject: Re: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b83b65ea-dbfc-b5f4-9681-6e9e53c76abb@oracle.com>
Date:   Wed, 9 Dec 2020 13:27:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090036
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org




> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index db884b96a5ea..7831cf6c6da4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1416,6 +1416,21 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
>   	return false;
>   }
>   
> +static inline u64 dev_extent_search_start_zoned(struct btrfs_device *device,
> +						u64 start)
> +{
> +	u64 tmp;
> +
> +	if (device->zone_info->zone_size > SZ_1M)
> +		tmp = device->zone_info->zone_size;
> +	else
> +		tmp = SZ_1M;
> +	if (start < tmp)
> +		start = tmp;
> +
> +	return btrfs_align_offset_to_zone(device, start);
> +}
> +
>   static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>   {
>   	switch (device->fs_devices->chunk_alloc_policy) {
> @@ -1426,11 +1441,57 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>   		 * make sure to start at an offset of at least 1MB.
>   		 */
>   		return max_t(u64, start, SZ_1M);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		return dev_extent_search_start_zoned(device, start);
>   	default:
>   		BUG();
>   	}
>   }
>   

> @@ -165,4 +190,13 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device,
>   	       !btrfs_dev_is_sequential(device, pos);
>   }
>   
> +static inline u64 btrfs_align_offset_to_zone(struct btrfs_device *device,
> +					     u64 pos)
> +{
> +	if (!device->zone_info)
> +		return pos;
> +
> +	return ALIGN(pos, device->zone_info->zone_size);
> +}
> +
>   #endif
> 

  Small functions (such as above) can be opened coded to make the
  reviewing easier. The btrfs_align_offset_to_zone() and
  dev_extent_search_start_zoned() can be open coded and merged into
  the parent function dev_extent_search_start() as below...

dev_extent_search_start()
::
	case BTRFS_CHUNK_ALLOC_ZONED:
		start = max_t(u64, start,
			      max_t(u64, device->zone_info->zone_size, SZ_1M));

          return ALIGN(start, device->zone_info->zone_size);

  As of now we don't allow mix of zoned with regular device in a
  btrfs (those are verified during mount and device add/replace).
  So we don't have to check for the same again in
  btrfs_align_offset_to_zone().

Thanks.
