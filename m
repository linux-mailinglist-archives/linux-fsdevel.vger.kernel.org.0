Return-Path: <linux-fsdevel+bounces-70197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453FC9362B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455453A9DE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA61D5CD1;
	Sat, 29 Nov 2025 01:36:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E818FDAF;
	Sat, 29 Nov 2025 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764380174; cv=none; b=bBUGh5YLwiqrbDo8hWOKPJtEFh+M6eD0yHxxUmlCSwmdOeHas/YlQT3FmX75bacGnTmjRoVfBXCpa7YWE1DhH8PQoFaO4pr+zrsNHIeIMlD6wQuxtVZpRk5GG08lBqu/sFGu3shJRB6kq1VmXn5BNgnBi79BuURTmiHs7HUBsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764380174; c=relaxed/simple;
	bh=JNGqFiRS28H3+0kZUOEA8ypYM8buy6tlWlVadSlYe+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhtEu7+aD0oURYr99ZWfvHTtbQzLD0UU2OVjFx7n0yuXjF7YbAe8OpzlqTmZKpdBfvNWKJd//NYJ3CfaK/4DsOg07e2VB/YOczuZXN9JKliLCCAdp6uauumAJeTpBkM+VWMGqvOIXNYbrmEAIb/KqHPEPqKqYiQ2k9C8xVZ/Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJCR25Mh7zKHLtb;
	Sat, 29 Nov 2025 09:35:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5A5661A07BB;
	Sat, 29 Nov 2025 09:36:09 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnw3kITippzPJ+CQ--.33388S3;
	Sat, 29 Nov 2025 09:36:09 +0800 (CST)
Message-ID: <b42dd2b9-f04e-4c0c-9fb1-5a46fb450e5e@huaweicloud.com>
Date: Sat, 29 Nov 2025 09:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] ext4: drop extent cache before splitting extent
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-8-yi.zhang@huaweicloud.com>
 <aSbxjVypU3vdOUmK@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8680efcd-dc84-4b4e-ab75-216de959ec88@huaweicloud.com>
 <aSlaeSGfjlZbY3hB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aSlaeSGfjlZbY3hB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnw3kITippzPJ+CQ--.33388S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyDGFyDGw4xGw43tryxZrb_yoW8Wry3pr
	W3GF18KrW8Aw1jk3s2vw4jqr92ka4rKr47ury5Kw1YyF9FgryYgF17ta1rCFyFgr48Xw1a
	vF48K34fuasxC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/28/2025 4:16 PM, Ojaswin Mujoo wrote:
> On Thu, Nov 27, 2025 at 03:27:26PM +0800, Zhang Yi wrote:
>> On 11/26/2025 8:24 PM, Ojaswin Mujoo wrote:
>>> On Fri, Nov 21, 2025 at 02:08:05PM +0800, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
[...]
>>>>
>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>> index 2b5aec3f8882..9bb80af4b5cf 100644
>>>> --- a/fs/ext4/extents.c
>>>> +++ b/fs/ext4/extents.c
>>>> @@ -3367,6 +3367,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>>>>  	ee_len = ext4_ext_get_actual_len(ex);
>>>>  	unwritten = ext4_ext_is_unwritten(ex);
>>>>  
>>>> +	/*
>>>> +	 * Drop extent cache to prevent stale unwritten extents remaining
>>>> +	 * after zeroing out.
>>>> +	 */
>>>> +	ext4_es_remove_extent(inode, ee_block, ee_len);
>>>> +
> 
> Okay this makes sense, there are many different combinations of how the
> on disk extents might turn out and if will become complicated to keep
> the es in sync to those, so this seems simpler.
> 
> There might be a small performance penalty of dropping the es here tho
> but idk if it's anything measurable. As a middle ground do you think it
> makes more sense to drop the es cache in ext4_split_extent_at() instead,
> when we know we are about to go for zeroout. Since the default non
> zeroout path seems to be okay?
> 
> Regards,
> ojaswin
> 
> 

Yes, this makes sense to me! I will move it to ext4_split_extent_at()
in my next iteration.

Thanks,
Yi.

> 
>>>>  	/* Do not cache extents that are in the process of being modified. */
>>>>  	flags |= EXT4_EX_NOCACHE;
>>>>  
>>>> -- 
>>>> 2.46.1
>>>>
>>


