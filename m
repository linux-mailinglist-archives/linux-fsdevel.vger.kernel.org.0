Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166762C24AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 12:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbgKXLit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 06:38:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbgKXLit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:38:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOBZId4116841;
        Tue, 24 Nov 2020 11:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+9cpHctWC39/LeAtaf1RPUoSnpc3cgQxN/BNyqZRqJ4=;
 b=mYy/1Z/shF5nms/gW3FkKFFuf+Oevcx9lOjWdIL5gVsuVo2RpHFJPec50zqQpNPhObn7
 V/N7xDx1/3VQHWTwFpzSoCxMAZIglPU86BBJIW5Sn1DnDRELXUfwFzjBs7HA8XNFy90c
 XpYd16nU/qtH3LsV4tO11mEz87goUArnBuhlX7LjMSRNhkIgKh5fQdZkcfO5v4JCrMFU
 JbCY6NwLiPGnTX8ZRywYcd5hl36ZuqFAklb84pnq77Gzy2XYpv0SzOqyLEpw48z2iory
 ZNfrHy4j4BJAms8CaURi+R75QDOY1+W0zrsb5b/IdQq584oNBxWU0DA0/YkqH88ZjIUx qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 34xtaqnp6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 11:38:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOBZei6174730;
        Tue, 24 Nov 2020 11:36:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34yx8jrfvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 11:36:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AOBaNmC029687;
        Tue, 24 Nov 2020 11:36:24 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 03:36:23 -0800
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
Message-ID: <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
Date:   Tue, 24 Nov 2020 19:36:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> This commit implements a zoned chunk/dev_extent allocator. The zoned
> allocator aligns the device extents to zone boundaries, so that a zone
> reset affects only the device extent and does not change the state of
> blocks in the neighbor device extents.
> 
> Also, it checks that a region allocation is not overlapping any of the
> super block zones, and ensures the region is empty.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Looks good.

Chunks and stripes are aligned to the zone_size. I guess zone_size won't
change after the block device has been formatted with it? For testing,
what if the device image is dumped onto another zoned device with a
different zone_size?

A small nit is below.

> +static void init_alloc_chunk_ctl_policy_zoned(
> +				      struct btrfs_fs_devices *fs_devices,
> +				      struct alloc_chunk_ctl *ctl)
> +{
> +	u64 zone_size = fs_devices->fs_info->zone_size;
> +	u64 limit;
> +	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
> +	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
> +	u64 min_chunk_size = min_data_stripes * zone_size;
> +	u64 type = ctl->type;
> +
> +	ctl->max_stripe_size = zone_size;
> +	if (type & BTRFS_BLOCK_GROUP_DATA) {
> +		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
> +						 zone_size);
> +	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> +		ctl->max_chunk_size = ctl->max_stripe_size;
> +	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
> +		ctl->devs_max = min_t(int, ctl->devs_max,
> +				      BTRFS_MAX_DEVS_SYS_CHUNK);
> +	}
> +


> +	/* We don't want a chunk larger than 10% of writable space */
> +	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),

  What's the purpose of dev_factor here?

Thanks.

