Return-Path: <linux-fsdevel+bounces-1550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CD7DBE0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03BC281675
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D652618E33;
	Mon, 30 Oct 2023 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PhRquX5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3818AFB;
	Mon, 30 Oct 2023 16:36:55 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D40D9;
	Mon, 30 Oct 2023 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698683810; x=1698943010;
	bh=48kbBn6jkCTqXGMjhvy3WCOjTju2J1w8JsfGvQF5nCY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PhRquX5XYbL9cmO7eGIsQTKgbWiey1WWXX6Do83etj6fuvfXkDAqA3RenBNzoUVff
	 h1qpb0am7m9QzyFK+RNca7nXY/R5ImWaFT+NWuLrTxrMbub8JMoJfzElJ2ig2ayipA
	 LkCnen1dGXfizTga5QtT63EV8vhw8chLuSVS/tmVVvyreapStbIiSteQSdMMRFxhk7
	 cmlYv26RpBAxXc+vSJkjEY3yjUkqF/CHGqpYpwIHfaci7gURYLaNNiE73lQtyHJjju
	 QosB5KTUVI2oc1VPPcxLSzRt1mqoMSqDcXGQ/a/O4dmvh0isW00EEFUiJFX1pspbln
	 jRslf8uKPncBA==
Date: Mon, 30 Oct 2023 16:36:35 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, a.hindborg@samsung.com, akiyks@gmail.com, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, brauner@kernel.org, david@fromorbit.com, dhowells@redhat.com, dlustig@nvidia.com, elver@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, j.alglave@ucl.ac.uk, joel@joelfernandes.org, kent.overstreet@gmail.com, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, luc.maranget@inria.fr, nathan@kernel.org, ndesaulniers@google.com, npiggin@gmail.com, ojeda@kernel.org, parri.andrea@gmail.com, paulmck@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, stern@rowland.harvard.edu, trix@redhat.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, will@kernel.org, willy@infradead.org
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <Yx813Gi8SUJm_qipa7I_y1k7MYo3Sn8Hoyn_x4rSOcngjqEvS-os6Sbjkoavf0nUIymeYKrzdyLZdEd2aPKnXdDJ46cdPXyAyl33tAN_UYo=@proton.me>
In-Reply-To: <20231030135849.1587717-1-aliceryhl@google.com>
References: <ZTmelWlSncdtExXp@boqun-archlinux> <20231030135849.1587717-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.23 14:58, Alice Ryhl wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
>>> On Wed, Oct 25, 2023 at 09:51:28PM +0000, Benno Lossin wrote:
>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>> index d849e1979ac7..b0872f751f97 100644
>>>> --- a/rust/kernel/types.rs
>>>> +++ b/rust/kernel/types.rs
>>>
>>> I don't think this should go into `types.rs`. But I do not have a good
>>> name for the new module.
>>
>> kernel::sync?
>=20
> I think `kernel::sync` is a reasonable choice, but here's another
> possibility: Put them in the `bindings` crate.
>=20
> Why? Well, they are a utility that intends to replicate the C
> `READ_ONCE` and `WRITE_ONCE` macros. All of our other methods that do
> the same thing for C functions are functions in the bindings crate.

I think we should keep things separate, that way `bindings` can be fully
automatically generated. Stuff in the bindings crate is just an interface
to the C world. Functions are not implemented there, but rather linked to.

> Similarly, if we ever decide to reimplement a C function in Rust for
> performance/inlining reasons, then I also think that it is reasonable to
> put that Rust-reimplementation in the bindings crate. This approach also
> makes it easy to transparently handle cases where we only reimplement a
> function in Rust under some configurations.

Is it really going to make things easier? We would have to make bindgen
conditionally not create bindings for an item, so I think it would be
easier to just always have the bindings function and handle the
conditional reimplementation fully in the Rust code.

Having extra code in the bindings crate will also make it more difficult
to ensure that only abstractions use the bindings (we already have some
exceptions, but why make it worse?).

--=20
Cheers,
Benno

