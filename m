Return-Path: <linux-fsdevel+bounces-72810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B42D041C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4288C303B466
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A9350A3C;
	Thu,  8 Jan 2026 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E5DfGP1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54103587A0;
	Thu,  8 Jan 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864711; cv=none; b=QVNsVuoIiDbH0HcQd126rEDry+3aytinz/Uy8J3vg+lq93r2vPHsQNV+hnqWR3dhaDyyUo3yPu+JqQiJpc9pohPDZCYIuAG/JqsTYYKZtq1pkmjNVhdav/MYM3hcQgCWp1Mh56nS9jQGuCjJ5UQjhKDQ2XZlfgcnDtOHwVUczmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864711; c=relaxed/simple;
	bh=fxgDOrDHdxqUOe7bBTFXSZEfkUCLDjOLa7/YHi+rGG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAslAnzaTNspI5GA3uRVOiPNeaDoMsnm6OFUuE7uwR1db4JjUBRHcbfg2ViGch0qZbQDY3jd4lDZofvvEQ3Z7RWxOynbAVMMFl/fsM4ArQNBXFOEEQKbZph4uYDoTBAybfkb4rDbrAHMhfMrxW2J0KADrjz+dYic8+nunm/Mri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E5DfGP1L; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767864701; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e8PS9uOvkWCdWHFIecWXheJ0mUjj4ZF8NqftcmWhWH8=;
	b=E5DfGP1L2QGMUBGKyuRDN3invCkyN4aejzN2g3fxrMT5plnHiQXkheYB/HSTrMKeHJMD0VvVAhVswqsIHhy+FLscI/kst0l6iKbFdE80cM6CR4v3+vAnTyFkzY7Dnly+zbLSjczRdIP9VSaZ6OgL3tAQSBtC4QQjOX7Vp7LEWCw=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwc9TIX_1767864696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 17:31:41 +0800
Message-ID: <a8bc6938-84d9-42d6-9928-7cdd13e3a4c8@linux.alibaba.com>
Date: Thu, 8 Jan 2026 17:31:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Sheng Yong <shengyong1@xiaomi.com>
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
 <CAHJ8P3LMqKYZjmMdSWyKv5EQvWvvycfidJiTi02UUBoEhgtXzQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHJ8P3LMqKYZjmMdSWyKv5EQvWvvycfidJiTi02UUBoEhgtXzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/8 17:28, Zhiguo Niu wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> 于2026年1月8日周四 11:07写道：
>>
>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>> stack overflow when stacking an unlimited number of EROFS on top of
>> each other.
>>
>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>> (and such setups are already used in production for quite a long time).
>>
>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>> from 2 to 3, but proving that this is safe in general is a high bar.
>>
>> After a long discussion on GitHub issues [1] about possible solutions,
>> one conclusion is that there is no need to support nesting file-backed
>> EROFS mounts on stacked filesystems, because there is always the option
>> to use loopback devices as a fallback.
>>
>> As a quick fix for the composefs regression for this cycle, instead of
>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>> nesting file-backed EROFS over EROFS and over filesystems with
>> `s_stack_depth` > 0.
>>
>> This works for all known file-backed mount use cases (composefs,
>> containerd, and Android APEX for some Android vendors), and the fix is
>> self-contained.
>>
>> Essentially, we are allowing one extra unaccounted fs stacking level of
>> EROFS below stacking filesystems, but EROFS can only be used in the read
>> path (i.e. overlayfs lower layers), which typically has much lower stack
>> usage than the write path.
>>
>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>> stack usage analysis or using alternative approaches, such as splitting
>> the `s_stack_depth` limitation according to different combinations of
>> stacking.
>>
>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
>> Reported-by: Timothée Ravier <tim@siosm.fr>
>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>> Acked-by: Alexander Larsson <alexl@redhat.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2->v3 RESEND:
>>   - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
>>     as pointed out by Sheng Yong (APEX will rely on this);
>>
>>   - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.
>>
>>   fs/erofs/super.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 937a215f626c..5136cda5972a 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>                   * fs contexts (including its own) due to self-controlled RO
>>                   * accesses/contexts and no side-effect changes that need to
>>                   * context save & restore so it can reuse the current thread
>> -                * context.  However, it still needs to bump `s_stack_depth` to
>> -                * avoid kernel stack overflow from nested filesystems.
>> +                * context.
>> +                * However, we still need to prevent kernel stack overflow due
>> +                * to filesystem nesting: just ensure that s_stack_depth is 0
>> +                * to disallow mounting EROFS on stacked filesystems.
>> +                * Note: s_stack_depth is not incremented here for now, since
>> +                * EROFS is the only fs supporting file-backed mounts for now.
>> +                * It MUST change if another fs plans to support them, which
>> +                * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>>                   */
>>                  if (erofs_is_fileio_mode(sbi)) {
>> -                       sb->s_stack_depth =
>> -                               file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
>> -                       if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
>> -                               erofs_err(sb, "maximum fs stacking depth exceeded");
>> +                       inode = file_inode(sbi->dif0.file);
>> +                       if ((inode->i_sb->s_op == &erofs_sops &&
>> +                            !inode->i_sb->s_bdev) ||
>> +                           inode->i_sb->s_stack_depth) {
>> +                               erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
> Hi Xiang
> Do we need to print s_stack_depth here to distinguish which specific
> problem case it is?

.. I don't want to complex it (since it's just a short-term
solution and erofs is unaccounted so s_stack_depth really
mean nothing) unless it's really needed for Android vendors?

> Other LGTM based on my basic test. so
> 
> Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Thanks for this too.

Thanks,
Gao Xiang

> Thanks！
>>                                  return -ENOTBLK;
>>                          }
>>                  }
>> --
>> 2.43.5
>>


