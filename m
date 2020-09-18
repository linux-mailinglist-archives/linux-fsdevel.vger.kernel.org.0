Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039F526F03F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 04:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgIRCl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 22:41:59 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54714 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728575AbgIRCLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:11:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U9Gue2N_1600395067;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0U9Gue2N_1600395067)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Sep 2020 10:11:07 +0800
Subject: Re: [PATCH 09/14] ocfs2: cleanup o2hb_region_dev_store
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <20200917165720.3285256-1-hch@lst.de>
 <20200917165720.3285256-10-hch@lst.de>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <1c8a3a5a-aa59-f30e-4865-6777436c4225@linux.alibaba.com>
Date:   Fri, 18 Sep 2020 10:11:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917165720.3285256-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/9/18 00:57, Christoph Hellwig wrote:
> Use blkdev_get_by_dev instead of igrab (aka open coded bdgrab) +
> blkdev_get.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/cluster/heartbeat.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 89d13e0705fe7b..0179a73a3fa2c4 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1766,7 +1766,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	int sectsize;
>  	char *p = (char *)page;
>  	struct fd f;
> -	struct inode *inode;
>  	ssize_t ret = -EINVAL;
>  	int live_threshold;
>  
> @@ -1793,20 +1792,16 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	    reg->hr_block_bytes == 0)
>  		goto out2;
>  
> -	inode = igrab(f.file->f_mapping->host);
> -	if (inode == NULL)
> +	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
>  		goto out2;
>  
> -	if (!S_ISBLK(inode->i_mode))
> -		goto out3;
> -
> -	reg->hr_bdev = I_BDEV(f.file->f_mapping->host);
> -	ret = blkdev_get(reg->hr_bdev, FMODE_WRITE | FMODE_READ, NULL);
> -	if (ret) {
> +	reg->hr_bdev = blkdev_get_by_dev(f.file->f_mapping->host->i_rdev,
> +					 FMODE_WRITE | FMODE_READ, NULL);
> +	if (IS_ERR(reg->hr_bdev)) {
> +		ret = PTR_ERR(reg->hr_bdev);
>  		reg->hr_bdev = NULL;
> -		goto out3;
> +		goto out2;
>  	}
> -	inode = NULL;
>  
>  	bdevname(reg->hr_bdev, reg->hr_dev_name);
>  
> @@ -1909,16 +1904,13 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  		       config_item_name(&reg->hr_item), reg->hr_dev_name);
>  
>  out3:
> -	iput(inode);
> +	if (ret < 0) {
> +		blkdev_put(reg->hr_bdev, FMODE_READ | FMODE_WRITE);
> +		reg->hr_bdev = NULL;
> +	}
>  out2:
>  	fdput(f);
>  out:
> -	if (ret < 0) {
> -		if (reg->hr_bdev) {
> -			blkdev_put(reg->hr_bdev, FMODE_READ|FMODE_WRITE);
> -			reg->hr_bdev = NULL;
> -		}
> -	}
>  	return ret;
>  }
>  
> 
