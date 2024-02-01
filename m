Return-Path: <linux-fsdevel+bounces-9826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54056845412
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E1B285046
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442284DA1A;
	Thu,  1 Feb 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L1SpQ0ZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123AF4D9F3
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779886; cv=none; b=t8onh2sDrya2k6t704KW2fQiH80Oq2Xc+udvSwbe1NbYRAN+HbNn4AvLp2e+1vQtTFqobfI2YFBvd07KKnZNjB+HwlTIf9HEhCf5+ZvF7wGW96joUA5nI3lk5LnVww/+mZOwZG7uyulH9onsKDOGRRFHzXofrxrJLLDrCnlir78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779886; c=relaxed/simple;
	bh=Pxf0gkPUSV6ML8ezzNHzC2q4EU2zzV+BO6VfllDl0nE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKa3jFJVdYw/7kQSB8w26CwBjXYXjJlQnl7BlyvJB6c4V2OU0lCuUXm2T8R3m3Hiwf7GDcV3c27YtUzda+zxyAvcl4MzWaXmnhqQvaVjiu53bO4YBknxdGuO/uue6QOBFnD5iDnkMVgFY3cFMRBTScbljZ50Nh3FbCekQKWVHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L1SpQ0ZK; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706779872; x=1707039072;
	bh=/TpO0duNnWXfuRmnGBDmPg/iJAgdmf8+TRYZheB4zzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L1SpQ0ZKZj0vEZbuhSTKvRRrWW6xgW5wTGeQWEXnf0CAAopQ1uUuErf6ZJShY6zcS
	 DRaGadbR1O069/g9s9vLme57qnXWHn72kNrcA+mO+vh8yOp9yqaFlXTb1PwRQgWd0+
	 yMzbr7gTl8PCjvZnGQ92+rl6Ksv1VhFApC3vcrsIywUVB1RvQEjz2VuC/YV+PGkPj4
	 k/p04fwZ8Qntri1r7/csU62ytmv2qaweNFBv58TA9fTur7Ledik1jgashxmaq1QdE+
	 5FH7Pz+Zg34ZVOj9+l+Ra6iTKzPI46/NOfWQGZzlceuUHTmcnI2CvCI6wjt6ZDY/L/
	 WUXng+BOezWig==
Date: Thu, 01 Feb 2024 09:30:46 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me>
In-Reply-To: <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me> <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.24 17:34, Alice Ryhl wrote:
> On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>> +///   closed.
>>> +/// * A light refcount must be dropped before returning to userspace.
>>> +#[repr(transparent)]
>>> +pub struct File(Opaque<bindings::file>);
>>> +
>>> +// SAFETY: By design, the only way to access a `File` is via an immuta=
ble reference or an `ARef`.
>>> +// This means that the only situation in which a `File` can be accesse=
d mutably is when the
>>> +// refcount drops to zero and the destructor runs. It is safe for that=
 to happen on any thread, so
>>> +// it is ok for this type to be `Send`.
>>
>> Technically, `drop` is never called for `File`, since it is only used
>> via `ARef<File>` which calls `dec_ref` instead. Also since it only conta=
ins
>> an `Opaque`, dropping it is a noop.
>> But what does `Send` mean for this type? Since it is used together with
>> `ARef`, being `Send` means that `File::dec_ref` can be called from any
>> thread. I think we are missing this as a safety requirement on
>> `AlwaysRefCounted`, do you agree?
>> I think the safety justification here could be (with the requirement add=
ed
>> to `AlwaysRefCounted`):
>>
>>       SAFETY:
>>       - `File::drop` can be called from any thread.
>>       - `File::dec_ref` can be called from any thread.
>=20
> This wording was taken from rust/kernel/task.rs. I think it's out of
> scope to reword it.

Rewording the safety docs on `AlwaysRefCounted`, yes that is out of scope,
I was just checking if you agree that the current wording is incomplete.

> Besides, it says "destructor runs", not "drop runs". The destructor
> can be interpreted to mean the right thing for ARef.

To me "destructor runs" and "drop runs" are synonyms.

> The right safety comment would probably be that dec_ref can be called
> from any thread.

Yes and no, I would prefer if you could remove the "By design, ..."
part and only focus on `dec_ref` being callable from any thread and
it being ok to send a `File` to a different thread.

--=20
Cheers,
Benno



