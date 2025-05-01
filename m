Return-Path: <linux-fsdevel+bounces-47814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51098AA5BED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EED31BC6A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E4265CD6;
	Thu,  1 May 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUoQIEcX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B91EB1BC;
	Thu,  1 May 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086886; cv=none; b=PUmf9S59pU1knTjhWnBgxxT58OqkJosFlsVQFvtmt68EdGUQDfi5ukPEFQdW5D1XA9xXvl5D6Ikp247tESMrbx63PIrlU7d4zEJc8dMXtsS8EIhfGuAG9GFZ+GzPM6N2kAQYr6W0wIU0gyha+11/FTzFws2nnJiezFMvoz//MRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086886; c=relaxed/simple;
	bh=IStBRnpyyrHvlZPdYcBnykN4iVCRJyDlookDYaJRMfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrNkqaVltD8qbb9/lW/jpZZ24Y2lrt8je0DF4kItGdkU653Rhf33sHkFJXZtZjCGNpLnTqtkz9EREU/uFG2XHB58Q9v3GVN9BmptCYZdKDAvsW0uGvlnq4Ke3B4seFWwvWjuiBsOKxU0sADbyr8cYsTn5IphNl+Ws92tNU45vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUoQIEcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2CC4CEE3;
	Thu,  1 May 2025 08:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746086885;
	bh=IStBRnpyyrHvlZPdYcBnykN4iVCRJyDlookDYaJRMfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PUoQIEcXTaYGPpDgDZBPPM2Nx0CfYuKohnsinfUyx+0lLFL+wophwPydaq6iP70U/
	 olzoJuMDUNb58lF8UXmWhX502Keys3kn4tbH2R1JhC0g0QpFVASWovUtYpBUb3Ye69
	 PYERBZ9qwMwWyj2usDUUICp371jE6oR9vxRQZWO3H7nUF814ZDrtOLNO1Vodsn7cxv
	 Uq3GM0pbkcCRWMHqW9zQ5SPkOiDOUXMiPfPZXprMC0LY+kLtDzXLA4GxnxMICJYzWR
	 OSIZARWloIDSlZ4QQ2GxZy23/+lpOhVvwJlp5Kjwg3Ah0orExSViCQJfU/I1qBnt+L
	 F/ID36einUWzg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Tamir Duberstein" <tamird@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Matthew Wilcox" <willy@infradead.org>,  "Bjorn
 Helgaas" <bhelgaas@google.com>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "FUJITA Tomonori" <fujita.tomonori@gmail.com>,  "Rob Herring (Arm)"
 <robh@kernel.org>,  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
  "Asahi Lina"
 <lina@asahilina.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 1/3] rust: types: add `ForeignOwnable::PointedTo`
In-Reply-To: <CAH5fLghKLZR7i6YQk8cQrvfOr11xEKia5LHtj1fn8dD3Stv0dQ@mail.gmail.com>
 (Alice
	Ryhl's message of "Thu, 01 May 2025 09:17:27 +0200")
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
	<20250423-rust-xarray-bindings-v19-1-83cdcf11c114@gmail.com>
	<20250430193112.4faaff3d.gary@garyguo.net>
	<CAJ-ks9nrrKvbfjt-6RPk0G-qENukWDvw=6ePPxyBS-me-joTcw@mail.gmail.com>
	<O9Mwwb_kcAVFpynz6f5Cjax4QQ7IJt8Mr55uZncKwzD61jq6aau--57jVhqRVzIsejnCsiNeMpDUoH8-80q7JA==@protonmail.internalid>
	<CAH5fLghKLZR7i6YQk8cQrvfOr11xEKia5LHtj1fn8dD3Stv0dQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 01 May 2025 10:07:49 +0200
Message-ID: <87y0vg21pm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Apr 30, 2025 at 8:57=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> On Wed, Apr 30, 2025 at 11:31=E2=80=AFAM Gary Guo <gary@garyguo.net> wro=
te:
>> >
>> > On Wed, 23 Apr 2025 09:54:37 -0400
>> > Tamir Duberstein <tamird@gmail.com> wrote:
>> > > -impl<T: 'static, A> ForeignOwnable for Box<T, A>
>> > > +// SAFETY: The `into_foreign` function returns a pointer that is we=
ll-aligned.
>> > > +unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
>> > >  where
>> > >      A: Allocator,
>> > >  {
>> > > +    type PointedTo =3D T;
>> >
>> > I don't think this is the correct solution for this. The returned
>> > pointer is supposed to opaque, and exposing this type may encourage
>> > this is to be wrongly used.
>>
>> Can you give an example?
>
> This came up when we discussed this patch in the meeting yesterday:
> https://lore.kernel.org/all/20250227-configfs-v5-1-c40e8dc3b9cd@kernel.or=
g/
>
> This is incorrect use of the trait. The pointer is supposed to be
> opaque, and you can't dereference it. See my reply to that patch as
> well:
> https://lore.kernel.org/all/CAH5fLggDwPBzMO2Z48oMjDm4qgoNM0NQs_63TxmVEGy+=
gtMpOA@mail.gmail.com/


For reference, the outcome of the discussion yesterday:

 - The use of `ForeignOwnable` in the configfs series is not correct. The p=
ointer
   must be opaque. I will drop the use of `ForeignOwnable` and adapt
   `Arc` methods `into_raw`/`from_raw` instead. I had a plan to make the
   code generic over the pointer type with a bound on `ForeignOwnable`.
   A new trait is required for that now.

 - There may be a use case for a trait that allows passing ownership of
   an object to C, similar to `ForeignOwnable` but with a non-opaque
   pointer. Trait methods would be `into_raw`, `from_raw`, `borrow`.

 - The solution for alignment adopted in this (xarray) series is not
   ideal. However, given the timeline we will proceed merging the series
   as is, and then change the solution to the one outlined by Gary in
   the next cycle.

@Gary you mentioned an implementation of the solution you outlined is
already posted to the list. I can't seem to find it, can you point to
it?

Best regards,
Andreas Hindborg



