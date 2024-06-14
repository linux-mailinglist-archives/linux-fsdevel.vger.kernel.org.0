Return-Path: <linux-fsdevel+bounces-21706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7959089F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A651C25FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D21195F0C;
	Fri, 14 Jun 2024 10:31:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8E146582;
	Fri, 14 Jun 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361108; cv=none; b=NCvB/Gn9V6VW343+VHT3MyK+Lf6sD0/Ly6Mq9W1Bt7GC//PrMQs90Qf2edrohdX3Pome4cMPMuwUMJnRXRC8u5cuVMbClw9GosNBtA0aZuJJ4NxZTt3jL/8JQ94N5bHeQf8utKdkq8Ex1Llnpx0lz6tbQvrDkAaENXDy1ES9gJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361108; c=relaxed/simple;
	bh=7/o+RQWCaaNGrfSufObH0pCcC/HZRaVC09CWwpJrhtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An6IhnO0THzhSap6GAwhXYmUDrCrdftdUJi0edSPhD5T0zeeChArTpCOIP2VLLnjJkZH2RqAFNB4f7LbkprjyFB5mVPOXMW87qpa2ga1apklo0X4hUQXf3fbL1XFSUzH1S0iwCO/3bm4X2lSmYp1O1QTvLtrysrKkaNJt4P7Lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E4BDA7;
	Fri, 14 Jun 2024 03:32:09 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA53B3F5A1;
	Fri, 14 Jun 2024 03:31:38 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:31:33 +0100
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
Subject: Re: [RFC 1/2] rust: Introduce atomic API helpers
Message-ID: <ZmwcBWjxf7gm89wA@J2N7QTR9R3.cambridge.arm.com>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612223025.1158537-2-boqun.feng@gmail.com>

On Wed, Jun 12, 2024 at 03:30:24PM -0700, Boqun Feng wrote:
> In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> the same as in C. This could save the maintenance burden of having two
> similar atomic implementations in asm.
> 
> Originally-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

FWIW, I'm happy with the concept; I have a couple of minor comments
below.

> ---
>  rust/atomic_helpers.h                     | 1035 +++++++++++++++++++++
>  rust/helpers.c                            |    2 +
>  scripts/atomic/gen-atomics.sh             |    1 +
>  scripts/atomic/gen-rust-atomic-helpers.sh |   64 ++
>  4 files changed, 1102 insertions(+)
>  create mode 100644 rust/atomic_helpers.h
>  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

[...]

> +#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, raw, arg...)
> +gen_proto_order_variant()
> +{
> +	local meta="$1"; shift
> +	local pfx="$1"; shift
> +	local name="$1"; shift
> +	local sfx="$1"; shift
> +	local order="$1"; shift
> +	local atomic="$1"; shift
> +	local int="$1"; shift
> +	local raw="$1"; shift
> +	local attrs="${raw:+noinstr }"

You removed the 'raw_' atomic generation below, so you can drop the
'raw' parameter and the 'attrs' variable (both here and in the
template)...

> +	local atomicname="${raw}${atomic}_${pfx}${name}${sfx}${order}"
> +
> +	local ret="$(gen_ret_type "${meta}" "${int}")"
> +	local params="$(gen_params "${int}" "${atomic}" "$@")"
> +	local args="$(gen_args "$@")"
> +	local retstmt="$(gen_ret_stmt "${meta}")"
> +
> +cat <<EOF
> +__rust_helper ${attrs}${ret}

... e.g. you can remove '${attrs}' here.

[...]

> +grep '^[a-z]' "$1" | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "atomic" "int" "" ${args}
> +done
> +
> +grep '^[a-z]' "$1" | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "atomic64" "s64" "" ${args}
> +done

With the 'raw' parameter removed above, the '""' argument can be
dropped.

Any reason to not have the atomic_long_*() API? It seems like an odd
ommision.

Mark.

