Return-Path: <linux-fsdevel+bounces-34380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF19C4D77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF861F22D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D28208208;
	Tue, 12 Nov 2024 03:44:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467519CC29;
	Tue, 12 Nov 2024 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731383048; cv=none; b=jzu9PLIi0zs2sc3GRRmQzEuK79yrzGXpgvh70IAFwDHFPfJ2SrxhxDzdy6VMBTJaQRiNVI+5wT00OPXPSei4hc3mqVWx3ab8GBm9L4BthJw8WZI5QOAT5A0SAb/PZF59JlCLeg9RK7CEM+b2hQSoCvZn60wsNL2A9h9fEe8P8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731383048; c=relaxed/simple;
	bh=ruY/EJqxhlXRsPF9HXdZIc+Z0H3EP9D6qVw/aLKKdhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2v1YDVscoYxxyHyS19Ze9CjcQOMUTqs2YMUsMC/Qz5MxIu4P6pxNgd9Exhlwd9R4mgMO2XLNsjfBs8/cDJnuU0I1tlkgtJGPDJlNctPlAGVvnNivAMqCDrWFV732LY5Y8N9tgGZS8nyqrs9wq3aw0THPxnPaShZhZVgEu+PsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XnXMK2VYnz4f3lY5;
	Tue, 12 Nov 2024 11:43:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 703091A0197;
	Tue, 12 Nov 2024 11:43:54 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4f1zjJnFXosBg--.43366S3;
	Tue, 12 Nov 2024 11:43:51 +0800 (CST)
Message-ID: <dd6bd7f5-cf2e-3123-3017-c209d81ab290@huaweicloud.com>
Date: Tue, 12 Nov 2024 11:43:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Chuck Lever <cel@kernel.org>,
 linux-stable <stable@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
 "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
 <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
 <96A93064-8DCE-4B78-9F2A-CF6E7EEABEB1@oracle.com>
 <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
 <09F40EA2-9537-4C7A-A221-AA403ED3FF64@oracle.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <09F40EA2-9537-4C7A-A221-AA403ED3FF64@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4f1zjJnFXosBg--.43366S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15WFykJF4xXw48KFWUCFg_yoW3KFW7pr
	W5Jan0krs7Xw1UGr4vq3WDZrySv3Z7Kr18Xrn5W34UJryqvr13KF1xAr1Y9a48Ar1kCr12
	qF45t343ur1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRJMa0UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/11/11 23:34, Chuck Lever III 写道:
> 
> 
>> On Nov 11, 2024, at 10:20 AM, yangerkun <yangerkun@huaweicloud.com> wrote:
>>
>>
>>
>> 在 2024/11/11 22:39, Chuck Lever III 写道:
>>>> On Nov 10, 2024, at 9:36 PM, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2024/11/11 8:52, cel@kernel.org 写道:
>>>>> From: yangerkun <yangerkun@huawei.com>
>>>>> [ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]
>>>>> After we switch tmpfs dir operations from simple_dir_operations to
>>>>> simple_offset_dir_operations, every rename happened will fill new dentry
>>>>> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
>>>>> key starting with octx->newx_offset, and then set newx_offset equals to
>>>>> free key + 1. This will lead to infinite readdir combine with rename
>>>>> happened at the same time, which fail generic/736 in xfstests(detail show
>>>>> as below).
>>>>> 1. create 5000 files(1 2 3...) under one dir
>>>>> 2. call readdir(man 3 readdir) once, and get one entry
>>>>> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
>>>>> 4. loop 2~3, until readdir return nothing or we loop too many
>>>>>     times(tmpfs break test with the second condition)
>>>>> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
>>>>> directory reads") to fix it, record the last_index when we open dir, and
>>>>> do not emit the entry which index >= last_index. The file->private_data
>>>>
>>>> Please notice this requires last_index should never overflow, otherwise
>>>> readdir will be messed up.
>>> It would help your cause if you could be more specific
>>> than "messed up".
>>>>> now used in offset dir can use directly to do this, and we also update
>>>>> the last_index when we llseek the dir file.
>>>>> Fixes: a2e459555c5f ("shmem: stable directory offsets")
>>>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>>>> Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
>>>>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> [brauner: only update last_index after seek when offset is zero like Jan suggested]
>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>>> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>> [ cel: adjusted to apply to origin/linux-6.6.y ]
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> ---
>>>>>   fs/libfs.c | 37 +++++++++++++++++++++++++------------
>>>>>   1 file changed, 25 insertions(+), 12 deletions(-)
>>>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>>>> index a87005c89534..b59ff0dfea1f 100644
>>>>> --- a/fs/libfs.c
>>>>> +++ b/fs/libfs.c
>>>>> @@ -449,6 +449,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
>>>>>    xa_destroy(&octx->xa);
>>>>>   }
>>>>>   +static int offset_dir_open(struct inode *inode, struct file *file)
>>>>> +{
>>>>> + struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
>>>>> +
>>>>> + file->private_data = (void *)ctx->next_offset;
>>>>> + return 0;
>>>>> +}
>>>>
>>>> Looks like xarray is still used.
>>> That's not going to change, as several folks have already
>>> explained.
>>>> I'm in the cc list ,so I assume you saw my set, then I don't know why
>>>> you're ignoring my concerns.
>>>> 1) next_offset is 32-bit and can overflow in a long-time running
>>>> machine.
>>>> 2) Once next_offset overflows, readdir will skip the files that offset
>>>> is bigger.
>>
>> I'm sorry, I'm a little busy these days, so I haven't responded to this
>> series of emails.
>>
>>> In that case, that entry won't be visible via getdents(3)
>>> until the directory is re-opened or the process does an
>>> lseek(fd, 0, SEEK_SET).
>>
>> Yes.
>>
>>> That is the proper and expected behavior. I suspect you
>>> will see exactly that behavior with ext4 and 32-bit
>>> directory offsets, for example.
>>
>> Emm...
>>
>> For this case like this:
>>
>> 1. mkdir /tmp/dir and touch /tmp/dir/file1 /tmp/dir/file2
>> 2. open /tmp/dir with fd1
>> 3. readdir and get /tmp/dir/file1
>> 4. rm /tmp/dir/file2
>> 5. touch /tmp/dir/file2
>> 4. loop 4~5 for 2^32 times
>> 5. readdir /tmp/dir with fd1
>>
>> For tmpfs now, we may see no /tmp/dir/file2, since the offset has been overflow, for ext4 it is ok... So we think this will be a problem.
>>
>>> Does that not directly address your concern? Or do you
>>> mean that Erkun's patch introduces a new issue?
>>
>> Yes, to be honest, my personal feeling is a problem. But for 64bit, it may never been trigger.
> 
> Thanks for confirming.
> 
> In that case, the preferred way to handle it is to fix
> the issue in upstream, and then backport that fix to LTS.
> Dependence on 64-bit offsets to avoid a failure case
> should be considered a workaround, not a real fix, IMHO.

