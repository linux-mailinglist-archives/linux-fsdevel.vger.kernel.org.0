Return-Path: <linux-fsdevel+bounces-72709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F3D00D1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 04:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165D73028DAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375E22C11C9;
	Thu,  8 Jan 2026 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a2FQcQjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EED29DB8F;
	Thu,  8 Jan 2026 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841832; cv=none; b=rxHYAtLfFjkPL+ZyPMNnBe2owD1O1fcNzu1ji4VmW27AHWy4KLSbEBrRoE4YLeMgEO3Vn8ig3GG1Va5wUK9mjR/ZsF9bIFyJpC5enNUb1quQU4ho/Y4RoTacRT1MzwczzTiHL8HogYe+FK99uJF+ePvDe3OAhbTQ02e5D1JbTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841832; c=relaxed/simple;
	bh=RymktlErUM1xQEApgkHf8BbON2yAwSVWacikZEpSCoc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VnDkv2RtOOMCgFYbcTWDy5xkcH70LrmYkTLAZtqZ8BygLo9eUqcEc0kkGsOuTJ2WN50UQ9WuCCSpA+ESqqmjNXhkHoy8tzHMAhU/xmuh3s/D6J96puCSjeZzkEyCotVkOzJ0/QH4wfrxcB890bG7x/Kcxm6xCJse1CCJDhNCQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a2FQcQjG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767841827; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=ilOtQUyo9M6rkHo3PeohnNfzFSbL+QX/DIj6x0rDyM0=;
	b=a2FQcQjGmpC75c69f3Gg94F32PdgvDuR2fyZzFMX2xl17T8JF5i29njTjWzxogdJuIq4vPilJ5GuIY243mS0tkpXE0HFGh49A08WCZGoG+fkG7MJNjiXF3KTKSnNQpzZF6MsKb+pkkW41sKGnnB0VNEOXTay4WT2/Lkt3aP3/iY=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwb7JBu_1767841826 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 11:10:26 +0800
Message-ID: <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
Date: Thu, 8 Jan 2026 11:10:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sheng Yong <shengyong2021@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>,
 shengyong1@xiaomi.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
 <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
In-Reply-To: <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/8 10:32, Gao Xiang wrote:
> Hi Sheng,
> 
> On 2026/1/8 10:26, Sheng Yong wrote:
>> On 1/7/26 01:05, Gao Xiang wrote:
>>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>>> stack overflow when stacking an unlimited number of EROFS on top of
>>> each other.
>>>
>>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>>> (and such setups are already used in production for quite a long time).
>>>
>>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>>> from 2 to 3, but proving that this is safe in general is a high bar.
>>>
>>> After a long discussion on GitHub issues [1] about possible solutions,
>>> one conclusion is that there is no need to support nesting file-backed
>>> EROFS mounts on stacked filesystems, because there is always the option
>>> to use loopback devices as a fallback.
>>>
>>> As a quick fix for the composefs regression for this cycle, instead of
>>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>>> nesting file-backed EROFS over EROFS and over filesystems with
>>> `s_stack_depth` > 0.
>>>
>>> This works for all known file-backed mount use cases (composefs,
>>> containerd, and Android APEX for some Android vendors), and the fix is
>>> self-contained.
>>>
>>> Essentially, we are allowing one extra unaccounted fs stacking level of
>>> EROFS below stacking filesystems, but EROFS can only be used in the read
>>> path (i.e. overlayfs lower layers), which typically has much lower stack
>>> usage than the write path.
>>>
>>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>>> stack usage analysis or using alternative approaches, such as splitting
>>> the `s_stack_depth` limitation according to different combinations of
>>> stacking.
>>>
>>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>>> Reported-by: Dusty Mabe <dusty@dustymabe.com>
>>> Reported-by: Timothée Ravier <tim@siosm.fr>
>>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>>> Cc: Alexander Larsson <alexl@redhat.com>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>> v2:
>>>   - Update commit message (suggested by Amir in 1-on-1 talk);
>>>   - Add proper `Reported-by:`.
>>>
>>>   fs/erofs/super.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index 937a215f626c..0cf41ed7ced8 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>            * fs contexts (including its own) due to self-controlled RO
>>>            * accesses/contexts and no side-effect changes that need to
>>>            * context save & restore so it can reuse the current thread
>>> -         * context.  However, it still needs to bump `s_stack_depth` to
>>> -         * avoid kernel stack overflow from nested filesystems.
>>> +         * context.
>>> +         * However, we still need to prevent kernel stack overflow due
>>> +         * to filesystem nesting: just ensure that s_stack_depth is 0
>>> +         * to disallow mounting EROFS on stacked filesystems.
>>> +         * Note: s_stack_depth is not incremented here for now, since
>>> +         * EROFS is the only fs supporting file-backed mounts for now.
>>> +         * It MUST change if another fs plans to support them, which
>>> +         * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>>>            */
>>>           if (erofs_is_fileio_mode(sbi)) {
>>> -            sb->s_stack_depth =
>>> -                file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
>>> -            if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
>>> -                erofs_err(sb, "maximum fs stacking depth exceeded");
>>> +            inode = file_inode(sbi->dif0.file);
>>> +            if (inode->i_sb->s_op == &erofs_sops ||
>>
>> Hi, Xiang
>>
>> In Android APEX scenario, apex images formatted as EROFS are packed in
>> system.img which is also EROFS format. As a result, it will always fail
>> to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
>> is true.
>> Any thoughts to handle such scenario?
> 
> Sorry, I forgot this popular case, I think it can be simply resolved
> by the following diff:
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0cf41ed7ced8..e93264034b5d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>                   */
>                  if (erofs_is_fileio_mode(sbi)) {
>                          inode = file_inode(sbi->dif0.file);
> -                       if (inode->i_sb->s_op == &erofs_sops ||
> +                       if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||

Sorry it should be `!inode->i_sb->s_bdev`, I've
fixed it in v3 RESEND:
https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang

>                              inode->i_sb->s_stack_depth) {
>                                  erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
>                                  return -ENOTBLK;
> 
> "!sb->s_bdev" covers file-backed EROFS mounts and
> (deprecated) fscache EROFS mounts, I will send v3 soon.
> 
> Thanks,
> Gao Xiang

