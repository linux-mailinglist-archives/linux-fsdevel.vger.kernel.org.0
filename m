Return-Path: <linux-fsdevel+bounces-74692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLHBHOvZb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:39:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB744A9C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A01EA07EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D544BC8E;
	Tue, 20 Jan 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hw1v9fFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736044A72F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926244; cv=none; b=kussWB3ObdskXIjotItCSuwmWyMMIghIIBkPHWKwhovsQtsStBb4oEPIefRwzkXe/knLtyx6eUdoEYqYvn6QWVa0Zxrf1UNjczo/2vQEEyFufCJMRjVo7KNdZkr+3ePiDptSfnUeRau+j9BVeVur8YgMXP5qrYsBdssQAr1HO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926244; c=relaxed/simple;
	bh=+ucFVRrgpEefO2Jjg8KKYYHKcBFgPjaiGNJQOyBpXkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYNOda4EAv1fTlbSxPUCgQUoadSWJoZzgNMRDGogP515F7u2SZnlTDa3b5uymL7Gc/HqE7Q+TPwV43/u6bblS4Yx1dk0cxXhvUPKmO7XO0DJ67J7t4O8YEvWxbrN8970W5/88ER/ZtVvHoBsWq50pG2xggCuyFVDQBrAuM5uBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hw1v9fFM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee07570deso38829415e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768926241; x=1769531041; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNTcrrXAP9aiDb63ILRilIlxrZ3yFdWvD8IViTWFwuw=;
        b=hw1v9fFMpGsgpXG3o+k1YfvkJs8x5VO9S39tUwwv545XSCXZ3vinSIZMt+bCEaM5ka
         i/zCBeqpHjohCrEMlgTww5AFHv9VvQdR7GmU3tuuAN2IPtrduvBJz67CX3ZUDtRzBBtZ
         1CiPxwikHX4xI4qp/gQb/Rys+qzHZ9Xw5LAyRmPVNDy7jcmqBjLxO1zEEZ0yKCLge8VO
         jGNZcN5Wk2bbRjgbg9LjLPUVpAY6359mj5DYASjEqISfkelYbZ7ISeUthuWS7Sph/1D0
         Be4F1KOPqnyl37RBkwqAE+RfrnVFzGwE67pTXAd6c7vPQ6aOrUCEwa5fzTv3FidpYg9q
         MCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926241; x=1769531041;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNTcrrXAP9aiDb63ILRilIlxrZ3yFdWvD8IViTWFwuw=;
        b=sKB2Q9bJHXg46A7ctVKTSfEW/QHCyKc9J8MWBwL01U5vQn9I58Up7IZtw2EDFEQ+CL
         h8XvCHden6GW+d4fiEQFPuImhy4c2vEgaCuN+eB8WcJjjsvr4YQn2bYyT/rHKQaF9GYZ
         DWxHSFg0sCoVmOWcUar8FfjBFtcOLMbif/mNByFn7fxWeokFNvwDUsDkib1I4L5VOWrw
         4n0ceppKP/gbF0KuLx9R3ot+EX5dNyVJDLWSigE9tvANpTDjaGkRHGU3srd9fxrEQkhP
         ZJjg4FjladdMmDVfHL3VuQVp8RYa/6Xri7yY1yMkl8AbnxDJswPG/PBbKbHP0QuWcP5z
         GkqA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RIREpaGbpaDlYmIZ9yDOijZuGeDG/VN6rjgMuUHN0ebwPKeIxAl4EBfQb3zMHl0pvVWhxRWhlDxI07qx@vger.kernel.org
X-Gm-Message-State: AOJu0YxlehoAOdYWMIghsNEpN6qHqeMjCXTgVIjfHZNRL7L1l0FOuu3X
	61WR5tJgeArTPNvsOCUa8nMeON/+24yN29JRsUCOMVw0/txw6gvrwxdcuDNGTTrfZg+tadiOXdp
	E4aCBKJH0
