Return-Path: <linux-fsdevel+bounces-22665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBE91AF0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8019B293EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFF19ADB6;
	Thu, 27 Jun 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5q8xp5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7119AD61;
	Thu, 27 Jun 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512867; cv=none; b=h7nyu3WyEQ8Nno487QjcWjInL9SROpm6WULhk52p1CT8JI6O3NJ8z+37mjEUAvli6zWfmwMXNFXi29YH1JzIMdk3nuef+J9rGWp2T/MhDsy4RSo3al3xTru9D9DkyCdrltQluqNaJvhdvmXvXjxvUyFm9tY32dTigiQ84bS+Ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512867; c=relaxed/simple;
	bh=45Y7n/Cfxoo6JaXfUfM3U4mXDua3ccYMJqfze3SvGB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cQI6DZm4NpLfD1dozLmwLeVLIoD10rsiW4PAi9Ih7nHom0yNlWvUTblBLCD0uRddOOJ2tLkmZeIYjBHiv/fnO6d4w9PRvfWc9Yks/LgzjUNUySUL/8jYL5OsJaqPq7lIJVCkC2uyjK5EPrKPDd8EHz+fd7i08JWO3b7Mz2Gxny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5q8xp5N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719512866; x=1751048866;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=45Y7n/Cfxoo6JaXfUfM3U4mXDua3ccYMJqfze3SvGB4=;
  b=h5q8xp5NHKx5vQrw6uu7MnpLmeXETZAMuzbnFjs87MFehM9CmbauPR9Q
   Mep6PCl0JwhPnwK8ImqyZXX8eGFzIhUDjb5m4wdSRiJYH5l50M6DtlpxS
   F32a0OMpPOFB3hdh25eWZhb2yduMx4HMoSQ+xUDYqBt7FhKypxC9MJ66+
   niFeSTvE5bFvyLQc6SPPr3+D6snUQ0DsjymwTo93Y0Rj7T86Np3b614me
   dfm7Oh53l5XvdRA0Djo0ilTnRbxcOSnhwiRsls1TeiHZ+LqV08Dj0XZrB
   AQ+IkZQNW98z3ZvNjQ1urdO1QpKd9acI3f1TNKbSMW6GirUVELpE4zFZ/
   g==;
X-CSE-ConnectionGUID: hBt62pfoSp2yXq3rkICnOw==
X-CSE-MsgGUID: gQrHwWAHRsqDVasTG1QXtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12287642"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="12287642"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 11:27:45 -0700
X-CSE-ConnectionGUID: 7Oh8RxbeSxKb4XqlvfwwQw==
X-CSE-MsgGUID: LWfCnHNIRaarm2gqbCwjgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44365987"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.232.196]) ([10.124.232.196])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 11:27:42 -0700
Message-ID: <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
Date: Fri, 28 Jun 2024 02:27:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
To: Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
 <20240627-laufschuhe-hergibt-8158b7b6b206@brauner>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, yu.ma@intel.com
In-Reply-To: <20240627-laufschuhe-hergibt-8158b7b6b206@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/27/2024 11:33 PM, Christian Brauner wrote:
> On Wed, Jun 26, 2024 at 09:13:07PM GMT, Mateusz Guzik wrote:
>> On Wed, Jun 26, 2024 at 1:54 PM Jan Kara <jack@suse.cz> wrote:
>>> So maybe I'm wrong but I think the biggest benefit of your code compared to
>>> plain find_next_fd() is exactly in that we don't have to load full_fds_bits
>>> into cache. So I'm afraid that using full_fds_bits in the condition would
>>> destroy your performance gains. Thinking about this with a fresh head how
>>> about putting implementing your optimization like:
>>>
>>> --- a/fs/file.c
>>> +++ b/fs/file.c
>>> @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>>>          unsigned int maxbit = maxfd / BITS_PER_LONG;
>>>          unsigned int bitbit = start / BITS_PER_LONG;
>>>
>>> +       /*
>>> +        * Optimistically search the first long of the open_fds bitmap. It
>>> +        * saves us from loading full_fds_bits into cache in the common case
>>> +        * and because BITS_PER_LONG > start >= files->next_fd, we have quite
>>> +        * a good chance there's a bit free in there.
>>> +        */
>>> +       if (start < BITS_PER_LONG) {
>>> +               unsigned int bit;
>>> +
>>> +               bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
>>> +               if (bit < BITS_PER_LONG)
>>> +                       return bit;
>>> +       }
>>> +
>>>          bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
>>>          if (bitbit >= maxfd)
>>>                  return maxfd;
>>>
>>> Plus your optimizations with likely / unlikely. This way the code flow in
>>> alloc_fd() stays more readable, we avoid loading the first open_fds long
>>> into cache if it is full, and we should get all the performance benefits?
>>>
>> Huh.
>>
>> So when I read the patch previously I assumed this is testing the bit
>> word for the map containing next_fd (whatever it is), avoiding looking
>> at the higher level bitmap and inlining the op (instead of calling the
>> fully fledged func for bit scans).
>>
>> I did not mentally register this is in fact only checking for the
>> beginning of the range of the entire thing. So apologies from my end
>> as based on my feedback some work was done and I'm going to ask to
>> further redo it.
>>
>> blogbench spawns 100 or so workers, say total fd count hovers just
>> above 100. say this lines up with about half of more cases in practice
>> for that benchmark.
>>
>> Even so, that's a benchmark-specific optimization. A busy web server
>> can have literally tens of thousands of fds open (and this is a pretty
>> mundane case), making the 0-63 range not particularly interesting.
>>
>> That aside I think the patchset is in the wrong order -- first patch
>> tries to not look at the higher level bitmap, while second reduces
>> stores made there. This makes it quite unclear how much is it worth to
>> reduce looking there if atomics are conditional.
>>
>> So here is what I propose in terms of the patches:
>> 1. NULL check removal, sprinkling of likely/unlikely and expand_files
>> call avoidance; no measurements done vs stock kernel for some effort
>> saving, just denote in the commit message there is less work under the
>> lock and treat it as baseline
>> 2. conditional higher level bitmap clear as submitted; benchmarked against 1
>> 3. open_fds check within the range containing fd, avoiding higher
>> level bitmap if a free slot is found. this should not result in any
>> func calls if successful; benchmarked against the above
>>
>> Optionally the bitmap routines can grow variants which always inline
>> and are used here. If so that would probably land between 1 and 2 on
>> the list.
>>
>> You noted you know about blogbench bugs and have them fixed. Would be
>> good to post a link to a pull request or some other spot for a
>> reference.
>>
>> I'll be best if the vfs folk comment on what they want here.
> Optimizing only the < BIT_PER_LONG seems less desirable then making it
> work for arbitrary next_fd. Imho, it'll also be easier to follow if
> everything follows the same logic.

Sorry that this message is a bit long. Thanks for your time to review.

Firstly sincerely thanks all for the hot discussion and kind suggestions 
with your expertise to make the patch set better. At least, we already 
reached some agreements on removing sanity_check and adding conditional 
clear (p.s. I'll revise the bug_on to warn_on in fd_install() as 
aligned). I fully agree with Guzik's suggestion to resort the patches. 
As the remaining focus of discussion is around fast path, I suggest that 
we submit patch 1 & 2 (after reorder) for up-streaming firstly (with 
data remeasured on latest kernel version accordingly), then we focus on 
discussion for fast path.

For this fast path idea, here I summarized some info for further 
discussion, why I still think it is valuable:

1. The original intention for fast path is to reduce func calls and 
avoid unnecessary load/store on the members sharing the same cacheline 
(such as file_lock, next_fd and the 3 bitmaps. BTW, we've tried to add 
__cacheline_aligned_in_smp for next_fd and fd array, no improvement 
observed), specially, yes, specially, all these operations are inside of 
critical section of file_lock.

2. For fast path implementation, the essential and simple point is to 
directly return an available bit if there is free bit in [0-63]. I'd 
emphasize that it does not only improve low number of open fds (even it 
is the majority case on system as Honza agreed), but also improve the 
cases that lots of fds open/close frequently with short task (as per the 
algorithm, lower bits will be prioritized to allocate after being 
recycled). Not only blogbench, a synthetic benchmark, but also the 
realistic scenario as claimed in f3f86e33dc3d("vfs: Fix pathological 
performance case for __alloc_fd()"), which literally introduced this 
2-levels bitmap searching algorithm to vfs as we see now. We may ask 
Eric for help to see whether it's possible to let us have some data on 
it. Besides, for those lots of fds are allocated and occupied for 
not-short time, the lock contention would be much less than the 
scenarios we're talking about here, then the impact of change would be 
much less.

3. Now we talk about the extra cost of fast path based on the patch we 
submitted. To be honest, before fast path, we firstly found that 
alloc_fd() is only called in two scenarios, as I mentioned in commit: 
(1) called by __get_unused_fd_flags() to find available fd start from 
bit 0, which is the most common usage. It means start==0 for alloc_fd(), 
and with this premise, alloc_fd() logic can be simpler, two branches for 
comparing to next_fd can be reduced; (2) dup a fd via dup_fd() to find a 
fd start from old_fd, which means "start" is not zero, but it is only 
called by fcntl. Then the first impression came into our mind is that 
why we sacrifice the performance of absolutely majority cases for this 
specific dup_fd. So we revised __get_unused_fd_flags() to not call 
alloc_fd() directly, but with the same logic as alloc_fd() by omitted 
the branches related to "start". Based on this version, we then found 
fast path would be possibly more efficient than the stock 2-levels 
bitmap searching based on the considerations stated in item 2 and commit 
message of this thread. Leaving aside the benefit, the extra cost is an 
conditional branch, but with 2 branches related to "start" has been 
reduced, it is still profitable, not even to say the cost can be 
alleviated by branch predictor. However, with this draft version, the 
code of __get_unused_fd_flags() duplicates a lot with alloc_fd(), then 
we change to current version for concise code. What I want to say is 
that there is space to make it faster with cost less than stock. For 
whether to use open_fds[0] as conditions for fast path, we think it's OK 
as all bitmaps are almost on the same cacheline, and we finaly need to 
write open_fds to allocate bit anyway.

4. Based on patches order as suggested by Guzik, we've re-measured the 
data on latest kernel 6.10-rc5, removing sanity_check and add 
likely/unlikely would have 6% gain for read, and 2% for write. Combined 
with conditional clear, it would have 14% gain for read, and 8% for 
write. If with fast path, it might have another ~15% gain to read (we do 
not re-measure this one yet due to time, will make up soon).


