Return-Path: <linux-fsdevel+bounces-41870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC7A38A64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4763C18944F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8432288FD;
	Mon, 17 Feb 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9gqRtsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773D2288E4;
	Mon, 17 Feb 2025 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812302; cv=none; b=A9TLtLzzaHr2Sg1C/jakNp6IHYATh6gyvPtdI/MjBRRfoniiKzA6JvUsFEWXiQrkZ9wL8uKTJp5lEa0Sr6334jrv9CK0cJTnMkY64JoXjTtvm65Q4ku54TSr4ZgEp5ss0DXwnDn+ZkNYtEkhO6Kp8XJRnz9kbMDRQebBRUaOhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812302; c=relaxed/simple;
	bh=TdQimzw8sSGiZgPyuQc7rE9Y1qlnABxwvqq2mC9bcKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvPhUaAaROM2WlXyWLepq9kKjZsZkpdt0nocgWUaFO1n2Q89lA5AkN0sX5DhsLKHV4Lyr+QD6I1FH8O5wmlhek3NLvmcjyEidPsvZ8+m3jPJkUWSbgR13G022jXNL75HID8ZmbEYWocRhIENJfcbG/cf4LFkY//qLuAWSQXXDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9gqRtsZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so46736241fa.1;
        Mon, 17 Feb 2025 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739812299; x=1740417099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdQimzw8sSGiZgPyuQc7rE9Y1qlnABxwvqq2mC9bcKA=;
        b=i9gqRtsZPG1cdfTPDG6BsUgSG9gpwhsK6sELK29ZCyumoabhIbDOqiKi9To5rrGGTX
         mk3/Imnl8TtwLZdG5MareXhdktPO+6b7yMA5zI0LT7eqLzVFepEV2aDnyD01egJkiuZZ
         MHVvzAF8wojP5ow4V/0MR7vUhON5dKbfyhRmBnltn/uydx/HtSWL/on26OrkwoPLq5SP
         4rodpXv+P1keqzYRwkF4AITXKoHuyn5oXxDA48PPz1566uLXqmaqkQ7z2xawy/+ripi6
         TM8zqpOIrtIFOGhlXHqWqZQxmg6OIpVLK1H50XUSWc9nnuRUGOXYMlsFaHMLu/BArG0s
         tgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739812299; x=1740417099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdQimzw8sSGiZgPyuQc7rE9Y1qlnABxwvqq2mC9bcKA=;
        b=t28WSNVp8+fZmS6UcKLWyFiZFh4cia1XA0DoTCRFZzp7locATszeYdlf9N2BZZsV8L
         Bka5ENjaVA13FZ8HmKF0SSM/BjhMSEMTCJ7HX9LD3ZKUBZmvthGMfVbDiU5fyr/6Ze8G
         F8SHhy28WVdVxCcPlVmJLNyzMH8skIyh24faAqwKAgliFpggja7ouJbmAPK8IJ40P8y4
         RQaP+ygZ6PKezBV4g2yZy2Jz4llZAKpyBB5zLenrkTzq0xXtpYiCW98UsCL0r334p/Ul
         CiKvRzN8qS4y6l4WY1tMaMa4o1RyyMqr58iw3ZnkWB/DV7MVzG/m7wn+g7gxDD/QQqyZ
         +iDA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJzvDC5MC/qBu8OOVZxNZ3TVy1+Y3Scp3yT/80Poa3/q0Mgkun0kikPvxu1Hwxf8sPWZRQ52p8FTx5WBs@vger.kernel.org, AJvYcCUmYJcqBIL3M5cGIZ+KkCLKSgUILVMGLAv7KAJHG65TdTJ8CdC7o4h7ZKWZRmMxXKVcrYOsPfntioCAeKGd@vger.kernel.org, AJvYcCVGCE5nu1Lt66FeGhIqJ2Y7/Ac3AZma9x1418+KsZvUBI2fuMsZRBDGg8lnnKtiQdYD7sHr6cmFXRRH@vger.kernel.org, AJvYcCWt6wespnFp24DiW/+rd6KD3D6MJEJbQw2LI+tqQY7Z+TOltzCHnK5F3UQRv0AdkmnlBYCT8N9WZ/vkX/BRB0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdPzDXXUdO8+zi1eH+JZA55GtC/dJo6jUp5ELHQo6ARVz3lQH
	TPoQKVO63wrfcgv4ftNk1Z863NxtykW30ZWFIsK8Xurgj5WscrwcfpEAfQ0mZDWxDqrrnnSzDGu
	s9+G3fk1S0bOrvjinD6iMfJ5ybc0=
X-Gm-Gg: ASbGncvAbLpiZWzdn+uvKgBkeWC0354BIGi1m6vkRUUat7m1YyURkepq86XR7ZQDBNN
	sYQ9xZnKHp3O2Lmy1zwrb/0QsQvOW1MR2bbl2B3N7OC5BJImBoFFArpqpdRmIXVhZ3C+mjAeSBp
	lYB2C4JiuCo73H0wREcTR8jSufxfJ3WXQ=
X-Google-Smtp-Source: AGHT+IHqOVPChZjgbGbD5mfExWOVQ4uFXlWjAO4vlidJKCyNetgORqhm7MNI+PlLjiF04CtQi2PxV/roEBI/gJrn5+U=
X-Received: by 2002:a2e:9e11:0:b0:309:20b4:b6d5 with SMTP id
 38308e7fff4ca-30927ad53aamr26164891fa.28.1739812298645; Mon, 17 Feb 2025
 09:11:38 -0800 (PST)
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
In-Reply-To: <CANiq72kAhw6XwPzGu+FrF64PZ9P_eSzX3gqG9CLvy7YJnbXgoQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 12:11:02 -0500
X-Gm-Features: AWEUYZknuo0rimKoVsJEwuUUuDsoy7Pimwwo1NjuyKC2DfaMa1l72y3cGrnElpU
Message-ID: <CAJ-ks9mFT1Gaao+OrdYF+hg6Sp=XghyHWu1VTALdeMJPwkX=Uw@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 12:03=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 17, 2025 at 3:21=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > because it doesn't acquire the git blame on the existing line.
>
> Hmm... What did give you the impression that we need to avoid that?

Only my personal experience with git blame. The `.cast()` call itself
is boilerplate that arises from the difference in types between the
abstractions and the bindings; my opinion is that a user of git blame
is more likely to be interested in the rationale accompanying the
implementation rather than that of the type shuffle.

Tamir

