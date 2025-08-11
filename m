Return-Path: <linux-fsdevel+bounces-57346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF3B20A34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABE0188AC93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000BB2DCF73;
	Mon, 11 Aug 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4gDQG8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DEC23BCFD;
	Mon, 11 Aug 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918980; cv=none; b=sXUioHeqjhqFSpGB1sPuh22smBVXfbmZFHyOLgQtABWfSs4DMKSs97Jw24Qbbbn3iKOrEeruP4bETTBhx1iUV/wfpcxWIg7IfAfd35T2qdXL1f1+6sX4O7s6N+w2pvw21j2Hv73+2Yx/qVT9ckrHxH7lJM2eq8aXt9pGIH7dRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918980; c=relaxed/simple;
	bh=tWrn+wPReluOay6jKgPbiSLpygpjZ4fsY4oQPbzsdnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEQLRtgf+djT4pIuaULCRudb6IdbCfMwnZ9Ft/KIIBZg8ApFmHBo0JMXXN9UGLBRbY2vFPkqTEPlrDBEYY5lTmSrPvfqVU7/97uwvOhBonwSWBO0Kdu0D9SPzAE+H8BNc/3oPLSNPoZIR97wmH5ELq7WyoVS3Zlf9VUaOEb9LJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4gDQG8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D133C4CEED;
	Mon, 11 Aug 2025 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754918979;
	bh=tWrn+wPReluOay6jKgPbiSLpygpjZ4fsY4oQPbzsdnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W4gDQG8UbsccF4DaPC4V54uVda+9Q3ZSrPLN5Kxb/h8XnsU8QSqhIYxgcySxwgFlv
	 3TJaNxA1/OGx93NlaslZpWdcFyFL/EowPe9aNaT1O8IJgvie45RZTWa8oI+gVSo9ht
	 xgY5GJ09CBGeqJH+35sT4WLbkiLz5mnrlgmzhfbvkaehTboIFxsH9wDXnl+VW0UX41
	 B1lDvOTYw5027EYzV3FzhqB+cQL3SO4A+o31sd9JAQyp3w3BAuIN9ApIj/GL8idm+m
	 L8hTRdy6S570AVr5RZBJQplZ7yFzfphxWqR9BzPNO7s5NJIa5FYLrah0f/VmbfDE+v
	 fZzsLlFwhVWnQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Janne
 Grunau <j@jannau.net>
Subject: Re: [PATCH v2 1/3] rust: xarray: use the prelude
In-Reply-To: <20250713-xarray-insert-reserve-v2-1-b939645808a2@gmail.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <ZxXVGFugqt2ByHuv4YzuNyLfOkmahkJq-olAfJteFuvj7twpuzU4461l5hVOWldMI75V-uWr1aQpCtazPRYA0Q==@protonmail.internalid>
 <20250713-xarray-insert-reserve-v2-1-b939645808a2@gmail.com>
Date: Mon, 11 Aug 2025 13:06:16 +0200
Message-ID: <87v7muf787.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Using the prelude is customary in the kernel crate.
>
> This required disambiguating a call to `Iterator::chain` due to the
> presence of `pin_init::Init` which also has a `chain` method.
>
> Tested-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg





