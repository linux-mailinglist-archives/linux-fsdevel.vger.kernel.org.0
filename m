Return-Path: <linux-fsdevel+bounces-53557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AACAF0135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189123B19A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983DE1940A2;
	Tue,  1 Jul 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkVXv9Qy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDE27A44C;
	Tue,  1 Jul 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389484; cv=none; b=WQ7KITYTdXj/0F2l+E+JOmfpDLO2j96Bfh1i8TNbbQp7SkW5kO7/FJn2iYCeIYGtxzBHYSDZLH2+f6QH7FE911JZ6txYBbrpky6UJXI/uit9StzEyGPxGGvpo3+AEEfMADKi5EsfB9x9bODiwhd07HxKMTuI2tbzq64bD4Qcguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389484; c=relaxed/simple;
	bh=Buoy+eHhC6eHoSe6ky5Z+oG1UzCc4eNOy2T2u08lRTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td8vK8Mibzfu4eGDdLoOt6EmsOggGLFIFEsmQeNDSNkEGPA5e0NANrkCBkJk/0vU/tMnEuOi94sVGH99UFWXGtCCmLQy9Hc2RTCLwAF4e2xUoSgqNiQNe0hDbIy76fIjv6ytw4aCXt7wZ7aqjKDKMoTAKvT/4fldmqmtDNSvRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkVXv9Qy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so31683461fa.0;
        Tue, 01 Jul 2025 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389480; x=1751994280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxqIhubUv69M8iMfBOop3LMw2L0Kp2fdzLhKTpcmD6A=;
        b=JkVXv9QyyhBzTQoyikA6++HTkh3uM+UkVlPHL4Co1uj8TGKZeoFHmTLOASGHlC97mv
         64bbvuUKGV9vms2iFKqiTp2SzN3OVcDagGv+kg+DgI66DjENIRT3kBwSfDU19DbO70D+
         itXMs+TO3XWOaPgZC6W6scjVj08KVhqyhLAGPIKQbBFsZYgbml9l0u/um4PmuU3AT632
         lzwVmNSJE7GwSZj5o46X45ILtu+Y0AOBDlC9a7tqUh/Pn1x8L82NbI3YSudoCSU3bNk4
         ar2xO4rGVrmtqfb4s7cyjZtzT/cKYwOOX3S+OjirVL14y0QjirSun2U+c5UC5ReC2Yu3
         BL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389480; x=1751994280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxqIhubUv69M8iMfBOop3LMw2L0Kp2fdzLhKTpcmD6A=;
        b=iF183pyhSf41Jn8u0IPWAH3jwCAR9PkR8TSR7n2LpIK/QHQ3BaOfg0SqOd+e1Fzl3T
         xH2g9BtgIisY8G/iQPxV31jSwpasP0lleCx6oPBc6GUH/FC1fcJnRbzw2ZmfcUSsPsPT
         w0MLEgcFED3DEo/FQGbHz6qcYPmanbKu+YPm6LfMR/9DN2bJrRqCOcuG3Nk55wCB9bWw
         Lp3VuacPzDs9n5tkeyUjnsMDV+zUh7dT2bYsoBuRNwzxsWy7DrKaUqqPcaTw1oOwwyDB
         GaTfHHDt5uozDh0IdniYbuOacvZFvO4ChnWF0RMukRQmG8F8EJiNLoQKm1zYrUw7fbyF
         XoYg==
X-Forwarded-Encrypted: i=1; AJvYcCUd92ZOYWfMKBRPDSZ4AV6a29cZ7UCQF96FY66wKb5d8zxvoWOa315FbSCkAbZv3H/IOENGke05uEgsUu0f@vger.kernel.org, AJvYcCVK62fB5Yvl5xemxsGgeHi8fH347wh/fbExuz8H6gd3FZhPuKYGyak2BohCe7t9SHyOP9k0blOv5FLUOl8ke0Q=@vger.kernel.org, AJvYcCXJrqJ5k4jqOByDuK/jPbzDDTnyBIL/ib01InJ3YLmpKsqAm6SKqGltKoXcXyBXR8PkLOYknh38m4is8YzD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/36NfGri/DHPo+zrZdFcZ1GQcG/yjGkgZFCCdg5+Vne3SQJvA
	6ZSb/9jdqUJJoqaAZEHQEsTHjtUsVVmWf/IfwOkGnA6+kwZGE5LHm21w3tKWxGRTsVV2sUbXVgn
	Il3U+6KUzQGVPFCapFBB7/d8Mbz3qiPHuMyR9Cp4=
X-Gm-Gg: ASbGncvGX8sey+8sutoQ5xbbQv/YWurQADbblm3JjT7T3f9SgI7SZa3D79avI9cdwbC
	7x+QEfZNGZufHjb1bkHr0eHNhnA4Og/U8bknoEzuKW32lRJ7lwaRdz0tdSQvjlGQR6u6T9pqBTX
	/6ATk4oJUVYNx3kw+hrDHlXFTI+59V9R0lKSNWhDqG3jpk/zoXO24IE/NoMbMlJwLzLbxFH4YaP
	hkeyg==
X-Google-Smtp-Source: AGHT+IEoQsxbSiZHk57iawY5wnpi5nf4WW7yFai/WzA54KcFJwljAAd73b6yGB+qwSMNFbK5Bk7g1hw5i9O4J0dukJ8=
X-Received: by 2002:a05:651c:419a:b0:32b:492c:5d10 with SMTP id
 38308e7fff4ca-32cdc524864mr69147631fa.22.1751389480057; Tue, 01 Jul 2025
 10:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com> <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
In-Reply-To: <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 1 Jul 2025 13:04:04 -0400
X-Gm-Features: Ac12FXy7e-RdRR1PBw48BY7WaB1YHjxcedC_KPOTmXI0875WVE3fJL8jozJ2aXM
Message-ID: <CAJ-ks9k7Jn=8K1a0QeDK-vhTWO8-dv_bkw2SJm3EEUsinMTFQA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Tue, Jul 1, 2025 at 12:56=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jul 1, 2025 at 6:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, whic=
h
> > are akin to `__xa_{alloc,insert}` in C.
>
> Who will be using this? i.e. we need to justify adding code, typically
> by mentioning the users.

Daniel, could you name your use case?

Alice, could you confirm whether rust binder needs this or not?

Andreas, did you also need this?

> By the way, it may help splitting the C parts into its own patch, so
> that Matthew can focus on that (but maybe you all already discussed
> this).

Happy to do so if it makes Matthew's life easier, but I'd prefer to
keep it together so the motivation is clearer in the git log. Matthew:
any preference?

> Also, unit tests are great, thanks for adding those. Can we add
> examples as well? Maybe on the module-level docs, given the rest are
> there.

Will do. I ported all the examples to unit tests now that we have
kunit, but I'll bring some examples back.

>
> > +    /// Wrapper around `__xa_alloc`.
>
> We try to mention what something does in the title at least, even if
> it is just copied from the C docs -- you can reference those docs too
> for more context, e.g. [`__xa_alloc`] to:
>
>     https://docs.kernel.org/core-api/xarray.html#c.__xa_alloc

=F0=9F=91=8D