X-Gm-Gg: AY/fxX718ArV7m/qdsL0+3K6LvvZsIzPqoHiDrWpuhCs6AM3HV+IQwkfJQadx4W64DM
	zHzwUuONF3x2f20/d+QvIlcFJxMIieRB0EsZry/VmYatpROTAqPH9iV4Y2k5w778yxngbPwp7Xu
	gM3ZHy4xy6446Id+0y2RXwQJ4Fwj/s86g3JZ6RVgxxNBqOPlJ4kIjhb0pT4nGPtfhkPrzQhVwpp
	76zTnQdSgeOltklh3fvyHvXLuyNFMVPsjeFe80RZFLMXDhuybZOQ2LGyq5AMEhJhcmkl/jx4Rqm
	ScqUTA2YZAYvc6YYqaa7Itm0rofoOzJJDiRocSHSkBh+PabiFImzSgw5sWkiyVpDoBJu6ReMLv3
	VPo/bUMwpHlws2egFdton6yhGyyyFS6XltlHNIkNEHFiY+vv8kuX32O8RpQvmtHjJjyqU8vUYYr
	uou9WlkSSgnxxohO7ExgNSsdHAEacnRb3ntQ+Wzqpy4cGd5ac=
X-Received: by 2002:a05:600c:548a:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-4801eb10f27mr172875965e9.30.1768926240817;
        Tue, 20 Jan 2026 08:24:00 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:7c8:a22a:d5aa:54db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm29599978f8f.18.2026.01.20.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:00 -0800 (PST)
Date: Tue, 20 Jan 2026 17:23:54 +0100
From: Marco Elver <elver@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
Message-ID: <aW-sGiEQg1mP6hHF@elver.google.com>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120115207.55318-3-boqun.feng@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-74692-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lpc.events:url]
X-Rspamd-Queue-Id: 0CB744A9C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:52PM +0800, Boqun Feng wrote:
> In order to synchronize with C or external, atomic operations over raw
> pointers, althought previously there is always an `Atomic::from_ptr()`
> to provide a `&Atomic<T>`. However it's more convenient to have helpers
> that directly perform atomic operations on raw pointers. Hence a few are
> added, which are basically a `Atomic::from_ptr().op()` wrapper.
> 
> Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
> conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
> named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
> `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
> `atomic_set()`, so keep the `atomic_` prefix.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++++
>  rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index d49ee45c6eb7..6c46335bdb8c 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -611,3 +611,107 @@ pub fn cmpxchg<Ordering: ordering::Ordering>(
>          }
>      }
>  }
> +
> +/// Atomic load over raw pointers.
> +///
> +/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and can be used to work
> +/// with C side on synchronizations:
> +///
> +/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using for inter-thread communication.
> +/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.

I'm late to the party and may have missed some discussion, but it might
want restating in the documentation and/or commit log:

READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
like memory_order_consume than it is memory_order_relaxed. This has, to
the best of my knowledge, not changed; otherwise lots of kernel code
would be broken. It is known to be brittle [1]. So the recommendation
above is unsound; well, it's as unsound as implementing READ_ONCE with a
volatile load.

While Alice's series tried to expose READ_ONCE as-is to the Rust side
(via volatile), so that Rust inherits the exact same semantics (including
its implementation flaw), the recommendation above is doubling down on
the unsoundness by proposing Relaxed to map to READ_ONCE.

[1] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf

Furthermore, LTO arm64 promotes READ_ONCE to an acquire (see
arch/arm64/include/asm/rwonce.h):

        /*
         * When building with LTO, there is an increased risk of the compiler
         * converting an address dependency headed by a READ_ONCE() invocation
         * into a control dependency and consequently allowing for harmful
         * reordering by the CPU.
         *
         * Ensure that such transformations are harmless by overriding the generic
         * READ_ONCE() definition with one that provides RCpc acquire semantics
         * when building with LTO.
         */

So for all intents and purposes, the only sound mapping when pairing
READ_ONCE() with an atomic load on the Rust side is to use Acquire
ordering.

