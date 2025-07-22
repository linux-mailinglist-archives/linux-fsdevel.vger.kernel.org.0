Return-Path: <linux-fsdevel+bounces-55650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF1B0D41B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AB0189A10F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C42C08B2;
	Tue, 22 Jul 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WndJokWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339402D1901
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171550; cv=none; b=IGGGkK7ehSKgtVOx4htVe0B5CEA4HpUWySRX1iAdUGTLzD/DUhMIQgcn89ZKUKrQMyY1pg9vNood9V9xFE0OOmp6hoyavlQ61VGTfrD4i+/VH+m3AiVdaOybwt35/1YjMnCftglwMP0iQzeTZ7cuII3qrSPd2/o+kSpJMbQ2mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171550; c=relaxed/simple;
	bh=CnMJw8qgm8jE4iaGeacCGl+54rCiaQEFHAWsMGaI+Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWs4jyhIMoYzDr9t0a1qBQiu3sVxd+3citFGZPHg3EANEeqiSlmXKqSToNcC3q8+l/Cy+9dJkAYWXMmnPtWiD2sh33H7wZykAMWtI8OOiAOdBwRunzjw6ksw/8vkhVLa5cJucB56lB0No4pWEHwPuRlA55v5aGeuXyUOtxwGFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WndJokWB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4555f89b236so51318165e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753171546; x=1753776346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfjnB0RzVX1onEBaivwGgg3zlp9uwBQhMC1tQmetXyk=;
        b=WndJokWBT28u2yETPfCC7YrlyEJifav+jIGw/xBSJPHTnDNFZ+aeuTIfpXvlb5/pHO
         jZkxU6nbu5UI8HiS5qYqWMrWIqHFMrI6JKw++CChmJHqqg3QocwhEBb9NtXHkqEH7VD6
         DJEsogX32aKuVuOCk5GjLNmIc2FclSsojwP/WjXAtv1tDu51NZcH0DCWcb5VA/+jZJpJ
         LOF0HZGpnnWpFFJJ6zMnqvVsBBNd3l5lCExs6amkDLw7mYhJfqTUpBaFYpo0gYZtUaxD
         pNw+1FOFG3NycC+KotITYl/WjqY9kh9MKMwpYn0cPCrwfEJKbrSTVnoJJlvQvaalP8KW
         oKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171546; x=1753776346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfjnB0RzVX1onEBaivwGgg3zlp9uwBQhMC1tQmetXyk=;
        b=H213zR+ZN5euWSTNng+bU3CnSJG6/8UbUgH3ArIggdiANpc3D3ibcqroFretHSOgiM
         Mr/Wun9ByPdZUNUIU4gUB50bTj7HTNKDSDXVjrStueuZT0HuQ/dhvHOy0Zx7X5hbVpYt
         mim7LQTNqcrSTB7b0LiA8TC+2Y1d68pi3qbDcMuxWofs06AkgCWmIHx0kIvIc27ybZg3
         QuZL05THrpOJeDxjFDcmQ74ZsFCX42ZisGqxtmseeKUtnRZ9y2XjgFMJPN0W7w8cGLn5
         gMsVd4JD9+E3rcT3sjB/IrlKkrDIUgipgyFhluNgw2nL1d60w8+ZA66CUY1lsTACJmz4
         7GEg==
X-Forwarded-Encrypted: i=1; AJvYcCUpzEmB2zQjCmIwxycWegG+/0cenfjLqWCtqhBQaHsoAvKECyymCENztgwm7XEUsjUCbeUvAZ81kJwVcGPX@vger.kernel.org
X-Gm-Message-State: AOJu0YySZNZn8cOhHCF9wFcRo/3KgKjqin9BuXycS54vXyUfzhlEdVKV
	URPdylRekuhM/0I7etN0nkmFmJD0X/om0gOaKaR3d3pZ8erviVxc3s9kNfFFStrm+JS57+3NLyn
	rx7ZCQtQV6oC6lPJDzttjac9C8bnpIrnrWnvzhtjT
X-Gm-Gg: ASbGncvNPb4mogVn17uqNVvCe61i4TeGKPBjUARNZIdH+FROyMexcXNdi2iIpucr/4c
	8XpHZUPT5DhuAsZznZdUSedObljWkD/2WM3pP+H/c4LPdWHrMRf0zRLZNqp+1pFgHX9S8WWOydk
	s21QAgVWZOhzhF6obMDlSf1IMyxYznQdPAyoaCRcYWhZcZThAGgo9Es/mDYtnhF8+Js6Jz6+zp8
	H1ImKtAawQl2y0UTLkiVkapEvEdDx6yr7sK
X-Google-Smtp-Source: AGHT+IEw84d53XcRHbzMwCvvvMTy56CE5J7Uzvc/tFQgaHNn6AVGRHDi9rYuYRwr5tK4BOrSh62WYx6dB29oES2mpvk=
X-Received: by 2002:a05:600c:3589:b0:456:1d34:97a with SMTP id
 5b1f17b1804b1-456357faf96mr180725475e9.9.1753171546498; Tue, 22 Jul 2025
 01:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715075140.3174832-1-aliceryhl@google.com> <20250715-glotz-ungefiltert-70f4214f1dbd@brauner>
In-Reply-To: <20250715-glotz-ungefiltert-70f4214f1dbd@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Jul 2025 10:05:34 +0200
X-Gm-Features: Ac12FXzK4ugn78BVvJfIdwke3mdfyD7-O9XOG5GpvkZVg6h4YYAhyi_ttzdDW6U
Message-ID: <CAH5fLgg-yZ3C3r7psMJ7_rAC8Ep+OUMk6Kmek6u0VAB0RFnG+Q@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: add Rust files to MAINTAINERS
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:50=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, 15 Jul 2025 07:51:40 +0000, Alice Ryhl wrote:
> > These files are maintained by the VFS subsystem, thus add them to the
> > relevant MAINTAINERS entry to ensure that the maintainers are ccd on
> > relevant changes.
> >
> >
>
> Applied to the vfs-6.17.rust branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.rust branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.rust
>
> [1/1] vfs: add Rust files to MAINTAINERS
>       https://git.kernel.org/vfs/vfs/c/3ccc82e31d6a

Thanks! Just a quick follow-up on this. I also sent a patch for the
pid namespace file:
https://lore.kernel.org/rust-for-linux/20250714124637.1905722-2-aliceryhl@g=
oogle.com/

Also, I forgot to pick up Miguel's Acked-by, but I believe it applies
to v2 too, so you are welcome to include it in the commit.

Alice

