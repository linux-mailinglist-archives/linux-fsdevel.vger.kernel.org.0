Return-Path: <linux-fsdevel+bounces-72801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E707DD03F55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D6234D413B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AF39901A;
	Thu,  8 Jan 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dJq58d3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B937C0F8;
	Thu,  8 Jan 2026 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859528; cv=none; b=A0NOAT0V+tqKL7mEagf/g2dz8qnQ6/EQSH+gXx++NctOUTTLUOELbij7wpfW9Ptj3uFoIiMO4O7MM8mN9Sld8Q6rcceDdMv3G0OWI/v+W4H7+s6xr1LwXTjo9+HlyArw3F04gaxcr4tXQoJu4Lb48Yq2hEjSMTMwK51Q2H4w46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859528; c=relaxed/simple;
	bh=rG7z64/iSTYrgxodpHNxu0gxdKmj8c7rgjUvPUXrV+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O94fyqIggjX4If+js7OqcsLQL4wcml/3/vxEXIhI9gXDVGql9NXOZRGBHjz1wISHG2k5SqjobT/nGRf23NvQm+qRTad4n9a/SiSyLSqxdOHo3x0YzG8tGcc//cFqSg0YNcdl7AsKUWVefLFMag1xZmKokKK6bybPGnEXkgp61WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dJq58d3/; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767859505; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CHryCxdnsqo2fHXKwdwy6HGEwzhP78fiP+irxJgS+DE=;
	b=dJq58d3/YXUFSQLZby5MhEFkMX9KGup1wtLUaYpQUxqGH4cg7rTP1A+PZT89tefxWfLP8YRqYX+Ryt/Lm4Tmvyy0tqQVcy2bPn2kvFHiGQ92VOmnG40S/uXkReQzu3NjMtsIYUBxQbeRivTWqjzJxOdQ5OuYlrft7Ohdx1zfcNU=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwbyGqs_1767859503 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 16:05:05 +0800
Message-ID: <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
Date: Thu, 8 Jan 2026 16:05:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>,
 =?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>,
 =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Alexander Larsson <alexl@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 Zhiguo Niu <niuzhiguo84@gmail.com>, shengyong1@xiaomi.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
 <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
 <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
 <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,

On 2026/1/8 16:02, Amir Goldstein wrote:
> On Thu, Jan 8, 2026 at 4:10 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

>>>>
>>>> Hi, Xiang
>>>>
>>>> In Android APEX scenario, apex images formatted as EROFS are packed in
>>>> system.img which is also EROFS format. As a result, it will always fail
>>>> to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
>>>> is true.
>>>> Any thoughts to handle such scenario?
>>>
>>> Sorry, I forgot this popular case, I think it can be simply resolved
>>> by the following diff:
>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index 0cf41ed7ced8..e93264034b5d 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>                    */
>>>                   if (erofs_is_fileio_mode(sbi)) {
>>>                           inode = file_inode(sbi->dif0.file);
>>> -                       if (inode->i_sb->s_op == &erofs_sops ||
>>> +                       if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
>>
>> Sorry it should be `!inode->i_sb->s_bdev`, I've
>> fixed it in v3 RESEND:
> 
> A RESEND implies no changes since v3, so this is bad practice.
> 
>> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibaba.com
>>
> 
> Ouch! If the erofs maintainer got this condition wrong... twice...
> Maybe better using the helper instead of open coding this non trivial check?
> 
> if ((inode->i_sb->s_op == &erofs_sops &&
>        erofs_is_fileio_mode(EROFS_I_SB(inode)))

I was thought to use that, but it excludes fscache as the
backing fs.. so I suggest to use !s_bdev directly to
cover both file-backed mounts and fscache cases directly.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


