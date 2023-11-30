Return-Path: <linux-fsdevel+bounces-4425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E917FF65D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D57B20E86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B98B54667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Fq856kW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF110EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701359229; x=1701618429;
	bh=cEvdKECLsg9a2eLWYuxUSspqEsF3BY9+NgXdkgl9pLA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Fq856kW64t+MOtZ9Ri2JEdAgatjjoQSLmYDevIA3Kcr7RHttrKN4KbdCnbI9PusHJ
	 rwtQHx187GizzkFthkPho86Be0FHErw0oRWfivHdt55oypqmOy3Vv/BhzEiUIyMqD+
	 aUy7/X5YKAMNwD3j+31Gl4UZSSr3m1IU8J2JQaeGcAE0P7bWJ57bXlm/V/cofOl7F5
	 O2nhxEx9Q38GQaDffOZbXGoeNZhnIpSkz31NsFCMhC4faMKuUAgKBQFGYfzMWK/wMb
	 VUkmLOkkeW7ebZcomEoR8Ho6MNXhze1jkG+Z4tl6lssBaugVSYQTdAV/Z2ptY8jy7k
	 IpPHjB3xADRAA==
Date: Thu, 30 Nov 2023 15:46:55 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
In-Reply-To: <2023113041-bring-vagrancy-a417@gregkh>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-1-f81afe8c7261@google.com> <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me> <2023113041-bring-vagrancy-a417@gregkh>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/30/23 15:59, Greg Kroah-Hartman wrote:
> On Thu, Nov 30, 2023 at 02:53:35PM +0000, Benno Lossin wrote:
>> On 11/29/23 13:51, Alice Ryhl wrote:
>>> +/// Flags associated with a [`File`].
>>> +pub mod flags {
>>> +    /// File is opened in append mode.
>>> +    pub const O_APPEND: u32 =3D bindings::O_APPEND;
>>
>> Why do all of these constants begin with `O_`?
>=20
> Because that is how they are defined in the kernel in the C code.  Why
> would they not be the same here?

Then why does the C side name them that way? Is it because `O_*` is
supposed to mean something, or is it done due to namespacing?

In Rust we have namespacing, so we generally drop common prefixes.

--=20
Cheers,
Benno

