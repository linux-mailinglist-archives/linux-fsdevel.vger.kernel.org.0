Return-Path: <linux-fsdevel+bounces-41126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C4A2B43A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7AA7A207F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF8223308;
	Thu,  6 Feb 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6AULSlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978222257E;
	Thu,  6 Feb 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877800; cv=none; b=foe8PF4f4b7WlFdFxaaIXY5bPMnLE7tSaS/NI73RGZPt+wkuB1v3OSvcQC7ZFghtTqWAAEg3sRLPiJJnfiFll1+B5xwstBR9EmprQldiDdW20UebtQpKeFbus9Slx6qxRRRlbo0GqbgrXvM4sR290R78i4sOvrPq9YTl2GydzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877800; c=relaxed/simple;
	bh=nCwZyzhpC0hkV2m1x93EBihOAA8Sdpu3DRgaf+2cGTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If1CidTVkNWzG42u7Ti9R35cM3AOmL3GrA6nLFDTx5Idh5g72TDvdmgk1A1zg2hczx6mPeV1GtnKrfXVuNVbs8IKyjEm7dmWuHks+apiMuhegluLpexkzfj6eC6fNpIV+5gnXsU8rIKSgaIc0ynoW47u4pEofXuQMKFcFlTM0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6AULSlE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401ab97206so1531987e87.3;
        Thu, 06 Feb 2025 13:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738877797; x=1739482597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCwZyzhpC0hkV2m1x93EBihOAA8Sdpu3DRgaf+2cGTM=;
        b=U6AULSlEdtwCXKL+XU+5JZ7t/Ky74yjHIXFYYLtjvixYilC2Z6/dLOfnBIO0h6k5VL
         zO9MH2XTcpODLQkeJcVar6JVJ5mLfOy7hOzQcKiBRMiE4MqA9N1FqbwfoSF8DErKpOHe
         ahx4QeNj2Ixa7cHOXGuyAiZF13q0mOdWTgOkfJVpKIaairsz4qrkdYC0RAlz57CNTm0N
         VNCPMtPYEX3BYnWR40eqkqViChPmXVyPzVY0ZnQIbm+tBmMsI+MKM/4HI8WYyQ+IW1cM
         9uLRgLywyft6M1x+2cfbf2Zg6/Jt5sAu4oyhLpGzAAOBamecBzEunUe5OddJaVzkjM2J
         ra2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738877797; x=1739482597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCwZyzhpC0hkV2m1x93EBihOAA8Sdpu3DRgaf+2cGTM=;
        b=IraD7VEnxTzw11KO/MpaH5Sf4eoB3egb2rEul+ckvVbdZFguplGAzhQ3aqGnIvWJBu
         9GY7mMuqhx43PNWx1G0TWaFy6cQ4+nDwQbUdrVZ+zT1K+uopyMtV4uWocvCcGGCKR8oM
         wY1V5shkY7B4syTkDqBzCop8dZ1qYtfFf6gSujnmTxwbzt/HWAwEiZXH8SD01oPgTNpJ
         11kGIQWZVh7+qkrYRz5uhWNgNuFp1yVWdFXq6D/uwxRM83wG/xRxMRuPERSQHEHOb7y8
         kK4aZmXt7w6SIUTT3Fjv5YTQWCHAEHuYe7Kr2EERGycEfj6q3lw7oxPAre4ezo3eNezU
         Bcjw==
X-Forwarded-Encrypted: i=1; AJvYcCUGRT1AOnQPY+3NCz5XgTTvaJzYaa6XAkJ00nWqPv/Ml5e76Pu6Sf8DtKkjmMM9HJjMlWYKAWEEpY/B@vger.kernel.org, AJvYcCUY4KPfQ9wqbfdxQIGRZ4/CXXGnGBF3i2juzoHUgYkaadNLZKM2m/4GxjU1kraIASLqY6YjN2qVImFpz1oz@vger.kernel.org, AJvYcCWPlshqPFmjLbf14TiHqTf9sFbuqSoXWSyiJz8CcvshaTkGBvOAN5adtS34A1TyP8hEndYh/vRtfk7nS6Yd@vger.kernel.org, AJvYcCXfVjlgeASMfrrPBJRYqyIrlSjowY1glt5F7mD7Gtyq+JbXs1PNiiNMroFeRs8IepkM8GU9ef1brgsxYuIAuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzcV1ObW1nY+fgiQOrU/MUXJqLmSMQYPl2JDj0NpZzcwho6tj
	uQ9SujkQ5xMkZF64bMSCxoF4e381HGHgCCxton9vXwcOygZljRn+T0xk3QmWauEjRfq7hBwIgWb
	i3Fvmq6VsjfOMV39pCGzVbWedaWI=
X-Gm-Gg: ASbGncsR/mSKi/naLJgT/NB8AnTCPynZ4vHa1IZaFFPU0KcDIWW0h2jcU22Z6jaa3FD
	Uj8G9aaPMsgtiyjNhka5faaEtadH5U88p0xhVEQq1Win3z4dQa26SgvXsxswNixt8Er67S4Jh+B
	emy5udZq//8D34OnAfxCtqxtYSG/4z
X-Google-Smtp-Source: AGHT+IFKsZ4neZ3WNle2nn5hNbX0wbEg2tMqnTVyt1oi7sWysli/k1ZAwtqDYExTcUt41YFmoVh1a7cBIrlW1sD9mcc=
X-Received: by 2002:a05:6512:2814:b0:544:1201:c0bb with SMTP id
 2adb3069b0e04-54414a9649emr111216e87.2.1738877796593; Thu, 06 Feb 2025
 13:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
 <20250206-rust-xarray-bindings-v15-2-a22b5dcacab3@gmail.com>
 <Z6Tu8E4r5ZEolFX1@Mac.home> <CAJ-ks9nGZCMjgTTzeRz3DUCQyLVu-xWKau4AFkMGutLtomK-fA@mail.gmail.com>
 <Z6UiNYOTUshEKNcL@boqun-archlinux>
In-Reply-To: <Z6UiNYOTUshEKNcL@boqun-archlinux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Feb 2025 16:35:59 -0500
X-Gm-Features: AWEUYZmUCZ0vWErylmSBmkD9QhhwDT4zy6MbR2nP6txP7jrlOwmvXIgfTGOJo9o
Message-ID: <CAJ-ks9=urZ54L5NkoyUw5rk+kSqJ1kS6n20WbC4THACU-TFfrg@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] rust: xarray: Add an abstraction for XArray
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 3:58=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> Your call ;-) It's a nitpicking after all, and you're the maintainer.
> However, I do want to make the point that being a bit more comprehensive
> won't hurt when providing an API.
>
> Regards,
> Boqun

Point taken, and I appreciate your feedback! I went with something a
bit more informative without being repetitive, inspired by std again.
Will send v16 tomorrow.

Cheers.
Tamir

