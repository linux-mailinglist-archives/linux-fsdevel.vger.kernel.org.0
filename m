Return-Path: <linux-fsdevel+bounces-53291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9AAED2D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B713A9460
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 03:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424E191F72;
	Mon, 30 Jun 2025 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozceJGQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5D3D6F;
	Mon, 30 Jun 2025 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253210; cv=none; b=nJ+5tqG/Cxl378IeGm2XG6GMbTYRwYnT3yt/vwVzSOxlMQzfYor1IisEDCjSzDyru3d0geo01bLp5jSbhFRGXUgZR1rNFbuk5l/iW64xzfgu069w1TmUFy32Vu7sEdrSa8WlswjJYpAhWOR4y1Oce1gmobe3tapnZ4YIZSMubiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253210; c=relaxed/simple;
	bh=3W6SKAqPjU0OF1wARKz8145crr8XIY1C3ru/WExeWoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCNFEfHTb9YpkatZoDhxk89bHz5fBr6R/NSuDsHOL1bM3mniNRvmSBEU39wkMlDT2NqfmiO1x6gLqAJx1Dp4HABgu0ftCmTrETNUpBFzu+1TuqIcHnzsXeDnxV25Z6YGv3xXGjjkj0CypMXP70RoNxIny3j/Vg4RaLrlNl61TZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozceJGQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDDAC4CEEB;
	Mon, 30 Jun 2025 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751253209;
	bh=3W6SKAqPjU0OF1wARKz8145crr8XIY1C3ru/WExeWoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozceJGQK3cusldE3bHGo9Ju05ldPUVlW0tuzNsKIxjkAIO6cW1ect2pMJZxppVSGt
	 eG2MwKcOtqYmXenhT63KxMwUstj1Dcui+vCWxCoPHlakvbp22JsrLw+ELcIwMTt3cu
	 MOUgcRI3UrRW0URKhq/J1A2Iji6eHhoRxMRSTtDnvX86H6UYSb1vwpZg44f7eX30N/
	 hK4TdwdxiUPMwLa1vEggPdVHRdHixSowXjJ5ytaB6y+xvPJ+9eJnXYaNwLI2IitOO9
	 Z1wllCdBwI2gz+UFm35Y1Mp8D1ORVUVtmGbvJf9c4YdwWPT/fv4z9fcTyt4kGAfZK1
	 iXEbm2rwm1X6g==
Date: Sun, 29 Jun 2025 23:13:27 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	akpm@linux-foundation.org, dada1@cosmosbay.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: Prevent file descriptor table allocations exceeding
 INT_MAX
Message-ID: <aGIA18cgkzv-05A2@lappy>
References: <20250629074021.1038845-1-sashal@kernel.org>
 <i3l4wxfnnnqfg76yg22zfjwzluog2buvc7rtpp67nnxtbslsb3@sggjxvhv7j2h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <i3l4wxfnnnqfg76yg22zfjwzluog2buvc7rtpp67nnxtbslsb3@sggjxvhv7j2h>

On Sun, Jun 29, 2025 at 09:58:12PM +0200, Mateusz Guzik wrote:
>On Sun, Jun 29, 2025 at 03:40:21AM -0400, Sasha Levin wrote:
>> When sysctl_nr_open is set to a very high value (for example, 1073741816
>> as set by systemd), processes attempting to use file descriptors near
>> the limit can trigger massive memory allocation attempts that exceed
>> INT_MAX, resulting in a WARNING in mm/slub.c:
>>
>>   WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x21a/0x288
>>
>> This happens because kvmalloc_array() and kvmalloc() check if the
>> requested size exceeds INT_MAX and emit a warning when the allocation is
>> not flagged with __GFP_NOWARN.
>>
>> Specifically, when nr_open is set to 1073741816 (0x3ffffff8) and a
>> process calls dup2(oldfd, 1073741880), the kernel attempts to allocate:
>> - File descriptor array: 1073741880 * 8 bytes = 8,589,935,040 bytes
>> - Multiple bitmaps: ~400MB
>> - Total allocation size: > 8GB (exceeding INT_MAX = 2,147,483,647)
>>
>> Reproducer:
>> 1. Set /proc/sys/fs/nr_open to 1073741816:
>>    # echo 1073741816 > /proc/sys/fs/nr_open
>>
>> 2. Run a program that uses a high file descriptor:
>>    #include <unistd.h>
>>    #include <sys/resource.h>
>>
>>    int main() {
>>        struct rlimit rlim = {1073741824, 1073741824};
>>        setrlimit(RLIMIT_NOFILE, &rlim);
>>        dup2(2, 1073741880);  // Triggers the warning
>>        return 0;
>>    }
>>
>> 3. Observe WARNING in dmesg at mm/slub.c:5027
>>
>> systemd commit a8b627a introduced automatic bumping of fs.nr_open to the
>> maximum possible value. The rationale was that systems with memory
>> control groups (memcg) no longer need separate file descriptor limits
>> since memory is properly accounted. However, this change overlooked
>> that:
>>
>> 1. The kernel's allocation functions still enforce INT_MAX as a maximum
>>    size regardless of memcg accounting
>> 2. Programs and tests that legitimately test file descriptor limits can
>>    inadvertently trigger massive allocations
>> 3. The resulting allocations (>8GB) are impractical and will always fail
>>
>
>alloc_fdtable() seems like the wrong place to do it.
>
>If there is an explicit de facto limit, the machinery which alters
>fs.nr_open should validate against it.
>
>I understand this might result in systemd setting a new value which
>significantly lower than what it uses now which technically is a change
>in behavior, but I don't think it's a big deal.
>
>I'm assuming the kernel can't just set the value to something very high
>by default.
>
>But in that case perhaps it could expose the max settable value? Then
>systemd would not have to guess.

The patch is in alloc_fdtable() because it's addressing a memory
allocator limitation, not a fundamental file descriptor limitation.

The INT_MAX restriction comes from kvmalloc(), not from any inherent
constraint on how many FDs a process can have. If we implemented sparse
FD tables or if kvmalloc() later supports larger allocations, the same
nr_open value could become usable without any changes to FD handling
code.

Putting the check at the sysctl layer would codify a temporary
implementation detail of the memory allocator as if it were a
fundamental FD limit. By keeping it at the allocation point, the check
reflects what it actually is - a current limitation of how large a
contiguous allocation we can make.

This placement also means the limit naturally adjusts if the underlying
implementation changes, rather than requiring coordinated updates
between the sysctl validation and the allocator capabilities.

I don't have a strong opinion either way...

-- 
Thanks,
Sasha

