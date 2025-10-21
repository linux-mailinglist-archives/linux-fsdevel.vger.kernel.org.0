Return-Path: <linux-fsdevel+bounces-64967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2A8BF78EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE95F19A0E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE511DFF7;
	Tue, 21 Oct 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp100qYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077272EE60F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062462; cv=none; b=GWOmAiR657+OBydvUH3nZzIXmEmwr/YTuUFonHyEK0vEwCGYV+pou5QOZUq2/ipfOOSJBJkMweGHtjdM3LST0ObL8f6IpfIfJ4RBUQTXPnoYOnYqIu/r9n19hXjHbF4pOvbedKt/MAfMkNXCwYR0tCAxgmDwevEnKsZnpgI27G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062462; c=relaxed/simple;
	bh=l9McPck7+fRtP8oHsbqDK3T9B1jxgL5s0koTgcHDrMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmVGZo/9QN8SZrNiUucoIoK3jT4r/HAaC07nbrWYeHtri0vZz4RYTmsDXo5OVkNWm1LkimdTUUFdfp1s/UDBWVhAuoEHhpjfQfxX0/XN8yFDah7sDkz9OOlAYHVCU7qtTK/ApyM8v8oWtSu15ZcO08VjXQjuCpYtYHK4PbDZjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp100qYW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5ca0345de8so96635a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062460; x=1761667260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9McPck7+fRtP8oHsbqDK3T9B1jxgL5s0koTgcHDrMI=;
        b=lp100qYW8ZZePqlGpiIXCJNN9rKA6JH5MVggkns8qPNM2eGTlGDvmyfQhkd1AXvtxF
         N0LFYwGt2cDq/pz0sRyyWR4pQ6+JEdKTeviIKhTLuFEOmrzF5PHfHug+wdK3oRTv0Q5G
         i5dWey9LP8GwpRKM+j4lpL8CXjkurZ8mztK78evFPgZ9P/D2PHvoEKOCu3wVQYJ5LwdO
         JpfaFSC5fknkXAqlAfDixvnTC6ZWrYPh+jZelgQdkRJTvAZTa2JjZkczEUkM50xuPicQ
         LU1OpqvQxpqElFirhboA9p0WLwcRpcKoDHCCB8Ys2e2lYs5rFud+1SAUHCDflZlabjE5
         d+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062460; x=1761667260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9McPck7+fRtP8oHsbqDK3T9B1jxgL5s0koTgcHDrMI=;
        b=kl8SLNYiL1DM0bDqnMVYPk39rJbtT2QllEhNtjJOT+bJfs7IhhBMIx2ohB88qh3XBx
         bG8bruq+vrHi0wgtJYL3duGszQ1yRT+dA3s9tkHG+IYZsH1of/3+8tS5WnUs72G9IAye
         ugoNeycfzf3Vrck2t8+e6F+Rft5jBX1xrdMAfvYCdAqowOJ21l1U7FOD7AE9OKK9qLUH
         zQfkrVI0KThly++VYTiN5a9sP6t4X08HHFOlQtaO6tBruuMHrSy/ZVzmoaobNZQq8H8G
         VP7gQvLVCHYl/toINq2MoMzn5i9XAI04FdJSjum44wDclib41eBzv5uK0yC2ZbZ/gXnU
         20/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCkQZYKpyawiJwVDeV52Q/TWV4BgX+mFg7GZ9GvCtugRgQVwrCwtl84Q+RcLscymNynkAqIlbptYyLuXIt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxujg9haGNKCDpioI613DtsK2XRk2jpwCNt8b610hJy89zpqUm/
	mpNwyOox2FxmbfogVggA4Lsrhdz0VRJ8pkwYbBAFVkMaqHBQQ0a1aR73nMakReLw4Sz2BKg2HsM
	mGABQhs8xXX80L0Xk4ieD6ADMPDTrFF0=
X-Gm-Gg: ASbGncuJxhik+Ym8lw+a7NUeIvS5jk4yo14qqQCXVWRij/YyYdqTrmx2E2QXo5+E6ZU
	xFtJfEByNQS5bRBjeoYsDebcbEDkpjJleAiZQI6FKWNQ4EuztQt6/N6LHqV8/ArF4MgfyWcAs6I
	jLLB4RpSX706cuAGCXbHLFLKSTvyHfiK/i3vvR/PHbGkohYZrsdbURdJIu/h1xgQUdnrQqTMKcP
	xYsFmMIvWLkO07r59bEZ1lZJZnO1Vcu1CTyZUEKVYAH10/2zKt+q1DrNb3f33DvYpsUecGGw+K3
	KYcXpfk7cdI1QFbiCK4Q80qgpgNcj3nJ28DAfpXjH4Rau8KA4B1uWWjeTf+CtD9MZ2x6Pj4PQWv
	4CGoxcaub9a3jGA==
X-Google-Smtp-Source: AGHT+IFQfi/s7O+AS7+ugi0AvG3Obf7x6s4gJSfq/z9A99N2GSsEFGD6AtODHA+FDvs4i/OimtZEcD5AA1Pf1qMAScw=
X-Received: by 2002:a17:902:ef08:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-292d3fad068mr25694605ad.6.1761062460097; Tue, 21 Oct 2025
 09:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com> <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
In-Reply-To: <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 18:00:47 +0200
X-Gm-Features: AS18NWBiq5dOJe6Pnbt51CNfFzfArDoMX7kF8GitQ2ivyHNjHdvLaE-OZwfPRas
Message-ID: <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Yeah, I don't think there's any value making this a new type in this case=
. There
> are no type invariants, useful methods, etc.
>
> In fact, not even the type alias is strictly needed, as i64 would be suff=
icient
> as well.

Even if there are no type invariants nor methods, newtypes are still
useful to prevent bad operations/assignments/...

In general, it would be ideal to have more newtypes (and of course
avoid primitives for everything), but they come with source code
overhead, so I was wondering here, because it is usually one chance we
have to try to go with something stronger vs. the usual C way.

Cheers,
Miguel

