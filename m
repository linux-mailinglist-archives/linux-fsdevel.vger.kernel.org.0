Return-Path: <linux-fsdevel+bounces-72828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7CD0407B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7AE3366416
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331494A1E0F;
	Thu,  8 Jan 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SJQrSbfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E114A13B4;
	Thu,  8 Jan 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875423; cv=none; b=bPdZeG5JyskgYh4982hZUKkYxNFdebn5/MVD1xtcrm+hjz/+MLRliFOcEffJNm8uAEAMXALwubY4BMmElkZ9NGO1l31OakqOhtt+A2vI21B+U0bYi0DmKLR7xiRvuqjnzpRVtzx8nicYS+BvoiaY1X2RyQEXVQfHBjNsB7dAkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875423; c=relaxed/simple;
	bh=PDWGfM6AM5zDc25RQ3HzUfskP6TEqUl6Px2sU7J5cos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3c7r0U2guw174iRFE5S70JZc2RdzTh7mgOFIHstDH7np9L447ngJRSLYaqQMiDxMFq0azIXkgT15aD1k506rB7xMSwJsTXR86icFUbt3PafFijXSOfH16paxCUuiKIvnjMAUAjsUWizuqE+cqiHYblhMqK5bL4imVPGY7cdPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SJQrSbfl; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767875411; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rpTnL+IU5xSnUkIXNyhmHEj7xuQTvMOaA3Ro0rIO+c8=;
	b=SJQrSbflQafUyBDi15TKZwsizGEmmyJWv0K0zCdLFU8DhDFYnsk1/PynsUtCfjaBeptwoEjCFc3U1MlBiTaCJvtnCgamA60xTPRIC95aLLNXMExLWH30yHOchXuFVemzn1RiViens6xQPIcwk6wyJJJLN7B8XiZQXLejIFuA+S8=
Received: from 30.251.32.236(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwcgDrv_1767875409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 20:30:10 +0800
Message-ID: <c805ff35-654f-44e2-92ce-0e2c367ac377@linux.alibaba.com>
Date: Thu, 8 Jan 2026 20:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: David Laight <david.laight.linux@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Sheng Yong
 <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
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
 <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
 <20260108102613.33bbc6d4@pumpkin>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260108102613.33bbc6d4@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2026/1/8 18:26, David Laight wrote:
> On Thu, 8 Jan 2026 16:05:03 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> Hi Amir,
>>
>> On 2026/1/8 16:02, Amir Goldstein wrote:
>>> On Thu, Jan 8, 2026 at 4:10 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> ...
>>
>>>>>>
>>>>>> Hi, Xiang
>>>>>>
>>>>>> In Android APEX scenario, apex images formatted as EROFS are packed in
>>>>>> system.img which is also EROFS format. As a result, it will always fail
>>>>>> to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
>>>>>> is true.
>>>>>> Any thoughts to handle such scenario?
>>>>>
>>>>> Sorry, I forgot this popular case, I think it can be simply resolved
>>>>> by the following diff:
>>>>>
>>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>>> index 0cf41ed7ced8..e93264034b5d 100644
>>>>> --- a/fs/erofs/super.c
>>>>> +++ b/fs/erofs/super.c
>>>>> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>>                     */
>>>>>                    if (erofs_is_fileio_mode(sbi)) {
>>>>>                            inode = file_inode(sbi->dif0.file);
>>>>> -                       if (inode->i_sb->s_op == &erofs_sops ||
>>>>> +                       if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
>>>>
>>>> Sorry it should be `!inode->i_sb->s_bdev`, I've
>>>> fixed it in v3 RESEND:
>>>
>>> A RESEND implies no changes since v3, so this is bad practice.
>>>    
>>>> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibaba.com
>>>>   
>>>
>>> Ouch! If the erofs maintainer got this condition wrong... twice...
>>> Maybe better using the helper instead of open coding this non trivial check?
>>>
>>> if ((inode->i_sb->s_op == &erofs_sops &&
>>>         erofs_is_fileio_mode(EROFS_I_SB(inode)))
>>
>> I was thought to use that, but it excludes fscache as the
>> backing fs.. so I suggest to use !s_bdev directly to
>> cover both file-backed mounts and fscache cases directly.
> 
> Is it worth just allocating each fs a 'stack needed' value and then
> allowing the mount if the total is low enough.
> This is equivalent to counting the recursion depth, but lets erofs only
> add (say) 0.5.
> Ideally you'd want to do static analysis to find the value to add,
> but 'inspired guesswork' is probably good enough.

That is a good alternative way but I could also use some
realistic issue such as how to evaluate stack usage under
the block layer.

And the rule exposing to userspace becomes complex if we
do in such way.

> 
> Isn't there also a big difference between recursive mounts (which need
> to do read/write on the underlying file) and overlay mounts (which just
> pass the request onto the lower filesystem).

As for EROFS, we only care read since it's safe enough
but I won't speak of write paths (like sb_writers and
journal nesting for example, and I don't want to spread
the discussion since it's much unrelated to the topic).

I agree but as I said above, it makes the rule more
complex and users have no idea when it can mount and
when it cannot mount.

Anyway, I think for the current 16k kernel stack,
FILESYSTEM_MAX_STACK_DEPTH = 3 is safe enough to provide
an abundant margin for the underlay storage stack.
I have no idea how to prove it strictly but I think it's
roughly provable to show the stack usages when reaching
the real backing fs (e.g. the remaining stack size when
reaching the real backing fs) and
FILESYSTEM_MAX_STACK_DEPTH 2 was an arbitary one too.

Thanks,
Gao Xiang

> 
> 	David
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Amir.
>>
>>


