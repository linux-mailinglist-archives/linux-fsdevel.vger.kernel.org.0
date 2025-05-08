Return-Path: <linux-fsdevel+bounces-48438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB87DAAF1AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D30D3A4A3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 03:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5B1F6694;
	Thu,  8 May 2025 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDWeLQBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A31E32BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674942; cv=none; b=JaXxYzAAUWEVjnqi2SgHpnQHwuRzfrxwl7CY41F14JLH2+CNNQZCzJ7Kafu5SBbeFevCRkoL/AvD6a8A1bqxRQEwdqi/ZAViIxdAhkVcDTjJuv5bk217n/zCzuRYgPOusz5m07YJt5qkZCHE8ik8aiGBrSOmzv63zvrF3IqEr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674942; c=relaxed/simple;
	bh=pCyYn4N03Oez00d6sol7X1wiGTbexMKVucPmEMi0IPk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YHhOo8ezFdpjhvNorjPn5VsAkqE0DMZm+tnsFAh2+vaTCDwU9jHfFQHIJMn2EGZj93BAuHqNf0mkiSlZq69uAw12aKPVhdozZr6uQgH2RgsUUYdZ7gMpOV2rH2/bXuLdgfsTOmDdQOmsjc3iPXndJSOO+ElmjkuH987OguvEvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDWeLQBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AFDC4CEE8;
	Thu,  8 May 2025 03:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746674941;
	bh=pCyYn4N03Oez00d6sol7X1wiGTbexMKVucPmEMi0IPk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DDWeLQBqkgpfICJXdSRul+dq4RlkiTnu19VuG3L9CR74W81x6sF5Egv5CDgvc/D7r
	 PvGEVufGsH9PdoaHVh0fpKtIkvQ6SGr2km5hWp/Jlb/vSbbOEc56zTO9ku0Tg0vFxS
	 nFl5GEQcb6sPsHftw3b2Uy1r244u/NUu/9vuhaLBjQGxlIXBO0CeRlw02Au052//8D
	 RfqnddBC2R6o3qi/pm6VvKe7RSokVZAE6jFYf7/tc/ptFMJTm7ZrTEYKZ2/UvZxFen
	 VUgdDsp8BtEN8KCcir1N5jU+TToeJ3jbbOieePwB0rLQetkg4/3/O7dztdU+oPa5R1
	 omz4EiuXJP10Q==
Message-ID: <e9a4bd0a-5f3c-4e13-ba4d-9f73782a37ba@kernel.org>
Date: Thu, 8 May 2025 11:28:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH 2/7] f2fs: move the option parser into handle_mount_opt
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250420154647.1233033-1-sandeen@redhat.com>
 <20250420154647.1233033-3-sandeen@redhat.com>
 <2e354373-9f00-4499-8812-bcb7f00a6dbc@kernel.org>
 <db0c33f2-9fa0-4ee7-b5c9-e055fcc4d538@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <db0c33f2-9fa0-4ee7-b5c9-e055fcc4d538@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 20:31, Eric Sandeen wrote:
> On 5/7/25 6:26 AM, Chao Yu wrote:
>> On 4/20/25 23:25, Eric Sandeen wrote:
>>> From: Hongbo Li <lihongbo22@huawei.com>
>>>
>>> In handle_mount_opt, we use fs_parameter to parse each option.
>>> However we're still using the old API to get the options string.
>>> Using fsparams parse_options allows us to remove many of the Opt_
>>> enums, so remove them.
>>>
>>> The checkpoint disable cap (or percent) involves rather complex
>>> parsing; we retain the old match_table mechanism for this, which
>>> handles it well.
>>>
>>> There are some changes about parsing options:
>>>   1. For `active_logs`, `inline_xattr_size` and `fault_injection`,
>>>      we use s32 type according the internal structure to record the
>>>      option's value.
>>
>> We'd better to use u32 type for these options, as they should never
>> be negative.
>>
>> Can you please update based on below patch?
>>
>> https://lore.kernel.org/linux-f2fs-devel/20250507112425.939246-1-chao@kernel.org
> 
> Hi Chao - I agree that that patch makes sense, but maybe there is a timing
> issue now? At the moment, there is a mix of signed and unsigned handling
> for these options. I agree that the conversion series probably should have
> left the parsing type as unsigned, but it was a mix internally, so it was
> difficult to know for sure.
> 
> For your patch above, if it is to stand alone or be merged first, it 
> should probably also change the current parsing to match_uint. (this would
> also make it backportable to -stable kernels, if you want to).
> 
> Otherwise, I would suggest that if it is merged after the mount API series,
> then your patch to clean up internal types could fix the (new mount API)
> parsing from %s to %u at the same time?
> 
> Happy to do it either way but your patch should probably be internally
> consistent, changing the parsing types at the same time.
> 
> (I suppose we could incorporate your patch into the mount API series too,
> though it'd be a little strange to have a minor bugfix like this buried
> in the series.)

Eric,

Yeah, it's a little bit strange to include that patch into mount API series,
now, I realize that rebasing huge change to a minor fix is not necessary,
anyway, let me focus on reviewing, and pickup that patch after mount API series
be merged. :P

Thanks,

> 
> Thanks,
> -Eric
> 


