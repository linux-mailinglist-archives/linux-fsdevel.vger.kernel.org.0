Return-Path: <linux-fsdevel+bounces-41097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C266CA2ADF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093123A667D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375023535B;
	Thu,  6 Feb 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hosZAp3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDCD235348;
	Thu,  6 Feb 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859961; cv=none; b=TWFDDmJvpCwTtjbUJWzGst3ag17H8sATWp1q15fBUJXWscwPAGoLZIOAqziwoKGfNY4suw3HcYd3EiByBy65hPme+fbUYHypdKU803DKYqPrvmUsbzWOddrjS+K1AyXkhiYAfG9TSc1VnCHuK70B2v1gpf30Cbeuk6XzBUfXcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859961; c=relaxed/simple;
	bh=cSB+8BL1vn2xSufW9RaKHwHiQ7C6IIGaEYpBK07yY9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfnHJtleEpyTyHzhEudBtPFca5Df57zECUszIrWxCJE0oqNlEK+RekryV+pLcciW4+R2Hv73BlwifnKDicoJH8saNmW5EAmDBxJLrw3MS1qT1e2QzuudIug0srMjTgtz1E5Wm9OA3nDC+Eo4isoRtaJPs+S69iSzrKxz424uOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hosZAp3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA130C4CEDD;
	Thu,  6 Feb 2025 16:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738859960;
	bh=cSB+8BL1vn2xSufW9RaKHwHiQ7C6IIGaEYpBK07yY9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hosZAp3+8IvEJtXsqrJN5fmuaGLpevV9zp1PCYguuyWZRWUpjq+ii67Rb94z4g8hN
	 9VUMGvcIPDWUtB7K2rdApY105y5AxY4D4OSSVBg67Kz1ZT+G/RQNWbPQbmwKimKwAC
	 2C3oDvgH5BqzassbzyZCBuQpK/n2DhArsR5npGLGIf2R9/bJGeZNHDPxHUHOzu1vIe
	 MBJMiaOGCicY+wT6aVCa2x3l1Tigja3entSb25hHP8inZ3dzvfmIuk38aCE7WpdNah
	 mjeDZ+PLPNa5GoAkzrmyonNZskZvtQPnO5eLdy44NZ8BLG/zoOwIwX7mW0LMGpvnME
	 NxqTvKNkcJ5Pw==
Date: Thu, 6 Feb 2025 17:39:14 +0100
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
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 1/3] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <Z6Tlsn2RIiE121Lg@cassiopeiae>
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
 <20250206-rust-xarray-bindings-v15-1-a22b5dcacab3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-rust-xarray-bindings-v15-1-a22b5dcacab3@gmail.com>

On Thu, Feb 06, 2025 at 11:24:43AM -0500, Tamir Duberstein wrote:
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
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
>  rust/kernel/miscdevice.rs |  7 ++++++-
>  rust/kernel/pci.rs        |  5 ++++-
>  rust/kernel/platform.rs   |  5 ++++-
>  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
>  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++---------------
>  6 files changed, 77 insertions(+), 45 deletions(-)
> 
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index e14433b2ab9d..f1a081dd64c7 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -225,13 +225,15 @@ impl<T: MiscDevice> VtableHelper<T> {
>          Ok(ptr) => ptr,
>          Err(err) => return err.to_errno(),
>      };
> +    let ptr = ptr.into_foreign();
> +    let ptr = ptr.cast();
>  
>      // This overwrites the private data with the value specified by the user, changing the type of
>      // this file's private data. All future accesses to the private data is performed by other
>      // fops_* methods in this file, which all correctly cast the private data to the new type.
>      //
>      // SAFETY: The open call of a file can access the private data.
> -    unsafe { (*raw_file).private_data = ptr.into_foreign() };
> +    unsafe { (*raw_file).private_data = ptr };

Why not just ptr.into_foreign().cast()?

>  
>      0
>  }
> @@ -246,6 +248,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>  ) -> c_int {
>      // SAFETY: The release call of a file owns the private data.
>      let private = unsafe { (*file).private_data };
> +    let private = private.cast();
>      // SAFETY: The release call of a file owns the private data.
>      let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
>  
> @@ -267,6 +270,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>  ) -> c_long {
>      // SAFETY: The ioctl call of a file can access the private data.
>      let private = unsafe { (*file).private_data };
> +    let private = private.cast();
>      // SAFETY: Ioctl calls can borrow the private data of the file.
>      let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
>  
> @@ -316,6 +320,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>  ) {
>      // SAFETY: The release call of a file owns the private data.
>      let private = unsafe { (*file).private_data };
> +    let private = private.cast();
>      // SAFETY: Ioctl calls can borrow the private data of the file.
>      let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
>      // SAFETY:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 4c98b5b9aa1e..eb25fabbff9c 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -72,10 +72,12 @@ extern "C" fn probe_callback(
>  
>          match T::probe(&mut pdev, info) {
>              Ok(data) => {
> +                let data = data.into_foreign();
> +                let data = data.cast();
>                  // Let the `struct pci_dev` own a reference of the driver's private data.
>                  // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
>                  // `struct pci_dev`.
> -                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> +                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data) };

This change isn't necessary for this patch, is it? I think it makes sense to
replace `as _` with cast(), but this should be a separate patch then.

>              }
>              Err(err) => return Error::to_errno(err),
>          }
> @@ -87,6 +89,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
>          // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
>          // `struct pci_dev`.
>          let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
> +        let ptr = ptr.cast();
>  
>          // SAFETY: `remove_callback` is only ever called after a successful call to
>          // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 50e6b0421813..53764cb7f804 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -63,10 +63,12 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
>          let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
>          match T::probe(&mut pdev, info) {
>              Ok(data) => {
> +                let data = data.into_foreign();
> +                let data = data.cast();
>                  // Let the `struct platform_device` own a reference of the driver's private data.
>                  // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
>                  // `struct platform_device`.
> -                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> +                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data) };

Same here.

