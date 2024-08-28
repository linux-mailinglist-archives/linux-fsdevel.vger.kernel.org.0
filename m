Return-Path: <linux-fsdevel+bounces-27480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99DC961B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1111C230AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5081B960;
	Wed, 28 Aug 2024 01:12:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FCBA4A;
	Wed, 28 Aug 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807577; cv=none; b=d9twP8SCH4J3/32okCSIx5SDCxbdVhf7vHOH1fmJSR0RhHKwM8OE76XrCmbZwKrwqPdjvrISM9nmXmNvkUZV82LiSx/BnXCfoY0YbdrNoP9BpVrfnZ6qYX9pueC48ulO6x8OpoLbvKuUsulEesNsb9eGa9CjcqX4R177XKuoPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807577; c=relaxed/simple;
	bh=1t9za/H/6QbifVxAphJ4cy2rzRE+Px9/KOcKIFrXipg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VSMkVoiolgD/++mJR89LSd7qISLHJI9fg1sXm2zafPv8ZencJ65HAGQkTqkJUopdme9BwHloAU6VT6XM3miIFKiKWIuRkZ27klnHEiSvAplyJ5Vb/cei9/BWp/T1wN7bgINd7zsJJaH1SwBj0BKX21AGWEKb2DDT+BUBLzXoiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wtmbm6bRSzyQxQ;
	Wed, 28 Aug 2024 09:12:20 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CF64414022E;
	Wed, 28 Aug 2024 09:12:50 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 09:12:50 +0800
Message-ID: <86e1541f-0d8b-4479-b8d1-bb5a9f5849d4@huawei.com>
Date: Wed, 28 Aug 2024 09:12:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] nilfs2: support STATX_DIOALIGN for statx file
Content-Language: en-US
To: <ebiggers@google.com>, Christian Brauner <brauner@kernel.org>,
	<hch@lst.de>
CC: <linux-nilfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>
References: <20240827015152.222983-1-lihongbo22@huawei.com>
 <CAKFNMomMtJbEbZNRAzari3koP1eRHOrUDQ=rAxDbL6yfHHG=gg@mail.gmail.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CAKFNMomMtJbEbZNRAzari3koP1eRHOrUDQ=rAxDbL6yfHHG=gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/28 2:15, Ryusuke Konishi wrote:
> Hi Hongbo,
> 
> Thanks for the suggestion.
> 
> I checked the STATX_DIOALIGN specification while looking at the
> implementation of other file systems, and I thought that if DIO
> support is incomplete, the dio_xx_align member should be set to 0.
> 
> Due to the nature of NILFS2 as a log-structured file system, DIO
> writes fall back to buffered io.  (DIO reads are supported)
> 
That's really a question. How to handle the asymmetric situation of 
O_DIRECT read and write?

The STATX_DIOALIGN specification does not define this case.

Thanks,
Hongbo

