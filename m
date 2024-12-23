Return-Path: <linux-fsdevel+bounces-38026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953AF9FAF54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368B47A259D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770C1401B;
	Mon, 23 Dec 2024 14:17:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688ADEAFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963456; cv=none; b=Ef0BF6rHRdm7aZlVI1Qv27jKK2ycRm35WluJ74LUEzkY5pSq32JF2AOuQ2iE8fKD9kJVtMQZNnoqzJihdETHdIkXdNmp21FuxW1w9mOBpdnKHbgVrq0Yag3edHWMWIsN0291bSnW6qTepU5BbBjcI5wjiIZJvhZwNoAjN4STp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963456; c=relaxed/simple;
	bh=F0WJtXbIrZlq7DHy/h9Ey2p1vWt/UxvKIX2J0TpxQbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npuERjVWi3PFmtjG9YHtpsXDdk6POnB2LOiwaUyPLmCpSF1GivaJwAgOJT5ZYCwTs7sKIwJ20PHL9xc0V/N55QGmlMb3gqAueVPjIYhSmeb9PzKrBEymwY5LHcb2+T4eED4D1HATVhYl+6ymmZZJUeTiwqKJ4HLESoS8VZgKFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YH0TM0mSCz4f3jYR
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:17:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BDA881A0930
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:17:30 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBHIob6cGlnfvyuFQ--.54478S3;
	Mon, 23 Dec 2024 22:17:30 +0800 (CST)
Message-ID: <bd6a5e7f-e73e-2344-835b-c2f1cddf2744@huaweicloud.com>
Date: Mon, 23 Dec 2024 22:17:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 4/5] libfs: Replace simple_offset end-of-directory
 detection
To: cel@kernel.org, Hugh Dickins <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-5-cel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241220153314.5237-5-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIob6cGlnfvyuFQ--.54478S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW8tF1xur4kKw17urW5GFg_yoW7Xw13pF
	Z8G3ZxKrs3Xw1j9F40vF4DZ34F9wnagrWxGr1Fgwn8A3sIqrsrKasFyr1Yka40kr4kCr12
	vF45Kr13uw4UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>


在 2024/12/20 23:33, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> According to getdents(3), the d_off field in each returned directory
> entry points to the next entry in the directory. The d_off field in
> the last returned entry in the readdir buffer must contain a valid
> offset value, but if it points to an actual directory entry, then
> readdir/getdents can loop.
> 
> This patch introduces a specific fixed offset value that is placed
> in the d_off field of the last entry in a directory. Some user space
> applications assume that the EOD offset value is larger than the
> offsets of real directory entries, so the largest possible offset
> value is reserved for this purpose. This new value is never
> allocated by simple_offset_add().
> 
> When ->iterate_dir() returns, getdents{64} inserts the ctx->pos
> value into the d_off field of the last valid entry in the readdir
> buffer. When it hits EOD, offset_readdir() sets ctx->pos to the EOD
> offset value so the last entry is updated to point to the EOD marker.
> 
> When trying to read the entry at the EOD offset, offset_readdir()
> terminates immediately.
> 
> It is worth noting that using a Maple tree for directory offset
> value allocation does not guarantee a 63-bit range of values --
> on platforms where "long" is a 32-bit type, the directory offset
> value range is still 0..(2^31 - 1).
> 
> Fixes: 796432efab1e ("libfs: getdents() should return 0 after reaching EOD")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 38 ++++++++++++++++++++++----------------
>   1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8c9364a0174c..5c56783c03a5 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -245,9 +245,16 @@ const struct inode_operations simple_dir_inode_operations = {
>   };
>   EXPORT_SYMBOL(simple_dir_inode_operations);
>   
> -/* 0 is '.', 1 is '..', so always start with offset 2 or more */
> +/* simple_offset_add() allocation range */
>   enum {
> -	DIR_OFFSET_MIN	= 2,
> +	DIR_OFFSET_MIN		= 2,
> +	DIR_OFFSET_MAX		= LONG_MAX - 1,
> +};
> +
> +/* simple_offset_add() never assigns these to a dentry */
> +enum {
> +	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
> +
>   };
>   
>   static void offset_set(struct dentry *dentry, long offset)
> @@ -291,7 +298,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>   		return -EBUSY;
>   
>   	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
> -				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
> +				 DIR_OFFSET_MAX, &octx->next_offset,
> +				 GFP_KERNEL);
>   	if (unlikely(ret < 0))
>   		return ret == -EBUSY ? -ENOSPC : ret;
>   
> @@ -447,8 +455,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   		return -EINVAL;
>   	}
>   
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	file->private_data = NULL;
>   	return vfs_setpos(file, offset, LONG_MAX);
>   }
>   
> @@ -458,7 +464,7 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>   	struct dentry *child, *found = NULL;
>   
>   	rcu_read_lock();
> -	child = mas_find(&mas, LONG_MAX);
> +	child = mas_find(&mas, DIR_OFFSET_MAX);
>   	if (!child)
>   		goto out;
>   	spin_lock(&child->d_lock);
> @@ -479,7 +485,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>   			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>   }
>   
> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   {
>   	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>   	struct dentry *dentry;
> @@ -487,7 +493,7 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   	while (true) {
>   		dentry = offset_find_next(octx, ctx->pos);
>   		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			goto out_eod;
>   
>   		if (!offset_dir_emit(ctx, dentry)) {
>   			dput(dentry);
> @@ -497,7 +503,10 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   		ctx->pos = dentry2offset(dentry) + 1;
>   		dput(dentry);
>   	}
> -	return NULL;
> +	return;
> +
> +out_eod:
> +	ctx->pos = DIR_OFFSET_EOD;
>   }
>   
>   /**
> @@ -517,6 +526,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>    *
>    * On return, @ctx->pos contains an offset that will read the next entry
>    * in this directory when offset_readdir() is called again with @ctx.
> + * Caller places this value in the d_off field of the last entry in the
> + * user's buffer.
>    *
>    * Return values:
>    *   %0 - Complete
> @@ -529,13 +540,8 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>   
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
> -
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == DIR_OFFSET_MIN)
> -		file->private_data = NULL;
> -	else if (file->private_data == ERR_PTR(-ENOENT))
> -		return 0;
> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> +	if (ctx->pos != DIR_OFFSET_EOD)
> +		offset_iterate_dir(d_inode(dir), ctx);
>   	return 0;
>   }
>   


