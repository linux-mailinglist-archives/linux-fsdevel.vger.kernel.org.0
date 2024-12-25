Return-Path: <linux-fsdevel+bounces-38114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6759FC3D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 07:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6E81883385
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7B14431B;
	Wed, 25 Dec 2024 06:57:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF04E571
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735109840; cv=none; b=LA358J2hNmdnvBC1b73+Ruq5s57K4gL2U29xDtgfSs4CvYvfRmiv7/ow2ty0AH6oaNQPTlThEIV5C5sq4jdBsDgYE/hGma4BAu2sQ/l5nSjTIYGdqmcDU6I4Zac15xdXFvrA8WxL2kfz4c47L5SHJ/jcMiKk2WNJu8qF/DVwojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735109840; c=relaxed/simple;
	bh=5KMpCm6VkHUzP3hkRsdCMsMhK7VVIPy12DadgCMl2cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKjxZkSdYB1YTNPy+iNmxvDdupLGCrGH/RFwe4pdFMe25UyyQmqd8wz+ihq5Xx/sdxFg27qZBmz4RApXh3Oc9raoXzH7c72xKbvDmP3bxdgH35CYUAtEfFTUsVl+Xv4PmCPytkp1lmA+Qt/3+PgpmEsSQCpdTgrM5i6w+4ijFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJ2cL6NcSz4f3jqw
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 14:56:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 83AF51A0568
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 14:57:05 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4e_rGtnDGxPFg--.25097S3;
	Wed, 25 Dec 2024 14:57:05 +0800 (CST)
Message-ID: <8bb2164c-5fdd-17f4-08dd-3b4f37a011a8@huaweicloud.com>
Date: Wed, 25 Dec 2024 14:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] fuse: enable writeback cgroup to limit dirty page
 cache
To: yangerkun <yangerkun@huaweicloud.com>, miklos@szeredi.hu,
 brauner@kernel.org, jack@suse.cz, amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org
References: <20240830120540.2446680-1-yangerkun@huaweicloud.com>
 <cc8fc5b3-4cfc-f65a-af46-59cb6cb0c9fb@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <cc8fc5b3-4cfc-f65a-af46-59cb6cb0c9fb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4e_rGtnDGxPFg--.25097S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW7Gr48JF48GF1DJr43ZFb_yoWxAr15pF
	1ktrZ8ArW3urykWr1xtw4Dury5t348Jw4DJr1rJ3WYvFsrAr109F4jqr1q9F1UAw48Jr4j
	qr4UGr97Zr17trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Gently ping again~

