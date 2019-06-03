Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1732DC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 12:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfFCKk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 06:40:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfFCKk2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:40:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E7154A3224CBF0D18B26;
        Mon,  3 Jun 2019 18:39:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 18:39:29 +0800
Subject: Re: [PATCH v3 3/4] f2fs: Fix accounting for unusable blocks
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kernel-team@android.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-4-drosen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c99079bd-99e1-e100-08f6-1e8adae5e722@huawei.com>
Date:   Mon, 3 Jun 2019 18:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530004906.261170-4-drosen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/30 8:49, Daniel Rosenberg wrote:
> Fixes possible underflows when dealing with unusable blocks.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/f2fs.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9b3d9977cd1ef..a39cc4ffeb4b1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1769,8 +1769,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  
>  	if (!__allow_reserved_blocks(sbi, inode, true))
>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -		avail_user_block_count -= sbi->unusable_block_count;
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		if (avail_user_block_count > sbi->unusable_block_count)
> +			avail_user_block_count = 0;

avail_user_block_count -= sbi->unusable_block_count;

> +		else
> +			avail_user_block_count -= sbi->unusable_block_count;

avail_user_block_count = 0;

Thanks,

> +	}
>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>  		diff = sbi->total_valid_block_count - avail_user_block_count;
>  		if (diff > *count)
> @@ -1970,7 +1974,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  					struct inode *inode, bool is_inode)
>  {
>  	block_t	valid_block_count;
> -	unsigned int valid_node_count;
> +	unsigned int valid_node_count, user_block_count;
>  	int err;
>  
>  	if (is_inode) {
> @@ -1997,10 +2001,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  
>  	if (!__allow_reserved_blocks(sbi, inode, false))
>  		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> +	user_block_count = sbi->user_block_count;
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -		valid_block_count += sbi->unusable_block_count;
> +		user_block_count -= sbi->unusable_block_count;
>  
> -	if (unlikely(valid_block_count > sbi->user_block_count)) {
> +	if (unlikely(valid_block_count > user_block_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
> 
