Return-Path: <linux-fsdevel+bounces-32464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0F9A6429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E45B27785
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917171EE036;
	Mon, 21 Oct 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLRBP4zu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18C1E5730;
	Mon, 21 Oct 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506882; cv=none; b=FiARp60K5XMj0CTI4ZavcJtF4kxgCOHtcgg1rsefMa8ou5gYPfCOh0zzGUjt2SQU4jVEPTPkyipoas9ZmF5ky4r9OGozTrpiVkSEzeJYPso1Bp2XMBDshZ0j579te/lPFx/1vHFfr+Z9PbVCFIMFTCCYvgN5DV/NN+HnDhRVgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506882; c=relaxed/simple;
	bh=mjX9MVMVhclTnc4n5WwSp4TANmX/e2dYI6+I3OGXrM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW6xRgh7i3/qUll4AbX80EHiWSqt3kM1JrBHHjA3D6OAbXsUzfi7WHuFHGKyEP0K/jb79/dt+1XQq3NulfH9wHCAsZJdgfCbhb2EaUN/0RSRK5vmJlj3piza6aLgZd81vjeUmkkpBHKoXhHAq4d8rZlmusHdWskPVpJ+ufVHpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLRBP4zu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so638717a91.0;
        Mon, 21 Oct 2024 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729506880; x=1730111680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzFUSvMKyC0pz/fOU3pg+dHf4nAOEco7zK0u7rPUR+E=;
        b=PLRBP4zuCloQ3q30a0HTI0oMApiF2iTydVLkXsa3YBLirRUneDM7LESd0XQRLWiFj8
         J9SYovWAlvUui+9Y3jK2sihQ/UlwQWhBycH1HPkAYG3Ldxo//ORCO8W7nCarAvZvw3j+
         qqq0gyAiBmvr3bAGXWdEFMvppePOACh/k63XIt6aKvvWrT4EHfUwRdththPwE+x58Bl9
         Ge79qMNbcuUkDIUhAYAGxo5/64WAaa7ysRsP1OQeAFXwDKre+oDmKluDkMPy/ntBBtbu
         UAE+a62zUiaDSEvUmXZV5hNQlwVy+VU8AlNOXDaEGEnvUM8+wbM//CQ4IvtocrMlfqwK
         BCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506880; x=1730111680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzFUSvMKyC0pz/fOU3pg+dHf4nAOEco7zK0u7rPUR+E=;
        b=nnmq2V+neuE9YHQ9Wc0Qkm9xMzswKs/wSAzqkQwgN8RtuvvVeLUbQqdzbrHdnKuZNm
         J5f0omVogVnkks3DM5mLb+5tlJL1h8lFiqaJycTlJLd2DmZG0vNcqb7KQ5O8N0xNah2r
         2tIpaSMYy/n9BXDPeZnvtFqyyEM+iFMT0zrX6VoRsPCG4n/5FUe9s05Tm1zOufcWZjcO
         Kx1/Rh67KwZT4W79a3LZWchfSLjbHt3c3NtVo4qhXro2xL4WXinQ97rz55Df/kBR4sOz
         juJSfurC4gmKGvcH4Y4HAEioSXBWZcaavNqwGjzvbkJaYL48NMnpIeGVsJQompZlavqS
         m3dw==
X-Forwarded-Encrypted: i=1; AJvYcCVvbqRkWdRnPJ0Y9qg5lU87h+rv30FyG7hZcxAyGRluJlmDblACruEWXfwBJJ71w+9KxZacuwAsxIt16UMt@vger.kernel.org, AJvYcCWtRz3gxzxywySh9M0JH6Os8/sHVFBSlmYtqoOGsDRBp226BtXPDqswMnXETVn3ylNDbhChBHUhjmzYkUZp@vger.kernel.org, AJvYcCXHipIaabcTxGBiNZ05LIkCB3Y7XoEbuJTf6+dsL0M/JYVjmnksSlVshs1CXl0m7Gpbw2P8sBBvrZS4T/ckJEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQffSXwfhHZc3HseNjzrcHGFC/eClSmpwUqDJV0vm8Qm5U8PT
	lH2Jh4oTC4LSxwC2PPJEVQpRsW10x63zI5cRPRnMRBAFtay0Y5i7pQgYK18GWwygxfpocTuCRdB
	R/opiEz5J8lMSTb92DpUlHmGRIT4=
X-Google-Smtp-Source: AGHT+IHs72T2YS0CYblRDY5uQQB8FSOkONT/eY4fUbSqnKoudjE1NHi3JiF+h9M17egu3eHQtLt92DJkFcFt5zla6HE=
X-Received: by 2002:a17:90b:2249:b0:2e2:c04b:da94 with SMTP id
 98e67ed59e1d1-2e5618d0f69mr5359896a91.5.1729506880370; Mon, 21 Oct 2024
 03:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com> <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
In-Reply-To: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 12:34:27 +0200
Message-ID: <CANiq72kOs6vPDUzZttQNqePFHphCQ30iVmZ5MO7eCJfPG==Vzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alice, Greg,

On Tue, Oct 1, 2024 at 10:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> +            compat_ioctl: if T::HAS_COMPAT_IOCTL {
> +                Some(fops_compat_ioctl::<T>)
> +            } else if T::HAS_IOCTL {
> +                Some(bindings::compat_ptr_ioctl)
> +            } else {
> +                None
> +            },
> +            ..unsafe { MaybeUninit::zeroed().assume_init() }

With the lints series queued for the next cycle, Clippy spots the
missing `// SAFETY` comment here...

> +unsafe extern "C" fn fops_open<T: MiscDevice>(
> +    inode: *mut bindings::inode,
> +    file: *mut bindings::file,
> +) -> c_int {

...as well as the missing `# Safety` section for each of these.

It can be seen in e.g. today's -next.

I hope that helps!

Cheers,
Miguel

