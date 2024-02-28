Return-Path: <linux-fsdevel+bounces-13064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F085086AC3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0B81F2660E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D857BB16;
	Wed, 28 Feb 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3p3Lgxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4B7AE58
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116347; cv=none; b=Bd0uuBhUlq0vCQ20RmGCbfbeFabm7GraoCroLx7lkdEZKmXKCJienKP13nMVyGJtiioALujwBAiMURkiSqGyM6aMXLk/6W3Z8nCjlDt2b5ZpPyufVDJZB9b7n88duZjref768//+S6hucOj07ibX6o5P4vHvFe2JrsiAUM//cPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116347; c=relaxed/simple;
	bh=eCOxep2JCT2PqTXZsYJ/8apV2ocu8sSoosYXQ6yO0WM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=caaY6dNmaqq/v693kiRRr+n/qZ9LZePyUtnDEdAh5UEuRiX0wz1DdK+ZRjgxQaIPKe5OAo6ewdp0vhu875t9KaD8sgdmPpskyMYIrLhIqgpSF+jPghQaC1eEyXmrgPkFEM3WAd/o6/o6vvSnp5TQSehjbB2QDJ4ubZZEQ4DxJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3p3Lgxj; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d22ff0aad9so44699201fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709116344; x=1709721144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjKtoRx+UwcsrjRBtC9M6m/N9NX0zBaZF32zrstWcEc=;
        b=D3p3LgxjFbs3WhdtkcaogoT+eLYyFtyyUiX60lE6ckL6KIgJT4219YbXeW+EaM03r1
         4/LMgVmG6G6C9TkH8fK7QlHNvPppjBwUeK4vwwVC81/x3jp+XvtxYpn33maJIZxms3/h
         nVu+YvJfLI1zHMovWB8Lh44m9pcOFLgMtB8sJHRvG9Ct0G6pWS/S5os5tVaZ2efOC28j
         lK0BHVijjREk4WQllyLNqDWLfC36sLquRBzI7jLfKmdz1FTPeufyuOwTCxs0CgAFq/6J
         bVpquZJr3EPErelqj6IWEi/HowqYTzG7+QKj4WMUinkkU0SvEDxG/vH3oQuQMGsVgF/D
         Nctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709116344; x=1709721144;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CjKtoRx+UwcsrjRBtC9M6m/N9NX0zBaZF32zrstWcEc=;
        b=jNzTRxzTzAl3hzQ1jtFZVYi2r6FUz5Sp9KpZkmv1kQGC5Tb4znL1UNTLbqDevji+DJ
         R8sTajBoNJfuLtOL8Mf8T9OFJSupAUz3226eZZJD0hmLMebpeqYzGxqYyis3uSmUsCt/
         538O6ktCR1wcm+bS8aIihnTFE5+Ea/00yNvhYXHGGS3diRFw9U3oP9ytiMfS1UWtf4rc
         m9uPIlr/xkDtUJAcyYx4fFS9+7W/ugue3QU6j716ohNITMjx6NTVwpj5sm8uoUKGtTlD
         TDCywBPNP7rGmhVtzL9R9Ia5umW/aa2Mho+2idNRu3MnKNFlIWwz0DfEjuoHPtcptNP3
         jiFg==
X-Forwarded-Encrypted: i=1; AJvYcCVbvPQcduJhmGo7QuaRFCK2XNbTc2bckrmoi/uVgySEruYGrQuRGp2BMwLzeTzPSri5NgZvXkSl1iqX4y14+5hW2J91gRQcN7hQo72hUQ==
X-Gm-Message-State: AOJu0Ywos7M1IHwU/s3tg8Qh+szb9xEnoH68fYzQQcINNmZQNJ3d4P+L
	1heh1/EOax9lXptW7a0sfpYdq/CmF2ImMEiX4yZvy6QLI1ZHmyP08CQIBgyKRsDCaEW/12QthvU
	PcuvZyuLVuMtbmA==