Yes.

> 
> Do you have a few moments to address it, or if not I
> will see to it.

You can try to do this, for the reason I am quite busy now until end of 
this month... Sorry.

> 
> I think reducing the xa_limit in simple_offset_add() to,
> say, 2..16 would make the reproducer fire almost
> immediately.

Yes.

> 
> 
>>> If there is a problem here, please construct a reproducer
>>> against this patch set and post it.
>>>> Thanks,
>>>> Kuai
>>>>
>>>>> +
>>>>>   /**
>>>>>    * offset_dir_llseek - Advance the read position of a directory descriptor
>>>>>    * @file: an open directory whose position is to be updated
>>>>> @@ -462,6 +470,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
>>>>>    */
>>>>>   static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>>>>>   {
>>>>> + struct inode *inode = file->f_inode;
>>>>> + struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
>>>>> +
>>>>>    switch (whence) {
>>>>>    case SEEK_CUR:
>>>>>    offset += file->f_pos;
>>>>> @@ -475,8 +486,9 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>>>>>    }
>>>>>      /* In this case, ->private_data is protected by f_pos_lock */
>>>>> - file->private_data = NULL;
>>>>> - return vfs_setpos(file, offset, U32_MAX);
>>>>> + if (!offset)
>>>>> + file->private_data = (void *)ctx->next_offset;
>>>>> + return vfs_setpos(file, offset, LONG_MAX);
>>>>>   }
>>>>>     static struct dentry *offset_find_next(struct xa_state *xas)
>>>>> @@ -505,7 +517,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>>>>>      inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>>>   }
>>>>>   -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>>>> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
>>>>>   {
>>>>>    struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
>>>>>    XA_STATE(xas, &so_ctx->xa, ctx->pos);
>>>>> @@ -514,17 +526,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>>>>    while (true) {
>>>>>    dentry = offset_find_next(&xas);
>>>>>    if (!dentry)
>>>>> - return ERR_PTR(-ENOENT);
>>>>> + return;
>>>>> +
>>>>> + if (dentry2offset(dentry) >= last_index) {
>>>>> + dput(dentry);
>>>>> + return;
>>>>> + }
>>>>>      if (!offset_dir_emit(ctx, dentry)) {
>>>>>    dput(dentry);
>>>>> - break;
>>>>> + return;
>>>>>    }
>>>>>      dput(dentry);
>>>>>    ctx->pos = xas.xa_index + 1;
>>>>>    }
>>>>> - return NULL;
>>>>>   }
>>>>>     /**
>>>>> @@ -551,22 +567,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>>>>   static int offset_readdir(struct file *file, struct dir_context *ctx)
>>>>>   {
>>>>>    struct dentry *dir = file->f_path.dentry;
>>>>> + long last_index = (long)file->private_data;
>>>>>      lockdep_assert_held(&d_inode(dir)->i_rwsem);
>>>>>      if (!dir_emit_dots(file, ctx))
>>>>>    return 0;
>>>>>   - /* In this case, ->private_data is protected by f_pos_lock */
>>>>> - if (ctx->pos == DIR_OFFSET_MIN)
>>>>> - file->private_data = NULL;
>>>>> - else if (file->private_data == ERR_PTR(-ENOENT))
>>>>> - return 0;
>>>>> - file->private_data = offset_iterate_dir(d_inode(dir), ctx);
>>>>> + offset_iterate_dir(d_inode(dir), ctx, last_index);
>>>>>    return 0;
>>>>>   }
>>>>>     const struct file_operations simple_offset_dir_operations = {
>>>>> + .open = offset_dir_open,
>>>>>    .llseek = offset_dir_llseek,
>>>>>    .iterate_shared = offset_readdir,
>>>>>    .read = generic_read_dir,
>>> --
>>> Chuck Lever
> 
> 
> --
> Chuck Lever
> 
> 


