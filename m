Return-Path: <linux-fsdevel+bounces-5169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4036808D73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC4D1F21130
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DF481B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C35125C5;
	Thu,  7 Dec 2023 15:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72E4C433C7;
	Thu,  7 Dec 2023 15:25:19 +0000 (UTC)
Date: Thu, 7 Dec 2023 15:25:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 11/25] arm64: enable ARCH_HAS_PKEYS on arm64
Message-ID: <ZXHj3TMuW7sPMqAc@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-12-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-12-joey.gouly@arm.com>

On Fri, Nov 24, 2023 at 04:34:56PM +0000, Joey Gouly wrote:
> diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> new file mode 100644
> index 000000000000..5761fb48fd53
> --- /dev/null
> +++ b/arch/arm64/include/asm/pkeys.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Arm Ltd.
> + *
> + * Based on arch/x86/include/asm/pkeys.h
> +*/
> +
> +#ifndef _ASM_ARM64_PKEYS_H
> +#define _ASM_ARM64_PKEYS_H
> +
> +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
> +
> +#define arch_max_pkey() 0
> +
> +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +		unsigned long init_val);
> +
> +static inline bool arch_pkeys_enabled(void)
> +{
> +	return false;
> +}
> +
> +static inline int vma_pkey(struct vm_area_struct *vma)
> +{
> +	return -1;
> +}

What's the point of these dummies? I guess they'll be populated later
but I haven't reached that point. Could we not just leave them out for
now and add the complete version directly? This would work better with
an earlier comment to move the Kconfig entry towards the end of the
series.

Also, they don't seem to match the generic include/linux/pkeys.h
dummies. For example, vma_pkey() returns 0 in the generic version, -1
here. Should they actually match?

-- 
Catalin