在 2024/9/7 11:22, yangerkun 写道:
> Hi,
> 
> Gently ping for this.
> 
> Only btrfs/ext2/ext4/f2fs/xfs/blkdev support SB_I_CGROUPWB which can
> limit dirty pagecache with memcg's max bytes, and for fs like nfs/cifs
> /fuse(and so on) still can not do that. Does this seems a big issue we 
> should try to fix...
> 
> 在 2024/8/30 20:05, Yang Erkun 写道:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> Commit 3be5a52b30aa("fuse: support writable mmap") give a strict limit
>> for about 1% max dirty ratio for fuse to protect that fuse won't slow
>> down the hole system by hogging lots of dirty memory. It works well for
>> system without memcg. But now for system with memcg, since fuse does
>> not support writeback cgroup, this max dirty ratio won't work for the
>> memcg's max bytes.
>>
>> So it seems reasonable to enable writeback cgroup for fuse. Same commit
>> as above shows why we manage wb's count within fuse itself. In order to
>> support writeback cgroup, we need inode_to_wb to find the right wb,
>> and this needs some locks to pretect it. We now choose
>> inode->i_mapping->i_pages.xa_lock to do this.
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/fuse/file.c  | 33 ++++++++++++++++++++++++---------
>>   fs/fuse/inode.c |  3 ++-
>>   2 files changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index f39456c65ed7..4248eaf46c39 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1774,15 +1774,20 @@ static void fuse_writepage_finish(struct 
>> fuse_mount *fm,
>>   {
>>       struct fuse_args_pages *ap = &wpa->ia.ap;
>>       struct inode *inode = wpa->inode;
>> +    struct address_space *mapping = inode->i_mapping;
>>       struct fuse_inode *fi = get_fuse_inode(inode);
>> -    struct backing_dev_info *bdi = inode_to_bdi(inode);
>> +    struct bdi_writeback *wb;
>> +    unsigned long flags;
>>       int i;
>> +    xa_lock_irqsave(&mapping->i_pages, flags);
>> +    wb = inode_to_wb(inode);
>>       for (i = 0; i < ap->num_pages; i++) {
>> -        dec_wb_stat(&bdi->wb, WB_WRITEBACK);
>> +        dec_wb_stat(wb, WB_WRITEBACK);
>>           dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
>> -        wb_writeout_inc(&bdi->wb);
>> +        wb_writeout_inc(wb);
>>       }
>> +    xa_unlock_irqrestore(&mapping->i_pages, flags);
>>       wake_up(&fi->page_waitq);
>>   }
>> @@ -2084,8 +2089,10 @@ static int fuse_writepage_locked(struct folio 
>> *folio)
>>       ap->args.end = fuse_writepage_end;
>>       wpa->inode = inode;
>> -    inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
>> +    xa_lock(&mapping->i_pages);
>> +    inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
>>       node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
>> +    xa_unlock(&mapping->i_pages);
>>       spin_lock(&fi->lock);
>>       tree_insert(&fi->writepages, wpa);
>> @@ -2169,7 +2176,8 @@ static void fuse_writepages_send(struct 
>> fuse_fill_wb_data *data)
>>   static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
>>                      struct page *page)
>>   {
>> -    struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
>> +    struct inode *inode = new_wpa->inode;
>> +    struct fuse_inode *fi = get_fuse_inode(inode);
>>       struct fuse_writepage_args *tmp;
>>       struct fuse_writepage_args *old_wpa;
>>       struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
>> @@ -2204,11 +2212,15 @@ static bool fuse_writepage_add(struct 
>> fuse_writepage_args *new_wpa,
>>       spin_unlock(&fi->lock);
>>       if (tmp) {
>> -        struct backing_dev_info *bdi = inode_to_bdi(new_wpa->inode);
>> +        struct address_space *mapping = inode->i_mapping;
>> +        struct bdi_writeback *wb;
>> -        dec_wb_stat(&bdi->wb, WB_WRITEBACK);
>> +        xa_lock(&mapping->i_pages);
>> +        wb = inode_to_wb(new_wpa->inode);
>> +        dec_wb_stat(wb, WB_WRITEBACK);
>>           dec_node_page_state(new_ap->pages[0], NR_WRITEBACK_TEMP);
>> -        wb_writeout_inc(&bdi->wb);
>> +        wb_writeout_inc(wb);
>> +        xa_unlock(&mapping->i_pages);
>>           fuse_writepage_free(new_wpa);
>>       }
>> @@ -2256,6 +2268,7 @@ static int fuse_writepages_fill(struct folio 
>> *folio,
>>       struct fuse_writepage_args *wpa = data->wpa;
>>       struct fuse_args_pages *ap = &wpa->ia.ap;
>>       struct inode *inode = data->inode;
>> +    struct address_space *mapping = inode->i_mapping;
>>       struct fuse_inode *fi = get_fuse_inode(inode);
>>       struct fuse_conn *fc = get_fuse_conn(inode);
>>       struct page *tmp_page;
>> @@ -2319,8 +2332,10 @@ static int fuse_writepages_fill(struct folio 
>> *folio,
>>       ap->descs[ap->num_pages].length = PAGE_SIZE;
>>       data->orig_pages[ap->num_pages] = &folio->page;
>> -    inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
>> +    xa_lock(&mapping->i_pages);
>> +    inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
>>       inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
>> +    xa_unlock(&mapping->i_pages);
>>       err = 0;
>>       if (data->wpa) {
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index d8ab4e93916f..71d08f0a8514 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1566,7 +1566,8 @@ static void fuse_sb_defaults(struct super_block 
>> *sb)
>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>       sb->s_time_gran = 1;
>>       sb->s_export_op = &fuse_export_operations;
>> -    sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>> +    sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE |
>> +            SB_I_CGROUPWB;
>>       if (sb->s_user_ns != &init_user_ns)
>>           sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
>>       sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
> 
> 


