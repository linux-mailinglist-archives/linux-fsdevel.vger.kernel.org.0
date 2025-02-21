Return-Path: <linux-fsdevel+bounces-42268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3018A3FB05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D56425932
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C722153D1;
	Fri, 21 Feb 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPClOD6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CC1EE00F;
	Fri, 21 Feb 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154481; cv=none; b=eYryS5jpvYOBEP6AxQwiFAu2WsQnDpVdDjtIKbIng9FVv7YVl8XeyDTF91sUha54Z/AUrQmUmahlBEuKic1XcHRVK8ws5HbmR114BHzw2HK6mANTPHlj4lEtWgEFW0UlvDVd1Xpqe7vmTp6BuF+FJeuCJ8tdRangEy0GWKRRVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154481; c=relaxed/simple;
	bh=q/yMBMdwqNmNiSClnWPOPMejBody9Qva2/76W4HT7EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i39yRuu/2sGjyLPDZSdTYfEc2mGAnxgmZR4RMJ3322/ulFxf4kYwM7fC9Kj0wntiL5mS7rysVhZh8NT7yHuJZVUp4cttM9reQ5RQqub325WRQH51dGX+MOp0ObB/JpY9QzpFJEHG8ueMTcxDwG5d5DBds5UjsbJLUezeeT8mxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPClOD6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED0FC4CED6;
	Fri, 21 Feb 2025 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740154480;
	bh=q/yMBMdwqNmNiSClnWPOPMejBody9Qva2/76W4HT7EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPClOD6zeSze3Efb3J7FdxYeonBw/ZPIgJsjIkgV/e8eDMdzEc4gLeah+T0vHXcl+
	 M96IEfW7tqQceZEVh9LNpj/pE0B4hwgriUUGyDv9HVHWONOmPJ4P56FubkG4Mg6PVg
	 9NUPDfgFh81BmgQFtQoAveLI7nG9ikSClsCYWgMnD6sE2ka2ZAWghoB084lQ6Urjzi
	 v+1YeIXwt/dGaXAochvXBu1lpAtqvVWgOXD6JY1eM/vuCHMVvGxwfv5MGMTTxO8NXu
	 LGfcorQH+vkjtbrshSiBKxXTwjAlxWoOXbJcJuNBKd0MPlOv5TFBDEudpsoTJB5CAQ
	 5IvxCe+VkI/Dw==
Date: Fri, 21 Feb 2025 17:14:33 +0100
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
Subject: Re: [PATCH v17 2/3] rust: xarray: Add an abstraction for XArray
Message-ID: <Z7imafmrrK0_TO65@pollux>
References: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
 <20250218-rust-xarray-bindings-v17-2-f3a99196e538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-rust-xarray-bindings-v17-2-f3a99196e538@gmail.com>

On Tue, Feb 18, 2025 at 09:37:44AM -0500, Tamir Duberstein wrote:
> +/// An array which efficiently maps sparse integer indices to owned objects.
> +///
> +/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but more efficient when there are
> +/// holes in the index space, and can be efficiently grown.
> +///
> +/// # Invariants
> +///
> +/// `self.xa` is always an initialized and valid [`bindings::xarray`] whose entries are either
> +/// `XA_ZERO_ENTRY` or came from `T::into_foreign`.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::alloc::KBox;
> +/// use kernel::xarray::{AllocKind, XArray};
> +///
> +/// let xa = KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERNEL)?;
> +///
> +/// let dead = KBox::new(0xdead, GFP_KERNEL)?;
> +/// let beef = KBox::new(0xbeef, GFP_KERNEL)?;
> +///
> +/// let mut guard = xa.lock();
> +///
> +/// assert_eq!(guard.get(0), None);
> +///
> +/// assert_eq!(guard.store(0, dead, GFP_KERNEL)?.as_deref(), None);
> +/// assert_eq!(guard.get(0).copied(), Some(0xdead));
> +///
> +/// *guard.get_mut(0).unwrap() = 0xffff;
> +/// assert_eq!(guard.get(0).copied(), Some(0xffff));
> +///
> +/// assert_eq!(guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(), Some(0xffff));
> +/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
> +///
> +/// guard.remove(0);
> +/// assert_eq!(guard.get(0), None);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[pin_data(PinnedDrop)]
> +pub struct XArray<T: ForeignOwnable> {
> +    #[pin]
> +    xa: Opaque<bindings::xarray>,
> +    _p: PhantomData<T>,
> +}
> +

[...]

> +
> +impl<T: ForeignOwnable> XArray<T> {
> +    /// Creates a new [`XArray`].
> +    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
> +        let flags = match kind {
> +            AllocKind::Alloc => bindings::XA_FLAGS_ALLOC,
> +            AllocKind::Alloc1 => bindings::XA_FLAGS_ALLOC1,
> +        };
> +        pin_init!(Self {
> +            // SAFETY: `xa` is valid while the closure is called.
> +            xa <- Opaque::ffi_init(|xa| unsafe {
> +                bindings::xa_init_flags(xa, flags)
> +            }),
> +            _p: PhantomData,
> +        })

I think this needs an `INVARIANT` comment.

[...]

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
> +    }

Still think this should just be `value.error`.

If it is important to especially point out that `value` is dropped, maybe a
comment is the better option.

IMHO, adding additionally code here just throws up questions on why that
additional code is needed.

> +}
> +
> +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> +    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
> +    where
> +        F: FnOnce(NonNull<T::PointedTo>) -> U,
> +    {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), index) };
> +        let ptr = NonNull::new(ptr.cast())?;
> +        Some(f(ptr))
> +    }
> +
> +    /// Provides a reference to the element at the given index.
> +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> +        self.load(index, |ptr| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { T::borrow(ptr.as_ptr()) }
> +        })
> +    }
> +
> +    /// Provides a mutable reference to the element at the given index.
> +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
> +        self.load(index, |ptr| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> +        })
> +    }
> +
> +    /// Removes and returns the element at the given index.
> +    pub fn remove(&mut self, index: usize) -> Option<T> {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        //
> +        // SAFETY: The caller holds the lock.

I think we only want one `SAFETY` section with an enumeration.

> +        let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
> +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
> +        //
> +        // SAFETY: `&mut self` guarantees that the lifetimes of [`T::Borrowed`] and
> +        // [`T::BorrowedMut`] borrowed from `self` have ended.

Same here...

> +        unsafe { T::try_from_foreign(ptr) }
> +    }
> +
> +    /// Stores an element at the given index.
> +    ///
> +    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
> +    ///
> +    /// On success, returns the element which was previously at the given index.
> +    ///
> +    /// On failure, returns the element which was attempted to be stored.
> +    pub fn store(
> +        &mut self,
> +        index: usize,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<Option<T>, StoreError<T>> {
> +        build_assert!(
> +            mem::align_of::<T::PointedTo>() >= 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );
> +        let new = value.into_foreign();
> +
> +        let old = {
> +            let new = new.cast();
> +            // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +            //
> +            // SAFETY: The caller holds the lock.

...and here.

> +            //
> +            // INVARIANT: `new` came from `T::into_foreign`.
> +            unsafe { bindings::__xa_store(self.xa.xa.get(), index, new, gfp.as_raw()) }
> +        };

