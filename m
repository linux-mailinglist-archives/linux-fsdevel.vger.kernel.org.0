Return-Path: <linux-fsdevel+bounces-30146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B4986F4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E561F21A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0B1A76D7;
	Thu, 26 Sep 2024 08:50:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862E1A4E9A;
	Thu, 26 Sep 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340648; cv=none; b=L9QHTAGLQvO9EmasCrLj/PbvZKC0hkiOV4ukxRA963+ZrHiAG4srIvmFmYg+DUX40mtYtgGB1KdFW0egAF2LeOQQ8dhXDbIeVGpqEH6q9hlvTSfFyw06D7v2hhxqNPyOQkIL6X3oVxeVLGOC76tV8W3BWNxdAA5gy6sy/wGORjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340648; c=relaxed/simple;
	bh=JMPDumpRjcYG80x8wTNbelHGSUF2apdzW2w1r/QDfU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HFiyASG86BQP8v2rsdzc6iwK6acekiDIKXdJI/6evtNerUEnFaaQcsriXwj7IAF9Jd8J8/i/DVMva1lVcWL6QFj/CbZ3+1XsX8E/WBmUyAZlRKsGrWaL5IKCTTvlZTCDf1ySTBAdUVtrD59R+uvZTa6zQJzOCr1YE/yVQ/Qu+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDnNK449Zz1SBrV;
	Thu, 26 Sep 2024 16:49:53 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id ACC2E140360;
	Thu, 26 Sep 2024 16:50:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 16:50:42 +0800
Message-ID: <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
Date: Thu, 26 Sep 2024 16:50:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Jan Kara
	<jack@suse.cz>
CC: <tytso@mit.edu>, <stable@vger.kernel.org>, Andreas Dilger
	<adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?=
	<stgraber@stgraber.org>, Christian Brauner <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, Wesley Hershberger
	<wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/26 0:17, Aleksandr Mikhalitsyn wrote:
> On Wed, Sep 25, 2024 at 5:57 PM Jan Kara <jack@suse.cz> wrote:
>> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
>>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
>>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
>>> [   33.888740] ------------[ cut here ]------------
>>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
>> Ah, I was staring at this for a while before I understood what's going on
>> (it would be great to explain this in the changelog BTW).  As far as I
>> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation
>> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
>> flexbg_size (for example when ogroup = flexbg_size, ngroup = 2*flexbg_size
>> - 1) which then confuses things. I think that was not really intended and
> Hi Jan,
>
> First of all, thanks for your reaction/review on this one ;-)
>
> You are absolutely right, have just checked with our reproducer and
> this modification:
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..530a918f0cab 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -258,6 +258,8 @@ static struct ext4_new_flex_group_data
> *alloc_flex_gd(unsigned int flexbg_size,
>                  flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
>                                                fls(n_group - last_group));
>
> +       BUG_ON(flex_gd->resize_bg > flexbg_size);
> +
>          flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>                                          sizeof(struct ext4_new_group_data),
>                                          GFP_NOFS);
>
> and yes, it crashes on this BUG_ON. So it looks like instead of making
> flex_gd->resize_bg to be smaller
> than flexbg_size in most cases we can actually have an opposite effect
> here. I guess we really need to fix alloc_flex_gd() too.
>
>> instead of fixing up ext4_alloc_group_tables() we should really change
>> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exceeds
>> flexbg size. Baokun?
> At the same time, if I understand the code right, as we can have
> flex_gd->resize_bg != flexbg_size after
> 5d1935ac02ca5a ("ext4: avoid online resizing failures due to oversized
> flex bg") and
> 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
> we should always refer to flex_gd->resize_bg value which means that
> ext4_alloc_group_tables() fix is needed too.
> Am I correct in my understanding?

Hi Alex,

These two are not exactly equivalent.

The flex_gd->resize_bg is only used to determine how many block groups we
allocate memory to, i.e., the maximum number of block groups per resize.
And the flexbg_size is used to make some judgement on flexible block
groups, for example, the BUG_ON triggered in the issue is to make sure
src_group and last_group must be in the same flexible block group.


Regards,
Baokun


