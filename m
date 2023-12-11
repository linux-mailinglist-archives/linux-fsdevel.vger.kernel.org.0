Return-Path: <linux-fsdevel+bounces-5560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C577A80D965
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3220BB216FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C230524AB;
	Mon, 11 Dec 2023 18:53:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F951C37;
	Mon, 11 Dec 2023 18:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E447C433C9;
	Mon, 11 Dec 2023 18:53:15 +0000 (UTC)
Date: Mon, 11 Dec 2023 18:53:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v3 15/25] arm64: add POE signal support
Message-ID: <ZXdamak1wDyUdwSG@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-16-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-16-joey.gouly@arm.com>

+ Szabolcs for libc ack (and keeping the full patch quoted below)

You should cc Szabolcs when reposting, we need his ack on the UAPI
changes.

On Fri, Nov 24, 2023 at 04:35:00PM +0000, Joey Gouly wrote:
> Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
>  arch/arm64/kernel/signal.c               | 51 ++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> index f23c1dc3f002..cef85eeaf541 100644
> --- a/arch/arm64/include/uapi/asm/sigcontext.h
> +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> @@ -98,6 +98,13 @@ struct esr_context {
>  	__u64 esr;
>  };
>  
> +#define POE_MAGIC	0x504f4530
> +
> +struct poe_context {
> +	struct _aarch64_ctx head;
> +	__u64 por_el0;
> +};
> +
>  /*
>   * extra_context: describes extra space in the signal frame for
>   * additional structures that don't fit in sigcontext.__reserved[].
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 0e8beb3349ea..379f364005bf 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -62,6 +62,7 @@ struct rt_sigframe_user_layout {
>  	unsigned long zt_offset;
>  	unsigned long extra_offset;
>  	unsigned long end_offset;
> +	unsigned long poe_offset;
>  };
>  
>  #define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
> @@ -182,6 +183,8 @@ struct user_ctxs {
>  	u32 za_size;
>  	struct zt_context __user *zt;
>  	u32 zt_size;
> +	struct poe_context __user *poe;
> +	u32 poe_size;
>  };
>  
>  static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
> @@ -227,6 +230,20 @@ static int restore_fpsimd_context(struct user_ctxs *user)
>  	return err ? -EFAULT : 0;
>  }
>  
> +static int restore_poe_context(struct user_ctxs *user)
> +{
> +	u64 por_el0;
> +	int err = 0;
> +
> +	if (user->poe_size != sizeof(*user->poe))
> +		return -EINVAL;
> +
> +	__get_user_error(por_el0, &(user->poe->por_el0), err);
> +	if (!err)
> +		write_sysreg_s(por_el0, SYS_POR_EL0);
> +
> +	return err;
> +}
>  
>  #ifdef CONFIG_ARM64_SVE
>  
> @@ -590,6 +607,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
>  	user->tpidr2 = NULL;
>  	user->za = NULL;
>  	user->zt = NULL;
> +	user->poe = NULL;
>  
>  	if (!IS_ALIGNED((unsigned long)base, 16))
>  		goto invalid;
> @@ -640,6 +658,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
>  			/* ignore */
>  			break;
>  
> +		case POE_MAGIC:
> +			if (!system_supports_poe())
> +				goto invalid;
> +
> +			if (user->poe)
> +				goto invalid;
> +
> +			user->poe = (struct poe_context __user *)head;
> +			user->poe_size = size;
> +			break;
> +
>  		case SVE_MAGIC:
>  			if (!system_supports_sve() && !system_supports_sme())
>  				goto invalid;
> @@ -812,6 +841,9 @@ static int restore_sigframe(struct pt_regs *regs,
>  	if (err == 0 && system_supports_sme2() && user.zt)
>  		err = restore_zt_context(&user);
>  
> +	if (err == 0 && system_supports_poe() && user.poe)
> +		err = restore_poe_context(&user);
> +
>  	return err;
>  }
>  
> @@ -928,6 +960,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>  		}
>  	}
>  
> +	if (system_supports_poe()) {
> +		err = sigframe_alloc(user, &user->poe_offset,
> +				     sizeof(struct poe_context));
> +		if (err)
> +			return err;
> +	}
> +
>  	return sigframe_alloc_end(user);
>  }
>  
> @@ -968,6 +1007,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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
> +	}
> +
>  	/* Scalable Vector Extension state (including streaming), if present */
>  	if ((system_supports_sve() || system_supports_sme()) &&
>  	    err == 0 && user->sve_offset) {
> @@ -1119,6 +1167,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  		sme_smstop();
>  	}
>  
> +	if (system_supports_poe())
> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> +
>  	if (ka->sa.sa_flags & SA_RESTORER)
>  		sigtramp = ka->sa.sa_restorer;
>  	else
> -- 
> 2.25.1

