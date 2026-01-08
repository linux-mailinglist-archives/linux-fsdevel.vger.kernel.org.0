Return-Path: <linux-fsdevel+bounces-72803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F48D03F01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1958F34561BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D73358D2;
	Thu,  8 Jan 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mw7NzIn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055033556D;
	Thu,  8 Jan 2026 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861295; cv=none; b=RPID0/tgDDnsI59nmYe/83FGM53UkKqLocT4QTP0i0js9rYp+r/XsatwtSS2eEPCZ1fUBR4nEZENrSV1e+kxK+pueWpnbLRPqPGLzxS3s9fnZdNP2q3H80XhTPi7N2nxDW1W6JcjE7rIEaRkA9WOBPD9Kjlx1kwfvtXPy4F4HLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861295; c=relaxed/simple;
	bh=dDPss0BIg0eDm14FmeWPg9Ec6fY90H8yR8w+v9Aj/a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz/GJ1HezMR5Hk9o8/mRrFyvoeQbACIcl9Su7nTs5+zHoqrwqUKr6H0Qv1WmFF3lKuKjRJgBgRIlXZ1rP8BcXBnXE9gILLWs4rJ/sN1gJ7YvXCDddFieZdZN2Bu2CNeQmWo1AY+kN1NbJ6b2+bpBpLapUlL58vzmen4nisNWJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mw7NzIn5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767861278; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JkY3oC0eOHfcTpAG17pfNlixKjvrWkpS4f3clKIGIaM=;
	b=Mw7NzIn5bXiP5+hrDt+pB4JSMPbsrNwJMpXPIog4vnZUoP90jM0aFS6MnNGcqi1f3i6JOVXzTHSjgWHOYQiA/cbs/N3S/VpifJZmFchKtag9f47KSa8LAUU7VbKAJRTGyu+QmNn+d7EpYb8WCW8itls64JBQGcEeM3z5Vqm8UUc=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwc.SPm_1767861275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 16:34:37 +0800
Message-ID: <b1296059-0bc6-49eb-ae6c-15d60c7a8b89@linux.alibaba.com>
Date: Thu, 8 Jan 2026 16:34:35 +0800
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
 <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
 <CAOQ4uxgcbauFza8ZsZebhTZJT-zwfydy2ofWOw-hqJbVRF+GCg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxgcbauFza8ZsZebhTZJT-zwfydy2ofWOw-hqJbVRF+GCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/8 16:24, Amir Goldstein wrote:
> On Thu, Jan 8, 2026 at 9:05 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
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
> Your fs, your decision.
> 
> But what are you actually saying?
> Are you saying that reading from file backed fscache has similar
> stack usage to reading from file backed erofs?

Nope, I just don't want to be bothered with fscache in any
cases since it's already deprecated, IOWs I don't want such
setup works:
  erofs (file-backed) + erofs(fscache) + ...

I just want to allow
  erofs(APEX) + erofs(bdev) + ...

cases since Android users use it

in addition to
  ovl^2 + erofs + ext4 / xfs /... (composefs, containerd and ...)

Does that make sense?

> Isn't filecache doing async file IO?

But as I said, AIO is not a must, it can still
fallback to sync I/Os.

> 
> If we regard fscache an extra unaccounted layer, because of all the
> sync operations that it does, then we already allowed this setup a long
> time ago, e.g. fscache+nfs+ovl^2.
> 
> This could be an argument to support the claim that stack usage of
> file+erofs+ovl^2 should also be fine.

Anyway, I'm not sure how many users really use that so
I won't speak of that.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


