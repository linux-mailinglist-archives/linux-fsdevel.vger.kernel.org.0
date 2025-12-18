Return-Path: <linux-fsdevel+bounces-71626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61DCCAE31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB5493009619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E677A331A6A;
	Thu, 18 Dec 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdyXhyLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663D137C52;
	Thu, 18 Dec 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046659; cv=none; b=p1twPPtw4ljbj+jR5EsmIys1OiOInSpy4NI7a2k5cda1Mqpq83ABqoiK2su/Rtut1a766l/GiCuEPIWW5YpkPljC9chaHJ/ZDsXdyzdxoYV+L5Z3OsnBxtJNLNI5a9X4wHU6VE1ISZRnP5EC7kMX+s6gsZjhqIztu/OOgYLgMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046659; c=relaxed/simple;
	bh=uWxfQmCWrYNSgH6TtvELIainhetU2B1JwIvJxQ3ncC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1St8zGBNOgAk9GpgyQi5JhhMoVfFhoyLuSlH6hsIT1eIOVt5eulT3Be8Pp94slHr/9m+l0553909Bb+QlrUdfDgDu0ovn8X1xwSAvfecsgwvua486z3Oblt27vsZUJ7AiX6sL8tn4zXviWbIP3q75Sou2Iz57jDwgKaY1GJ4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdyXhyLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6317C4CEFB;
	Thu, 18 Dec 2025 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766046657;
	bh=uWxfQmCWrYNSgH6TtvELIainhetU2B1JwIvJxQ3ncC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OdyXhyLLnqhdD6rKtgXu7ITH1q41wIuX9sEPJpMHYHhMmV/hHwcjeaRjXLoXa6IBy
	 Os6aL7/A6NqEx7PAz4DeJ7oheKt/eo7Zcut9f8YlrkImS++qc3LBgwcxZhsxN5DaeS
	 a74pthncwQmP4jSgCu5OoZrPEQV8LPd6f5iqHTN3kd4w3gfMsfy6t+nv8AfgsdrW/w
	 2S/4qLyUwfqw/5FQXaIUf2nwCKI12QS1iIaKDaGaoLJA6xIvAcaTiJErh92iWnPN8+
	 JUhTrmxlHMTaLDK8kNTIWMvT5C6N1G863SWHUTFVPWlGnrg0kirmJTFEbbI1PaEIKw
	 LXLRs/WOfFwKQ==
Message-ID: <060edde3-7cc4-4a36-b9aa-824e607d954c@kernel.org>
Date: Thu, 18 Dec 2025 09:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
To: Aaron Tomlin <atomlin@atomlin.com>, oleg@redhat.com,
 akpm@linux-foundation.org, gregkh@linuxfoundation.org, brauner@kernel.org,
 mingo@kernel.org
Cc: sean@ashe.io, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251217024603.1846651-1-atomlin@atomlin.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251217024603.1846651-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 03:46, Aaron Tomlin wrote:
> This patch introduces two new fields to /proc/[pid]/status to display the
> set of CPUs, representing the CPU affinity of the process's active
> memory context, in both mask and list format: "Cpus_active_mm" and
> "Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
> cache synchronisation.
> 
> Exposing this information allows userspace to easily identify
> memory-task affinity, insight to NUMA alignment, CPU isolation and
> real-time workload placement.
> 
> Frequent mm_cpumask changes may indicate instability in placement
> policies or excessive task migration overhead.

I agree with Oleg's comments.

Given that everybody has read access to /proc/$PID/status IIUC, I wonder 
if that information could somehow help an attacker to better attack a 
target program (knowing which CPUs have dirty TLB etc). As you saise, 
it's primarily for TLB and cache sync ...

Just a thought, have nothing concrete in mind.

-- 
Cheers

David

