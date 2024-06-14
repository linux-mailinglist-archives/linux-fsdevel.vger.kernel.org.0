Return-Path: <linux-fsdevel+bounces-21707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED66908A58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5F6B2B9A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4940194A6B;
	Fri, 14 Jun 2024 10:41:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F31946A7;
	Fri, 14 Jun 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361664; cv=none; b=Sx5l7sE2zfq1/c30R0zmXkpDbzgbGGkJN9C1M1VoLJlSnQXpkjoEXjm+f8TIc41WnBAhDzMSQ5ncdmmjxYWyNJIhqXHgPzXHR6zsZVPZII3MzxyWTqA9+Yrp1jsqJONyNgFo/JHpy9v0TOUg03LxRNgg2Njqgxv2VhZdoGAyEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361664; c=relaxed/simple;
	bh=AmUgqvZgbKj2NQIuvs3Dt8TOXhMLfPmQOpUxQzf8iYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evrx9fNGU2jVeYxwLjvjMGFXC+H+z4aLP/LKiZRCe0CFw0uL1wELo5Zx8soyJQHg5iLj5qgP+iZZVBuGOvIhos/UwR12rWu/21tDb8u/q3gPn+dZaRZYaVyKwEPIP94yRxuKtTzjHnBCQOArvPUW6OdhdcHHzatf/KQCwbRrX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1476B1480;
	Fri, 14 Jun 2024 03:41:20 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4E003F5A1;
	Fri, 14 Jun 2024 03:40:49 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:40:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <ZmweL12SL7Unlfpe@J2N7QTR9R3.cambridge.arm.com>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612223025.1158537-3-boqun.feng@gmail.com>

On Wed, Jun 12, 2024 at 03:30:25PM -0700, Boqun Feng wrote:
> Provide two atomic types: AtomicI32 and AtomicI64 with the existing
> implemenation of C atomics. These atomics have the same semantics of the
> corresponding LKMM C atomics, and using one memory (ordering) model
> certainly reduces the reasoning difficulty and potential bugs from the
> interaction of two different memory models.
> 
> Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
> my responsiblity on these Rust APIs.
> 
> Note that `Atomic*::new()`s are implemented vi open coding on struct
> atomic*_t. This allows `new()` being a `const` function, so that it can
> be used in constant contexts.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

I have a few minor comments below.

> ---
>  MAINTAINERS                       |    4 +-
>  arch/arm64/kernel/cpufeature.c    |    2 +
>  rust/kernel/sync.rs               |    1 +
>  rust/kernel/sync/atomic.rs        |   63 ++
>  rust/kernel/sync/atomic/impl.rs   | 1375 +++++++++++++++++++++++++++++
>  scripts/atomic/gen-atomics.sh     |    1 +
>  scripts/atomic/gen-rust-atomic.sh |  136 +++
>  7 files changed, 1581 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/atomic.rs
>  create mode 100644 rust/kernel/sync/atomic/impl.rs
>  create mode 100755 scripts/atomic/gen-rust-atomic.sh
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..a8528d27b260 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3458,7 +3458,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
>  ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Mark Rutland <mark.rutland@arm.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> @@ -3467,6 +3467,8 @@ F:	arch/*/include/asm/atomic*.h
>  F:	include/*/atomic*.h
>  F:	include/linux/refcount.h
>  F:	scripts/atomic/
> +F:	rust/kernel/sync/atomic.rs
> +F:	rust/kernel/sync/atomic/
>  
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
>  M:	Bradley Grove <linuxdrivers@attotech.com>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 48e7029f1054..99e6e2b2867f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1601,6 +1601,8 @@ static bool
>  has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
>  {
>  	u64 val = read_scoped_sysreg(entry, scope);
> +	if (entry->capability == ARM64_HAS_LSE_ATOMICS)
> +		return false;
>  	return feature_matches(val, entry);
>  }

As per other replies, this'll obviously need to go.

> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> new file mode 100644
> index 000000000000..b0f852cf1741
> --- /dev/null
> +++ b/rust/kernel/sync/atomic.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic primitives.
> +//!
> +//! These primitives have the same semantics as their C counterparts, for precise definitions of
> +//! the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory (Consistency)
> +//! Model is the only model for Rust development in kernel right now, please avoid to use Rust's
> +//! own atomics.
> +
> +use crate::bindings::{atomic64_t, atomic_t};

As with the last patch, why no atomic_long_t?

[...]

> +#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, ty, int, raw, arg...)
> +gen_proto_order_variant()
> +{
> +	local meta="$1"; shift
> +	local pfx="$1"; shift
> +	local name="$1"; shift
> +	local sfx="$1"; shift
> +	local order="$1"; shift
> +	local atomic="$1"; shift
> +	local ty="$1"; shift
> +	local int="$1"; shift
> +	local raw="$1"; shift
> +
> +	local fn_name="${raw}${pfx}${name}${sfx}${order}"
> +	local atomicname="${raw}${atomic}_${pfx}${name}${sfx}${order}"
> +
> +	local ret="$(gen_ret_type "${meta}" "${int}")"
> +	local params="$(gen_params "${int}" $@)"
> +	local args="$(gen_args "$@")"
> +	local retstmt="$(gen_ret_stmt "${meta}")"
> +
> +cat <<EOF
> +    /// See \`${atomicname}\`.
> +    #[inline(always)]
> +    pub fn ${fn_name}(&self${params}) ${ret}{
> +        // SAFETY:\`self.0.get()\` is a valid pointer.
> +        unsafe {
> +            ${retstmt}${atomicname}(${args});
> +        }
> +    }
> +EOF
> +}

AFAICT the 'ty' argument (AtomicI32/AtomicI64) isn't used and can be
removed.

Likewise for 'raw'.

> +
> +cat << EOF
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generated by $0
> +//! DO NOT MODIFY THIS FILE DIRECTLY
> +
> +use super::*;
> +use crate::bindings::*;
> +
> +impl AtomicI32 {
> +EOF
> +
> +grep '^[a-z]' "$1" | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "atomic" "AtomicI32" "i32" "" ${args}

With 'ty' and 'raw' gone, this'd be:

	gen_proto "${meta}" "${name}" "atomic" "i32" ${args}

> +done
> +
> +cat << EOF
> +}
> +
> +impl AtomicI64 {
> +EOF
> +
> +grep '^[a-z]' "$1" | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "atomic64" "AtomicI64" "i64" "" ${args}

With 'ty' and 'raw' gone, this'd be:

	gen_proto "${meta}" "${name}" "atomic64" "i64" ${args}

Mark.

> +done
> +
> +cat << EOF
> +}
> +
> +EOF
> -- 
> 2.45.2
> 

