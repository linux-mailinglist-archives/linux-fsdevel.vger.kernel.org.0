Return-Path: <linux-fsdevel+bounces-11540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FE8547E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E039AB27A29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142861946C;
	Wed, 14 Feb 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W27nP2Cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3218EAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909311; cv=none; b=AG1KODOqgMopDaq9yql7dtz6gi0XW54Wra3NooxSsTZFtFiDH+whwTkvRp28BU+aY86vVeQ3FhLNqu8QBfM4sc4IPyi0y5uiHA47Gk1N8ETgNctFv8WSO0Y9MdOwZkQRfvrJXgpmWOVqhwpTnRkInZU8fgITtyDs6+tsGJHzMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909311; c=relaxed/simple;
	bh=m3WnjKCI7bLS7ccsONVUBpgf5ngxxm6vnaNNNqJP2UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOMwlmg33PLQ5zF1e2lxjq4EulD2L0zvV55vwAB9+8UiTT9yO2ZyLOaRHxOpWlkN/zFl5ZifkU32IqOckn89zGhleyJBwp5HJKqGpVOC1Wqa/V10TmZvpm8I9+Ordv5hPXCLJw3mkIcsktFXcRKENxlzN8gMcTQhUsZhuuYM8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W27nP2Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A8C43394;
	Wed, 14 Feb 2024 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707909311;
	bh=m3WnjKCI7bLS7ccsONVUBpgf5ngxxm6vnaNNNqJP2UA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W27nP2CmDsOVv5D5CZv0q+9s8PDrNAN0zrBhbwfv7EeSXOYzGals69FtFLgY97lbI
	 SkG9ffDYix6OU1vDrQdJbbZ+Bx5wcox20Du6iNt08GpIdKY54p11/WuqfHEGELAp3u
	 rLxD160XujotAKb3Wj/03mSvRVU0n2tsp8T1QPq4blV9ExPEnUWVyutHh5bsz7+dnB
	 11R5WDQSyJsd2hggrJ3OBBCzxLGe9sE3X2kewm3h5UfDbGjBzuJnsxy/0ymXkICvKO
	 tdWRYnCxr085MMKmpr/ABxvewSnU9B0RoXb2Y0+CbtHaC11XiZxX1fGy+XeE/4/WRn
	 gtrkygeHyYkkg==
Message-ID: <cc8a914e-6711-4a5f-963b-a2efd05c4b2b@kernel.org>
Date: Wed, 14 Feb 2024 20:15:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
 <3252c311-8f8f-4e73-8e4a-92bc6daebc7b@themaw.net>
 <7cf58fb0-b13c-473c-b31c-864f0cac3754@kernel.org>
 <a312df58-4f52-44fe-8eec-92d34aaa46f2@themaw.net>
 <341e9b40-17b9-4607-8bac-693980c1ab75@themaw.net>
 <Zcv9L4t9t6QfAKJ0@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zcv9L4t9t6QfAKJ0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/14/24 08:37, Bill O'Donnell wrote:
> On Wed, Feb 14, 2024 at 07:31:09AM +0800, Ian Kent wrote:
>> On 12/2/24 20:12, Ian Kent wrote:
>>> On 12/2/24 09:13, Damien Le Moal wrote:
>>>> On 2/11/24 12:36, Ian Kent wrote:
>>>>>>> +static void zonefs_free_fc(struct fs_context *fc)
>>>>>>> +{
>>>>>>> +    struct zonefs_context *ctx = fc->fs_private;
>>>>>> I do not think you need this variable.
>>>>> That's a fair comment but it says fs_private contains the fs context
>>>>>
>>>>> for the casual reader.
>>>>>
>>>>>>> +
>>>>>>> +    kfree(ctx);
>>>>>> Is it safe to not set fc->fs_private to NULL ?
>>>>> I think it's been safe to call kfree() with a NULL argument for ages.
>>>> That I know, which is why I asked if *not* setting fc->fs_private to
>>>> NULL after
>>>> the kfree is safe. Because if another call to kfree for that pointer
>>>> is done, we
>>>> will endup with a double free oops. But as long as the mount API
>>>> guarantees that
>>>> it will not happen, then OK.
>>>
>>> Interesting point, TBH I hadn't thought about it.
>>>
>>>
>>> Given that, as far as I have seen, VFS struct private fields leave the
>>>
>>> setting and freeing of them to the file system so I assumed that, seeing
>>>
>>> this done in other mount api implementations, including ones written by
>>>
>>> the mount api author, it was the same as other VFS cases.
>>>
>>>
>>> But it's not too hard to check.
>>
>> As I thought, the context private data field is delegated to the file
>> system.
>>
>> The usage here is as expected by the VFS.
> 
> Thanks for the reviews. I submitted a v2 patch.
> Cheers-
> Bill

Testing was all good, so I applied this to for-6.9 branch.
I did tweak the patch to re-add the local ctx variable in zonefs_free_fc() since
that seems to be the accepted pattern.

Thanks !

-- 
Damien Le Moal
Western Digital Research


