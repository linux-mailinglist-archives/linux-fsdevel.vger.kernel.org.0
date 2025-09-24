Return-Path: <linux-fsdevel+bounces-62538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD6B97F92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D025819C78CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA61F09A8;
	Wed, 24 Sep 2025 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0wWEKd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3801F1527
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676173; cv=none; b=Nzs/1LM48vUj0GF4I4QB+KZeMwkxeC+JWGWxBuSXTBBGDN9BJU8FNvVx4JhxjJnNIaZDmGXBSuLKSfAZmA5cicv3FENrQgqEpLVpeBxnSGwr0DbeWC0r/LAgWUQloitpELxg3+J9HTTJenC1LNiw4OgFJcyW1T4eotTmNdcPrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676173; c=relaxed/simple;
	bh=Blu+tUHawvRU8Xs0DUcuclzoQyPlfz7B1WyF4IU8+1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYi7j7FzeDcUw9/ZW+AbhDq0bmex0aMhVp0eTeCG0RSsWPLtjiCESdGojvjz0HqG8oW6FVF2YAkHf+iSNTmzdluJZikVnEt6Lb1YHTeg4cDqmUXdxItLUFlYtUQz6VTPQ7g6a6fZACzANRSWH7C9kmsGEcC7+ps4zLR/5XV8LzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0wWEKd5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36453927ffaso42041681fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 18:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758676170; x=1759280970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lll/ssUUyzpdCEieMHN7OfODTvGl3B3jSAMJ3V0c2x4=;
        b=S0wWEKd5l5xg9+5BT7CtUUnlPtSeIXHUVRrCS/B2kYs8vbq/7gGFbyipX43FY9PcHF
         xbUG6hq2GWpWc0GJn02dDjiTSnrfgOX/ieQr8ZHdSDdY/nBrRXO0+IxhHd+g46Q1sWyc
         O1u4whV2pC6W2isSvBdztI8wUjY4201oA0pI0Ditxaka559vPt5CAvmhWePiyRpvaoT7
         Vmox6YJUamxAMjt9MrqNASyLNjLzgjOlPE0APHIrhTrIs6bfxt/CpsHx4DBfIIP4HiSd
         X2EmsSOx8fo0/j3917nGqDqYAmyKkHw4JrFJ2F+tRWDxi50jqOkodBlX9rMmIHmm8Hpa
         y59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676170; x=1759280970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lll/ssUUyzpdCEieMHN7OfODTvGl3B3jSAMJ3V0c2x4=;
        b=epxu73+DdYKvzaJPuj+klzS6dx8rPrmQP53KjBRbRM+pMgf8Q1tn3eoJ+Nn0Y6OLsD
         hJbp4nIvKgNccKRCxf4yqp1DiXYCw+8iNyNC0xSTNFhKc8GNRtQvDQPByTpe4SkrItbK
         wf6j6tzvEGJyer9GK0c4KknUT2Rm3KRvjIpK69ZpwV9l5Lrb7uKqu7qECmx9hV+4z4O6
         AJvo3PfXnx/R4LGZe9drnN+qL0n2x3WdwTSbUpGI4JsY57FB5NxCMeANnqu59KCLR5KZ
         Cfwt7iMBR4CLvpf94qEkPEWK0vKbr7MLzInpJ87bx8+J/h1fgiE6nTj1xeuvLDu387I6
         nhFA==
X-Forwarded-Encrypted: i=1; AJvYcCUPBubLpviGdMTylNvRTCOSOnClNvJ3n8dVZ56PSw7ZIQEM56A+hCITvHtYYQn+CclDclMkMTDNs3ng/KHb@vger.kernel.org
X-Gm-Message-State: AOJu0YxwklzsSY7kV9nvsjH7o7CkqOgpsO11lMe2ZAYVU/r4ij0akm5r
	cya2+zx7+lrx6sS3Rn6AhtNCPUkI1SCfrpUvt3HRSfbhoiyYC5vXbZeVkjakEQoyCZ2GW5Dar0Y
	P1E0FbfUozzkFb7/pibYK7IVLDt43tVU=
X-Gm-Gg: ASbGncu25L0NBT5BN8EQ4Ko5yh39EXPX4eo5nhv1ZB1+2dJhATqOvQEDBTXKzEMrVwD
	huC5wkF0wssiA4dCjoleCGn0pL1F6Q9NeNWlYIgXIkZ9PzUCwtybB+h8WiNfohkKxAEOMPaQvUW
	h/9/J6ieBG2LuWTg+5+nQmAJ57pORgcTxnNP4q6oaKbMHJ2xuUggpQ1+mD7CeXFX6dpQ9G0c8Op
	mEJi/924WpWD7YTnabtnwy9yuR/FZAwD43dna49cN+fFbTIDTkdM579QGR8tsRc6WRVtco7lLU7
	pElI2iQQO7w65cSMvILZLw==
X-Google-Smtp-Source: AGHT+IHbXAiH1s8VtlmDbsaNP/syoKVWdCeZZCRV8zDEN53vF6lttuESXWuJKlJaexy/SVsmDvyy4M/m2cASKJkmK3E=
X-Received: by 2002:a05:651c:4088:b0:338:bb4:6d6f with SMTP id
 38308e7fff4ca-36d177d8cf8mr8960551fa.44.1758676169573; Tue, 23 Sep 2025
 18:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
 <20250813-core-cstr-fanout-1-v3-9-a15eca059c51@gmail.com> <DC1ZLP61HJAL.3I2YF82Y4T7L9@kernel.org>
In-Reply-To: <DC1ZLP61HJAL.3I2YF82Y4T7L9@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 24 Sep 2025 10:08:53 +0900
X-Gm-Features: AS18NWB5wsxS2a7jxyLos1K4bMIsLFjDF8Ocsoy_wDtXVwMvZmga8KSuS7D7hNE
Message-ID: <CAJ-ks9=9V5Ex-VuSV7Er-jTLHyMCyVWYOiWF7wpYB9V_F=+QQg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] rust: device: use `kernel::{fmt,prelude::fmt!}`
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:54=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Wed Aug 13, 2025 at 5:39 PM CEST, Tamir Duberstein wrote:
> > Reduce coupling to implementation details of the formatting machinery b=
y
> > avoiding direct use for `core`'s formatting traits and macros.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
>
> > ---
> >  rust/kernel/device/property.rs | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
>
> > @@ -413,9 +414,9 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> =
core::fmt::Result {
> >                  // SAFETY: `fwnode_get_name_prefix` returns null or a
> >                  // valid C string.
> >                  let prefix =3D unsafe { CStr::from_char_ptr(prefix) };
> > -                write!(f, "{prefix}")?;
> > +                fmt::Display::fmt(prefix, f)?;
> >              }
> > -            write!(f, "{}", fwnode.display_name())?;
>
> So we're not able to use `write!` with our `Display` or did you also
> write a `FmtAdapter` wrapper for that? (don't think we need it now, just
> wanted to know if we have this issue possibly in the future)

Correct; we cannot use `write!` with our `Display`.

Apologies for the late reply - I had sent this back in August but was
still being throttled by gmail :(

