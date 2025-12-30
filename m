Return-Path: <linux-fsdevel+bounces-72255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28686CEAB46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 22:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88DD63030599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24593229B12;
	Tue, 30 Dec 2025 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBAwaT3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817803A1E81;
	Tue, 30 Dec 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129395; cv=none; b=VKG/iqzW9FZvOiJH21xc4r3KibyfkEE4iBUsDc7NZyq1ecVj8epMoSNDHjCtjrc/EZP2ZxU76Hw7u3ZKm3lTqyefBOe3eqDvFlOyVqpbAyQCYYagMZtb4dvgxnkkkuP5RZjVMSxTG4nqMXtA1Wvgt8JxjsZBdfAWW2O7AudHng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129395; c=relaxed/simple;
	bh=4DKULb/zuWKAShCcUWLrmxZb0ZVLjYP4ZC9IAD+5sZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB5akK+2lv2BtxVzL0rVBJwRy8f3BxnC/y/rZ43CLLMNgl2uF7+N+rDzyUXWDjDgxUw4qJCyst9LkeG4X31J4Zff1SNh24w5lllkmf90nlEKR00HVBgSfph2fqX96RUnC7hhJUCl2HTo7QzFawqcWBrqvjgNi/zxgGWKDH30AuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBAwaT3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B2DC4CEFB;
	Tue, 30 Dec 2025 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767129395;
	bh=4DKULb/zuWKAShCcUWLrmxZb0ZVLjYP4ZC9IAD+5sZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lBAwaT3DCkGP8tR0MTimu69apbG5cWbRANBmPDMz6KgRQScZYW6QoSrjxFemajZCa
	 mFd88BMw4p7aekW9hJ/saQtN/itiAX7vgTkBoWyHXzUWk3pHxTiW1HiUWxOBcHiJXQ
	 zu7oVhnO6kvEDMiN9m+Q9+kzNFfXnPFay88XYFdTX0yaPHf7KxzWl7D+nGRpxlVD7c
	 np1ovlAgWup75llT1C+h6szaS2ZwjyuLn471yUtfFAvlrtTVtH3UFAJtGn/g/eW0H+
	 fF/Ou5S8rDEIqm/FQpdIWcBs3amTj/9bbrU/sMmXDE9EpU6++0zCwkPAPTDr8ShTl4
	 ZdhnNpRK0RL2w==
Message-ID: <ac50181c-8a9d-43b8-9597-4d6d01f31f81@kernel.org>
Date: Tue, 30 Dec 2025 22:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
To: Aaron Tomlin <atomlin@atomlin.com>, oleg@redhat.com,
 akpm@linux-foundation.org, gregkh@linuxfoundation.org, brauner@kernel.org,
 mingo@kernel.org
Cc: sean@ashe.io, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251226211407.2252573-1-atomlin@atomlin.com>
 <20251226211407.2252573-2-atomlin@atomlin.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251226211407.2252573-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/26/25 22:14, Aaron Tomlin wrote:
> This patch introduces two new fields to /proc/[pid]/status to display the
> set of CPUs, representing the CPU affinity of the process's active
> memory context, in both mask and list format: "Cpus_active_mm" and
> "Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
> cache synchronisation.
> 
> Exposing this information allows userspace to easily describe the
> relationship between CPUs where a memory descriptor is "active" and the
> CPUs where the thread is allowed to execute. The primary intent is to
> provide visibility into the "memory footprint" across CPUs, which is
> invaluable for debugging performance issues related to IPI storms and
> TLB shootdowns in large-scale NUMA systems. The CPU-affinity sets the
> boundary; the mm_cpumask records the arrival; they complement each
> other.
> 
> Frequent mm_cpumask changes may indicate instability in placement
> policies or excessive task migration overhead.

Just a note: I have the faint recollection that there are some 
arch-specific oddities around mm_cpumask().

In particular, that some architectures never clear CPUs from the mask, 
while others (e.g., x86) clear them one the TLB for them is clean.

I'd assume that all architectures at least set the CPUs once they ever 
ran an MM. But are we sure about that?

$ git grep mm_cpumask | grep m68k

gives me no results and I don't see common code to ever set a cpu in
the mm_cpumask.

-- 
Cheers

David

