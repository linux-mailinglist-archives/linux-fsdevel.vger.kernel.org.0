Return-Path: <linux-fsdevel+bounces-74068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B3D2E4E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFAD4305F66A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22530FF3B;
	Fri, 16 Jan 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEymhmaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7630F7F1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553609; cv=none; b=q39eHr5pIKsH15hPp7j6gVxjXgR79HfSTiVQ/eip9kzKSo1aFerRKoW8oaWGXdxvrqivixNNbFf/uiOYYurnSX9zpTNWfsV0KTCt9sgnrob0n8/ksAThkgfDNwL9xHXbijzM+o+ZId7romd59BjdB4mY4LjMub9K3+IkTURzDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553609; c=relaxed/simple;
	bh=QNbCEM/CPbisel6FUSp83Gcjx7gbMxEpasASgx5g+NQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VNY0MRagN8oq9lU9pR9w90BY2tp5yUBYCrsvJ9QMBm0KL9Zf1qSSHUYw6ODfFnSDyjyrfFteYRw83tjFXQb7vmTBoe1TA50f34CvkqfzKE3zFpTdwEk9l9p2tEWBWq4Sc7AH1JYZJhmhcdWF7WUCLLWE0uKbZviKh7U7t0CgFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEymhmaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B5AC2BCB6;
	Fri, 16 Jan 2026 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768553609;
	bh=QNbCEM/CPbisel6FUSp83Gcjx7gbMxEpasASgx5g+NQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NEymhmaGTEcYhdqht4sekH5v2qIhZybo3ZId8AbZS/HbU/RRMYEafgseIJs58Gpwc
	 ArO+xQlUl7coNJf5YyMVZCrJAxdsB/m5ux3khkZU27/sbqK1Si/fO1iQRU59p2btz9
	 any1GmcgSGx82cYbXJw3gfmP3y7Ny9YEWGJ7jXhuuVYqKNoIGP112U3edPMn5MvM6i
	 Z4LwQKCIreIelS0Pw3afi4Qik2HW55JbQyjyam7rEew959lsp5X64TJ7SHco+7PKd8
	 aJg5J/mXCp5WmmpjojVDpyzeG8ECFRQ3p+0EnkpXDqjimlx82Ia1ua2Zq0qMLSUaDI
	 3k36ojOOVcdhg==
Message-ID: <564a4389-f462-48b3-bd1a-cc4fbb0a6e88@kernel.org>
Date: Fri, 16 Jan 2026 16:53:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Nanzhe Zhao <nzzhao@126.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
 <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
 <13c7c3ce.71fa.19bb1687da1.Coremail.nzzhao@126.com>
 <5158ff31-bd7b-4071-b2b1-12cb75c858dd@kernel.org>
 <aWZ7X9yig5TK2yNN@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aWZ7X9yig5TK2yNN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 1:05 AM, Jaegeuk Kim wrote:
> On 01/12, Chao Yu wrote:
>> On 1/12/2026 4:52 PM, Nanzhe Zhao wrote:
>>>
>>> At 2026-01-12 09:02:48, "Chao Yu" <chao@kernel.org> wrote:
>>>>> @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>>>>>     	}
>>>>>     	trace_f2fs_read_folio(folio, DATA);
>>>>>     	if (rac) {
>>>>> +		if (!folio_in_bio) {
>>>>> +			if (!ret)
>>>>
>>>> ret should never be true here?
>>>>
>>>> Thanks,
>>> Yes.Need I send a v3 patch to remove the redundant check?
>>
>> Yes, I think so.
> 
> Applied in dev-test with it.

For upstreamed version,

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Nanzhe Zhao


