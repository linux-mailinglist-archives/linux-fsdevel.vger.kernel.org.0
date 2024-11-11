Return-Path: <linux-fsdevel+bounces-34178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E801E9C3698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 03:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A700C280D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 02:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE664D8CE;
	Mon, 11 Nov 2024 02:36:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD917C77;
	Mon, 11 Nov 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731292591; cv=none; b=aDYP/nUkJJ2ySy+cAxUQT0cUSxZWXEV0MtsUwZxNPMF3o0o1KGuXk9H9dBcp1jq+smx4Zs1U2wihLHfvHFtVnsjUlgZquV4jhHLXe8l1H3v4x6zyhdHdHZdUqxJVn1zxwSRnh0eg6BUX9vTOMvZe9pvKAbom0Vyejjcnz+Q/Ucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731292591; c=relaxed/simple;
	bh=/obaPwKtg0uV70P8aOmwQc1IzswX+27JM4iKLSXuZQs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F9NQbVupV36CNraYWmXghXd7/qlUSfT0cl9ccj6ca+X4YQzAg275RzVO4L3e9fQ45NRXTIa9X4R6iFv9uI6vSvPt30foWlFWMIKm7GCgf0cdEYiH4jtaQA3I8zKXpJj0B9vK24iqny8XIXOboCcTO4ST5GGzpxoywQecmAEy8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xmtvt1ssxz4f3l8M;
	Mon, 11 Nov 2024 10:36:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C3DC1A06D7;
	Mon, 11 Nov 2024 10:36:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoKgbTFnhWTJBQ--.55246S3;
	Mon, 11 Nov 2024 10:36:19 +0800 (CST)
Subject: Re: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
To: cel@kernel.org, stable@vger.kernel.org
Cc: yukuai1@huaweicloud.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, hughd@google.com,
 willy@infradead.org, gregkh@linuxfoundation.org, sashal@kernel.org,
 srinivasan.shanmugam@amd.com, chiahsuan.chung@amd.com, mingo@kernel.org,
 mgorman@techsingularity.net, chengming.zhou@linux.dev,
 zhangpeng.00@bytedance.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
 linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
Date: Mon, 11 Nov 2024 10:36:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241111005242.34654-7-cel@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoKgbTFnhWTJBQ--.55246S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw18Ww4rWF13tF18ZryDGFg_yoW7ZF1fpF
	Z8G3W3Kr4fXw1UKF4vvF1DZryF93Z3Kw45W34rW345Ary2qrZ8KFn2yr1aka48tr95Cr12
	qF45K343Ww4jkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCXdbUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/11/11 8:52, cel@kernel.org Ð´µÀ:
> From: yangerkun <yangerkun@huawei.com>
> 
> [ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]
> 
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> 1. create 5000 files(1 2 3...) under one dir
> 2. call readdir(man 3 readdir) once, and get one entry
> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> 4. loop 2~3, until readdir return nothing or we loop too many
>     times(tmpfs break test with the second condition)
> 
> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> directory reads") to fix it, record the last_index when we open dir, and
> do not emit the entry which index >= last_index. The file->private_data

Please notice this requires last_index should never overflow, otherwise
readdir will be messed up.
> now used in offset dir can use directly to do this, and we also update
> the last_index when we llseek the dir file.
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> [brauner: only update last_index after seek when offset is zero like Jan suggested]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> [ cel: adjusted to apply to origin/linux-6.6.y ]
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 37 +++++++++++++++++++++++++------------
>   1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index a87005c89534..b59ff0dfea1f 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -449,6 +449,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
>   	xa_destroy(&octx->xa);
>   }
>   
> +static int offset_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
> +	file->private_data = (void *)ctx->next_offset;
> +	return 0;
> +}

Looks like xarray is still used.

I'm in the cc list ,so I assume you saw my set, then I don't know why
you're ignoring my concerns.

1) next_offset is 32-bit and can overflow in a long-time running
machine.
2) Once next_offset overflows, readdir will skip the files that offset
is bigger.

Thanks,
Kuai

> +
>   /**
>    * offset_dir_llseek - Advance the read position of a directory descriptor
>    * @file: an open directory whose position is to be updated
> @@ -462,6 +470,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
>    */
>   static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   {
> +	struct inode *inode = file->f_inode;
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
>   	switch (whence) {
>   	case SEEK_CUR:
>   		offset += file->f_pos;
> @@ -475,8 +486,9 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   	}
>   
>   	/* In this case, ->private_data is protected by f_pos_lock */
> -	file->private_data = NULL;
> -	return vfs_setpos(file, offset, U32_MAX);
> +	if (!offset)
> +		file->private_data = (void *)ctx->next_offset;
> +	return vfs_setpos(file, offset, LONG_MAX);
>   }
>   
>   static struct dentry *offset_find_next(struct xa_state *xas)
> @@ -505,7 +517,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>   			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>   }
>   
> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
>   {
>   	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
>   	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> @@ -514,17 +526,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   	while (true) {
>   		dentry = offset_find_next(&xas);
>   		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			return;
> +
> +		if (dentry2offset(dentry) >= last_index) {
> +			dput(dentry);
> +			return;
> +		}
>   
>   		if (!offset_dir_emit(ctx, dentry)) {
>   			dput(dentry);
> -			break;
> +			return;
>   		}
>   
>   		dput(dentry);
>   		ctx->pos = xas.xa_index + 1;
>   	}
> -	return NULL;
>   }
>   
>   /**
> @@ -551,22 +567,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   static int offset_readdir(struct file *file, struct dir_context *ctx)
>   {
>   	struct dentry *dir = file->f_path.dentry;
> +	long last_index = (long)file->private_data;
>   
>   	lockdep_assert_held(&d_inode(dir)->i_rwsem);
>   
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
>   
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == DIR_OFFSET_MIN)
> -		file->private_data = NULL;
> -	else if (file->private_data == ERR_PTR(-ENOENT))
> -		return 0;
> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> +	offset_iterate_dir(d_inode(dir), ctx, last_index);
>   	return 0;
>   }
>   
>   const struct file_operations simple_offset_dir_operations = {
> +	.open		= offset_dir_open,
>   	.llseek		= offset_dir_llseek,
>   	.iterate_shared	= offset_readdir,
>   	.read		= generic_read_dir,
> 


