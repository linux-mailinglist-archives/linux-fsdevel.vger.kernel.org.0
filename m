Return-Path: <linux-fsdevel+bounces-73861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838BD22128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206C3301F7D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858325F995;
	Thu, 15 Jan 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x+Q78qNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1D4369A;
	Thu, 15 Jan 2026 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768442185; cv=none; b=hsqANSGclO/TMM26yc69BEUSsfzNx3ccgXPqYOm1TlK3KIe+GZwwUMl5iPRXy2YZ61B8cafwVbjVKHX4yLylmyN/h5dHX2xuceM4Rpb+3DabYfh4K2KTXCmRuWMb1glVXaSGK3TIK5+Fi5VRsFUd/1YwIPxAL3npRVpazmDaGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768442185; c=relaxed/simple;
	bh=agH4RSvn4ZkF6Xtbd97hcIG+UYKgzFlY/ZH1uk8pyN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3hR0/r0Vih+KK04ViQeG71J7tQdykH3C6fTf1EydTYWHHaHUYW5lL8dloMbZ0Gib5iDEMAfOy293wq3Jqq0DHC8c1wxe4B+isCrHmzkbzNHPkItWGtzHYMAsIpme5oSa/r3d14wj1MvE3CEDf61jngEv1kFCSAJKtOEywo6gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x+Q78qNe; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768442180; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/SdX2kCJs18J+iBuTTsTk1w+FzyHmPIGA2Sygj7BTk8=;
	b=x+Q78qNeacgNUIsJe6VKNYo39pM8WyiQAuWAO6QP7zH+502AeXlgPc5DvokUnWt+3pgLC+lQqkDCf8kqDaUvwUe0BiRyeEXS65T7D5Kf0/TDPLRlyXZNEONd5Afr8huyoaQ1siq4BUY3vbzU0k4VGvo2XjNkassQcKjwp10s1Ro=
Received: from 30.221.146.238(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx4m1DA_1768442178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 09:56:20 +0800
Message-ID: <a9fa2da0-91e7-4671-95a6-a0a44c83a92d@linux.alibaba.com>
Date: Thu, 15 Jan 2026 09:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: fix premature writetrhough request for large
 folio
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, horst@birthelmer.de,
 joseph.qi@linux.alibaba.com
References: <20260114124514.62998-1-jefflexu@linux.alibaba.com>
 <CAJnrk1bjxyUw58WyiwsyBcJ0CcsBJZKNkcm_U+A+2KSmNqvjyQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1bjxyUw58WyiwsyBcJ0CcsBJZKNkcm_U+A+2KSmNqvjyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/15/26 2:41 AM, Joanne Koong wrote:
> On Wed, Jan 14, 2026 at 4:45 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> When large folio is enabled and the initial folio offset exceeds
>> PAGE_SIZE, e.g. the position resides in the second page of a large
>> folio, after the folio copying the offset (in the page) won't be updated
>> to 0 even though the expected range is successfully copied until the end
>> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
>> before the request has reached the max_write/max_pages limit.
>>
>> Fix this by eliminating page offset entirely and use folio offset
>> instead.
>>
>> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
>> Cc: stable@vger.kernel.org
> 
> This should not need the stable tag or any backports. The bug cannot
> trigger until the future patch for turning on large folios lands.

I think 6.18 stable also needs this fix?

-- 
Thanks,
Jingbo


