Return-Path: <linux-fsdevel+bounces-23387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F292BAA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766241F22B78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3915B98D;
	Tue,  9 Jul 2024 13:08:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8E158875
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530498; cv=none; b=l6aL7OWYkR57HjqTmya2xXtoIbX36nr9xd2EMxSOKtHvbPHyF8JqIHJ8/XexzBsXOD2axDKbdggtF8NY1njtrhiBsBAdImqZV6wtquVryIzriJrXF+Fy35UTZZd8fr3sqo5q7OS/d/8xPaetUIcbCQ1956BtrPX14Qv4mzjZZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530498; c=relaxed/simple;
	bh=nn5FAGMG4kckBC970pj2hM9RWiaA6CdakgovQpFk3lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIkowVGw3GyQTy2Lw56bByBHrZIJS2nzNcrTkzUvICy/0J3t8duX4sXlfkqoxDzXcg1XOIQ72bufjUNkkv5eZtnUmQNoqbTHF7SLNdLuaUDFNoByUnOsH4Bfk7E+KaEuWLDgJLD5bmQS9UX+x0KJEb7o52cOFthPUgTqbkRn3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F631650;
	Tue,  9 Jul 2024 06:08:41 -0700 (PDT)
Received: from [10.44.160.75] (e126510-lin.lund.arm.com [10.44.160.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5BCC3F766;
	Tue,  9 Jul 2024 06:08:08 -0700 (PDT)
Message-ID: <4a71f4e2-0c2d-4632-a600-c4e098546546@arm.com>
Date: Tue, 9 Jul 2024 15:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
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
 <20240503130147.1154804-19-joey.gouly@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20240503130147.1154804-19-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 15:01, Joey Gouly wrote:
> @@ -1020,6 +1060,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
>  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
>  	}
>  
> +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> +		struct poe_context __user *poe_ctx =
> +			apply_user_offset(user, user->poe_offset);
> +
> +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);

Nit: would be nicer to have this in its own helper
(preserve_poe_context()), like for the other optional records.

Kevin

