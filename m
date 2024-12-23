Return-Path: <linux-fsdevel+bounces-38058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0D9FB02D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554DB188DED9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF91A724C;
	Mon, 23 Dec 2024 14:21:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB91B4F0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963707; cv=none; b=QTD0m9NXjMsszTvyahofu6hIY1nnIydPm1xW8AGk1vMBVFO1UoLAy5ptztONgNE+YdbwspeqKZ/b75V5Ku8SPjdc66diEmE1N+tRGR4sPVRnyOGd0CJsC7kmxdGFC23XXtrNFh6uOAzc4YoqG1C5FfRvDMkqwZbkweSzE3h1+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963707; c=relaxed/simple;
	bh=31uFLKDfYiMLu1hf9Q8XiVEfamQUC7PPYBSHmfyuDJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqbnMsCF5UYka+SwKPr94T4drDEbvfmFMwJjnKdT5FPfIUOsYDQ271bTackm0sMgR7gptj+u+dkes9YSIT+EO8DCcEYdGKxOzhfBPRLaJL/iN+MoGRpDOP12EdTdxsoR6ZZK1hWujVIiDSQCKWL5SVIahsLneF0EWeptTKX0vKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YH0ZJ20WTz4f3jkk
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:21:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D5C3C1A0197
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:21:42 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHYob2cWlnCkKvFQ--.45637S3;
	Mon, 23 Dec 2024 22:21:42 +0800 (CST)
Message-ID: <3ccf8255-dfbb-d019-d156-01edf5242c49@huaweicloud.com>
Date: Mon, 23 Dec 2024 22:21:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 5/5] libfs: Use d_children list to iterate
 simple_offset directories
To: cel@kernel.org, Hugh Dickins <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-6-cel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241220153314.5237-6-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYob2cWlnCkKvFQ--.45637S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4Dur48AFy5tF1xAr48tFb_yoW7Cr17pF
	Z8XasIkr4fXw12gF4xXF4DZryS9w10gF45Wr1fWw1rA3sFqrnrt3Za9r1av34UJr4kCr17
	XF45KwnI9w4UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



在 2024/12/20 23:33, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The mtree mechanism has been effective at creating directory offsets
> that are stable over multiple opendir instances. However, it has not
> been able to handle the subtleties of renames that are concurrent
> with readdir.
> 
> Instead of using the mtree to emit entries in the order of their
> offset values, use it only to map incoming ctx->pos to a starting
> entry. Then use the directory's d_children list, which is already
> maintained properly by the dcache, to find the next child to emit.
> 
> One of the sneaky things about this is that when the mtree-allocated
> offset value wraps (which is very rare), looking up ctx->pos++ is
> not going to find the next entry; it will return NULL. Instead, by
> following the d_children list, the offset values can appear in any
> order but all of the entries in the directory will be visited
> eventually.
> 
> Note also that the readdir() is guaranteed to reach the tail of this
> list. Entries are added only at the head of d_children, and readdir
> walks from its current position in that list towards its tail.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 84 +++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 58 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 5c56783c03a5..f7ead02062ad 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>   
>   /* simple_offset_add() allocation range */
>   enum {
> -	DIR_OFFSET_MIN		= 2,
> +	DIR_OFFSET_MIN		= 3,
>   	DIR_OFFSET_MAX		= LONG_MAX - 1,
>   };
>   
>   /* simple_offset_add() never assigns these to a dentry */
>   enum {
> +	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
>   	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
>   
>   };
> @@ -458,51 +459,82 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   	return vfs_setpos(file, offset, LONG_MAX);
>   }
>   
> -static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
> +static struct dentry *find_positive_dentry(struct dentry *parent,
> +					   struct dentry *dentry,
> +					   bool next)
>   {
> -	MA_STATE(mas, &octx->mt, offset, offset);
> +	struct dentry *found = NULL;
> +
> +	spin_lock(&parent->d_lock);
> +	if (next)
> +		dentry = d_next_sibling(dentry);
> +	else if (!dentry)
> +		dentry = d_first_child(parent);
> +	hlist_for_each_entry_from(dentry, d_sib) {
> +		if (!simple_positive(dentry))
> +			continue;
> +		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> +		if (simple_positive(dentry))
> +			found = dget_dlock(dentry);
> +		spin_unlock(&dentry->d_lock);
> +		if (likely(found))
> +			break;
> +	}
> +	spin_unlock(&parent->d_lock);
> +	return found;
> +}
> +
> +static noinline_for_stack struct dentry *
> +offset_dir_lookup(struct dentry *parent, loff_t offset)
> +{
> +	struct inode *inode = d_inode(parent);
> +	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>   	struct dentry *child, *found = NULL;
>   
> -	rcu_read_lock();
> -	child = mas_find(&mas, DIR_OFFSET_MAX);
> -	if (!child)
> -		goto out;
> -	spin_lock(&child->d_lock);
> -	if (simple_positive(child))
> -		found = dget_dlock(child);
> -	spin_unlock(&child->d_lock);
> -out:
> -	rcu_read_unlock();
> +	MA_STATE(mas, &octx->mt, offset, offset);
> +
> +	if (offset == DIR_OFFSET_FIRST)
> +		found = find_positive_dentry(parent, NULL, false);
> +	else {
> +		rcu_read_lock();
> +		child = mas_find(&mas, DIR_OFFSET_MAX);

Can this child be NULL? Like we delete some file after first readdir, 
maybe we should break here, or we may rescan all dentry and return them 
to userspace again?

> +		found = find_positive_dentry(parent, child, false);
> +		rcu_read_unlock();
> +	}
>   	return found;
>   }
>   
>   static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>   {
>   	struct inode *inode = d_inode(dentry);
> -	long offset = dentry2offset(dentry);
>   
> -	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
> -			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> +	return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
> +			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>   }
>   
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
>   {
> -	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> +	struct dentry *dir = file->f_path.dentry;
>   	struct dentry *dentry;
>   
> +	dentry = offset_dir_lookup(dir, ctx->pos);
> +	if (!dentry)
> +		goto out_eod;
>   	while (true) {
> -		dentry = offset_find_next(octx, ctx->pos);
> -		if (!dentry)
> -			goto out_eod;
> +		struct dentry *next;
>   
> -		if (!offset_dir_emit(ctx, dentry)) {
> -			dput(dentry);
> +		ctx->pos = dentry2offset(dentry);
> +		if (!offset_dir_emit(ctx, dentry))
>   			break;
> -		}
>   
> -		ctx->pos = dentry2offset(dentry) + 1;
> +		next = find_positive_dentry(dir, dentry, true);
>   		dput(dentry);
> +
> +		if (!next)
> +			goto out_eod;
> +		dentry = next;
>   	}
> +	dput(dentry);
>   	return;
>   
>   out_eod:
> @@ -541,7 +573,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
>   	if (ctx->pos != DIR_OFFSET_EOD)
> -		offset_iterate_dir(d_inode(dir), ctx);
> +		offset_iterate_dir(file, ctx);
>   	return 0;
>   }
>   


