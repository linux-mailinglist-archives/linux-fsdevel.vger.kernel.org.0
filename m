Return-Path: <linux-fsdevel+bounces-41877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312EDA38B3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E182188E79E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EA235C0F;
	Mon, 17 Feb 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkdj9jrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AE235359;
	Mon, 17 Feb 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816693; cv=none; b=VDBl+TXnuGfw3bZe6zoefm2IQIsnYvVXcvm2uPBH+kuHYToBYvidHsWYSAkV05S6MQsYhGBgCyN7u1DMlPJofPMG6jVcEXOt+heumDJEq7lLgDm5rvHYdw6aRXOufvq5iLMDCxUoF1oaQVKmsNWRSXY80wfUo+NOLQ0HP93BZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816693; c=relaxed/simple;
	bh=gn0QjBFQOKxAe0g2/k4/mFmZgvlOFoIke7zUVB/fbtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ulgf3xT3WMF6p71j8V/FObKpCyYBhWZwq+ch+DFdeZsCSdGbsS1uNujJ+kjU1dJDFLcRtJ4R+5CWnH9A8luudCnb/zgwLBDfZnbASL+ieb1CbZxa14A7r7trm2xTAw4w0JSnMZDW/0PWBfHmpx5QILuVJoSOSGZB025mvLcx5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkdj9jrX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a2594435dso15502831fa.1;
        Mon, 17 Feb 2025 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739816689; x=1740421489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn0QjBFQOKxAe0g2/k4/mFmZgvlOFoIke7zUVB/fbtQ=;
        b=Qkdj9jrXvkxhEG/7VdXZl08gHjKcB0RVLY8IpEQzaptz4rDNGYrJUm0i0ZGSXUeYen
         vbiQBDsBIhwxuRpB5k3KeUQJjw7cip4L+icdd2Tg9IlJ50/7qHojElWO5uf61yw0wrZi
         tLBb79ou73siNbiROR0sZ6D+5WwQREsgAxTeZ4Q+184EZI4QfMRqJBWyUcwZPNemKXX+
         F8OEQXrzaQ7xPgtbxNxdhR4+WQ4LRd7n8DUS46T+I060Xz+JN++NGxEQpnY1/ccb7W4A
         uD8SBlPIdFXekRzc86i9IK8tJRuQhaGV1od5C7roQU8NKqDbToxsM2aVfXYuNVzXRjKe
         M+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816689; x=1740421489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn0QjBFQOKxAe0g2/k4/mFmZgvlOFoIke7zUVB/fbtQ=;
        b=nS4tz/Q8nUSCG7W+U3HBulgnIkbpQgAVTbWKBpPT764O5eQFMy9WieJU1/4J6pdMOW
         L2ClcqkNekiW2/FQZ7ketQE7qmNIkVX1De+Pv5soGK85ni1wPSWEtoXhV694la35bBmJ
         NVdQ4ssv2C4rE9D8eScIdlC02IFbk8YuzlxSG83DS5UiqePN1jrj3ysSj9FRDFOQBUGQ
         Ah5u612FwSkPeXyE+Fbrx0kDgV8xFXb0moVt2eRkUk0Bmc+F1jDi9zHU6yyoQWAu9YWw
         NrSwtAaENgHN57Ss/JSSej9ohEzHotzkQN5jZ245WUwOsqQq9c5bRhHB0qy80fF069aw
         E4lw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3qyVrxErnHIyaXeHPetURWb0I+g+QSNe6E1HBip2RayN7xk8ueOg0Wf1U7nwEU7SptgTEk4eIHtD@vger.kernel.org, AJvYcCVyn+pBBL9nfjeQuu8x4kRg5h7lgoVs/2gCGyqVQCgHfnVx3kzoUjt2zu+EzosenWmdu2BbmCoVDIn3nNVU@vger.kernel.org, AJvYcCWzdzl8DQp8QgeyLCDwgKrivPyipN58rUQE905e8MGahYMJV+rll4OvCX9e+6sttyy8cIPPFrWhjfk1LWAt@vger.kernel.org, AJvYcCXYFGr/8h3Qd/59LSbO2nzrejvIc10wC2dUvRiJ8Ysk6s1qrqC189CG//g37XXiFCsGstOuVISq0Uw4eF4u2GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCuSTJ9PJoWrBhwfB+4ggrmXtZPjYjDzsdgLiEUu0qfqZRNsc
	viEQdI21YUgCGyMDpd0TS7Ey+Pyw00EQPwT+Fec5tSS3hKRcyYk0Tj23jYFasK7toRjn8Kqtpz/
	vlQs8cSEK80QYtBlCXLza/9zrZ+0=
X-Gm-Gg: ASbGnctWT8wLJoBpJffctQyl/GRL6OaAUrh4lse/D7VxkrzPXgCa/Lmg9C9+a1VhpnO
	kmxE/Tqh1Eat5fx7xdxVTstTXV493Reb5UklmlXcZyv8B41mXqqRqIiz/cB8b8s96acjERkuIsI
	dBOmiHH+4PMBHo4S7YmxvcdgERsQ3tPk8=
X-Google-Smtp-Source: AGHT+IF5nUcc45TCNyTyJENRSlv8p48gA51c8C9Bfv5GRzkgcYG1j+d6OpNURrgeLJQwKLz8eBbpQln2PvkXNQmB4Zc=
X-Received: by 2002:a2e:9517:0:b0:308:ee65:7f44 with SMTP id
 38308e7fff4ca-309288ca32dmr27136571fa.8.1739816688951; Mon, 17 Feb 2025
 10:24:48 -0800 (PST)
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
 <CANiq72kjAx4a20cnE3XrJ-z4K=8pCRuc+TOa+WtcuUsdZ22tSA@mail.gmail.com>
 <CAJ-ks9nZNzrPbK577ibUUjs_aE_o5QrpZbRuwCTEKuuSKG6ZHQ@mail.gmail.com> <CANiq72mUW_PBmwjTqx2vH4Xucykea9MRhpDMs3OvwLJ6zdN8+A@mail.gmail.com>
In-Reply-To: <CANiq72mUW_PBmwjTqx2vH4Xucykea9MRhpDMs3OvwLJ6zdN8+A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 13:24:12 -0500
X-Gm-Features: AWEUYZm8nj7xTn7dcDtYCzihPsz3j2vH6bg1FPlz6OV-5OeM_FPCxoMkLLZucoE
Message-ID: <CAJ-ks9nB8Y_i7szABOgJbG1vZS45XsL5f9LU4zSf2S7bpoZ4TA@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Mon, Feb 17, 2025 at 1:13=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 17, 2025 at 6:44=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > I agree with you that optimizing for git blame while pessimizing for
> > normal readers is not what we should do. I don't agree that putting
> > boilerplate on its own line is a pessimization for the normal reader -
> > in my opinion it is the opposite. Trivial expressions of the form
>
> But that is a different argument, unrelated to `git blame`, no?

Yes it is. I suppose I misunderstood your objection to this rationale,
along with

> So if you have a change like that, please just change the line, rather
than adding new ones just for `git blame`.

as an objection to the decision, so I was giving additional rationale.

> What I was saying is that, if the only reason one is adding a line is
> for `git blame`, then it shouldn't be done.
>
> But, of course, if there is a different, good reason to add a line,
> then it should be done.
>
> In other words, `git blame` does not play a role here.
>
> I mean, a reasonable person could say it should at least have a small
> weight into the decision, sure. But I don't think we currently do that
> and it makes decisions even more complex...

Unclear where this leaves us so I'll just go with .cast() in-line.

