Return-Path: <linux-fsdevel+bounces-54861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E4B04233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC1A7B16BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF02258CC1;
	Mon, 14 Jul 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abiq4bu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062D2459E3;
	Mon, 14 Jul 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504762; cv=none; b=tpM9PMVEJfcTepfFfsBqkoQhGtSa1upkkGPM6q0m52x99HlGJdT2MnU2SJrfMAAbmA5RXH2M+/notRLyEFsfKSQMNe3KHw98CUqsbRtwLjNtRneG++cepinQV2fjPe+FjENhs1FeHFOW6Jb35IYEhDtHMb8icdscsyxbYTXnjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504762; c=relaxed/simple;
	bh=ALwKxArqUoXjIR2QYQJYhe3QVGhssgLDNe8GTzcfYDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/Jc49vrhQlMS87SWD4TNg+B5w0KU995PGyxnemwyLAhpr7AoemEr08M3D8B6+I0WkH/gzjfl93eYx3zB/lag5241vkrV6gmNABY3Q/F84UZKBMIm6HAaIQEvJ98smpPNV2Lq8oFDQstfFcryh2ljVIYzaT5ZVsfSfgW1AYS0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abiq4bu1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so1073551a91.1;
        Mon, 14 Jul 2025 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752504760; x=1753109560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALwKxArqUoXjIR2QYQJYhe3QVGhssgLDNe8GTzcfYDE=;
        b=Abiq4bu1kDjPHELFhsJfEZru1NJjDVfGIFmyE3ZMjHOzho+iH4FIqclsNvxmDTdDNz
         uRQ++jJP1abvcQe7Rne3LeUYNkdyY1+vAgseopNIBIj5INx697/OI56YTxxsFASKXszb
         rmyqnyX0TFejoucQh/Uk8+njGRvv8XEghOESOYRb7N1+mEKU6Qvl02xf4+KB6bP7ivbU
         lOpG2LoXa4hlVwXDe4vU67egEMmYSP3PpE7zTLbLioh4ElqH7XlFuYX7QqP1YDDK+Orx
         iOvRrlMMKF40x4ElW0quiU8d9rWHHEBUJEDPo8i8n2eQi0GyMAkPZAfiFlR8ycMeUYW9
         uRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504760; x=1753109560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALwKxArqUoXjIR2QYQJYhe3QVGhssgLDNe8GTzcfYDE=;
        b=Kb42/ewOcZFx40nPyX+9BlVzcp+4rCs9f0wJ+C20u24KukverJFysHNoAodDtuvp54
         D5jFPo7d7gE3alyJy2q6/wWghzteD8Le/AkfnekpVMfD8V2masnowqoFIFmoxQzQB364
         PCw6aEc1jkEd0Mw6vGiVwtkVU31L4NXPtBTSAszXS8e1RL/u8FIASwnydK0/c/z+fAgN
         jWaZ/GPQ9OEI4gQ0h1lo067h+XizN2yIdaBVBRbOr1ysujuRJSXzl9tdozK+ExWapPw3
         B88vPIs2XWyIIx9np7ol6KwkQ7S/chzmoq5prYYYHsCihBRjE9nJCwAsajtxhjhqYnSn
         GlTg==
X-Forwarded-Encrypted: i=1; AJvYcCVit9mN2heFzP973QcCyx5Ja15wN0b4z70XBv3GpLwfP5GiMt+mOi3jvfUPRuvVZHC5v3HD7Xx5Q/ptgRrN@vger.kernel.org, AJvYcCVkdNe/ECoUmf/1NHEveZ8IcYBbiCGXV4vnwjBww4ok6Wo/fHooDkc7YPqh8kiQkROY1HvugyO4AaS3v4yCIvQ=@vger.kernel.org, AJvYcCXGemmoMD/bJUj9Swh9f9ShA4Dub07weTR6nLvCTnnf0G0zvppvD73Q3ZXtKPOZCMsOrEebTXuT8hOwREIT@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWRbyKlJg+9dEJY+KbQRQOTv1s26sPnFYpl4TMihvEX77aNpd
	EJbzT8rwQH6kSaZIaMlQyfMpuVnGpyKuwix5nwlf1eRQeO6R47+NrNEskeTtESu82t37qNLcOAv
	w92uT/ho/DH7sVryoTt3U1uAU1qPU7VI=
X-Gm-Gg: ASbGncusT2+EU7f9vWJksk8Kc5mgXrg44g4ye3j7MOp3oqZT5/XUNz/vUKNPdk59OdJ
	8lmXmSTK3omFHIKxlfU3lO+zLjvaiFl2Ii8Nz+AYYdL122KRCB972/jJYlWi8ljz1fkzmPviYPI
	ZKYUzrL+rkC/df2MKfS+p/U4/t9J/yuoiVBZfwvUKqcciwm93vc0rxc+9PXEF5P54LGx6WJT7Eg
	hW0oTsB
X-Google-Smtp-Source: AGHT+IHcwCJMDp1SPTbI63OWvldNiz/Uhdc0dLj+cXdt/zSQIRmR6AhZHlLW/nHhKTRYw6vPffpup4VPrUjiDiOeibM=
X-Received: by 2002:a17:90b:51cb:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-31c4f50be98mr7430463a91.3.1752504760367; Mon, 14 Jul 2025
 07:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714124637.1905722-1-aliceryhl@google.com> <20250714124637.1905722-2-aliceryhl@google.com>
In-Reply-To: <20250714124637.1905722-2-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 16:52:28 +0200
X-Gm-Features: Ac12FXzpYijkIhRenpWeLfB97hgjaloD3FOEkKcBbBD_Q0q-iICTPoaH6jjN_-k
Message-ID: <CANiq72nC6L9_SB6dQLn7AVjPguTucnuX_N_eA=iLh9qKDr9VWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pid: add Rust files to MAINTAINERS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 2:47=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This files is maintained by Christian Brauner, thus add it to the
> relevant MAINTAINERS entry.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Like the VFS one, I think this is what Christian wanted (which is
great, by the way):

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

