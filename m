Return-Path: <linux-fsdevel+bounces-54214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E21AFC199
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 06:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CE3B69DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47123C4E7;
	Tue,  8 Jul 2025 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSDQsS9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2A1F869E;
	Tue,  8 Jul 2025 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947453; cv=none; b=XindnjsgC0eb93FIFjuW4EZXQsD4LEuiy/UvRMLk8dOIo48OsFZmPLbbzSNgfogbUAzCBZ+ftlooh4oFjmVP+wVCgho3p6wjkYaXJba6EmGmAfbAqYu5yIJ3mffJIT8bPWZ337/GBKCnNkpfiTtTKXE5VhTwsiFqsSkSpw2jfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947453; c=relaxed/simple;
	bh=y20hIvj7FJ+ub26EEZ5MyosVhGj+5NSliq7e+YqImEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlYCqJNznEoax1q4KFmpQFgb5QO79oR35bqfaQvX4eQILthGf3GSNIFIxu1lRBZWFkCQg3bLSutT+kUw2EAex8xACWezdrQ8ONd8qSX0XmeQkrbAGLL61vsYYGLs9xpV8lwpVMJl51m0caL05tr87sOjVxM/PhcQ1yqjaL8+09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSDQsS9/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso2885288a12.0;
        Mon, 07 Jul 2025 21:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751947451; x=1752552251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvGy7UdF6AbgGyEnqmLu7yYn0wddkSFKtO9DiUDvuus=;
        b=XSDQsS9/JosR1Ev2t8EUFbLshTB7lFQQbAO0aDJXoApMqy6aITcviWqtCdEARseekt
         2MJkOpFp9bWcfNuBVQUbMYEWtZCNNhqOQR+CUWFo+bkKjYEJiR4CqCm4g4zR4aJhpTeH
         0hAaK+QCNSjiQOBIcCdLQPzocYwtIDPYh0BZYomC7vGa4bNWjdyaAzokylOT4qao+FcV
         ZTAFBijK2ZBIpnawNZLJkMUd9/W1SzBa2YDCRozYQ3ic/+zzIErLMoLuCy7lkRbM1Vxw
         3fJYxK/DtJw5OxtGNaYz7txmG0cTFOIvjGyG35psDJQjyqqYkwd4CtCFBvQ/KUOS6Mcq
         wJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751947451; x=1752552251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvGy7UdF6AbgGyEnqmLu7yYn0wddkSFKtO9DiUDvuus=;
        b=jw2J0y8wNyAcYK/zbxh/8mRSeWiuHIGGP+/seK4vQSdjE1dNxmRSnyo2zj7iVTMkmg
         prLlUZvaWmpwJJdLVr8fuwsyMmX2NpOURowg68nGIkaIIsACOqbIGv2rOL2fd0Bd2N8N
         P3HXy7hEVBy9RK5RW6q2WOOsuOuCWQr+ME8IcAIKMRBHGt9pCixIP/ubZQMtXpYUbq4O
         uKssfjl13PqNVhaVn0xqGeREIYUTaFYD2ZTMZm9HePhOqAc+Op9z1ZsunCxEmH6u6PgE
         ADTIKQI7V/xuFjfWGeYotjNtkMZAuZZE2wYuBqlVei1BQilbm+2mA1cxQJ+WmV/6SuVw
         gBfw==
X-Forwarded-Encrypted: i=1; AJvYcCUbH202SuUEsbDdn6HcF2XTmxS0elOPYGCli9lpHXPZMBkIoKwYzWSKLX67eocMyW1QbAVXIRA6YYwH@vger.kernel.org, AJvYcCXvt+z1AHFltcQ5qymgGDpdIaP3FlO21ywpKH3GzAde2A7bl3JW563q1FAmJBMOjXI+Utz5BvHwt1Qs3h+z@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXdHlnI6vSxwqucj2VCYEsllRwivyBEQveRsti3+kyUl9CFxJ
	yeeWMASnvaeGeXT/S3rbLp5GQIRkE54wOgg1aDqEVhledLo4c/KIBasM
X-Gm-Gg: ASbGncsVBgp0pLgf4tDekMz5OD3g0DyrY73yhiNsi2ZNGUN74vm29AoN1eQ/7sKj2aa
	hD0sBXkUVhmLVrObvhV+VwC68XFKYcpIGluXZSPBZ6G3uKSxUDJY92ZFyiqqu4iqE/8Ag/6MCuZ
	kU2rddnwgdMxC2srpD+Yxovw4ACnY5OkM/btrZz5CJJyYAed1nRl/BIasfQ7SXUYogjuAr30jZG
	mQI6OpXivHVGRQiWcngjApFK3k4dXUmEtT73A1D2EiiHcvBJjaOHxhmaOgM6CsgJZQDL8WtXg4a
	ZYN7u98bWwX5GDjGJ/jF6LlWxRPxfqvvDQFVAYjyGZrDVGMWgXsUcnflJkzK7yL3pYgy2PsaaBU
	uWmw=