> This is similar to the journal data mode of ext4 and the blkzoned
> device support of f2fs, but in such case, these file systems return a
> value of 0 (direct I/O not supported).
> 
> So, it's fine to respond to a STATX_DIOALIGN request, but I think the
> value of dio_xx_align should be set to 0 to match these file systems.
> 
> In this sense, there may be no need to rush to support STATX_DIOALIGN
> now.  Do you still think it would be better to have it?
> 
> The following are some minor comments:
> 
> On Tue, Aug 27, 2024 at 10:58 AM Hongbo Li wrote:
>>
>> Add support for STATX_DIOALIGN to nilfs2, so that direct I/O alignment
>> restrictions are exposed to userspace in a generic way.
>>
>> By default, nilfs2 uses the default getattr implemented at vfs layer,
>> so we should implement getattr in nilfs2 to fill the dio_xx_align
>> members. The nilfs2 does not have the special align requirements. So
>> we use the default alignment setting from block layer.
>> We have done the following test:
>>
>> [Before]
>> ```
>> ./statx_test /mnt/nilfs2/test
>> statx(/mnt/nilfs2/test) = 0
>> dio mem align:0
>> dio offset align:0
>> ```
>>
>> [After]
>> ```
>> ./statx_test /mnt/nilfs2/test
>> statx(/mnt/nilfs2/test) = 0
>> dio mem align:512
>> dio offset align:512
>> ```
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/nilfs2/file.c  |  1 +
>>   fs/nilfs2/inode.c | 20 ++++++++++++++++++++
>>   fs/nilfs2/namei.c |  2 ++
>>   fs/nilfs2/nilfs.h |  2 ++
>>   4 files changed, 25 insertions(+)
>>
>> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
>> index 0e3fc5ba33c7..5528918d4b96 100644
>> --- a/fs/nilfs2/file.c
>> +++ b/fs/nilfs2/file.c
>> @@ -154,6 +154,7 @@ const struct file_operations nilfs_file_operations = {
>>
>>   const struct inode_operations nilfs_file_inode_operations = {
>>          .setattr        = nilfs_setattr,
>> +       .getattr        = nilfs_getattr,
>>          .permission     = nilfs_permission,
>>          .fiemap         = nilfs_fiemap,
>>          .fileattr_get   = nilfs_fileattr_get,
>> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
>> index 7340a01d80e1..b5bb2c2de32c 100644
>> --- a/fs/nilfs2/inode.c
>> +++ b/fs/nilfs2/inode.c
>> @@ -1001,6 +1001,26 @@ int nilfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>          return err;
>>   }
>>
>> +int nilfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>> +                       struct kstat *stat, u32 request_mask, unsigned int query_flags)
>> +{
>> +       struct inode *const inode = d_inode(path->dentry);
>> +       struct block_device *bdev = inode->i_sb->s_bdev;
>> +       unsigned int blksize = (1 << inode->i_blkbits);
>> +
>> +       if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>> +               stat->result_mask |= STATX_DIOALIGN;
>> +
> 
>> +               if (bdev)
>> +                       blksize = bdev_logical_block_size(bdev);
> 
> I don't think there's any need to check that bdev is NULL, but is
> there a reason?
> 
> If sb->s_bdev can be NULL, I think that for such devices, a NULL
> pointer dereference bug will occur in the mount path.
> That's why I was concerned about this.
> 
>> +               stat->dio_mem_align = blksize;
>> +               stat->dio_offset_align = blksize;
>> +       }
>> +
>> +       generic_fillattr(idmap, request_mask, inode, stat);
>> +       return 0;
>> +}
>> +
>>   int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
>>                       int mask)
>>   {
>> diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
>> index c950139db6ef..ad56f4f8be1f 100644
>> --- a/fs/nilfs2/namei.c
>> +++ b/fs/nilfs2/namei.c
>> @@ -546,6 +546,7 @@ const struct inode_operations nilfs_dir_inode_operations = {
>>          .mknod          = nilfs_mknod,
>>          .rename         = nilfs_rename,
>>          .setattr        = nilfs_setattr,
>> +       .getattr        = nilfs_getattr,
> 
> In the case of directories, the STATX_DIOALIGN request is ignored, so
> I don't think this is necessary for now. (It can be added in the
> future when supporting other optional getattr requests/responses).
> 
>>          .permission     = nilfs_permission,
>>          .fiemap         = nilfs_fiemap,
>>          .fileattr_get   = nilfs_fileattr_get,
>> @@ -554,6 +555,7 @@ const struct inode_operations nilfs_dir_inode_operations = {
>>
>>   const struct inode_operations nilfs_special_inode_operations = {
>>          .setattr        = nilfs_setattr,
>> +       .getattr        = nilfs_getattr,
>>          .permission     = nilfs_permission,
>>   };
> 
> Ditto.
> 
>>
>> diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
>> index 4017f7856440..98a8b28ca1db 100644
>> --- a/fs/nilfs2/nilfs.h
>> +++ b/fs/nilfs2/nilfs.h
>> @@ -280,6 +280,8 @@ extern void nilfs_truncate(struct inode *);
>>   extern void nilfs_evict_inode(struct inode *);
>>   extern int nilfs_setattr(struct mnt_idmap *, struct dentry *,
>>                           struct iattr *);
>> +extern int nilfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>> +                       struct kstat *stat, u32 request_mask, unsigned int query_flags);
> 
> Do not add the "extern" directive to new function declarations.
> We are moving towards eliminating the extern declarator from function
> declarations whenever possible.
> 
>>   extern void nilfs_write_failed(struct address_space *mapping, loff_t to);
>>   int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
>>                       int mask);
>> --
>> 2.34.1
>>
> 
> That's all for my comments.
> 
> Thanks,
> Ryusuke Konishi

