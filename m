Return-Path: <linux-fsdevel+bounces-43084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81DA4DCAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0953ABB2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98111201024;
	Tue,  4 Mar 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFitHzB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127C1F150D;
	Tue,  4 Mar 2025 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088119; cv=none; b=FdxHaKJ6eT+dbGs+XkiDRsxgw5esp+4f4oyTDViExjNm2qN9DUFxIvX8DrSb7fKXUM8ymEjO1a5uy/ytDrxguKCX9dc4glhnBW3ISUcpsJf9IQMkkLsw7UPSaViI68oHfePusevicz6J9fBxiPfGT6w9Phq5OWgMPY8QKTbw7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088119; c=relaxed/simple;
	bh=vGfyis5EROFVhdnxNgDSSiE3wb7Om/RbM1OEYQfxME4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mp2qb+8KQ7A7q3wO1wsonHp+ul6Pm/kiA4iWqK4ByrjUVrxm8zrKEMOnFrx9Y4dKPuNjnJ4lnZyvb4uPpp11RdsexuZXT1pKdfHBrr7JKYohvC6kK25nxnZGBsYFk/3zioRN7613OBg8HwQkLoOB/UMhPJegCaifB7z0AEF6ak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFitHzB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8B6C4CEE5;
	Tue,  4 Mar 2025 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088117;
	bh=vGfyis5EROFVhdnxNgDSSiE3wb7Om/RbM1OEYQfxME4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lFitHzB+5G6YoiPah3cPXXZqz2nSvj+Y6VRiUXd9QJBdeXYCw719x3ExH1CjiIh/E
	 1aho2dVoxyXHjl7z9JcpeMIJLQYcM28rLmxHVTObvyPQs8qiOZgA9otDJNnC7o2FcX
	 705keiZSDYjiEOnP6Qk5ZcmEmwN30gmhDEadI2JdTKwKEL3CdB9ua1xkJ9wqNgjHw2
	 +iRtQIo86ZZvenJVyvFIPH6dxxJHZ5yhtcVwnzqtWcNjs6GQEm5HVb3s+7hj+7jXRp
	 TmIf0Mvgw4oxmQQ7No9BFR+nzIH+NkFeodXEHQlu/cT6C1RaVO6l46diuNw8fVnMqr
	 rRJK7FYBohjaA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Matthew Wilcox" <willy@infradead.org>,  "Bjorn Helgaas"
 <bhelgaas@google.com>,  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>,  "Rob Herring (Arm)" <robh@kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v18 1/3] rust: types: add `ForeignOwnable::PointedTo`
In-Reply-To: <20250221-rust-xarray-bindings-v18-1-cbabe5ddfc32@gmail.com>
	(Tamir Duberstein's message of "Fri, 21 Feb 2025 15:27:40 -0500")
References: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
	<gkTqxLvcj88JAaKduIwkXgmxsh9Dq8t3iqVEAbfgc1UnIL7L5YNy3WNgqvx53WIZI9jdjB34rxpRdqU2585SUQ==@protonmail.internalid>
	<20250221-rust-xarray-bindings-v18-1-cbabe5ddfc32@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 12:35:01 +0100
Message-ID: <87bjuhhvve.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Allow implementors to specify the foreign pointer type; this exposes
> information about the pointed-to type such as its alignment.
>
> This requires the trait to be `unsafe` since it is now possible for
> implementors to break soundness by returning a misaligned pointer.
>
> Encoding the pointer type in the trait (and avoiding pointer casts)
> allows the compiler to check that implementors return the correct
> pointer type. This is preferable to directly encoding the alignment in
> the trait using a constant as the compiler would be unable to check it.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



