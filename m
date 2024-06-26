Return-Path: <linux-fsdevel+bounces-22483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6926917F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A0C283131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27DC17D373;
	Wed, 26 Jun 2024 11:07:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454D2AF1A;
	Wed, 26 Jun 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400030; cv=none; b=FUHG40aHZlcljNHnM5gnjwI53wEHJ/W8mySCmA18Co2XW4BJ8KCW2P8IVPwOIkSTuuIrP8mdHw4DEjSze7AUNmB8PU8dHnNebgHjjgkF1ZyFGSn9dP7iLJg3xyAX6dod2k6uQPvBdPXE0c8RPM3Z1ie1srLEIfXMBVlv21DhfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400030; c=relaxed/simple;
	bh=/a9LZmTKDpvH82+VtQ9vu54a2Y6n/B7FiDeYvPzrWns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIwYYIQuwsECZNfikNlwuVgx7Shk07aYCg3TY3Cc7YylxHaCcirCa9BayA1FdM1Tw1okDIoAmcJxjVfvBq5EfHxd5daCEcJd1oUM9T1umXtRSCKJ8Fznoa5zqYSNorrH+2DLRclgHLYBK/z/zQDPbmq5y9ijsGh69+05ep+8OZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8A3339;
	Wed, 26 Jun 2024 04:07:32 -0700 (PDT)
Received: from [10.57.73.149] (unknown [10.57.73.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D93B53F766;
	Wed, 26 Jun 2024 04:07:05 -0700 (PDT)
Message-ID: <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
Date: Wed, 26 Jun 2024 12:07:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>,
 akpm@linux-foundation.org, willy@infradead.org
Cc: vbabka@suse.cz, svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn,
 baohua@kernel.org, peterx@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
 <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 04:06, Zi Yan wrote:
> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>> pages, which means of any order, but KPF_THP should only be set
>> when the folio is a 2M pmd mappable THP. 

Why should KPF_THP only be set on 2M THP? What problem does it cause as it is
currently configured?

I would argue that mTHP is still THP so should still have the flag. And since
these smaller mTHP sizes are disabled by default, only mTHP-aware user space
will be enabling them, so I'll naively state that it should not cause compat
issues as is.

Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all mTHP
sizes to function correctly. So that would need to be reworked if making this
change.

Thanks,
Ryan


