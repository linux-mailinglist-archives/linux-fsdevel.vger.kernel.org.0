Return-Path: <linux-fsdevel+bounces-41849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29326A382A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316483A2D7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90BC21A443;
	Mon, 17 Feb 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF2WsCXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D822185A8;
	Mon, 17 Feb 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794380; cv=none; b=pz57ANKm9F1crhq+0NOXUVHdsf0Ul/n6MEjGZFoMBnII0lat23HWI/ZqicglecMnxJHXZthLtCy9YMlpDgV+L/i9ydtibeYR/jfZlqJBIm8LWZhDFsWWxPFMOG6xTdjsILi9DBgxKu2reLdWYmAuknKvfPxOH9msChS523mn3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794380; c=relaxed/simple;
	bh=VJNVrcvoIcKGWBC4m+wwvcuEU2F2sV9NM4ZPEjdhRA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti2g6STouqN97krAphPnZVywqT2hHIOAfayGT837V90l9BOIjuYlCdJ7AqXf/9YKmpXzBFnXGy3k8/rptlw6vMsxfjueEk0C8FcdU6mY1Q/rc53zOt8FV8HaSgCdCggZbWgDfXrjfrQsgHOw9OoRoIES/J0qaJz2kfXDFEVEfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF2WsCXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FC7C4CED1;
	Mon, 17 Feb 2025 12:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739794379;
	bh=VJNVrcvoIcKGWBC4m+wwvcuEU2F2sV9NM4ZPEjdhRA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sF2WsCXnNO2Mq09ZP8eSrQmmecWEJZ6QCZhrPgk69AgUzET9dlUqjJDIWCzUCPaXi
	 XgYLSeUO/aw0P3rJE8SbUet5UGF3b7SZFuw72dDnFbVXzCZXFmW7Cc4cXokrYIRKpJ
	 nni21nwzpaC1ZBEzhUMsTfl59HQ6Gc3+ZOkz35+gE+RRIUl10OF3Xhso+ULq/JLgCE
	 aP0VHmM27BR2OcELOO6pHlSLkKQcTPctahl1VztCZON8O1G2PIokz75s6hbUPjk3bE
	 0H2a1ekaqdCVSNMvyc9F3QB1b/UiWwaqe1WXhvTvcwhirt15WONul4o3b642kNFsH/
	 cBdb+gVEj0FEg==
Date: Mon, 17 Feb 2025 13:12:52 +0100
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
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <Z7MnxKSSNY7IyExt@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>

On Fri, Feb 07, 2025 at 08:58:25AM -0500, Tamir Duberstein wrote:
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
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>

I know that Andreas also asked you to pick up the RBs from [1], but - without
speaking for any of the people above - given that you changed this commit after
you received all those RBs you should also consider dropping them. Especially,
since you do not mention the changes you did for this commit in the version
history.

Just to be clear, often it is also fine to keep tags for minor changes, but then
you should make people aware of them in the version history, such that they get
the chance to double check.

[1] https://lore.kernel.org/rust-for-linux/20250131-configfs-v1-1-87947611401c@kernel.org/

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
>  rust/kernel/miscdevice.rs |  7 ++++++-
>  rust/kernel/pci.rs        |  2 ++
>  rust/kernel/platform.rs   |  2 ++
>  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
>  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++---------------
>  6 files changed, 73 insertions(+), 43 deletions(-)
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

I still think that it's unnecessary to factor this out, you can just do it
inline as you did in previous versions of this patch and as this code did
before.

>  
>      // This overwrites the private data with the value specified by the user, changing the type of
>      // this file's private data. All future accesses to the private data is performed by other
>      // fops_* methods in this file, which all correctly cast the private data to the new type.
>      //
>      // SAFETY: The open call of a file can access the private data.
> -    unsafe { (*raw_file).private_data = ptr.into_foreign() };
> +    unsafe { (*raw_file).private_data = ptr };
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
> index 6c3bc14b42ad..eb25fabbff9c 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -73,6 +73,7 @@ extern "C" fn probe_callback(
>          match T::probe(&mut pdev, info) {
>              Ok(data) => {
>                  let data = data.into_foreign();
> +                let data = data.cast();

Same here and below, see also [2].

I understand you like this style and I'm not saying it's wrong or forbidden and
for code that you maintain such nits are entirely up to you as far as I'm
concerned.

But I also don't think there is a necessity to convert things to your preference
wherever you touch existing code.

I already explicitly asked you not to do so in [3] and yet you did so while
keeping my ACK. :(

(Only saying the latter for reference, no need to send a new version of [3],
otherwise I would have replied.)

[2] https://lore.kernel.org/rust-for-linux/Z7MYNQgo28sr_4RS@cassiopeiae/
[3] https://lore.kernel.org/rust-for-linux/20250213-aligned-alloc-v7-1-d2a2d0be164b@gmail.com/

>                  // Let the `struct pci_dev` own a reference of the driver's private data.
>                  // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
>                  // `struct pci_dev`.
> @@ -88,6 +89,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
>          // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
>          // `struct pci_dev`.
>          let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
> +        let ptr = ptr.cast();
>  
>          // SAFETY: `remove_callback` is only ever called after a successful call to
>          // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index dea104563fa9..53764cb7f804 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -64,6 +64,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
>          match T::probe(&mut pdev, info) {
>              Ok(data) => {
>                  let data = data.into_foreign();
> +                let data = data.cast();
>                  // Let the `struct platform_device` own a reference of the driver's private data.
>                  // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
>                  // `struct platform_device`.
> @@ -78,6 +79,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
>      extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
>          // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
>          let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
> +        let ptr = ptr.cast();
>  
>          // SAFETY: `remove_callback` is only ever called after a successful call to
>          // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized


