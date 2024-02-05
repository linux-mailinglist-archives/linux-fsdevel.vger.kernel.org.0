Return-Path: <linux-fsdevel+bounces-10293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE48499ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D842854A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF71B953;
	Mon,  5 Feb 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YlIgIGRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F321B949;
	Mon,  5 Feb 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135521; cv=none; b=YjtfuaaIwWEFwcfaeMG0xiKygAVhRLyrIAUvMYUfuSrOtS8LjTROEa9pLjyr0IagTGqiwUw54kB2Vslk8+MN8bBZEtbxmByx4KiLfGQZHRi/nQo3KvFDM2duwI7CCEYUNDAxbDDX1m9Lio5C33lMtr1T26mPWmdHqRR4BhF8+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135521; c=relaxed/simple;
	bh=Ysr9xtLV4DrX5hUg539QdBNlVtKZkT6XZzfhMfs+j3I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9dMo+somAlgjlrOJoNQ16pBqxr46RYuURV2LF09pFe497HRYgftXRT+j/7/IF7XxR+jP7wIOuLGca8uAU0vkR3pEQewTTD7iKa/2mzxkSVdshwwul70PBgwERP/0yol+fX4M2+YCsMGm9hN8TjGh+PVhB1X50DJc5jPMsR8cMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YlIgIGRf; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1707135510; x=1707394710;
	bh=Weor1BS+GjUl++QK7p/VyHltAw7gfa56ze5aB5NLLeI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YlIgIGRfvEO3k9det+3i+l6muBxeH6zeZ/tcO+ysqcA7PsuK0N3Qv/Ha33jOIcnmj
	 yK+bdDBG4loaRK9Spqh03gqrcUt9vT/ZQEIumTpvGX7/xC+wQc9/1lxMO2xG0rUtDT
	 N6SdpKi4xoBELSy+CXmjyz00NbUDH/B00083CyDe7nkIF6PqgYnC9i3CWptWgfmKaQ
	 GigpldkEtp5j40t8B9TqaFt5iQM/xCo+bErSmFKel6X6LFjIndoGuIQdZcURJLimAD
	 /pEZz4Ej8IxpAB1LiDW5SoR6Knx06fY4TXLHVcIPU2NISxsrI9kkmTtx70JuV6B82Y
	 4uUlOxpKq5tVw==
Date: Mon, 05 Feb 2024 12:18:19 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] rust: file: add `DeferredFdCloser`
Message-ID: <d35d9e56-02b1-45a5-aa72-2e82bde371ee@proton.me>
In-Reply-To: <20240202-alice-file-v4-8-fc9c2080663b@google.com>
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-8-fc9c2080663b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/2/24 11:55, Alice Ryhl wrote:
> To close an fd from kernel space, we could call `ksys_close`. However,
> if we do this to an fd that is held using `fdget`, then we may trigger a
> use-after-free. Introduce a helper that can be used to close an fd even
> if the fd is currently held with `fdget`. This is done by grabbing an
> extra refcount to the file and dropping it in a task work once we return
> to userspace.
>=20
> This is necessary for Rust Binder because otherwise the user might try
> to have Binder close its fd for /dev/binder, which would cause problems
> as this happens inside an ioctl on /dev/binder, and ioctls hold the fd
> using `fdget`.
>=20
> Additional motivation can be found in commit 80cd795630d6 ("binder: fix
> use-after-free due to ksys_close() during fdget()") and in the comments
> on `binder_do_fd_close`.
>=20
> If there is some way to detect whether an fd is currently held with
> `fdget`, then this could be optimized to skip the allocation and task
> work when this is not the case. Another possible optimization would be
> to combine several fds into a single task work, since this is used with
> fd arrays that might hold several fds.
>=20
> That said, it might not be necessary to optimize it, because Rust Binder
> has two ways to send fds: BINDER_TYPE_FD and BINDER_TYPE_FDA. With
> BINDER_TYPE_FD, it is userspace's responsibility to close the fd, so
> this mechanism is used only by BINDER_TYPE_FDA, but fd arrays are used
> rarely these days.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |   8 ++
>  rust/kernel/file.rs             | 184 +++++++++++++++++++++++++++++++-
>  rust/kernel/task.rs             |  14 +++
>  4 files changed, 207 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--
Cheers,
Benno