X-Google-Smtp-Source: AGHT+IFREujPi5EY8W+CcU1CZV4F2U5gLySYjhZNHD4XmStfesLIvGhunk58eYx3OWdIqgxOlskjBg==
X-Received: by 2002:a17:90b:4a81:b0:313:d79d:87eb with SMTP id 98e67ed59e1d1-31c21e3bdcemr2110996a91.35.1751947451237;
        Mon, 07 Jul 2025 21:04:11 -0700 (PDT)
Received: from [30.221.128.116] ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220ed0f9sm685028a91.0.2025.07.07.21.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 21:04:10 -0700 (PDT)
Message-ID: <17009dd5-fd3e-4d1d-92df-3ba9cdf666cc@gmail.com>
Date: Tue, 8 Jul 2025 12:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] ext4: limit the maximum folio order
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ojaswin@linux.ibm.com, sashal@kernel.org, naresh.kamboju@linaro.org,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
 <20250707140814.542883-12-yi.zhang@huaweicloud.com>
From: Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <20250707140814.542883-12-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/7/7 22:08, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In environments with a page size of 64KB, the maximum size of a folio
> can reach up to 128MB. Consequently, during the write-back of folios,
> the 'rsv_blocks' will be overestimated to 1,577, which can make
> pressure on the journal space where the journal is small. This can
> easily exceed the limit of a single transaction. Besides, an excessively
> large folio is meaningless and will instead increase the overhead of
> traversing the bhs within the folio. Therefore, limit the maximum order
> of a folio to 2048 filesystem blocks.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Joseph Qi <jiangqi903@gmail.com>
> Closes: https://lore.kernel.org/linux-ext4/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Confirmed that this can fix the following jbd2 warning in start_this_handle():
"JBD2: kworker/u32:0 wants too many credits credits:32 rsv_credits:1577 max:2695"

Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ext4/ext4.h   |  2 +-
>  fs/ext4/ialloc.c |  3 +--
>  fs/ext4/inode.c  | 22 +++++++++++++++++++---
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f705046ba6c6..9ac0a7d4fa0c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3020,7 +3020,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>  				     struct buffer_head *bh));
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  				struct buffer_head *bh);
> -bool ext4_should_enable_large_folio(struct inode *inode);
> +void ext4_set_inode_mapping_order(struct inode *inode);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA	 2
>  
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 79aa3df8d019..df4051613b29 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1335,8 +1335,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> -	if (ext4_should_enable_large_folio(inode))
> -		mapping_set_large_folios(inode->i_mapping);
> +	ext4_set_inode_mapping_order(inode);
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4b679cb6c8bd..1bce9ebaedb7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5181,7 +5181,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return -EFSCORRUPTED;
>  }
>  
> -bool ext4_should_enable_large_folio(struct inode *inode)
> +static bool ext4_should_enable_large_folio(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  
> @@ -5198,6 +5198,22 @@ bool ext4_should_enable_large_folio(struct inode *inode)
>  	return true;
>  }
>  
> +/*
> + * Limit the maximum folio order to 2048 blocks to prevent overestimation
> + * of reserve handle credits during the folio writeback in environments
> + * where the PAGE_SIZE exceeds 4KB.
> + */
> +#define EXT4_MAX_PAGECACHE_ORDER(i)		\
> +		min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
> +void ext4_set_inode_mapping_order(struct inode *inode)
> +{
> +	if (!ext4_should_enable_large_folio(inode))
> +		return;
> +
> +	mapping_set_folio_order_range(inode->i_mapping, 0,
> +				      EXT4_MAX_PAGECACHE_ORDER(inode));
> +}
> +
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			  ext4_iget_flags flags, const char *function,
>  			  unsigned int line)
> @@ -5515,8 +5531,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		ret = -EFSCORRUPTED;
>  		goto bad_inode;
>  	}
> -	if (ext4_should_enable_large_folio(inode))
> -		mapping_set_large_folios(inode->i_mapping);
> +
> +	ext4_set_inode_mapping_order(inode);
>  
>  	ret = check_igot_inode(inode, flags, function, line);
>  	/*


