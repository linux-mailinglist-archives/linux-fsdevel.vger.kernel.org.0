Return-Path: <linux-fsdevel+bounces-48180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD54AABC60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A109189EAC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94815442A;
	Tue,  6 May 2025 07:41:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6C4B1E4B;
	Tue,  6 May 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517263; cv=none; b=MrUTjPj8/BjzRT57ZJ7iC4qWpXZM9miTwU5YoWesNZCP4JqVy8Jvd4qKF2GfJxs2tBoLsjtn5NZAJ2F5q96pT9bAdo6JZX/nhvFSUU1Bg7V5X3+ed74WbNbqOJsfrn5q9/9KlMVkOBZKyLUdMErmpez7EdtA+DNI5x7cC9GkVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517263; c=relaxed/simple;
	bh=1PDerzji9sZolvTVbd7WKys0MwxiR3D5ftsqUnsekyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GJcEyDVFFZPMWKcvCUbpzWIMFPWJdPNvf6Ab+MpMvoC0FHjmNRIq7j09ETNsXRNMSXjL8HTft75Qzr2+JxVZbNBNYlTphqOcGD2mS6jxJqeaJ/Yp4RNujujgZ2f1uWqiNoP4Y9tCAs16JW1mxMQoQUVc3LlMyaU7Pa/laCfMsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zs9Kk08n5z2TSDl;
	Tue,  6 May 2025 15:40:26 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 13B3D1A0188;
	Tue,  6 May 2025 15:40:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 6 May
 2025 15:40:58 +0800
Message-ID: <317c8848-6b66-4f54-b3ce-894e040dad60@huawei.com>
Date: Tue, 6 May 2025 15:40:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ext4: factor out ext4_get_maxbytes()
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <wanghaichi0403@gmail.com>, <yi.zhang@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
 <20250506012009.3896990-3-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250506012009.3896990-3-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/6 9:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> There are several locations that get the correct maxbytes value based on
> the inode's block type. It would be beneficial to extract a common
> helper function to make the code more clear.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
Nice cleanup! Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/ext4.h    | 7 +++++++
>   fs/ext4/extents.c | 7 +------
>   fs/ext4/file.c    | 7 +------
>   3 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..8664bb5367c5 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3378,6 +3378,13 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
>   	return 1 << sbi->s_log_groups_per_flex;
>   }
>   
> +static inline loff_t ext4_get_maxbytes(struct inode *inode)
> +{
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return inode->i_sb->s_maxbytes;
> +	return EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> +}
> +
>   #define ext4_std_error(sb, errno)				\
>   do {								\
>   	if ((errno))						\
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..b294d2f35a26 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4931,12 +4931,7 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
>   
>   static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
>   {
> -	u64 maxbytes;
> -
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		maxbytes = inode->i_sb->s_maxbytes;
> -	else
> -		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> +	u64 maxbytes = ext4_get_maxbytes(inode);
>   
>   	if (*len == 0)
>   		return -EINVAL;
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index beb078ee4811..b845a25f7932 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -929,12 +929,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>   loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
>   {
>   	struct inode *inode = file->f_mapping->host;
> -	loff_t maxbytes;
> -
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
> -		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> -	else
> -		maxbytes = inode->i_sb->s_maxbytes;
> +	loff_t maxbytes = ext4_get_maxbytes(inode);
>   
>   	switch (whence) {
>   	default:



