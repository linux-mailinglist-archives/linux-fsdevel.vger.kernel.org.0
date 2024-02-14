Return-Path: <linux-fsdevel+bounces-11508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBA8540C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 01:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9691A1C26487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7D385;
	Wed, 14 Feb 2024 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF0NsA9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC97F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869767; cv=none; b=F2o7p8ruZMbKL/KZJa5sbLDZ1r27dpPTFCJRU9jCwQtXh9xpW+jRDZIfx2H1MnMyNCzPvru2Za9fSCpEUSvrOJTfTm446K7Ui9q0gP4MUWhjbXdBQW0RggyINSgzF4sApTw4xIyazyZnA/AxjfRZQcHh27p64D65NGreOWaxfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869767; c=relaxed/simple;
	bh=5Pb6hek7ZU7G2HmBOxAjqk8pDtJV/GrfYEH3z7JmKa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3V75mNjjGbJhB0zJPaZA30UFcjwjATbV2CwfGrTSQtRiHMavfO3BfucQg0nt/MRe3S+2vgV4ED42/lgMGL6xvZzqz0y5BU+cF/jCoOWs1hIrYB8BuoGwF6aPssMWlqJyzqjLgKzDBikHq6WMiuOwIE5xwNW/2/egWtd/h+2Z0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF0NsA9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFCBC433C7;
	Wed, 14 Feb 2024 00:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707869767;
	bh=5Pb6hek7ZU7G2HmBOxAjqk8pDtJV/GrfYEH3z7JmKa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KF0NsA9lEFgeUWwcyRuO81HpwJTwUUSPEtJbJozWvU9UVohhpSjsYhsoGnA+EMQFW
	 Puu9+KnovwY1iUc6u7t9NQV+shxImim3ki3+96YeXMpW8AlmhVHVFAoYVh1tM/k8hm
	 k4vDp5Q/FArcg/HRRPAUBXT0OIaFYmkSlwVPVtur+qox1WEkMwb0U+5S50EzS84Ysb
	 O4+PTG7PdWIKjsBWDNZSwRnBoXq2TG+T5ZCMGrxEm10JNjiLydGrXAsZ0MD6VIZgaN
	 7ls0QGmIgMDFC7DGSZsD92VrzawkBnffWf62M6qwbOh/XTdD8/9duqCm/ih3pRVL//
	 WR2VjYp2ljmKQ==
Message-ID: <64ef9fd8-6fec-4fa5-987c-3ad401db02af@kernel.org>
Date: Wed, 14 Feb 2024 09:16:01 +0900
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

I will run tests today. Thanks.

-- 
Damien Le Moal
Western Digital Research


