Return-Path: <linux-fsdevel+bounces-37377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7C9F1806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A25188A421
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD012192D68;
	Fri, 13 Dec 2024 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1aKSwA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97954723;
	Fri, 13 Dec 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125499; cv=none; b=Kku82jMvm9dXTEEndSsVop83lixz62OjEXuHN9wmYKDHDoINV0fhW060+tNr4Fjqg6GC8dnAD8A8J420sjmQcd+qRMIU3T/uSVxrQU5IaEbyKxyDTOU5Bw0rgXAauMqL+dmmCGo6/AnVxR6k1av8/xGeex+ujnCnTmpalE/X4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125499; c=relaxed/simple;
	bh=Tdw2S2HmeIZB1fPjjTmnH9JydpkyJAzun0VieOPlFNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAI6b7mcBD7aqKLF9WZBPmPGfGeSihbpbjmp2ociE1zRvQbj4uhWWgi5mqLU59F/2M7yTy83C5C1zKyvt+6081nh+1PHv8H9PoK0sX4wI1+DuzAkueKTNN9eE2JmMe1+LwfQ7zmfVcHobSp0Dq7qA2OSf580rTe+NavHuTJSlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1aKSwA0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef9f17cb7eso232651a91.0;
        Fri, 13 Dec 2024 13:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734125497; x=1734730297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdw2S2HmeIZB1fPjjTmnH9JydpkyJAzun0VieOPlFNo=;
        b=d1aKSwA0rO3dQNSTWc5B3M0G4Csg4jUiidpm0lJboIKFGxTH9k1K1l+D/gTxczk8sM
         2MmGv8lSD5GS9/AlBBStGjXON50hMHw9RRHNNzEYrmbEYu4JDhF/DgPKIQcHZFE2Uv4y
         PE9C8uX2NR/S5HDvAn9wTqAUoSQDucdj4I6dfaqno/LwTSliL39P/Au16ApyLL8ykOSq
         4NIswuF0sYLsGKoQqe9Vo7lWxGvWVbUqlDHnDd/gRbjGB8YCilBS5N/hKPdCC49izdKK
         OdEi9bZg4b0AhRaodMtvF+FvHoDwJQ6GZETwpINIW8KesKXWZyjN64zZnlpBJv0c+vLJ
         dT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125497; x=1734730297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tdw2S2HmeIZB1fPjjTmnH9JydpkyJAzun0VieOPlFNo=;
        b=YrWzAB7WZFKunfPoO/VhF6eaGzICRV+RiubGFn0hRL3Fes4nH8mWmijpCA3DahkRYd
         pGEYIvt9DbcP+JVNYxPZHAj9UVunYPp168CYLopmQEXX4a8LYVZ3YuXaaN21ArRAI8Iw
         5NWoxA3MpmWMxfMnQR9lE6n/UBw8YN73Jeq/YJbrs7z9o53lgYLF8cYp1oBeB5ebMN0w
         ogf0lo5TzCjBHQ36s2xOWKrfuLtaEgxCywk7rKwgfKI2U+XcOIQcCZZKBRwGHWvjp5/H
         kNswNjo4t372aEyEzAY5xICxi01WLomJjaDDzTqejiZl8v141krcewMI1sT4V63WXRly
         +pwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAtXBOOv3moZ6CyMUdoaaFGa8D+5NZ0bS2znbS5MyFWG7g5rPiG0CRHkm33XXaD0d64ehVkvGQGusadqpC@vger.kernel.org, AJvYcCUF14QD3hhpidpsyvng+xTa2XV2ZYfPgTeSj67HumgZMA2q/KjkI0n3BCGO5wH6BZygD9H2uVDO+N0/8TDo@vger.kernel.org, AJvYcCXudyKY4sYqHxSZyCGxRKdJ2Sq+sc6TIF9RVUOmkJZBW90WL8Em7ZlNFu82ovFnxC3uV/u89yn7IL9VEHXRCoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGUED5LE1Fny9Nhta7tBkmCsOVepZP7lT8G3QBf4VsiMuQdTx
	URvfyiN25jxjny8RzsSnavyk/kI70K3vXGV/PCZ9Aho4ubuww1RAypmzu0hq6UUBENiPsH62Ei4
	QmtrQmMFY0N8+DOaa1E5s8bl8YJU=
X-Gm-Gg: ASbGnctIa9s/d+586N3kWt/boHyTn8eijc5MfKGkaGMVULqwdE6vw+M3J7T4lbxMR+0
	8jqxdL3ZZNpUyYaIuuldKZjtAcIc2OwTGV3Ax5Q==
X-Google-Smtp-Source: AGHT+IFAVtty0UeHnEGnlZsztA5jzL61zW87GyiPaG1bFFzVRUydVVjtvNrAd5rpNqsjXrWI5NKPgcs8EQ7RO8nCblI=
X-Received: by 2002:a17:90b:224c:b0:2ee:ab27:f28b with SMTP id
 98e67ed59e1d1-2f2901ac1a9mr2377553a91.7.1734125495683; Fri, 13 Dec 2024
 13:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-rust-xarray-bindings-v13-0-8655164e624f@gmail.com>
In-Reply-To: <20241213-rust-xarray-bindings-v13-0-8655164e624f@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Dec 2024 22:31:22 +0100
Message-ID: <CANiq72mUoDFZuJZsfEbodXtXsVoHAXRDO27gBES3=uAOGZ6kfw@mail.gmail.com>
Subject: Re: [PATCH v13 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:02=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Changes in v13:
> - Replace `bool::then` with `if`. (Miguel Ojeda)
> - Replace `match` with `let` + `if`. (Miguel Ojeda)

Personally, I would also use the early return style in both of these,
like in C. I think you may also omit the parenthesis in the first one.

(No need for a new version just for this)

Thanks!

Cheers,
Miguel

