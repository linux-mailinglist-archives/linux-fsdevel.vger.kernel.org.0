Return-Path: <linux-fsdevel+bounces-74627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI6kMcZ9cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:18:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4C52B60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FD4254B67F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83942883D;
	Tue, 20 Jan 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZvcGUFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD942847C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912861; cv=none; b=HrqLdcVTFJNj0V+GLLWMoa3VrvQ5MdNCXRlQPJ28Gkx5f7T5gpEGmlJciKmXLOorFC/w1K2cjGizbjPQIynyy7VRNjQpeKS9XtRJ61Kev8qWd0XcT8tGRgkSgC4GTH3A0RYSJNdg0FhPoa19ydZUcAyFVAYoHs3Mzjv9SdUA/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912861; c=relaxed/simple;
	bh=vFTKGGke7gcYt0Y24qQ4qECg4XQrgXTzFKM0gvn13TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7tAHLeVThc/s21GUtbxSkk52h0rArZDPByvJhwfLGdQcT1dLAE1JuGaz73HXuKjsftRtzw1u7gzqa8PfNBXcOOhl8HIL181Brh2D+i/Dm7VyexW584pClH7fSldvOQm4p12JYfXL3BX7aJ761ai2kqqQ+4wmZumdX7KWIfis+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZvcGUFw; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64d01707c32so8557028a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768912858; x=1769517658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZRsF4NvxTK9k0YGvZ/neWvOZ1bis6ac+sRh2zfafCw=;
        b=3ZvcGUFwJY3tRPDE666ArVIz+J7eKTvfpv+AqpKm9bQ2+LuKcebohDx4nE6H1l72N1
         jNGukDRZ5AO6u6yhMPdaPtRMsF2dtb6XArmty4SIfzIqg+49+XGaA8BdnGI9YbMdXKG9
         Latgd5Uq3VtY/9l6KinOX/LYvXIk9eRa9+WhNVUIiluRZ17QYGFqBvj/8P1/jzs6lmyL
         pwE8Q/xoz5Qjm3GLcrfyDdp4D+82ArS5VAXaI15Dgg/LjDTSnhVuWu3+/W8NB8bbQ2eb
         MGA7tXi5faR2VV6ys3ml1IyJj6y0yjFJ94pzQaEP4BfwDeE6eF1pRAQ3RdmJZxqn0vl+
         IW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912858; x=1769517658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZRsF4NvxTK9k0YGvZ/neWvOZ1bis6ac+sRh2zfafCw=;
        b=dDPc10vZvi3zVtGcSk2zDcZlz194xRVRisEd8SGFQPkfymzBhh7yQk+LzOfOSnvanV
         INW5V4QBi0Poz6eKm0vOEfHmlZaVkQYYDJB0NvQxKzVafg296Hvb77vccKfpOdZX1yZo
         4HiX2+lD3i9HKLHUVgDUDEuW2L3RyVJTK5efN+aCwN3dFDKUwYJdWID2APuGHTAmT+r1
         DJYIExC0hUZRqmRjA6pULnZM+dP/bvSPfgUBU6BJeK1JuqY6XRSjl/Nqv5+6mlpFEEaD
         tlRr5AmPxss2dAfbLZRp6ucGU1F+idxvoULJqwU+LeVUNwNjocURC5y049uwQLcJOvw5
         uePw==
X-Forwarded-Encrypted: i=1; AJvYcCUamwFX+WMx2teMMvupOjgoa1MuOTEPTLG3vEmGuKY8V6IBqVSlOMsTdOffEhNuDWYAY+E7F0TTT3b2+dIW@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyYLXYh357YBXAfq7/gi82y9JZnNw7Ua/G54vzGhvYKgbPvzW
	DB7IMbOnBYUrzhmGdCt/NZtIjPPb5p6G1uY8uPrxDd7ehntZ+9okI21qid0YjBf5WUe8r1wXwJ2
	fADxG8xXtxXV0KGTxiQ==
X-Received: from edqp3.prod.google.com ([2002:aa7:d303:0:b0:64b:511b:32fc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3643:b0:64c:e9b6:14d7 with SMTP id 4fb4d7f45d1cf-654bb427f7amr8037497a12.24.1768912857702;
 Tue, 20 Jan 2026 04:40:57 -0800 (PST)
Date: Tue, 20 Jan 2026 12:40:56 +0000
In-Reply-To: <20260120115207.55318-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-3-boqun.feng@gmail.com>
Message-ID: <aW932LmY0IBwrIt7@google.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over
 raw pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74627-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,garyguo.net,protonmail.com,umich.edu,weathered-steel.dev,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 70E4C52B60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:52:07PM +0800, Boqun Feng wrote:
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// - `atomic_store(.., Relaxed)` maps to `WRITE_ONCE()` when using for inter-thread communication.

typo: "when used for"

Alice