X-Google-Smtp-Source: AGHT+IES6rAcCkmc4wG6UsFZKuwU47RDINdYd53eIctneIw/XlcbBtlnpOrLBuenHe1mzmxTBd64HBNpF8CmfKs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:aa14:0:b0:2d2:5a1c:700c with SMTP id
 bf20-20020a2eaa14000000b002d25a1c700cmr13274ljb.10.1709116343735; Wed, 28 Feb
 2024 02:32:23 -0800 (PST)
Date: Wed, 28 Feb 2024 10:32:20 +0000
In-Reply-To: <20240209223201.2145570-4-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209223201.2145570-4-mcanal@igalia.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228103220.3941367-1-aliceryhl@google.com>
Subject: Re: [PATCH v7 2/2] rust: xarray: Add an abstraction for XArray
From: Alice Ryhl <aliceryhl@google.com>
To: mcanal@igalia.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, kernel-dev@igalia.com, lina@asahilina.net, 
	linux-fsdevel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> From: Asahi Lina <lina@asahilina.net>
>=20
> The XArray is an abstract data type which behaves like a very large
> array of pointers. Add a Rust abstraction for this data type.
>=20
> The initial implementation uses explicit locking on get operations and
> returns a guard which blocks mutation, ensuring that the referenced
> object remains alive. To avoid excessive serialization, users are
> expected to use an inner type that can be efficiently cloned (such as
> Arc<T>), and eagerly clone and drop the guard to unblock other users
> after a lookup.
>=20
> Future variants may support using RCU instead to avoid mutex locking.
>=20
> This abstraction also introduces a reservation mechanism, which can be
> used by alloc-capable XArrays to reserve a free slot without immediately
> filling it, and then do so at a later time. If the reservation is
> dropped without being filled, the slot is freed again for other users,
> which eliminates the need for explicit cleanup code.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Co-developed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Sorry for the delay in reviewing this.

I have one important comment (the first one), and the rest are nits that
are not so important.


> +pub struct Guard<'a, T: ForeignOwnable>(NonNull<T>, &'a XArray<T>);

This stores a pointer to a `T`, but really it's the pointer returned by
`into_foreign`, correct? So e.g. in the case of `T =3D Box<U>`, you have
an `NonNull<Box<U>>`, even though the pointer actually points at an
`U`, not a `Box<U>`.

I think it's better to keep this as `NonNull<c_void>`, since that's the
type used by `into_foreign`. That also lets you remove a bunch of calls
to `.cast()`.

> +/// INVARIANT: All pointers stored in the array are pointers obtained by
> +/// calling `T::into_foreign` or are NULL pointers. By using the pin-ini=
t
> +/// initialization, `self.xa` is always an initialized and valid XArray.

Nit: usually invariants listed on structs use this heading:

/// # Invariants
///=20
/// All pointers stored ...

Nit: You also do not need to mention that you use pin-init to make
`self.xa` be initialized and valid. It's enough to explain that it is
always initialized and valid - the *how* is not necessary in this type
of comment.

> +/// Represents a reserved slot in an `XArray`, which does not yet have a=
 value but has an assigned
> +/// index and may not be allocated by any other user. If the Reservation=
 is dropped without
> +/// being filled, the entry is marked as available again.
> +///
> +/// Users must ensure that reserved slots are not filled by other mechan=
isms, or otherwise their
> +/// contents may be dropped and replaced (which will print a warning).
> +pub struct Reservation<'a, T: ForeignOwnable>(&'a XArray<T>, usize, Phan=
tomData<T>);

Nit: I don't think the PhantomData is necessary here.

> +            if !new.is_null() {
> +                // SAFETY: If `new` is not NULL, it came from the `Forei=
gnOwnable` we got
> +                // from the caller.
> +                unsafe { T::from_foreign(new) };
> +            }

Nit: Adding a call to `drop` here makes the code more clear to me.

> +        unsafe {
> +            bindings::xa_destroy(self.xa.get());
> +        }

Nit: Moving the semicolon outside of the unsafe block formats better.

Alice

