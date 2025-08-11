Return-Path: <linux-fsdevel+bounces-57348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495CB20A37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8CB7A36F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620792DEA9B;
	Mon, 11 Aug 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHYQdHSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34C1F5820;
	Mon, 11 Aug 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918988; cv=none; b=czlyiJV/3qUQawsJLCD3Bx2qtW+N2GuyZ0nU9rjkszVVXorb6vXL0BY/lVa6vc8238JqauqRm6kDG5zLMubDwYnaDnOKs9vP59ORPWNm/VcC5oJf12LuuDA5cVan0ZPutsDyyx+fnY8QeQNlxYlpPzBMVcTHwnsINZgop6E61Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918988; c=relaxed/simple;
	bh=TgjO8kHAVKI3l7CYVMLzptQqzc2/jaFVmi388jyGESY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGCYg/t1TrSkEyHb5cQvnFiyel9UHMRwGZ42v/SJf372XcAKSeXc9WmnCMsvQ4sySfpyp9nSJ14GnlPhsQVsHz5BmZ0FVSpiLV6F42wGJ7dzgU1dG9/Rp105g6STPXga3MJLU3d6vpcN+XY4cd/llx+pDls/RziPubL6sffs5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHYQdHSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E83C4CEF7;
	Mon, 11 Aug 2025 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754918988;
	bh=TgjO8kHAVKI3l7CYVMLzptQqzc2/jaFVmi388jyGESY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nHYQdHSSsQwSWCD3WrYy07OaO4m86uNO8iyi3aw6PA55zHLFltaTHVJUygKn6D2GA
	 Y+UmhsiLOJ3RptaWumnpZZT3EVrIi746eRRBdDKeY1WVcqoZsuatOyykNiQxQFNbGj
	 5nHPIR4LS3w7UJvKIMLUD8vkAXFafB8oYjzL/KUiL8zEt7xrg+Rn6jh0utGwwReCvZ
	 nPF5SQ7W2+epSEgJ26xHgkiO3gPZTnBluEWwiv5/YQfkNMv0tpyfPmv0Ra35lLUyK5
	 kv7xn3kkbcotz4S40rFwfiuHybfIoFUDaUYQL6m9MEoAiZm8Dk2UOzQeN1lk/wk6ap
	 yNI4p5nOvyF4Q==
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
Subject: Re: [PATCH v2 3/3] rust: xarray: add `insert` and `reserve`
In-Reply-To: <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <iPv7ly-33WYOq_9Fait3DBD6dQCAn1WCRGwXjlPgNBmuj5yejzu0D6-qfg3VYyJfwu9uS4rJOu9o3L2ebudROw==@protonmail.internalid>
 <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com>
Date: Mon, 11 Aug 2025 15:28:11 +0200
Message-ID: <87o6smf0no.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, which
> are akin to `__xa_{alloc,insert}` in C.
>
> Note that unlike `xa_reserve` which only ensures that memory is
> allocated, the semantics of `Reservation` are stricter and require
> precise management of the reservation. Indices which have been reserved
> can still be overwritten with `Guard::store`, which allows for C-like
> semantics if desired.
>
> `__xa_cmpxchg_raw` is exported to facilitate the semantics described
> above.
>
> Tested-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

<cut>

> +    /// Stores an element somewhere in the given range of indices.
> +    ///
> +    /// On success, takes ownership of `ptr`.
> +    ///
> +    /// On failure, ownership returns to the caller.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be `NULL` or have come from a previous call to `T::into_foreign`.
> +    unsafe fn alloc(


The naming of this method in C is confusing. Could we call it
insert_limit_raw on the Rust side?

Even though this is private, I think we should also document that the
effect of inserting NULL is to reserve the entry.

> +        &mut self,
> +        limit: impl ops::RangeBounds<u32>,
> +        ptr: *mut T::PointedTo,
> +        gfp: alloc::Flags,
> +    ) -> Result<usize> {
> +        // NB: `xa_limit::{max,min}` are inclusive.
> +        let limit = bindings::xa_limit {
> +            max: match limit.end_bound() {
> +                ops::Bound::Included(&end) => end,
> +                ops::Bound::Excluded(&end) => end - 1,
> +                ops::Bound::Unbounded => u32::MAX,
> +            },
> +            min: match limit.start_bound() {
> +                ops::Bound::Included(&start) => start,
> +                ops::Bound::Excluded(&start) => start + 1,
> +                ops::Bound::Unbounded => 0,
> +            },
> +        };
> +
> +        let mut index = u32::MAX;
> +
> +        // SAFETY:
> +        // - `self.xa` is always valid by the type invariant.
> +        // - `self.xa` was initialized with `XA_FLAGS_ALLOC` or `XA_FLAGS_ALLOC1`.
> +        //
> +        // INVARIANT: `ptr` is either `NULL` or came from `T::into_foreign`.
> +        match unsafe {
> +            bindings::__xa_alloc(
> +                self.xa.xa.get(),
> +                &mut index,
> +                ptr.cast(),
> +                limit,
> +                gfp.as_raw(),
> +            )
> +        } {
> +            0 => Ok(to_usize(index)),
> +            errno => Err(Error::from_errno(errno)),
> +        }
> +    }
> +
> +    /// Allocates an entry somewhere in the array.

Should we rephrase this to match `alloc`?

  Stores an entry somewhere in the given range of indices.

<cut>

> +impl<T: ForeignOwnable> Reservation<'_, T> {
> +    /// Returns the index of the reservation.
> +    pub fn index(&self) -> usize {
> +        self.index
> +    }
> +
> +    /// Replaces the reserved entry with the given entry.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be `NULL` or have come from a previous call to `T::into_foreign`.

We should document the effect of replacing with NULL.


Best regards,
Andreas Hindborg



