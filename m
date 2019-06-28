Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581A359238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 05:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfF1D4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 23:56:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56060 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfF1D4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:56:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3ssRB017302;
        Fri, 28 Jun 2019 03:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qoSzCPCCpXWHwOhkoHrIjqbxyk10xabogj8Yt3/QUS0=;
 b=jfYXyDgO6mbJw+tTplAh4kIQep1m/UfLsztlmoIkTJs8ouObELdPPyMPt/7ML+Bp2Rql
 gFEf/eYP/0MoWa14+74N7sIMkvMtrfwxrbgG1wbD9iPNzOns6qd/93ekVybl6rhRAgh1
 46jYE7tazyt9SAdsXSsq1Z1w18WpMOVNGm+XC9y2irWSQsaYF/1untylkGP8gqLHI4yk
 lvb9lpNQ2TzFW7RNV2PqmDdG57PVEpmOYoFuVi6wIUGFejqlnJRqmkLp5EGhj+hYDVPF
 ct5SjwYFAERb2/6zl2MHn7tFBuCQ3AVmzcNIb87dh6WLW8LMzqEUQ8WOz3fXJC33BiJN oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtke49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:56:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3txhF054313;
        Fri, 28 Jun 2019 03:56:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f5bwqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:56:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S3tw8h021176;
        Fri, 28 Jun 2019 03:55:59 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 20:55:58 -0700
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0ca3c475-fe10-4135-ddc9-7a82cc966d9a@oracle.com>
Date:   Fri, 28 Jun 2019 11:55:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190607131025.31996-10-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280039
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/6/19 9:10 PM, Naohiro Aota wrote:
> When in HMZONED mode, make sure that device super blocks are located in
> randomly writable zones of zoned block devices. That is, do not write super
> blocks in sequential write required zones of host-managed zoned block
> devices as update would not be possible.

  By design all copies of SB must be updated at each transaction,
  as they are redundant copies they must match at the end of
  each transaction.

  Instead of skipping the sb updates, why not alter number of
  copies at the time of mkfs.btrfs?

Thanks, Anand


> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/disk-io.c     | 11 +++++++++++
>   fs/btrfs/disk-io.h     |  1 +
>   fs/btrfs/extent-tree.c |  4 ++++
>   fs/btrfs/scrub.c       |  2 ++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7c1404c76768..ddbb02906042 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3466,6 +3466,13 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
>   	return latest;
>   }
>   
> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos)
> +{
> +	/* any address is good on a regular (zone_size == 0) device */
> +	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device */
> +	return device->zone_size == 0 || !btrfs_dev_is_sequential(device, pos);
> +}
> +
>   /*
>    * Write superblock @sb to the @device. Do not wait for completion, all the
>    * buffer heads we write are pinned.
> @@ -3495,6 +3502,8 @@ static int write_dev_supers(struct btrfs_device *device,
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>   		    device->commit_total_bytes)
>   			break;
> +		if (!btrfs_check_super_location(device, bytenr))
> +			continue;
>   
>   		btrfs_set_super_bytenr(sb, bytenr);
>   
> @@ -3561,6 +3570,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>   		    device->commit_total_bytes)
>   			break;
> +		if (!btrfs_check_super_location(device, bytenr))
> +			continue;
>   
>   		bh = __find_get_block(device->bdev,
>   				      bytenr / BTRFS_BDEV_BLOCKSIZE,
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index a0161aa1ea0b..70e97cd6fa76 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -141,6 +141,7 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
>   		struct page *page, size_t pg_offset, u64 start, u64 len,
>   		int create);
>   int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos);
>   int __init btrfs_end_io_wq_init(void);
>   void __cold btrfs_end_io_wq_exit(void);
>   
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 3d41d840fe5c..ae2c895d08c4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -267,6 +267,10 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
>   			return ret;
>   	}
>   
> +	/* we won't have super stripes in sequential zones */
> +	if (cache->alloc_type == BTRFS_ALLOC_SEQ)
> +		return 0;
> +
>   	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
>   		bytenr = btrfs_sb_offset(i);
>   		ret = btrfs_rmap_block(fs_info, cache->key.objectid,
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f7b29f9db5e2..36ad4fad7eaf 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3720,6 +3720,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>   		    scrub_dev->commit_total_bytes)
>   			break;
> +		if (!btrfs_check_super_location(scrub_dev, bytenr))
> +			continue;
>   
>   		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>   				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
> 

