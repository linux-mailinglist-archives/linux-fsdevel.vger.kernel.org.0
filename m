Return-Path: <linux-fsdevel+bounces-57347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0985B20A38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712CC189A80B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EECB2DEA6A;
	Mon, 11 Aug 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k73R8cds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F312D77EF;
	Mon, 11 Aug 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918984; cv=none; b=rqSUkjsgl57EQPuDRpQSKX0n1i4XZCdaSgrAHfNjM+TOSlmuNlfpRsxaS5gQVZcLudWc9jX/USOjQxUAW6vikxI/YS/Ebu7pNZKWCmeGz4u4yBPLuTbRNH0dJ6Afj1uX8VdeS1Kv3N/LdRc375WVnN2kGlJgX2mGswUzTAHOGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918984; c=relaxed/simple;
	bh=IZ3wvkv63IesEvvPXCEb04QsAfvpGvn64Li4Jd/16Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idfw69HThw9NhKfZumAgKmERnmEvigIzcqzPs1YtBgnRMdIDXGcxTMWvW1Se6fCMxnsPxBmDoNalqFOyko4B0yMscgF/E3znEFpfBtgdh1Ht93h5rChx20f/YohdvAkNkbEp+t7zmfv7M/zY9iG0kLM7MjwXtBkRl6BEMQqfzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k73R8cds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6043CC4CEF4;
	Mon, 11 Aug 2025 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754918984;
	bh=IZ3wvkv63IesEvvPXCEb04QsAfvpGvn64Li4Jd/16Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k73R8cds/dBvx3cph4Kg0NCZBBbnknZoxSbx2nq/NI7ojCzvIDSO7V/A/R7OAPRbo
	 SBX8CwdI96xiePyMRuuhmTKml0PmrSI7u0bNC4J0WLMuABOt8XxvGPC359qU+SgsZn
	 sufctmnONQmCr55g94CfA5HFynUCR8XKvr4/J99Cwa5W7toHYWqMlDISFlzilRWHmP
	 NgOG1uKS6PaA8sSkV5mKYHZ/vxFrupDwxAnUDE5nhTsGNJ8f2b3XmtP1h90WVEiYW0
	 l2KQDQtseCI48OoicKSnYBDYlhjeVRi9L/ALadjmc60pKCHd/gXQO2imUym4G/7qqo
	 FWCxv9vo5kgbw==
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
Subject: Re: [PATCH v2 2/3] rust: xarray: implement Default for AllocKind
In-Reply-To: <20250713-xarray-insert-reserve-v2-2-b939645808a2@gmail.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <VsBkv88RSMICpG9KPe3i9REC7ElfySwTUyyWRfk9nGea5F7RxX7llxUd-lfFvGvw6fTVIKo8NOfWIt51BFngsA==@protonmail.internalid>
 <20250713-xarray-insert-reserve-v2-2-b939645808a2@gmail.com>
Date: Mon, 11 Aug 2025 13:07:37 +0200
Message-ID: <87sehyf75y.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Most users are likely to want 0-indexed arrays. Clean up the
> documentation test accordingly.
>
> Tested-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




