Return-Path: <linux-fsdevel+bounces-22413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF7916D29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B9F1C20D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669DC175552;
	Tue, 25 Jun 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn15kazM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902317333B;
	Tue, 25 Jun 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329621; cv=none; b=kwij41Aaoks4lbVxFe3qv2LSrKrxSR8a67a0ckM3g3xA+Zw9UbHyOHRwj5PQ0/X2ufSPC62javso5qFQXMGSb+ENDtFWlo2dbea9CHD6Dr6JusCrsMtqO/OsfAw73jHymK6YnOJOqaIjYAOKsQGCI7vUOEGFvJHNMVuxu+jqw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329621; c=relaxed/simple;
	bh=uPLUs+i0sWGfpRm6c5Uu6lzqMGMSQX3L/kQuHlglG8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv1DOvA6F7BcCv3XIe1cwcAw4A3uKbO5ZZJQXhH7mzjTi9/inl7PD1IOf4bj/odznBeqmZOw7doc5RhLTebRTACMO9qMtkxnAHDiYyARm4TMjMFL8FEKJTmzqyt4loy+wUX1EzVnGXafMHFJHTF5D9k2cIVL9MNdNdnJPjYPYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn15kazM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719329620; x=1750865620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uPLUs+i0sWGfpRm6c5Uu6lzqMGMSQX3L/kQuHlglG8I=;
  b=Xn15kazMOTeoa5nwaFyiZonjheDfVoMo5zWGLKN/lphAzGt0v3lx+LKG
   BPSMa0bUJeWfhxzntqOU/n2aroNIYZ/TI51A2xfuJKRjpUNqUfo72eoAx
   HjoO4+/6PJ1e6kJpJIzOjCPQlGaPfNrkmX2zDI/dlHQgMfD/m5/Brh5lg
   6+Ah6MF6CQwKpK/vxzT2jqMaekRrfJa824KSupGxPyuz/hPtTKqN+2QT/
   qiYd1/1A6n6dxDhU8t9Chdgea6lX6JVER3L/8sA5rXU+wmlNEWtdrGvHe
   BnU7NL1T6hi6aFMQ9FnCimIY2Pj8wwhq4z526W3ck48qeZ01JpERDiiou
   A==;
X-CSE-ConnectionGUID: RV9Kgbi5ScWlydNCVHStfQ==
X-CSE-MsgGUID: 6gaQ3wV5TWqU/QYndULoYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16112763"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16112763"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:33:39 -0700
X-CSE-ConnectionGUID: AYIIf208RJOkFbGrjuYamQ==
X-CSE-MsgGUID: gJ+esJnnQOCfkh0szhdzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43660078"
Received: from wenjun3x-mobl1.ccr.corp.intel.com (HELO [10.124.232.196]) ([10.124.232.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:33:36 -0700
Message-ID: <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
Date: Tue, 25 Jun 2024 23:33:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <20240625125309.y2gs4j5jr35kc4z5@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/25/2024 8:53 PM, Jan Kara wrote:
> On Tue 25-06-24 13:52:57, Jan Kara wrote:
>> On Sat 22-06-24 11:49:02, Yu Ma wrote:
>>> There is available fd in the lower 64 bits of open_fds bitmap for most cases
>>> when we look for an available fd slot. Skip 2-levels searching via
>>> find_next_zero_bit() for this common fast path.
>>>
>>> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
>>> free slot is available there, as:
>>> (1) The fd allocation algorithm would always allocate fd from small to large.
>>> Lower bits in open_fds bitmap would be used much more frequently than higher
>>> bits.
>>> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
>>> it would never be shrunk. The search size increases but there are few open fds
>>> available here.
>>> (3) find_next_zero_bit() itself has a fast path inside to speed up searching
>>> when size<=64.
>>>
>>> Besides, "!start" is added to fast path condition to ensure the allocated fd is
>>> greater than start (i.e. >=0), given alloc_fd() is only called in two scenarios:
>>> (1) Allocating a new fd (the most common usage scenario) via
>>> get_unused_fd_flags() to find fd start from bit 0 in fdt (i.e. start==0).
>>> (2) Duplicating a fd (less common usage) via dup_fd() to find a fd start from
>>> old_fd's index in fdt, which is only called by syscall fcntl.
>>>
>>> With the fast path added in alloc_fd(), pts/blogbench-1.1.0 read is improved
>>> by 17% and write by 9% on Intel ICX 160 cores configuration with v6.10-rc4.
>>>
>>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>>> ---
>>>   fs/file.c | 35 +++++++++++++++++++++--------------
>>>   1 file changed, 21 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/fs/file.c b/fs/file.c
>>> index a3b72aa64f11..50e900a47107 100644
>>> --- a/fs/file.c
>>> +++ b/fs/file.c
>>> @@ -515,28 +515,35 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>>   	if (fd < files->next_fd)
>>>   		fd = files->next_fd;
>>>   
>>> -	if (fd < fdt->max_fds)
>>> +	error = -EMFILE;
>>> +	if (likely(fd < fdt->max_fds)) {
>>> +		if (~fdt->open_fds[0] && !start) {
>>> +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
>> So I don't think this is quite correct. If files->next_fd is set, we could
>> end up calling find_next_zero_bit() starting from quite high offset causing
>> a regression? Also because we don't expand in this case, we could cause access
>> beyond end of fdtable?
> OK, I've misunderstood the next_fd logic. next_fd is the lowest 0-bit in
> the open_fds bitmap so if next_fd is big, the ~fdt->open_fds[0] should
> be false. As such the above condition could be rewritten as:
>
> 		if (!start && files->next_fd < BITS_PER_LONG)
>
> to avoid loading the first bitmap long if we know it is full? Or we could
> maybe go as far as:
>
> 		if (!start && fd < BITS_PER_LONG && !test_bit(fd, fdt->open_fds))
> 			goto fastreturn;
>
> because AFAIU this should work in exactly the same cases as your code?
>
> 								Honza

Thanks Honza for the good concern and suggestions here, while both above 
conditions are not enough to ensure that there is available fd in the 
first 64 bits of open_fds. As next_fd just means there is no available 
fd before next_fd, just imagine that fd from 0 to 66 are already 
occupied, now fd=3 is returned back, then next_fd would be set as 3 per 
fd recycling logic (i.e. in __put_unused_fd()), next time when 
alloc_fd() being called, it would return fd=3 to the caller and set 
next_fd=4. Then next time when alloc_fd() being called again, 
next_fd==4, but actually it's already been occupied. So 
find_next_zero_bit() is needed to find the real 0 bit anyway. The 
conditions should either be like it is in patch or if (!start && 
!test_bit(0, fdt->full_fds_bits)), the latter should also have the 
bitmap loading cost, but another point is that a bit in full_fds_bits 
represents 64 bits in open_fds, no matter fd >64 or not, full_fds_bits 
should be loaded any way, maybe we can modify the condition to use 
full_fds_bits ?

>>> +			goto fastreturn;
>>> +		}
>>>   		fd = find_next_fd(fdt, fd);
>>> +	}
>>> +
>>> +	if (unlikely(fd >= fdt->max_fds)) {
>>> +		error = expand_files(files, fd);
>>> +		if (error < 0)
>>> +			goto out;
>>> +		/*
>>> +		 * If we needed to expand the fs array we
>>> +		 * might have blocked - try again.
>>> +		 */
>>> +		if (error)
>>> +			goto repeat;
>>> +	}
>>>   
>>> +fastreturn:
>>>   	/*
>>>   	 * N.B. For clone tasks sharing a files structure, this test
>>>   	 * will limit the total number of files that can be opened.
>>>   	 */
>>> -	error = -EMFILE;
>>> -	if (fd >= end)
>>> +	if (unlikely(fd >= end))
>>>   		goto out;
>>>   
>>> -	error = expand_files(files, fd);
>>> -	if (error < 0)
>>> -		goto out;
>>> -
>>> -	/*
>>> -	 * If we needed to expand the fs array we
>>> -	 * might have blocked - try again.
>>> -	 */
>>> -	if (error)
>>> -		goto repeat;
>>> -
>>>   	if (start <= files->next_fd)
>>>   		files->next_fd = fd + 1;
>>>   
>>> -- 
>>> 2.43.0
>>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>>

