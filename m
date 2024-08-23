Return-Path: <linux-fsdevel+bounces-26890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587895C95E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF65B21961
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738D157465;
	Fri, 23 Aug 2024 09:37:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922414F9D0;
	Fri, 23 Aug 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405848; cv=none; b=kEds519WrQ2GgPzIa/v1CGgfWHgIrurvrapymLQ265kt6k2TA9iFN1/dekSfJBkdhmUbPEPRRskIeekmZ+40x7P2RoE5mfFSK3vMzKj0bvlXvtvS+H3BD8hDah5kDRQIS0eTDC0RxefnrIb+oExqPCDup2iqTmT8zcwjjURef2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405848; c=relaxed/simple;
	bh=3X+03SKG3xtneksGiN0c3G7LAf2OyJVqqVW6hGSkLKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8CxR4jAgfKg+7GW5X7a5q4HttQQWcg9aWLuDhav72anUmYkUhZ7X71/wfAsG8gJfcAV4yFBDgAJL8BDnFcTTAFkoqWKBpMsFLFd+IiZ5M/D+cJi1ebQ6eRyHq34FLjdSTaPFG0XGyMKiLb3cX6LFqhuAdKTG7AeQ+2uScIqqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2810C32786;
	Fri, 23 Aug 2024 09:37:21 +0000 (UTC)
Date: Fri, 23 Aug 2024 10:37:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 25/39] arm64/signal: Expose GCS state in signal frames
Message-ID: <ZshYTyNbveD7WMyJ@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:28AM +0100, Mark Brown wrote:
> +static int preserve_gcs_context(struct gcs_context __user *ctx)
> +{
> +	int err = 0;
> +	u64 gcspr;
> +
> +	/*
> +	 * We will add a cap token to the frame, include it in the
> +	 * GCSPR_EL0 we report to support stack switching via
> +	 * sigreturn.
> +	 */
> +	gcs_preserve_current_state();
> +	gcspr = current->thread.gcspr_el0 - 8;
> +
> +	__put_user_error(GCS_MAGIC, &ctx->head.magic, err);
> +	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
> +	__put_user_error(gcspr, &ctx->gcspr, err);
> +	__put_user_error(0, &ctx->reserved, err);
> +	__put_user_error(current->thread.gcs_el0_mode,
> +			 &ctx->features_enabled, err);
> +
> +	return err;
> +}

Do we actually need to store the gcspr value after the cap token has
been pushed or just the value of the interrupted context? If we at some
point get a sigaltshadowstack() syscall, the saved GCS wouldn't point to
the new stack but rather the original one. Unwinders should be able to
get the actual GCSPR_EL0 register, no need for the sigcontext to point
to the new shadow stack.

Also in gcs_signal_entry() in the previous patch, we seem to subtract 16
rather than 8.

I admit I haven't checked the past discussions in this area, so maybe
I'm missing something.

> +static int restore_gcs_context(struct user_ctxs *user)
> +{
> +	u64 gcspr, enabled;
> +	int err = 0;
> +
> +	if (user->gcs_size != sizeof(*user->gcs))
> +		return -EINVAL;
> +
> +	__get_user_error(gcspr, &user->gcs->gcspr, err);
> +	__get_user_error(enabled, &user->gcs->features_enabled, err);
> +	if (err)
> +		return err;
> +
> +	/* Don't allow unknown modes */
> +	if (enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> +		return -EINVAL;
> +
> +	err = gcs_check_locked(current, enabled);
> +	if (err != 0)
> +		return err;
> +
> +	/* Don't allow enabling */
> +	if (!task_gcs_el0_enabled(current) &&
> +	    (enabled & PR_SHADOW_STACK_ENABLE))
> +		return -EINVAL;
> +
> +	/* If we are disabling disable everything */
> +	if (!(enabled & PR_SHADOW_STACK_ENABLE))
> +		enabled = 0;
> +
> +	current->thread.gcs_el0_mode = enabled;
> +
> +	/*
> +	 * We let userspace set GCSPR_EL0 to anything here, we will
> +	 * validate later in gcs_restore_signal().
> +	 */
> +	current->thread.gcspr_el0 = gcspr;
> +	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);

So in preserve_gcs_context(), we subtract 8 from the gcspr_el0 value.
Where is it added back?

What I find confusing is that both restore_gcs_context() and
gcs_restore_signal() seem to touch current->thread.gcspr_el0 and the
sysreg. Which one takes priority? I should probably check the branch out
to see the end result.

> @@ -977,6 +1079,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>  			return err;
>  	}
>  
> +	if (add_all || task_gcs_el0_enabled(current)) {
> +		err = sigframe_alloc(user, &user->gcs_offset,
> +				     sizeof(struct gcs_context));
> +		if (err)
> +			return err;
> +	}

I'm still not entirely convinced of this conditional saving and the
interaction with unwinders. In a previous thread you mentioned that we
need to keep the GCSPR_EL0 sysreg value up to date even after disabling
GCS for a thread as not to confuse the unwinders. We could get a signal
delivered together with a sigreturn without any context switch. Do we
lose any state?

It might help if you describe the scenario, maybe even adding a comment
in the code, otherwise I'm sure we'll forget in a few months time.

-- 
Catalin

