Return-Path: <linux-fsdevel+bounces-8297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8F83270D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02047283A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C13CF68;
	Fri, 19 Jan 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fG7uDGKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAA3CF59;
	Fri, 19 Jan 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657961; cv=none; b=UtCzfFIAtJJXBVE/u2aQpiRBKeuu/E+r8E9vJ0bFHg2VGX/4xb1ENNU5Al06OWDAp1YdpOA/7TxizLxNihkb6aM40AJkNQrXsLAOKaGcAgCIBykpG8dpmJ4IjF7Q19G6+Bysfq+qcMFZRGlv97CfSxxSTkXiVIX+N1tLpjvM1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657961; c=relaxed/simple;
	bh=1joX4KZ+kV0CTqHB1iy9vxHj/Ak6e8aHKe1GEqGcQFY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACv8XLgLhaDH/Kz4LgiywMTt1CVgS32WfrCmW21G+TOeiWgk1MarjQpSrdlQGM8qvPiRpAFaNg/wnvXKg6rWUM5190a50wEIdgsROkbkdTEKlBq3eb6H9eMwgpUbFgeIi9jGUqS1v2uJHCji1ABI9j474i199i4Y/gzChJmk+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fG7uDGKu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1705657957; x=1705917157;
	bh=1joX4KZ+kV0CTqHB1iy9vxHj/Ak6e8aHKe1GEqGcQFY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fG7uDGKuHeCF1IEE/UvU5/zkcTXEZSK8gsb8/UJVDYk0o2AUDjB73+EzXHs8NbcVO
	 MLm+j612RjN+2Mm0kpcFketVILRqQt+mUaoF/By41NYvqF0S6lwmWqlsdNaSa4K1Em
	 NGn0GCyhNQ8P97+QmtygxVk6ixCnYBdwooHHuCddhHuh8zoSxZQJSFP3+9I6zOBxpX
	 xWuJnoYkoDKRw6k8XfFb1DUmLpIEkeyVLzqqcdHTAa8toNNyuTshcrYPKVPbTuHadd
	 A+UpZeV+VXI8q9iE0o9jr+srNC+S4kfY/q+ZIdM6JLQK85p9X+T/KN244UAs834Aef
	 O1GKIBvKQRmJg==
Date: Fri, 19 Jan 2024 09:52:03 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] rust: task: add `Task::current_raw`
Message-ID: <cb69ffe9-c387-4477-92a9-8961c00de848@proton.me>
In-Reply-To: <20240118-alice-file-v3-6-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-6-9694b6f9580c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/24 15:36, Alice Ryhl wrote:
> Introduces a safe function for getting a raw pointer to the current
> task.
>=20
> When writing bindings that need to access the current task, it is often
> more convenient to call a method that directly returns a raw pointer
> than to use the existing `Task::current` method. However, the only way
> to do that is `bindings::get_current()` which is unsafe since it calls
> into C. By introducing `Task::current_raw()`, it becomes possible to
> obtain a pointer to the current task without using unsafe.
>=20
> Link: https://lore.kernel.org/all/CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCm=
X0Ang3tAgGHA@mail.gmail.com/
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


