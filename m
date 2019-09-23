Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03397BAC72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403816AbfIWB4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Sep 2019 21:56:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35012 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390768AbfIWB4W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:56:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EFF74F41318306BA7B05;
        Mon, 23 Sep 2019 09:56:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 23 Sep
 2019 09:56:13 +0800
Subject: Re: [PATCH 1/1] f2fs: update multi-dev metadata in resize_fs
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>
References: <20190918125158.12126-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1bb74096-8499-7779-503e-5fc7c3350a1b@huawei.com>
Date:   Mon, 23 Sep 2019 09:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190918125158.12126-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/18 20:51, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Multi-device metadata should be updated in resize_fs as well.
> 
> Also, we check that the new FS size still reaches the last device.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  fs/f2fs/gc.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5877bd7..a2b8cbe 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1431,26 +1431,46 @@ static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
>  	int segment_count_main = le32_to_cpu(raw_sb->segment_count_main);
>  	long long block_count = le64_to_cpu(raw_sb->block_count);
>  	int segs = secs * sbi->segs_per_sec;
> +	int ndevs = sbi->s_ndevs;
>  
>  	raw_sb->section_count = cpu_to_le32(section_count + secs);
>  	raw_sb->segment_count = cpu_to_le32(segment_count + segs);
>  	raw_sb->segment_count_main = cpu_to_le32(segment_count_main + segs);
>  	raw_sb->block_count = cpu_to_le64(block_count +
>  					(long long)segs * sbi->blocks_per_seg);
> +	if (ndevs > 1) {

if (f2fs_is_multi_device(sbi)) {
	int last_ndev = sbi->s_ndevs - 1;


> +		int dev_segs =
> +			le32_to_cpu(raw_sb->devs[ndevs - 1].total_segments);
> +
> +		raw_sb->devs[ndevs - 1].total_segments =
> +						cpu_to_le32(dev_segs + segs);
> +	}
>  }
>  
>  static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  {
>  	int segs = secs * sbi->segs_per_sec;
> +	long long blks = (long long)segs * sbi->blocks_per_seg;
>  	long long user_block_count =
>  				le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
> +	int ndevs = sbi->s_ndevs;
>  
>  	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
>  	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
>  	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
>  	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
> -	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count +
> -					(long long)segs * sbi->blocks_per_seg);
> +	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
> +
> +	if (ndevs > 1) {

if (f2fs_is_multi_device(sbi)) {
	int last_ndev = sbi->s_ndevs - 1;

> +		FDEV(ndevs - 1).total_segments =
> +				(int)FDEV(ndevs - 1).total_segments + segs;
> +		FDEV(ndevs - 1).end_blk =
> +				(long long)FDEV(ndevs - 1).end_blk + blks;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		FDEV(ndevs - 1).nr_blkz = (int)FDEV(ndevs - 1).nr_blkz +
> +					(int)(blks >> sbi->log_blocks_per_blkz);
> +#endif
> +	}
>  }
>  
>  int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> @@ -1465,6 +1485,14 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	if (block_count > old_block_count)
>  		return -EINVAL;
>  
> +	if (sbi->s_ndevs > 1) {

if (f2fs_is_multi_device(sbi)) {
	int last_ndev = sbi->s_ndevs - 1;

Otherwise it looks good to me.

Thanks,

> +		__u64 last_segs = FDEV(sbi->s_ndevs - 1).total_segments;
> +
> +		if (block_count + last_segs * sbi->blocks_per_seg <=
> +								old_block_count)
> +			return -EINVAL;
> +	}
> +
>  	/* new fs size should align to section size */
>  	div_u64_rem(block_count, BLKS_PER_SEC(sbi), &rem);
>  	if (rem)
> 
