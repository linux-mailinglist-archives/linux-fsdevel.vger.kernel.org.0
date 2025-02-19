Return-Path: <linux-fsdevel+bounces-42029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF2A3AF2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 02:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181A61894A94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924A7169397;
	Wed, 19 Feb 2025 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s29znBnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2245156228;
	Wed, 19 Feb 2025 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930123; cv=none; b=nOGhWOqH0V19MIdhX2a1RVAwb4/zMeSdLPQ+pzp1xiMOP0O4ZfPaXT1rvR5FA5/PoqLb5P/mZsozRN0e3ZIvMcQiwBAc1ymbkLiMgYsuiiHwHeCzxJngFGfq3qbAjXfDAR18aqzc0aXEfOeEsuiIUhSp7LjivvNqfcMK3OtSR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930123; c=relaxed/simple;
	bh=ecaHx7TFn62428CUF1iaLNg/cOUrC12Q11faPMF6dAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf5u2JJOJe1DHoq/MX+cs17YNVFq0jh5pMPNSrFWqsvmRq86DDjT3gI4RAu4OIo8CnVV4DjUaCmnDit8Jl8+vrOP4kKOc1/WAEjpJoR0IYi4+V2yikCv0eSan1mfXqVvtzp2wpdq6YtRo0QlACj/a+1l1MlIe6LXTQIMf0AfNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s29znBnJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739930110; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HO+oLkUCtd9RKcvmLT+yfCznp4OX/hFJFuB5S2j5XeM=;
	b=s29znBnJJOxLC6aBcwMRIhtTHlWzRENUiJl9ZeQhvjAne7ypkW1yKoFtRLZ4QQf8I5VdDuQ5g2n9xg2mwatAw8CR6UzgQgu4uI32RTuV07IGaDdKOhiZtuL+s2v6CkccOIX3qcE74WKdBS7IDZiNz4Moa4wWZoTnRzgcU/e6Kxs=
Received: from 30.221.145.137(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WPnQNgX_1739930108 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 09:55:09 +0800
Message-ID: <fefdb1f7-bf14-4bae-8666-132d1ceaed66@linux.alibaba.com>
Date: Wed, 19 Feb 2025 09:55:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
To: Dave Chinner <david@fromorbit.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 brauner@kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
 <Z7UhllvPUxVuYOqf@dread.disaster.area>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <Z7UhllvPUxVuYOqf@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/25 8:11 AM, Dave Chinner wrote:
> On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
>> ... otherwise this is a behavior change for the previous callers of
>> invalidate_complete_folio2(), e.g. the page invalidation routine.
>>
>> Fixes: 4a9e23159fd3 ("mm/truncate: add folio_unmap_invalidate() helper")
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  mm/truncate.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index e2e115adfbc5..76d8fcd89bd0 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -548,8 +548,6 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>>  
>>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>  
>> -	if (folio_test_dirty(folio))
>> -		return 0;
> 
> Shouldn't that actually return -EBUSY because the folio could not be
> invalidated?
> 
> Indeed, further down the function the folio gets locked and the
> dirty test is repeated. If it fails there it returns -EBUSY....
> 
> -Dave.

Yeah, the original logic of invalidate_inode_pages2_range() is like

```
invalidate_inode_pages2_range
  # lock page
  # launder the page if it's dirty

  invalidate_complete_folio2
    # recheck if it's dirty, and skip the dirty page (no idea how page
could be redirtied after launder_page())
```

while after commit 4a9e23159fd3 ("mm/truncate: add
folio_unmap_invalidate() helper"), this logic is changed to:

```
invalidate_inode_pages2_range
  # lock page
  folio_unmap_invalidate
    # check if it's dirty, and skip dirty page
    # launder the page if it's dirty (doubt if it's noops)

    # recheck if it's dirty, and skip the dirty page
```


-- 
Thanks,
Jingbo

