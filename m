Return-Path: <linux-fsdevel+bounces-24683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A832A942F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ACA1F2B828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC91BC077;
	Wed, 31 Jul 2024 12:51:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA641BC069
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430273; cv=none; b=VaKH6Z1L4NGDmf6Zqmizt5hwLlGGC+Uxs/nZ7yuLqsGrIXbyDy4ZzHj2wfYQwNs0TlJP9JaPMC7U8+a1MqqYNbELJz21gOIY+0xz0W+/TKY/ZK9xc47b9dleUncEtw4dMqhFRFEmbj/cNarK/0FAn4WbBvc6OXysxaeKC2GzxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430273; c=relaxed/simple;
	bh=WlOASvRCvATmB9AdDKugLv+j34MEoGHMjm+RdlmQ7g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j07155+wXeDa5OlUxMuvRk4pvR7A4j8aqOzx3Gr07JLoNEu+gLuiBQIvB8mNPFPnqYtL/pcda/8S+tH3OR3MGSRYUxxU2zeUMFPQbCJqZCSph6atxeY6lLajdQmAviQJ4myYkE1iCSfFQStGb0f6p8rANkDyAyQfApK0qfEhIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYsQj2Rpxz4f3lCt
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 20:50:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4BA4B1A058E
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 20:51:07 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4U5M6pmUdqBAQ--.57343S3;
	Wed, 31 Jul 2024 20:51:07 +0800 (CST)
Message-ID: <57de6354-f53d-d106-aed8-9dff3e88efa6@huaweicloud.com>
Date: Wed, 31 Jul 2024 20:51:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>
Cc: hch@infradead.org, chuck.lever@oracle.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, hughd@google.com, zlang@kernel.org,
 fdmanana@suse.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731115134.tkiklyu72lwnhbxg@quack3>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240731115134.tkiklyu72lwnhbxg@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4U5M6pmUdqBAQ--.57343S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw18Ww4UGw4rJryrJw13Jwb_yoW7ZryUpr
	Z8GanxKrs3X34jgr4vv3WDur1F9wn3Ka1rXryvg345Ar9Fqr43KFyIyr1Y9a48Jrs5Cr12
	vF45try3ur15CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Hi!

在 2024/7/31 19:51, Jan Kara 写道:
> On Wed 31-07-24 12:38:35, yangerkun wrote:
>> After we switch tmpfs dir operations from simple_dir_operations to
>> simple_offset_dir_operations, every rename happened will fill new dentry
>> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
>> key starting with octx->newx_offset, and then set newx_offset equals to
>> free key + 1. This will lead to infinite readdir combine with rename
>> happened at the same time, which fail generic/736 in xfstests(detail show
>> as below).
>>
>> 1. create 5000 files(1 2 3...) under one dir
>> 2. call readdir(man 3 readdir) once, and get one entry
>> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
>> 4. loop 2~3, until readdir return nothing or we loop too many
>>     times(tmpfs break test with the second condition)
>>
>> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
>> directory reads") to fix it, record the last_index when we open dir, and
>> do not emit the entry which index >= last_index. The file->private_data
>> now used in offset dir can use directly to do this, and we also update
>> the last_index when we llseek the dir file.
> 
> The patch looks good! Just I'm not sure about the llseek part. As far as I
> understand it was added due to this sentence in the standard:
> 
> "If a file is removed from or added to the directory after the most recent
> call to opendir() or rewinddir(), whether a subsequent call to readdir()
> returns an entry for that file is unspecified."
> 
> So if the offset used in offset_dir_llseek() is 0, then we should update
> last_index. But otherwise I'd leave it alone because IMHO it would do more
> harm than good.

IIUC, what you means is that we should only reset the private_data to
new last_index when we call rewinddir(which will call lseek to set
offset of dir file to 0)?

Yeah, I prefer the logic you describle! Besides, we may also change
btrfs that do the same(e60aa5da14d0 ("btrfs: refresh dir last index
during a rewinddir(3) call")). Filipe, how do you think?

Thanks,
Erkun.

> 								Honza
> 
>>
>> Fixes: a2e459555c5f ("shmem: stable directory offsets")
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/libfs.c | 34 +++++++++++++++++++++++-----------
>>   1 file changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 8aa34870449f..38b306738c00 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -450,6 +450,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
>>   	mtree_destroy(&octx->mt);
>>   }
>>   
>> +static int offset_dir_open(struct inode *inode, struct file *file)
>> +{
>> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
>> +
>> +	file->private_data = (void *)ctx->next_offset;
>> +	return 0;
>> +}
>> +
>>   /**
>>    * offset_dir_llseek - Advance the read position of a directory descriptor
>>    * @file: an open directory whose position is to be updated
>> @@ -463,6 +471,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
>>    */
>>   static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>>   {
>> +	struct inode *inode = file->f_inode;
>> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
>> +
>>   	switch (whence) {
>>   	case SEEK_CUR:
>>   		offset += file->f_pos;
>> @@ -476,7 +487,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>>   	}
>>   
>>   	/* In this case, ->private_data is protected by f_pos_lock */
>> -	file->private_data = NULL;
>> +	file->private_data = (void *)ctx->next_offset;
>>   	return vfs_setpos(file, offset, LONG_MAX);
>>   }
>>   
>> @@ -507,7 +518,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>>   			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>   }
>>   
>> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
>>   {
>>   	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>   	struct dentry *dentry;
>> @@ -515,17 +526,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>   	while (true) {
>>   		dentry = offset_find_next(octx, ctx->pos);
>>   		if (!dentry)
>> -			return ERR_PTR(-ENOENT);
>> +			return;
>> +
>> +		if (dentry2offset(dentry) >= last_index) {
>> +			dput(dentry);
>> +			return;
>> +		}
>>   
>>   		if (!offset_dir_emit(ctx, dentry)) {
>>   			dput(dentry);
>> -			break;
>> +			return;
>>   		}
>>   
>>   		ctx->pos = dentry2offset(dentry) + 1;
>>   		dput(dentry);
>>   	}
>> -	return NULL;
>>   }
>>   
>>   /**
>> @@ -552,22 +567,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>   static int offset_readdir(struct file *file, struct dir_context *ctx)
>>   {
>>   	struct dentry *dir = file->f_path.dentry;
>> +	long last_index = (long)file->private_data;
>>   
>>   	lockdep_assert_held(&d_inode(dir)->i_rwsem);
>>   
>>   	if (!dir_emit_dots(file, ctx))
>>   		return 0;
>>   
>> -	/* In this case, ->private_data is protected by f_pos_lock */
>> -	if (ctx->pos == DIR_OFFSET_MIN)
>> -		file->private_data = NULL;
>> -	else if (file->private_data == ERR_PTR(-ENOENT))
>> -		return 0;
>> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
>> +	offset_iterate_dir(d_inode(dir), ctx, last_index);
>>   	return 0;
>>   }
>>   
>>   const struct file_operations simple_offset_dir_operations = {
>> +	.open		= offset_dir_open,
>>   	.llseek		= offset_dir_llseek,
>>   	.iterate_shared	= offset_readdir,
>>   	.read		= generic_read_dir,
>> -- 
>> 2.39.2
>>


