Return-Path: <linux-fsdevel+bounces-41842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF3A3815E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258551891464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCCA217716;
	Mon, 17 Feb 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX6r5jEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A764192B71;
	Mon, 17 Feb 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790397; cv=none; b=KwTfRZGGPBzp3TAI/vXlbVZ8EA1Is1PPwGdWeuP96XUculVoL5p2foGfgTLmlQaW4ubDApjpUjPvbbkPuEGJ1tRTV5WSyXsXv/CCKEpB/BKx0WcKSOXLwN8t2qUgPtgdAkiDfOaiY9Q97WT0/k+CPsfwM8e87KVkXixspKIEa7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790397; c=relaxed/simple;
	bh=/uLSaQ8/AX+7JBzTXTWiDH8TY/nCHQokb5v2C5HJhw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN1p2BGvVSRn9mXcHfF4BqIqLqWYKPnkcZlWz0yc6Os900HdRDdgnAeFclqFyxm3Mavfr81Vt5aYp1Xxg/IA7UlsAyMOMMnC1GVnb//3hWKFcb61gNKPZi+jmAlUgsvZsIfXELvMjgXxK9swxJJDsO/6WgBIITdP5++nWDXONl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX6r5jEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401C6C4CED1;
	Mon, 17 Feb 2025 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739790396;
	bh=/uLSaQ8/AX+7JBzTXTWiDH8TY/nCHQokb5v2C5HJhw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VX6r5jEWVRxsmUicOE7V1g1y9XOm8FvEt3Vs/YU1sEcByQ6cpyVjZytcRc+BFq8mB
	 cT/4q5bzsvERnLCEA92BEhTCFMs+xdyaDKajGhu5MfY9558GlDq1CK6LyFTI0VHRf9
	 rGwtSy/mPV2KuUwulmryjZCWobMXz3KuTu27glMA8IGaO/0B3eyn6Vk1YeZzyIVpZG
	 KEOkZcRXURu67P4T5LYFh5vUTVJGgujq8NIB2kbWcsfzm3bpuCH+QwEdMujuH2T2+O
	 k8Bvmi6Q6BdTrOmyH0UdgcNIbgEh317qjZWNBEAFVyBTsRhmZMUfV3pnX1frotdFxV
	 m8UoQOJCOs8kg==
Date: Mon, 17 Feb 2025 12:06:29 +0100
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
Subject: Re: [PATCH v16 1/4] rust: remove redundant `as _` casts
Message-ID: <Z7MYNQgo28sr_4RS@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-1-256b0cf936bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-rust-xarray-bindings-v16-1-256b0cf936bd@gmail.com>

On Fri, Feb 07, 2025 at 08:58:24AM -0500, Tamir Duberstein wrote:
> Remove redundant casts added in commit 1bd8b6b2c5d3 ("rust: pci: add
> basic PCI device / driver abstractions") and commit 683a63befc73 ("rust:
> platform: add basic platform device / driver abstractions")

I thought of doing it the other way around: Do only the *required* changes in
commit "rust: types: add `ForeignOwnable::PointedTo`", i.e. no need to touch
this code at all. And then switch to cast() in a subsequent patch.

This way you don't need to remove (previously unnecessary) casts and then add
them back in.

> 
> While I'm churning this line, move the `.into_foreign()` call to its own
> statement to avoid churn in the next commit which adds a `.cast()` call.
> 
> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
> Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver abstractions")

No, at the time those casts were indeed necessary, because the types differed in
mutability.

"A Fixes: tag indicates that the patch fixes an issue in a previous commit." [1]

Even if the cast was unnecessary in the first place, it is at least questionable
to me whether this falls under "fixing an issue".

[1] https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statement-of-oversight

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/pci.rs      | 3 ++-
>  rust/kernel/platform.rs | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 4c98b5b9aa1e..6c3bc14b42ad 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -72,10 +72,11 @@ extern "C" fn probe_callback(
>  
>          match T::probe(&mut pdev, info) {
>              Ok(data) => {
> +                let data = data.into_foreign();
>                  // Let the `struct pci_dev` own a reference of the driver's private data.
>                  // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
>                  // `struct pci_dev`.
> -                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> +                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data) };

Please do not factor this out, it is unnecessary for what you want to accomplish
with your commit.

>              }
>              Err(err) => return Error::to_errno(err),
>          }
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 50e6b0421813..dea104563fa9 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -63,10 +63,11 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
>          let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
>          match T::probe(&mut pdev, info) {
>              Ok(data) => {
> +                let data = data.into_foreign();
>                  // Let the `struct platform_device` own a reference of the driver's private data.
>                  // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
>                  // `struct platform_device`.
> -                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> +                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data) };
>              }
>              Err(err) => return Error::to_errno(err),
>          }
> 
> -- 
> 2.48.1
> 

