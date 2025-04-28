Return-Path: <linux-fsdevel+bounces-47490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC321A9E8FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16418189C0AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E51DB366;
	Mon, 28 Apr 2025 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4NQSVEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E71D514E;
	Mon, 28 Apr 2025 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824487; cv=none; b=AQWXw5NSVU0iZDO6Yc60XPvcBle8AJCA+F1BDUi4hNod1rso2e/yu3B4M9Wh8Olt085L3dKoQuEGNgI9SedTOSJgzvXx+kdwECxqG9coYvhRwyEKTVZZK/i8PeUpaVzQgBOo7wR0HOJ2RSBaTNVRbjA1NGCRWTap8JMDUhQoPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824487; c=relaxed/simple;
	bh=Bzv1ncWrZjgkqy6XnIMS5/4bommgSxaGXnH8i64OXYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bP/aklkV8up0/Oyijshjn9AAFdeooIeMlc8peeX95bLNMwQn0OScrP9iFHHWZsdvSbGFovHCk1imPNPUgY47QLeK8LrE9Ea+kamHnLL0Q3avaOlbnWrrmvAJXzcGyEj91OdCNhnWkUBRh/H6VF7j7eK8TJ1yaZgtzVn4tyk79tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4NQSVEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601B2C4CEE4;
	Mon, 28 Apr 2025 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745824487;
	bh=Bzv1ncWrZjgkqy6XnIMS5/4bommgSxaGXnH8i64OXYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r4NQSVEksO3YmPYu/shJOPfU0zsD1qENe6qf71KvNgY9PINe/DYhnHzd81bPUYYmH
	 LMfg0cQCDnryLskd8OeY94gUhJqtsiiZQJqtDEYSeUG7fbE5v7mM/EeAcWoseTpKsA
	 ycShJ8XzJlX6DzBa0WzVrOAiJnCzm55qflEb/GhDw5Whs5Fd4BJw9aNxmGvHTx3UC0
	 n1EW6ZG7eQyixX0ZXcr9pFxjrWLf5rs3i+BO1HeulRu5MWmIWiZW7cs+Kb7Ru7TSSI
	 3o21mvezkCIsddByZVdCHKabnV1bd40qQvAQsngTBgFqU+iuOZVVo7MYZMD96s4bLW
	 KB9dKnazS4csg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Bjorn Helgaas" <bhelgaas@google.com>,  "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  "FUJITA Tomonori" <fujita.tomonori@gmail.com>,  "Rob
 Herring (Arm)" <robh@kernel.org>,  "Tamir Duberstein" <tamird@gmail.com>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 0/3] rust: xarray: Add a minimal abstraction for XArray
In-Reply-To: <87ldrl4mwp.fsf@kernel.org> (Andreas Hindborg's message of "Sun,
	27 Apr 2025 17:57:58 +0200")
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
	<174569693396.840230.8180149993897629324.b4-ty@kernel.org>
	<-4ES_myfpiIqBRA27qXi1g19UfFVV7HMTi9wB6PA5Zs-yv3UgTg3Rnq5nnUiNWz9b1cnux0LNB7K_0t-49B7Pg==@protonmail.internalid>
	<aA5Bp3Psj7yWg9wu@pollux> <87ldrl4mwp.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 28 Apr 2025 09:14:34 +0200
Message-ID: <87cycw4v1h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Danilo Krummrich" <dakr@kernel.org> writes:
>
>> On Sat, Apr 26, 2025 at 09:48:53PM +0200, Andreas Hindborg wrote:
>>>
>>> On Wed, 23 Apr 2025 09:54:36 -0400, Tamir Duberstein wrote:
>>> > This is a reimagining relative to earlier versions[0] by Asahi Lina a=
nd
>>> > Ma=C3=ADra Canal.
>>> >
>>> > It is needed to support rust-binder, though this version only provides
>>> > enough machinery to support rnull.
>>> >
>>> >
>>> > [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/3] rust: types: add `ForeignOwnable::PointedTo`
>>>       commit: a68f46e837473de56e2c101bc0df19078a0cfeaf
>>> [2/3] rust: xarray: Add an abstraction for XArray
>>>       commit: dea08321b98ed6b4e06680886f60160d30254a6d
>>> [3/3] MAINTAINERS: add entry for Rust XArray API
>>>       commit: 1061e78014e80982814083ec8375c455848abdb4
>>
>> I assume this went into xarray-next? If so, you probably want to adjust =
the
>> MAINTAINERS entry accordingly.
>
> Yes, thanks for catching that. I'm very much in the learning phase
> still.
>

I changed the branch to `xarray-rust` on my side.


Best regards,
Andreas Hindborg




