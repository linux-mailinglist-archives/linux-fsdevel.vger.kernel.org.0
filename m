Return-Path: <linux-fsdevel+bounces-70735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82998CA56D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 22:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B525306CA1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC98330301;
	Thu,  4 Dec 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3wf04Kn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A726E706;
	Thu,  4 Dec 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882932; cv=none; b=qA4ARdnQPAnQCeC0WVFVacrr1z5NVBmec4N4vHiqbEImFovwMJJcBXMgf99FB4UGjMpCZ83V6RReSSGXYcXxrkamRL6EDq2CZuLiRy0NbxORiVu90Lx54jxoWawSdtR4vkcGoL83DhnQnbsq9HfJ3DJaCthJTNZhUPKpmxDH5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882932; c=relaxed/simple;
	bh=6k2GRQBqjw6t/2Bq8gihyaMJPqlUwySvgrCW4cFAx6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2bFXLEtakd8jAxRfIBQ8YdPmHLl4xFiiwtPcdirGFrAlkbDEOvKOApH4y69I2YyoHR0Y9JvU84f8JLUZTzYmwIr/3HwrmuM1z6QgUoMyWE8PpfPoqyI4mHPYzSmWjQoLiCgTWDOPoKJJ7nOmIiQkHif+R1P1VxylzoBIiBnIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3wf04Kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83279C4CEFB;
	Thu,  4 Dec 2025 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764882932;
	bh=6k2GRQBqjw6t/2Bq8gihyaMJPqlUwySvgrCW4cFAx6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q3wf04KnbAkEHgWC+A33jjSzlZb8qEPLEkgwP7PI+FQ8KEvhTEw8OYkRJNLwKH18z
	 lgdSCA+EMDz4TY4uqMvcQ8abxPe877MxDXPmHgRAS7vX6tuvvL3QKj4xHoKOz05Gfn
	 Z9d3WL7m+Vv6vZ/LaCCKgPXsnSRbtmWhiM8ASk90zVNcg2Hm97YYCQ6jxe6T0mrPtx
	 ecn5VKBeURBkElVh/va7higgF4X/VGeIyPYsmBhOP2aAzWWkllpzyQFVeWo87hiLIV
	 9HdRRfFd9kEGnr+f8IBkKCe1fNlVZSX4IxlZylExgtC+CKpuFGLVmXfI0HQvE0T9eW
	 zKnmnmjryd/Cw==
Message-ID: <992028c4-dff1-49a5-9cef-42484783da8e@kernel.org>
Date: Thu, 4 Dec 2025 22:15:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib: xarray: free unused spare node in
 xas_create_range()
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, willy@infradead.org,
 linux-mm@kvack.org, akpm@linux-foundation.org
Cc: dev.jain@arm.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, janak@mpiricsoftware.com, shardulsb08@gmail.com
References: <7a31f01ac0d63788e5fbac15192c35229e1f980a.camel@mpiricsoftware.com>
 <20251201074540.3576327-1-shardul.b@mpiricsoftware.com>
 <57d5793d-2343-49b3-a30c-cd12dc40460d@kernel.org>
 <78c9b5eeb10051dd9791ed3cb0ce7a18eedc5e7f.camel@mpiricsoftware.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <78c9b5eeb10051dd9791ed3cb0ce7a18eedc5e7f.camel@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/25 15:15, Shardul Bankar wrote:
> On Mon, 2025-12-01 at 09:39 +0100, David Hildenbrand (Red Hat) wrote:
>> Please don't post new versions as reply to old versions.
>> ...
>>
>> ...
>> The first thing xas_destroy() does is check whether xa_alloc is set.
>>
>> I'd assume that the compiler is smart enough to inline xas_destroy()
>> completely here, so likely the xa_alloc check here can just be
>> dropped.
> 
> Got it, will share a v4 of the patch on a new chain with redundant
> xas_destroy() removed.
> 
>> Staring at xas_destroy() callers, we only have a single one outside
>> of
>> lib: mm/huge_memory.c:__folio_split()
>>
>> Is that one still required?
> 
> I checked the callers of xas_destroy(). Apart from the internal uses in
> lib/xarray.c and the unit tests in lib/test_xarray.c, the only external
> user is indeed mm/huge_memory.c:__folio_split().
> 
> That path is slightly different from the xas_nomem() retry loop I fixed
> in xas_create_range():
> 
> 	__folio_split() goes through xas_split_alloc() and then
> xas_split() / xas_try_split(), which allocate and consume nodes via
> xas->xa_alloc.
> 
> 	The final xas_destroy(&xas) in __folio_split() is there to
> drop any leftover split-allocation nodes, not the xas_nomem() spare
> node I handled in xas_create_range().
> 
> So with the current code I don’t think I can safely declare that
> xas_destroy() in __folio_split() is redundant- it still acts as the
> last cleanup for the split helpers.
> 
> For v4 I’d therefore like to keep the scope focused on the syzkaller
> leak and just drop the redundant "if (xa_alloc)" around xas_destroy()
> in xas_create_range() as you suggested.
> 
> Separately, I agree it would be cleaner if the split helpers guaranteed
> that xa_alloc is always cleared on return, so callers never have to
> think about xas_destroy(). I can take a closer look at xas_split() /
> xas_try_split() and, if it looks sound, propose a small follow-up
> series that makes their cleanup behaviour explicit and then removes the
> xas_destroy() from __folio_split().

That makes sense, thanks. Handling it internally is certainly harder to 
mess up by callers ...

-- 
Cheers

David

