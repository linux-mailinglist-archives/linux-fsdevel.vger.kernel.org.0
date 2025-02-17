Return-Path: <linux-fsdevel+bounces-41845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0EA381E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5079516F1E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC7218EB0;
	Mon, 17 Feb 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDhlAgJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56D218ADD;
	Mon, 17 Feb 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792153; cv=none; b=i3MiIZ+B34RJg0tsPCLrA8WVQekvvmDKTOmnrjpmYBBIZ9TU9m2WibMkI9Vw3tE/Y5+dLUbKu60FrMyc3liE55ICIRKFqYZ3GXzs7cgxpiquF1Ed3N1MgqieQBKoF3QqqP2/i3llAu3IfSaaVlomCAbAQ/FAJSUsNnQwvhTHfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792153; c=relaxed/simple;
	bh=+IGG54n1lmfSbU9emZ51GaDiateiqm/EMpg9ehhM86w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvR2P3agYKxaoFGK/N/ApxIYZfJnULwg+y8tV2HrHFCJXtkF3972FRDfo9Ipstz6BvR/TZUG3pilTivNUEWwxSF05PrAITbZk/xih2OjvQkDnYWoblleGKDjrb0IlhCe208kJIV59+LPlzNvjv6sVl5XqIQiSAF7M3VPYoCViGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDhlAgJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D6C4CED1;
	Mon, 17 Feb 2025 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739792152;
	bh=+IGG54n1lmfSbU9emZ51GaDiateiqm/EMpg9ehhM86w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDhlAgJWcH8yw/tYPDr27ADbMMiim3kxn9Fhxmq+D1Qt28Ejs7cIOjrGKbYcf2tvJ
	 CLlT7Xp/ZMcveUlu/EiJFxcWNe0nsQCg9Ji5p+sUZCSEqnXTKwwlkfAYcLLl4AE6QA
	 4iX+bPA+Rdw3W4gW29pNnEnDcUHXfds4lO+iyYWvqsVj1QU/3zlP1VQStSL8MzPQbX
	 9W7cu9s/cdLL+pX7sx342DyG0a1ARoir2Ja+se4d9nCE2/Mpo5hwSUnxBYbuSjN507
	 P0j3Pe3jhUEmoZVhT/ny9C0wTu/CXnBRy0ICie7Ba8WT+3m0gVAAn3jQwWgNWRXfm6
	 9dGkgbWLXXZcA==
Date: Mon, 17 Feb 2025 12:35:45 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v16 3/4] rust: xarray: Add an abstraction for XArray
Message-ID: <Z7MfETop-rGSNLFo@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-3-256b0cf936bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-rust-xarray-bindings-v16-3-256b0cf936bd@gmail.com>

On Fri, Feb 07, 2025 at 08:58:26AM -0500, Tamir Duberstein wrote:
> `XArray` is an efficient sparse array of pointers. Add a Rust
> abstraction for this type.
> 
> This implementation bounds the element type on `ForeignOwnable` and
> requires explicit locking for all operations. Future work may leverage
> RCU to enable lockless operation.
> 
> Inspired-by: Maíra Canal <mcanal@igalia.com>
> Inspired-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   6 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/xarray.c           |  28 ++++
>  rust/kernel/alloc.rs            |   5 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/xarray.rs           | 276 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 317 insertions(+)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index fc9c9c41cd79..77840413598d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -39,6 +39,11 @@
>  pub struct Flags(u32);
>  
>  impl Flags {
> +    /// Get a flags value with all bits unset.
> +    pub fn empty() -> Self {
> +        Self(0)
> +    }

No! Zero is not a reasonable default for GFP flags. In fact, I don't know any
place in the kernel where we would want no reclaim + no IO + no FS without any
other flags (such as high-priority or kswapd can wake). Especially, because for
NOIO and NOFS, memalloc_noio_{save, restore} and memalloc_nofs_{save, restore}
guards should be used instead.

You also don't seem to use this anywhere anyways.

Please also make sure to not bury such changes in unrelated other patches.

> +/// The error returned by [`store`](Guard::store).
> +///
> +/// Contains the underlying error and the value that was not stored.
> +pub struct StoreError<T> {
> +    /// The error that occurred.
> +    pub error: Error,
> +    /// The value that was not stored.
> +    pub value: T,
> +}
> +
> +impl<T> From<StoreError<T>> for Error {
> +    fn from(value: StoreError<T>) -> Self {
> +        let StoreError { error, value: _ } = value;
> +        error

Why not just `value.error`?

