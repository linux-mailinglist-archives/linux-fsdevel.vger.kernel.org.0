Return-Path: <linux-fsdevel+bounces-74626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMEIHUtMcGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:47:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 494BA508F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCC756A21B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDE42EEB7;
	Tue, 20 Jan 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SINlgYNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C4426D14
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912757; cv=none; b=Mrk0uyweWNDXaAuQgQu5FMqprjOFpNz0eIFPH5KLYyNwKoUe1MORK/A9L0E47qnDWVbXe/j8bc9r6Yxo+JkD+TR0iBeqb7VxvkMRVvbMX2ZzDE+5O/zOuqbjsHJ/K3WzZ1ayBoFzIXthMj2dIBFqBVpsof01Jf7+pEWfJmA1W50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912757; c=relaxed/simple;
	bh=4hQ5wthGbRwK+tJ8j7a8ZpnaN272v9XF9TyqQHVeT7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=niDQp5DFYOveo+zu+U1vDhqy07mMc7cvfugedqMw/hMkk1coaWccyiehasfvrjrQOt34V1nXevEt2ksatlmgo0bWQ3rXviSPRQYIc99BNhsTAuBza5OpDqBZlCoI3XS7U/3hlJrJUOey2vCyRpAJmuo5+qE8h97UJPoJ9SCCC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SINlgYNR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso9037295e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768912754; x=1769517554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aC20Vi3ua6RNxinQI5h1askXn9iFU0ocrDNDebQDeNI=;
        b=SINlgYNR2tMUaMhpKlTrBu24v2h7sDtC19jXJFpl3psVbL8Kzxm6+vO/x7W0/z4HxD
         eaB7ohKK8yTpqOjVFmNqyfzWZ9BL9JtcHuHJHx2R2yOilpBTpQL2XApTO4d31ptnVMN3
         E3lWP/DJZEVWV34g5BPZWHPHPOWWzEtEU0n+kj5ED+FAIPyhEAUMFVK0o4td/w2Iszne
         LJwa/XtQwmsiXyb6bp9fZzSUQiKaMq7RM74YsdVaP3GXFYf8Jau60ucY3LGE49C7iGjI
         wyKeZH6S36RzTf8NVLSAKaN8MDmupPMra+Tt51T42NZvAvynocg6Dz+VY3Jt5RGvjOIT
         zv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912754; x=1769517554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC20Vi3ua6RNxinQI5h1askXn9iFU0ocrDNDebQDeNI=;
        b=tv3IM2P+aJ7HJzsBeah8BrSf+KamepMXpPAPMgzyzbIHwxEAlZs+ydi9cCaGfqFc9t
         2DTpIhMPmHacD3+4A+jManvlgl0vJbiKxvSYbs2USTmkh58uBxpwSTMp7XpgoQ1vYQcz
         PWhqO7M1mMxSb/GMv67sRlnQA7BiUfaObFOVjUppzhD5IofXpsaOoceAJZJRWIIiNXlG
         VzjUSxZTO6+knbveYQvEL7/40TyfYIkM6hDAH7TxPOWMFU2kG0DQlH6clwexUUULOEOC
         9zfNNaCVOn+RxTYa/8vPNKGB2CaqZvL4TsNbcQXWYqy3ZXrmWzr7YG1pjUTwXVvH8hru
         5c9g==
X-Forwarded-Encrypted: i=1; AJvYcCVcAn1bZIp+vnTdKjYYd/lbyfBnpgvLHnsIb3M0w3WsC/8ItsOafc2OrXWDHbC8vQR0fDolpHywVvGFDjoq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YDhpGLWVZ3WE/ftoVxP7NIruydPlNUs45rMNAWqoHSHkdJyw
	fJ/HlwPYxhnFjRS47nshDbrMOvbCqX+5Cr5HZKDVWGAU93zYPraVFUTb9bPoPiUb1vdsD+ZPGFP
	zhoKgfDY17ORc46CGIw==
X-Received: from wmig10.prod.google.com ([2002:a05:600c:140a:b0:47a:9f70:c329])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr156081605e9.13.1768912754423;
 Tue, 20 Jan 2026 04:39:14 -0800 (PST)
Date: Tue, 20 Jan 2026 12:39:13 +0000
In-Reply-To: <20260120115207.55318-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-2-boqun.feng@gmail.com>
Message-ID: <aW93cQq0Cyd9ivpE@google.com>
Subject: Re: [PATCH 1/2] rust: sync: atomic: Remove bound `T: Sync` for `Atomci::from_ptr()`
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
	TAGGED_FROM(0.00)[bounces-74626-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 494BA508F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:52:06PM +0800, Boqun Feng wrote:
> Originally, `Atomic::from_ptr()` requires `T` being a `Sync` because I
> thought having the ability to do `from_ptr()` meant multiplle
> `&Atomic<T>`s shared by different threads, which was identical (or
> similar) to multiple `&T`s shared by different threads. Hence `T` was
> required to be `Sync`. However this is not true, since `&Atomic<T>` is
> not the same at `&T`. Moreover, having this bound makes `Atomic::<*mut
> T>::from_ptr()` impossible, which is definitely not intended. Therefore
> remove the `T: Sync` bound.
> 
> Fixes: 29c32c405e53 ("rust: sync: atomic: Add generic atomics")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

there is a typo in patch title


