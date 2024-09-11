Return-Path: <linux-fsdevel+bounces-29110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DF975653
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864881C22DD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47CC1A38CF;
	Wed, 11 Sep 2024 15:02:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98D19C552;
	Wed, 11 Sep 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066924; cv=none; b=lK1sf0zSs2orE8kTzp2LFNq4kHZLb7nTZ1q13WFYKBTPIKutqgzyXzpE1Qch+iBFRzLqsR4bShk/Oka7ApTpLEJ2caDqnM2hC5SqwVE3w+LpoKkhR4raerHTC0L8A7VrUJEzgGs5eWvKILnd/3ufde0+tzHCxRKCHkbtr8vWtvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066924; c=relaxed/simple;
	bh=KFoLsMibpjrh3IxjBWh3BLz+C6klx9k2wrAaGvcurH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHXThCqrUJaiGGSJSYjnF6ChOIxp9yxURLQNZtK3IdA6coSW9irP0uouFZFPCO/ZxudrNiDrGT4BXpEF+oKa1Z2VYPJl9/1pvEW4pfO4gKuBdYGon7Bg0UJh2+N9qcjEziqkYOBRYRR4BtOrT8H3YMJAYXSmGMPwJovhaFT182c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBAFD1007;
	Wed, 11 Sep 2024 08:02:30 -0700 (PDT)
Received: from [10.57.74.200] (unknown [10.57.74.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3AF3F73B;
	Wed, 11 Sep 2024 08:01:55 -0700 (PDT)
Message-ID: <425b8f8c-b6b5-422a-b5f4-41dd2d1ae3bb@arm.com>
Date: Wed, 11 Sep 2024 17:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
 broonie@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 skhan@linuxfoundation.org, szabolcs.nagy@arm.com, tglx@linutronix.de,
 will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20240822151113.1479789-7-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 17:10, Joey Gouly wrote:
> @@ -371,6 +382,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  		if (system_supports_tpidr2())
>  			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
>  
> +		if (system_supports_poe())
> +			p->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);

Here we are only reloading POR_EL0's value if the target is a user
thread. However, as this series stands, POR_EL0 is also relevant to
kthreads, because any uaccess or GUP done from a kthread will also be
checked against POR_EL0. This is especially important in cases like the
io_uring kthread, which accesses the memory of the user process that
spawned it. To prevent such a kthread from inheriting a stale value of
POR_EL0, it seems that we should reload POR_EL0's value in all cases
(user and kernel thread).

Other approaches could also be considered (e.g. resetting POR_EL0 to
unrestricted when creating a kthread), see my reply on v4 [1].

Kevin

[1]
https://lore.kernel.org/linux-arm-kernel/b4f8b351-4c83-43b4-bfbe-8f67f3f56fb9@arm.com/

