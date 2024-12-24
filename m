Return-Path: <linux-fsdevel+bounces-38101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2428E9FBEE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 15:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954401631CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15F1BD032;
	Tue, 24 Dec 2024 14:00:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54C42A8B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048823; cv=none; b=tUoNj6SNCuCAZHgEPmJLvdyN1jRqMmWYIqTV+t4E6xu5TCf+mbcvT06w1iVrVbui4ElZWTcDFUNb63RTxUwwx7jDnwS9iIpy9UvVDHZkZeBDwiO3KxIAisLn7/eicC2woMiDQ+GkFJ0WSHV8D3Ei4istqWq0xSEViZh4iruc9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048823; c=relaxed/simple;
	bh=2ltI33R34PPGQrS3JWc/BpIpyQJ5lLxqtwIuL6Kr5+g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=frXch2+g7nECTwFOOgeSIyK2xy4DR7yAJks2M6UimUfV0ajt+TrIJobL27mUucMi+pm97yi7lF6Y4DlYzsdOmwjCc4aVBdn/o2YlrhWacbX2sKY9JTEiW8dP0nMaawy1Lq1rGTa5ccXl+aQQADq0F378t3yit8tm0UxYC5kkIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHc2z3fQkz4f3jdm
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 21:59:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 357741A07B6
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 22:00:15 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVuvmpnbqAMFg--.59356S3;
	Tue, 24 Dec 2024 22:00:15 +0800 (CST)
Message-ID: <6dac6b48-c5ef-452c-fb75-84c7be587089@huaweicloud.com>
Date: Tue, 24 Dec 2024 22:00:14 +0800
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
From: yangerkun <yangerkun@huaweicloud.com>
To: Chuck Lever <chuck.lever@oracle.com>, cel@kernel.org,
 Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-6-cel@kernel.org>
 <3ccf8255-dfbb-d019-d156-01edf5242c49@huaweicloud.com>
 <fcae58c8-edcf-4a42-a23b-4747ccbf758c@oracle.com>
 <3976ba47-76c7-28e1-9f20-6e94e0adbbea@huaweicloud.com>
 <71bbbf23-361b-4461-9739-ede4f120c982@oracle.com>
 <75a58251-27b7-9309-cb2a-e614dc29cb49@huaweicloud.com>
In-Reply-To: <75a58251-27b7-9309-cb2a-e614dc29cb49@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVuvmpnbqAMFg--.59356S3
X-Coremail-Antispam: 1UD129KBjvJXoW3CF4fAryDKFy5AF1rZr1fJFb_yoWDCF1xpF
	95JFWUGrW5Jr1rGr10qr1UJrySyw1UG3WUXr18W3W8JrsrtrnFgF1UXr1q9r18Jr48Gr1U
	Xr4Utrnxur1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/24 21:57, yangerkun 写道:
