Return-Path: <linux-fsdevel+bounces-53555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02184AF00D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41957AAECF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74427CCF3;
	Tue,  1 Jul 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg5PunUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4FC1C3306;
	Tue,  1 Jul 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388991; cv=none; b=jL+yRdak60CFZ7vk1sQLQ0JzALXLgYJzcJ2MKOS8cv/tD/6yG6xDp8NWhQ3QCX79vKyj7kJjU6ju6W5lGTQblVAcmUgthpNwiHMVhIvgMEE2hL0BKnZS+X+my7ax7bsnWgXfFe2GDC9VVaNBHsCCAAj1MMTeJm68XEC1kxwGnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388991; c=relaxed/simple;
	bh=0pW3TP/nGu93gQFVw2O41yC0Ln3jmgnyWGFF53ZWbI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnfMjktozqjV3KF/cercXR9+K5L2t4gil96NLSmaHeYtJDNmFvNXpvR9ohtf0Qc08Y02yMxRzV69oeS1DWQOREmvEQmr8NTZuDmvuoY4iyi4W4kV7V8QLslOSwLQ0n85d+4ANTowc1ul8AcqzvqUtDLZF9Mccrflsbc5IvpmvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg5PunUY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so1290616a91.1;
        Tue, 01 Jul 2025 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388990; x=1751993790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdOA3lpTZpeFzYmOyWPv0Y1QoQj1TrHSWxUR8VixR+Y=;
        b=eg5PunUYraAe77uAXRrnIG+MZT8AV1vQJYSn7tvUbpLyPhzF8YJqSFD/rI395IzCOU
         R+XdRZHXsje9wojskYaJTNCnMfeCfBunCBlAlyNSFaZYB5PdLU7QzYArboJp3bTaVd/E
         9IgW9/9X01mU0NnmDbVsa5KeOqeLMTYLEbak0aK1QNx+baUPnguo0CcxIALEdptPIl7g
         xRX2b2GEoZ5FijQaNyEoiLKE/Y25geAp69QGJyus991zaP5Ko0DjlSbHdSApsLOCjFT/
         euA6DdhACcYTEOJUK2cdFzT8z+WpG++GJFAYfDPAUKJNHIjv0H0GyiRx04xgwvAs9kDq
         P70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388990; x=1751993790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdOA3lpTZpeFzYmOyWPv0Y1QoQj1TrHSWxUR8VixR+Y=;
        b=h3pPYHyQwfKInamwgDghtnXOSD0D4z+NQbdfGnqW0NFqqvnd5dLic7P8j4DVo34yPZ
         3V80icsCQv9gfKUPZKf9xTu8db+NKZPXsvKbGu+pNGZUwcrE30SpjJ8w3B6mCEGqIZ7c
         YP9C/zn5bj1UwUe4EfdEImiT4RW29orhgiLYAwZwcqGjW81jTtVo+/skNiArvnDtA5mI
         SNhdPtnGeqPrC7lxOla5uzsl+N++TnDKeL/k95p3V2wCdR6upZoGe3t3HNKOLnjvQKfZ
         gq81WEuDe9a4NVXpCONjoPAeZFDacwRSyr643ehVug93tTJSNcySyz5jite4wlz7lZ/R
         CswQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAzH1vrcNI9AviNcCvsjJUwj6GIMQ3+4BsC32R76nN57oNCqkTfo+K0nYIr3vRwjd84iD//aUpUWsfU5uB@vger.kernel.org, AJvYcCWT6nFhiCfrMt+jYFbDclbDX/ZDvaLder90pk/hS14lTmushyDzf3sT+EJsp2mgesamKYyC0OLLwrddX6jb6Rs=@vger.kernel.org, AJvYcCXHKn0ZnLPx7qtS0pNAo8OG7t/LQJqjUzk9z/+OaI9iKEil8iJ7nf9h8/rFsNcneqvneAj6SbyokUiOoWhU@vger.kernel.org
X-Gm-Message-State: AOJu0YzEROc/f4iCYKuQp9X27Yh26ka/HSGZXXVkYt2cq87sa13EcLX8
	mDNL1cqZyzWZQAdhqwxwmoQ/m47jDvwQUXfrSi50Dm/HzNwR1gqYZ8KpHK0+yKC4vRul3QW70JP
	vqKyfGsVqx2QR/awCWF9JB3LdmF5yvheZ2FP94BFgCw==
X-Gm-Gg: ASbGncvG/3nTsPfB5A6PWQIocaS35UGKmkb34Icbun0n5230LBJz6CgwwrlxlU43fpv
	gvaFNXa0cBdq9eXKqKzxoC8jqPO9Sk8kA0/AsfvLm1UsNe3gHmvJuOS7YTSAQbxMZtYTbo329h7
	xror05TMoNu0HGFNxB+RC10vQrL3r4mC2YzvKyURU1/0LaN9oeqGQZsg==
X-Google-Smtp-Source: AGHT+IHbBSasC4FVI3lzENfix/hTaP0fBUH0mKDnnKo6XoONgyd/DDi5zgE6Flmur2I1ueeEbVilDJzopPJpcZD480A=
X-Received: by 2002:a17:90b:2ecb:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31951a12a78mr2098121a91.5.1751388989619; Tue, 01 Jul 2025
 09:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com> <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com>
In-Reply-To: <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Jul 2025 18:56:17 +0200
X-Gm-Features: Ac12FXzVE-UNW0TA4Ex_sS0i850xaRXXSEsIJ4SwFR7UgdwzUfddQlSdSNp4frE
Message-ID: <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, which
> are akin to `__xa_{alloc,insert}` in C.

Who will be using this? i.e. we need to justify adding code, typically
by mentioning the users.

By the way, it may help splitting the C parts into its own patch, so
that Matthew can focus on that (but maybe you all already discussed
this).

Also, unit tests are great, thanks for adding those. Can we add
examples as well? Maybe on the module-level docs, given the rest are
there.

> +    /// Wrapper around `__xa_alloc`.

We try to mention what something does in the title at least, even if
it is just copied from the C docs -- you can reference those docs too
for more context, e.g. [`__xa_alloc`] to:

    https://docs.kernel.org/core-api/xarray.html#c.__xa_alloc

Cheers,
Miguel

