Return-Path: <linux-fsdevel+bounces-23393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D2492BAB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA53EB264EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87015699E;
	Tue,  9 Jul 2024 13:10:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791413A25F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530624; cv=none; b=EJR98oXUnQXuNW5BfJzXBzHaj1F0kWdl4KFAeD+TQWR29CYk0g6hR61hHk12MAEA2VkJzXfbqiSRfIBXUdln5NLqchdgR95xbzjj8j03pZ2CB6nW7K53+REQbghKHHb4eBMHrQJ5AEJXQdXh8h4N83IOSnnQNouSzX+gv9CN3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530624; c=relaxed/simple;
	bh=DRuLjv39VerGQ/0zc5FtA1Vu+3dM9YqwkoMi4KhxEXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sevybwUmdkCBMBuDNOD6HuMkoNxFXPu/eeJf/BzUL5P2ilTFWseFLfj6FcrHu/7WBfI3owSCEyB3IUbSGbH35qu3HzsDxzKVFlJT5Q70oved/OKNq7g0KYn8qJDhXZIznTdCf+b87Cv0Elu9k9DqHiUUD0o9HbatC2M8p9MvlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2462F1650;
	Tue,  9 Jul 2024 06:10:48 -0700 (PDT)
Received: from [10.44.160.75] (e126510-lin.lund.arm.com [10.44.160.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7283F766;
	Tue,  9 Jul 2024 06:10:15 -0700 (PDT)
Message-ID: <48f65838-4da0-401b-8636-c595989cfe05@arm.com>
Date: Tue, 9 Jul 2024 15:10:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/29] kselftest/arm64: Add test case for POR_EL0
 signal frame records
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-29-joey.gouly@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20240503130147.1154804-29-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 15:01, Joey Gouly wrote:
> +static uint64_t get_por_el0(void)
> +{
> +	uint64_t val;
> +
> +	asm volatile (
> +		"mrs	%0, " SYS_POR_EL0 "\n"
> +		: "=r"(val)
> +		:
> +		: "cc");

Not sure why we would need "cc" for an MRS? __read_pkey_reg() doesn't
use it (maybe we could directly use that function here if including
pkey-arm64.h is OK).

Kevin

> +
> +	return val;
> +}

