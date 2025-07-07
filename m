Return-Path: <linux-fsdevel+bounces-54109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A8AFB525
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1194A188B3EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3742BDC16;
	Mon,  7 Jul 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzSGrTOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3816CD33;
	Mon,  7 Jul 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896141; cv=none; b=CDx6LyV9d/ZRoJnWPt6MTqCXX3B+IRy6DTCH+v70D8ooTInmHm8lE7L+m7gKANmoOSvaQWnaAh0e+kZOsPPRNHSN2rEloSSwoVTUCW9BuXuXB93wagzj9kb68/erayVfW2qwzuNnOrZtXMDZ5/cQZlmy64lD2NcgJccJndGAASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896141; c=relaxed/simple;
	bh=iBv6okUseyiTdjt3XFNpy+qoASB9X2reY393kqaQui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK9BjwvjGDjKfOUDktP5tZmZpKgrJxDh64t15YEilHZQGS2n2M3Yjd/CrFj8fCIFS605L2WuH/5Xwnn6WIYpu6/WBKl3d/OFIiBa78/KRMHXlvrPAl9Oe+K1VIEWpY5+DAhuHHCXvYS7rCVpS1trnIflJts6Lv25hmv0kQZF7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzSGrTOT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so26275511fa.0;
        Mon, 07 Jul 2025 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751896137; x=1752500937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBv6okUseyiTdjt3XFNpy+qoASB9X2reY393kqaQui8=;
        b=YzSGrTOTWMH8Pi5gYbdOqfS9bFk17Nsc4qmcPoRSQAP1pX9iP+h0Eh/007a28JXcFO
         MtMpSieBONvhMrlp0L/TqizKWPiz8R3wRvGmhzj6iaMFGaTlcf1ujt6ZQQviA1iT6fb1
         wX/H97RIAoHiPEivQbT5wCIYfi202RG5cuj8Hch7BUVLhu8S6dDOHlGw3vy/0uikfix4
         s80EDIDVQ0G7ylfCTKV6/ROCTMyrz1jhao5aYLeXKhT+ticRzUvMMcZ8U9KE6Y4ILlcq
         +COcDrQZLlWGRGPOxoPBTk84QqzJU230UVnbG31umrWM+LVkdkD9rST9mXtmJZ0LtQq/
         rIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751896137; x=1752500937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBv6okUseyiTdjt3XFNpy+qoASB9X2reY393kqaQui8=;
        b=ct+y8/rtDpMBfZiDwpMWohddEmZY3hswfXaI60Zl8EfgPqXNtXM/yj41YWqwbBrJ9U
         u6NewZEv6hUd87+iJa5JSwQ8TdZW44aQ3Hp4SNp92DdDfb/JySIIrO8ZJsm4IImbGr9H
         wv18z36lxRg7BQnbOlYGJGF5gmneoqrUPhMBNeeMCc/FatOMOSr+QKaRnzJMCenMP/qw
         3s8L2p1EZFv4kHmIZVMgUTwJILIRAEQF77v59W1Bt1cpCr8E62MwUMaQRoo1pcljiM7V
         J0Cxw+4j6Oh4n6r7G5k2Zl2Zdda6ngHPlDo3i21iSlTleFC5uH1G9y/uAFuj2kNfMcyb
         spqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIbZRvhgMmrzeigCqe+yjQ6cvqXOWVuoNgzLicRMb5/4rNBb2kCXh0k4C9ZcFKmTbYGQ31l97f5VWcE7aE@vger.kernel.org, AJvYcCUZNfA61PoL1KwpRuWEffcCNeztrVXWozUZeEadmNLQtdrdhmNLeCRy2aJbT+UrePAv+nEVAazkGStylaL3@vger.kernel.org, AJvYcCWnnp1VvMzEMSWe4AsF5NOpQ5U79WJQYn2rIUz1yOiqfChXUsmQr4J9Jsr3j7m0Ajq3JLvUsOKFGc47WGvBOTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCA3YNH2u8kE7l96kjBMAmNZTYlwWfMV2AFzbaUxy1EojcvIS2
	4SUtqT9MJu410hXaVHGiK1zDqPfEWcmFnF1ec0bmM7iVBYcS5AfXz7uA0AJ/xhv7/ANf4Ta9GRX
	og3AsDgv7FTIbKHcFeWu5Ic0AJ+TcoeA=
X-Gm-Gg: ASbGnctRJHdX+lTuGR/FlMC0DiQ6pxFjrYVHa9rpOYAlCWoJusjY5xM+vrvP3wVAx/7
	W/HWUTf6kvKwKN4zyYkl5Mm1E+XlsMJ0JeVT6lnu9D1CBhLKT4JsY8BCEVa3FiZQ+7+s20HJe9a
	jQCXOJIr5i8papMs9KAZq2x/q3fuuyYO7r+HIrVMq4JgazXY7X4ei6GkoTs5tI7fOZCEwfxT0ZB
	IwKZLXGX6yNYFk=
X-Google-Smtp-Source: AGHT+IG6mESRFwHrjMPB8IJhsBDIv7jvEhAZYhXGS/YJrBI7hE2OE3eUCK3Rsd7KBGcxdf0IEh0SQDDfRzDFGBXXLEc=
X-Received: by 2002:a05:651c:418a:b0:32b:2f4a:35e4 with SMTP id
 38308e7fff4ca-32e610eae45mr32663681fa.34.1751896136651; Mon, 07 Jul 2025
 06:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com>
 <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com> <20250706082904.GB1546990@robin.jannau.net>
In-Reply-To: <20250706082904.GB1546990@robin.jannau.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 7 Jul 2025 09:48:20 -0400
X-Gm-Features: Ac12FXxKbt56dwBuo7MeSvdevPz34_ZeU8dMdxkb0P_S_eSO5uofzl8509YIRo4
Message-ID: <CAJ-ks9mkYR118njo9rvFaqZMhEa+uQusUBAYTSH_1gCxTy-2ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
To: Janne Grunau <j@jannau.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Sun, Jul 6, 2025 at 4:29=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> On Tue, Jul 01, 2025 at 06:56:17PM +0200, Miguel Ojeda wrote:
> > On Tue, Jul 1, 2025 at 6:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> > >
> > > Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, wh=
ich
> > > are akin to `__xa_{alloc,insert}` in C.
> >
> > Who will be using this? i.e. we need to justify adding code, typically
> > by mentioning the users.
>
> xa_alloc() / reserve() is used by asahi. It's still using our own
> abstraction but I'm in the progress of rebase onto the upstream xarray
> abstractions from v6.16-rc1. Once I'm done I'll reply with "Tested-by:".
>
> Janne

Thanks Janne. I'll wait for your Tested-by before sending v2.
Tamir

