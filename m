Return-Path: <linux-fsdevel+bounces-73198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDD9D117D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EBF230B555F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5F347FF4;
	Mon, 12 Jan 2026 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+THGGg8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80732346FD1
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209847; cv=none; b=eQHgqJ8+OwZno/i2o5/H+zC4pqimGaLmJ3oNf9eNXoy6Uru+eYmhj+G7L7/M3zbFB7yHJmXrMFZM0ODt6H1j59EXtfJ4HNGT/K8ez2o9jSoxv1eTKpxbFDWtROQhfz7IxTxmiTvjx/0WQQLbMxcGRpsvSwCgBZnWLq3TGggYFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209847; c=relaxed/simple;
	bh=5LJExeGODMsSIpIYpTEkFA1z1A6Ijpae+jp4pVQ2bD4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P+noIgb/Ex42PE+17NpMwaksJGfdIidd77Z7rZcxO+A4B9vxANcxCn3SZ4q/Pw+hNWsU42mbNs4KA1yaw3YkB5hhOoXIyZXuEF0utvFXxtLLtLBLnymlhnGbUGAlcLd/2j5g1eLqQ/QJREuV0u7hyw+XCdCNCdDV5h/dZBL84zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+THGGg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A2DC116D0;
	Mon, 12 Jan 2026 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209847;
	bh=5LJExeGODMsSIpIYpTEkFA1z1A6Ijpae+jp4pVQ2bD4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g+THGGg8HS3NecvEKmFObwb8U28bvBGlDZGMqneEFNzb9Yo66iDPyM6oo+cnXSPb2
	 zjPpXuABz+8j7onvx9nnJCH2aH+4Xji0nC+Rl4xHOv3ZNdUvIsV0g/OF+VbnCESpB5
	 zJ1h+QJdk2/UDNMICp8xv2iZdfv5z6A7qbQAss58bd9uw3PWeUOqon1LEJb6RG7FLv
	 tN45I8EWucb7PotIBmE8zThq9lQxzAj6kk79IdDpb3GVzHWv0H/wdG/JV9wuTEF6Qx
	 pwKrvoKDl3jV2xs5JtcdBs84bCzwtJN+PgS3xF1D+1O7GSysBYWksIlFhRNktnMoTI
	 gBY2kZRoyFEOQ==
Message-ID: <5158ff31-bd7b-4071-b2b1-12cb75c858dd@kernel.org>
Date: Mon, 12 Jan 2026 17:24:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
To: Nanzhe Zhao <nzzhao@126.com>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
 <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
 <13c7c3ce.71fa.19bb1687da1.Coremail.nzzhao@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <13c7c3ce.71fa.19bb1687da1.Coremail.nzzhao@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/2026 4:52 PM, Nanzhe Zhao wrote:
> 
> At 2026-01-12 09:02:48, "Chao Yu" <chao@kernel.org> wrote:
>>> @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>>>    	}
>>>    	trace_f2fs_read_folio(folio, DATA);
>>>    	if (rac) {
>>> +		if (!folio_in_bio) {
>>> +			if (!ret)
>>
>> ret should never be true here?
>>
>> Thanks,
> Yes.Need I send a v3 patch to remove the redundant check?

Yes, I think so.

Thanks,

> 
> Thanks,
> Nanzhe Zhao