> 
> 
> 在 2024/12/24 21:52, Chuck Lever 写道:
>> On 12/23/24 11:40 PM, yangerkun wrote:
>>>
>>>
>>> 在 2024/12/23 22:44, Chuck Lever 写道:
>>>> On 12/23/24 9:21 AM, yangerkun wrote:
>>>>>
>>>>>
>>>>> 在 2024/12/20 23:33, cel@kernel.org 写道:
>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>
>>>>>> The mtree mechanism has been effective at creating directory offsets
>>>>>> that are stable over multiple opendir instances. However, it has not
>>>>>> been able to handle the subtleties of renames that are concurrent
>>>>>> with readdir.
>>>>>>
>>>>>> Instead of using the mtree to emit entries in the order of their
>>>>>> offset values, use it only to map incoming ctx->pos to a starting
>>>>>> entry. Then use the directory's d_children list, which is already
>>>>>> maintained properly by the dcache, to find the next child to emit.
>>>>>>
>>>>>> One of the sneaky things about this is that when the mtree-allocated
>>>>>> offset value wraps (which is very rare), looking up ctx->pos++ is
>>>>>> not going to find the next entry; it will return NULL. Instead, by
>>>>>> following the d_children list, the offset values can appear in any
>>>>>> order but all of the entries in the directory will be visited
>>>>>> eventually.
>>>>>>
>>>>>> Note also that the readdir() is guaranteed to reach the tail of this
>>>>>> list. Entries are added only at the head of d_children, and readdir
>>>>>> walks from its current position in that list towards its tail.
>>>>>>
>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>> ---
>>>>>>   fs/libfs.c | 84 ++++++++++++++++++++++++++++++++++++ 
>>>>>> +-----------------
>>>>>>   1 file changed, 58 insertions(+), 26 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>>>>> index 5c56783c03a5..f7ead02062ad 100644
>>>>>> --- a/fs/libfs.c
>>>>>> +++ b/fs/libfs.c
>>>>>> @@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>>>>>>   /* simple_offset_add() allocation range */
>>>>>>   enum {
>>>>>> -    DIR_OFFSET_MIN        = 2,
>>>>>> +    DIR_OFFSET_MIN        = 3,
>>>>>>       DIR_OFFSET_MAX        = LONG_MAX - 1,
>>>>>>   };
>>>>>>   /* simple_offset_add() never assigns these to a dentry */
>>>>>>   enum {
>>>>>> +    DIR_OFFSET_FIRST    = 2,        /* Find first real entry */
>>>>>>       DIR_OFFSET_EOD        = LONG_MAX,    /* Marks EOD */
>>>>>>   };
>>>>>> @@ -458,51 +459,82 @@ static loff_t offset_dir_llseek(struct file 
>>>>>> *file, loff_t offset, int whence)
>>>>>>       return vfs_setpos(file, offset, LONG_MAX);
>>>>>>   }
>>>>>> -static struct dentry *offset_find_next(struct offset_ctx *octx, 
>>>>>> loff_t offset)
>>>>>> +static struct dentry *find_positive_dentry(struct dentry *parent,
>>>>>> +                       struct dentry *dentry,
>>>>>> +                       bool next)
>>>>>>   {
>>>>>> -    MA_STATE(mas, &octx->mt, offset, offset);
>>>>>> +    struct dentry *found = NULL;
>>>>>> +
>>>>>> +    spin_lock(&parent->d_lock);
>>>>>> +    if (next)
>>>>>> +        dentry = d_next_sibling(dentry);
>>>>>> +    else if (!dentry)
>>>>>> +        dentry = d_first_child(parent);
>>>>>> +    hlist_for_each_entry_from(dentry, d_sib) {
>>>>>> +        if (!simple_positive(dentry))
>>>>>> +            continue;
>>>>>> +        spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>>>>>> +        if (simple_positive(dentry))
>>>>>> +            found = dget_dlock(dentry);
>>>>>> +        spin_unlock(&dentry->d_lock);
>>>>>> +        if (likely(found))
>>>>>> +            break;
>>>>>> +    }
>>>>>> +    spin_unlock(&parent->d_lock);
>>>>>> +    return found;
>>>>>> +}
>>>>>> +
>>>>>> +static noinline_for_stack struct dentry *
>>>>>> +offset_dir_lookup(struct dentry *parent, loff_t offset)
>>>>>> +{
>>>>>> +    struct inode *inode = d_inode(parent);
>>>>>> +    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>>>>>       struct dentry *child, *found = NULL;
>>>>>> -    rcu_read_lock();
>>>>>> -    child = mas_find(&mas, DIR_OFFSET_MAX);
>>>>>> -    if (!child)
>>>>>> -        goto out;
>>>>>> -    spin_lock(&child->d_lock);
>>>>>> -    if (simple_positive(child))
>>>>>> -        found = dget_dlock(child);
>>>>>> -    spin_unlock(&child->d_lock);
>>>>>> -out:
>>>>>> -    rcu_read_unlock();
>>>>>> +    MA_STATE(mas, &octx->mt, offset, offset);
>>>>>> +
>>>>>> +    if (offset == DIR_OFFSET_FIRST)
>>>>>> +        found = find_positive_dentry(parent, NULL, false);
>>>>>> +    else {
>>>>>> +        rcu_read_lock();
>>>>>> +        child = mas_find(&mas, DIR_OFFSET_MAX);
>>>>>
>>>>> Can this child be NULL?
>>>>
>>>> Yes, this mas_find() call can return NULL. find_positive_dentry() 
>>>> should
>>>> then return NULL. Kind of subtle.
>>>>
>>>>
>>>>> Like we delete some file after first readdir, maybe we should break 
>>>>> here, or we may rescan all dentry and return them to userspace again?
>>>>
>>>> You mean to deal with the case where the "next" entry has an offset
>>>> that is lower than @offset? mas_find() will return the entry in the
>>>> tree that is "at or after" mas->index.
>>>>
>>>> I'm not sure either "break" or returning repeats is safe. But, now that
>>>> you point it out, this function probably does need additional logic to
>>>> deal with the offset wrap case.
>>>>
>>>> But since this logic already exists here, IMO it is reasonable to leave
>>>> that to be addressed by a subsequent patch. So far there aren't any
>>>> regression test failures that warn of a user-visible problem the way it
>>>> is now.
>>>
>>> Sorry for the confusing, the case I am talking is something like below:
>>>
>>> mkdir /tmp/dir && cd /tmp/dir
>>> touch file1 # offset is 3
>>> touch file2 # offset is 4
>>> touch file3 # offset is 5
>>> touch file4 # offset is 6
>>> touch file5 # offset is 7
>>> first readdir and get file5 file4 file3 file2 #ctx->pos is 3, which
>>> means we will get file1 for second readdir
>>>
>>> unlink file1 # can not get entry for ctx->pos == 3
>>>
>>> second readdir # offset_dir_lookup will use mas_find but return NULL,
>>> and we will get file5 file4 file3 file2 again?
>>
>> After this patch, directory entries are reported in descending
>> cookie order. Therefore, should this patch replace the mas_find() call
>> with mas_find_rev() ?
> 
> Emm... The reason that why readdir report file with descending cookie
> order is d_alloc will insert child dentry to the list head of
> &parent->d_subdirs, and find_positive_dentry will get child in order. So
> it seems this won't work?

I prefer this is not a problem since dcache_readdir already report dir 
with this order.

> 
>>
>>
>>> And for the offset wrap case, I prefer it's safe with your patch if 
>>> we won't unlink file between two readdir. The second readdir will use an
>>> active ctx->pos which means there is a active dentry attach to this
>>> ctx->pos. find_positive_dentry will stop once we meet the last child.
>>>
>>>
>>> I am not sure if I understand correctly, if not, please point out!
>>>
>>> Thanks!
>>>
>>>>
>>>>
>>>>>> +        found = find_positive_dentry(parent, child, false);
>>>>>> +        rcu_read_unlock();
>>>>>> +    }
>>>>>>       return found;
>>>>>>   }
>>>>>>   static bool offset_dir_emit(struct dir_context *ctx, struct 
>>>>>> dentry *dentry)
>>>>>>   {
>>>>>>       struct inode *inode = d_inode(dentry);
>>>>>> -    long offset = dentry2offset(dentry);
>>>>>> -    return ctx->actor(ctx, dentry->d_name.name, 
>>>>>> dentry->d_name.len, offset,
>>>>>> -              inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>>>> +    return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
>>>>>> +            inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>>>>   }
>>>>>> -static void offset_iterate_dir(struct inode *inode, struct 
>>>>>> dir_context *ctx)
>>>>>> +static void offset_iterate_dir(struct file *file, struct 
>>>>>> dir_context *ctx)
>>>>>>   {
>>>>>> -    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>>>>> +    struct dentry *dir = file->f_path.dentry;
>>>>>>       struct dentry *dentry;
>>>>>> +    dentry = offset_dir_lookup(dir, ctx->pos);
>>>>>> +    if (!dentry)
>>>>>> +        goto out_eod;
>>>>>>       while (true) {
>>>>>> -        dentry = offset_find_next(octx, ctx->pos);
>>>>>> -        if (!dentry)
>>>>>> -            goto out_eod;
>>>>>> +        struct dentry *next;
>>>>>> -        if (!offset_dir_emit(ctx, dentry)) {
>>>>>> -            dput(dentry);
>>>>>> +        ctx->pos = dentry2offset(dentry);
>>>>>> +        if (!offset_dir_emit(ctx, dentry))
>>>>>>               break;
>>>>>> -        }
>>>>>> -        ctx->pos = dentry2offset(dentry) + 1;
>>>>>> +        next = find_positive_dentry(dir, dentry, true);
>>>>>>           dput(dentry);
>>>>>> +
>>>>>> +        if (!next)
>>>>>> +            goto out_eod;
>>>>>> +        dentry = next;
>>>>>>       }
>>>>>> +    dput(dentry);
>>>>>>       return;
>>>>>>   out_eod:
>>>>>> @@ -541,7 +573,7 @@ static int offset_readdir(struct file *file, 
>>>>>> struct dir_context *ctx)
>>>>>>       if (!dir_emit_dots(file, ctx))
>>>>>>           return 0;
>>>>>>       if (ctx->pos != DIR_OFFSET_EOD)
>>>>>> -        offset_iterate_dir(d_inode(dir), ctx);
>>>>>> +        offset_iterate_dir(file, ctx);
>>>>>>       return 0;
>>>>>>   }
>>>>>
>>>>
>>>>
>>>
>>
>>
> 
> 


