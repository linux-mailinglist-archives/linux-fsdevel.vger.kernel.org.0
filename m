Return-Path: <linux-fsdevel+bounces-49971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE2AC67B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 12:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE524A3EF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203A27A124;
	Wed, 28 May 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2xt+j+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B397125DF;
	Wed, 28 May 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429530; cv=none; b=C12BkXP2c5sQ8LWUVt8ZMDf3KS6Qv8NRJveGKOO3GP1xOZuJZzdJ0Bj0Qbzg8ng//2rIflL8DdkeptfOwXxypOH2gIZSF+QjFDSugsOk5EDHT9UFpZ4bEP8vuC7y4SXhQLhPOJO9G3AEA/pCJuPad4MV+6Lrx0QS3Nywqo7CneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429530; c=relaxed/simple;
	bh=EUwrbpwQ1JOkb9+kiB9V360QHuBxmCHR7WtQ/iFAenY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nof9qWvd/7I7EN2fqS/apEc6vh7umu7u4lBEFzOHJivI/fP5fMW9XIwkEo2d7/6g03MIj31qjA6O1JBmUVRd8VPpfJAOtc6rI02899/zSY03oPzMPQdhLcKSwhhIch+hmWzX5wZdEykbmFiEwW6Q/cB2ZTxq6mEFFL7MOif9vQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2xt+j+w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742ad4a71a0so199337b3a.1;
        Wed, 28 May 2025 03:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748429528; x=1749034328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUwrbpwQ1JOkb9+kiB9V360QHuBxmCHR7WtQ/iFAenY=;
        b=O2xt+j+wCEaS+QHp6YhGGO8cY4J3q4mRsghyN3UE0enNZ4Ef7OAtxT/cbSxJtdWNj1
         kWXyKJdsQ0Zcw9WEqDA/53nkFgzbqlpxPIdbfQSZJHasJGiEFzkpvw4epPXBXJaOhvnD
         mMCLZ95DQB0LKWGriu8f2edTul5V0Ls+c39xH4gZvHZdE2e9/65SHQSHe3aEudFD7crz
         Ysbr8EFt7+4lHFgcW8IqDhcm7Xi40KwsPXgB0gbCE+OVakmy28QhBgSvL5epOEmVsY+4
         xlq4b9BV+lOQruWHbH9+fh+JoDezJW+Amwfpy9FVExbOcilSLz1EqcJiCDiIr1eWwHIn
         37YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748429528; x=1749034328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUwrbpwQ1JOkb9+kiB9V360QHuBxmCHR7WtQ/iFAenY=;
        b=qLlPOM6xDOVv+BQdpMQex7wWErb/0kpTRlZEdHcleI7UgK6tivsn/ANFzjnW0J9vHI
         bVOoWqbd5v/ipog8hRZ1zcjd5xuYHhaffDbz0IamR+1YjP2v7A7h32JhWgxn47v+tLri
         EuIOMflpqp22X44U8V5jqhq3Qm7UdSvJT8atCFNr0WJbUEZw0pMFWsCe+GUWzjb6KVHE
         l5K7FPgzLWwxTGQEoG+SwlqaxTvwge0WE+blpSTZM78diu4LYM2HJ4O9BGyt43VpPsbw
         g9u3VmlwbnwCf6Jio9g1pcQvFnoZgiQzduD9hNv126MI4fbpWGhvMJkJeU/MPdxsrQUj
         qpJA==
X-Forwarded-Encrypted: i=1; AJvYcCVVByZF2s+wBl9QiGx6gigldtI9pZ0bLstAfgckGMs5uoSQB7s9ll5fxkzTbwLpvg5yL4scuc/PJWzF7K2h6gE=@vger.kernel.org, AJvYcCXP6TxR064VQRnWOLmjdxx6P7tI3b9k4fGq/1EyRheU2nKKOGcatA60rrzFjXSB5ZJRQCG4NxNJluBR9sJt@vger.kernel.org, AJvYcCXWeDkmHetsTKQpz5EhUpL3Wq5rn+7OhJpfh8wkSND1YWU4T7ajMKzm1WRGdCLWwToN0kOOf+vvYQLnX1Sa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Za5IoxWBhV75pYTV2R86Hlh4mEe/YGw/M3DbwkYdGqU9gz8G
	4Twcv5+mmdIENOoh0GHVEr+mYXtA6mfZJ3uI78EJRnpw1jB8HbtH/7YiBdrdu4mpmw8cSvaFbgy
	Ydk5mpSOWLkbP86HOxj/JaurAZKmyPKY=
X-Gm-Gg: ASbGncvCUy2RvXg0KMwpmNOBiMCAv5NdeLJ/YXb6SwYwPJDUhqE/LmnmGiu7NhCv04c
	RsL23LKkFxCZvxlFAhiIPCnaBLdEinshYUCb7sCYeEjNBJI6Gix1fy+7O+EsSoiZM3r0uRT7ttz
	cJGeBdY/CUUIP7ecM6clhUVGSrDAkvhn+M
X-Google-Smtp-Source: AGHT+IHfPTHmMRq3pP+tHA4uSAtyuPwc0/J1qF3EQXD/6n+vSjrMqJsfUa8K4jNNDxI1FvsNq5ui0L1Iv30eHKTFeNk=
X-Received: by 2002:a17:903:181:b0:234:bfe3:c4b8 with SMTP id
 d9443c01a7336-234cc08f6f5mr10989035ad.2.1748429528426; Wed, 28 May 2025
 03:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527204636.12573-1-pekkarr@protonmail.com>
In-Reply-To: <20250527204636.12573-1-pekkarr@protonmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 May 2025 12:51:55 +0200
X-Gm-Features: AX0GCFur2ooyqiX9o0dgEJ1syY8B-ipKPG0HeMAxM-ke-LN9uVLyyNAo4K9MERQ
Message-ID: <CANiq72kgu+qKBFOUfcsF9fJkq78p+uBA6KAnpY1Uz5McT0y=SA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: file: mark `LocalFile` as `repr(transparent)`
To: Pekka Ristola <pekkarr@protonmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:49=E2=80=AFPM Pekka Ristola <pekkarr@protonmail.=
com> wrote:
>
> Unsafe code in `LocalFile`'s methods assumes that the type has the same
> layout as the inner `bindings::file`. This is not guaranteed by the defau=
lt
> struct representation in Rust, but requires specifying the `transparent`
> representation.
>
> The `File` struct (which also wraps `bindings::file`) is already marked a=
s
> `repr(transparent)`, so this change makes their layouts equivalent.
>
> Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`"=
)
> Closes: https://github.com/Rust-for-Linux/linux/issues/1165
> Signed-off-by: Pekka Ristola <pekkarr@protonmail.com>

Thanks Pekka, both patches look good to me. I will close the issue
when Christian applies them (or if I should take them, that is good
too).

Cheers,
Miguel

