Return-Path: <linux-fsdevel+bounces-41876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECFA38B1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D273A1891772
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D0235BEE;
	Mon, 17 Feb 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mladbC6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4A17DE2D;
	Mon, 17 Feb 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815990; cv=none; b=dh1J0ThQ6UYKJGnO8PeMJjtcO0UW18mlOze5C5AV9iR92ch8HOvY2O4cSGHDDSzkJctT1lbl0hcnaXx1GAlRemZA24IGQPLYpeV/C7CU0lHgj5pTybBzy0gcf2KFx5hc1Iis9IMw5ziGzqrnhY7O+TqIgJ1v2FzJyFz+RxtmG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815990; c=relaxed/simple;
	bh=v1nfZtPaEntqdwfspRp0CKdNkECmeg90mQBAJcrCgLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jG5LLp1sb3Ve0myNBdCzhDcSiP5SL/14WHDJPe2oQ5eiVeZBuuwBwMsrV265bTFwKDwBu/+bg7fwK/EMQJigmYO1hEDWvjaXLWtk3Z12SKpD5vUCMlvOjjt+rSMV4Q/c5P8huS/vxoOP7WFuzl9GjcoZT9eT9Wodc2YQ0KWP4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mladbC6h; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f7d35de32dso1060187a91.3;
        Mon, 17 Feb 2025 10:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739815988; x=1740420788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1nfZtPaEntqdwfspRp0CKdNkECmeg90mQBAJcrCgLg=;
        b=mladbC6hrGCUv732Act9DWGgQ3P8HY2SQuZKKH5J2nYKE+ZrkltdvRFimI4KqH+V+M
         RD92u9kV4/dG9HoHs1NzINLi0hlah4eR2XSNDlvvh4xGQR8H6/3aIgwGIuzGAWxzKowf
         7kvMKy0Ez+O1QiYPiuWpgbBkcyvy8e1h+p4bFv1tuRKk3Jk6ohW9qlesLo2xrv6vhKwV
         ovuY+EyS7DdPIn/i61sM04Wb3/Zii20vh5KDPx76q20tEVQ/XMYwoXtjaeNiYtiP05aB
         8vSyS1hNHbJU10O/IhCjvuCk7yzH1kv0Rzs44DzQizTqdIWMMNXh2bGp0vbdLbxiR5JN
         SB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739815988; x=1740420788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1nfZtPaEntqdwfspRp0CKdNkECmeg90mQBAJcrCgLg=;
        b=HYckQuAEsRL6PAzJxBx4gmuYodGmA5xbV3g+SkhQp/aXjX7V1baUCBG4th2KYOOvkS
         MdWLsOrDeTsRJCX5pj8F/Dfm8YAsLGLKVqTLAwlLm4UwRSQc3BkrZKE7Z0gb9I31WjtT
         B1CQHYaZ+AzSAWXMwZpXCUJsNcOHLu/FpsKen8TN8cw4qppHUMUlp+NzCZmyRuS2IKpu
         MBd4XnUITPxSPOpEFQ1+9acd1L5QMkD305XsJ5HcLdbTVWGdt1V5yhtJpxSWy8HB1Hpe
         ZjXSt8XCPkblyfWkKGCNCoYCo9Y+MSwIyo0uLe3KEdzLqcEv7F27TOmYTP2RiIJ631+f
         ocqA==
X-Forwarded-Encrypted: i=1; AJvYcCVibbUiVAZZ84c2x1v+gOTtIb9wghVaQKz6qIER9Q6lbFg8VAMH6uOMnYpoJMib7GEKysiLrbM8dWYC@vger.kernel.org, AJvYcCVrk5r+cxN/x6rfPxukUI0BxqjTA+1VZmyyp0gCsbAs10PZH5RnSprBZtXYn74xOhBVroLJDdcB8neD5jt2@vger.kernel.org, AJvYcCWfgNqb9xrQZrtkitYrQH0+Q4sLrgI1rhfTxFYlc6C2CI3PrqSIIvT1Iq3qDEYJfMjzyAmC8YDFvTbtgaul@vger.kernel.org, AJvYcCXd6X+9Y5X8lgdXGdaEgF9IzH7Rqvi0r/UZZDINGwLzI2QJqwGhwAnnhlupzZP9avRdv3+rHw6t1WWaF72BERc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgO1SHvuZAWL3pqByTr+z7O8aEW9IAi02ZUogJUCEc+cWm8SdW
	smZM8Egwp+E89XIZiQC10vQRGFXApNEDJIYWGD5bY3/nQEsXRn0M76fNxNd1i5ghduvCvl75KFX
	GX4fu9BasSbQNs4Ec8BfQvJIXoqpT5AtTxUI=
X-Gm-Gg: ASbGncuAeTyjxPHp7QjrA1rlH3kkzEm3o6qdONBbh/ZmbmqfzRJ5PcZthYZX2TG7UdF
	d1ZvQlqqXiMWujPf7wQHs+WTBZAH6/FJ4VrN531ve6nproWgl88mw3L9av5owuTraR6N1mJu3
X-Google-Smtp-Source: AGHT+IHM+AtHAlq3rDcfQxavGUqTfdbjeicnUZTaEsOXbhXTXeu6NAdaRokOfqCZOsATXzdYf3MZfZbpn17UewaARdA=
X-Received: by 2002:a17:90b:1e05:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2fc407909c6mr6396486a91.0.1739815988484; Mon, 17 Feb 2025
 10:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae> <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae> <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
 <CANiq72kAhw6XwPzGu+FrF64PZ9P_eSzX3gqG9CLvy7YJnbXgoQ@mail.gmail.com>
 <CAJ-ks9mFT1Gaao+OrdYF+hg6Sp=XghyHWu1VTALdeMJPwkX=Uw@mail.gmail.com>
 <CANiq72kFpDt230zBugN12q978LRSJiZB5dJZszWkL2p7XqQ52w@mail.gmail.com>
 <CANiq72kjAx4a20cnE3XrJ-z4K=8pCRuc+TOa+WtcuUsdZ22tSA@mail.gmail.com> <CAJ-ks9nZNzrPbK577ibUUjs_aE_o5QrpZbRuwCTEKuuSKG6ZHQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9nZNzrPbK577ibUUjs_aE_o5QrpZbRuwCTEKuuSKG6ZHQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 19:12:55 +0100
X-Gm-Features: AWEUYZmECx5DjdNwykcXNpufWirkto2iB7kCKCIy0LmdaajRuseu5llBMyTfQYs
Message-ID: <CANiq72mUW_PBmwjTqx2vH4Xucykea9MRhpDMs3OvwLJ6zdN8+A@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:44=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> I agree with you that optimizing for git blame while pessimizing for
> normal readers is not what we should do. I don't agree that putting
> boilerplate on its own line is a pessimization for the normal reader -
> in my opinion it is the opposite. Trivial expressions of the form

But that is a different argument, unrelated to `git blame`, no?

What I was saying is that, if the only reason one is adding a line is
for `git blame`, then it shouldn't be done.

But, of course, if there is a different, good reason to add a line,
then it should be done.

In other words, `git blame` does not play a role here.

I mean, a reasonable person could say it should at least have a small
weight into the decision, sure. But I don't think we currently do that
and it makes decisions even more complex...

Cheers,
Miguel

