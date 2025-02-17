Return-Path: <linux-fsdevel+bounces-41874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEFFA38AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F21B7A4558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E3022C355;
	Mon, 17 Feb 2025 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEqnG1BC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE16224AF6;
	Mon, 17 Feb 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814250; cv=none; b=NitXBQ9cjJCKV8ysG0D4S80ut7XIF9Umx5Salfn0iM3FU8Xt7QMZJBOt2HL1ldrSHfvyFO/VVQekM9AzpgQ3Yct5HUKlA+RgE+xjNxpWzxFEHdd9i2zGZyHupwyFY8ygHSq27k8dOzsFy/PmeghYSAfzoG0EsH4UuU9KWxLBFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814250; c=relaxed/simple;
	bh=QJEQnNzyerVZgPIqexLxIHlai98K7LAJ91eV7IWhhIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3JoxNlROLac9OWNRIrwhWSupbcxZMlvgmJWHHj2L7C19NNQcMScEckSBGnQ5Mp6Bv0V/GTooYjTKgMgdq1qyHjXz2YlEvN28qXxjNBAve7uMLksUVLg5IqrCIWHtdgfmMZzl+SBbJkyT5Z7EwVm2uisdxj7ld2tu0Ujrc3U6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEqnG1BC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-546237cd3cbso1158305e87.0;
        Mon, 17 Feb 2025 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739814246; x=1740419046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJEQnNzyerVZgPIqexLxIHlai98K7LAJ91eV7IWhhIo=;
        b=JEqnG1BCXjgLFFHv9Eey4/b8QHXJzxCpLoO6zPBEqeFIp4rUSXHhmIrUy6bfi+1DI3
         I6C8wK8imrdSyf0lEkWugBzPVBSTKqRg6Xaz5X3qzfv94VYQRjvF6L9oiDZpP1jo4IDa
         aDAqCSikuOozKwHQmMYxMvg5thYgelTGUMrRgQFTbDHtiLhZ2cz5xa/Xn68w4bxw6UaF
         N8Hb04Pp6waWd6IcA9DTcr2x4W04qOXw/nuca+51/iIthV9FoGtwM1jz7dLp5dhH/n4U
         mrH9FBSQDkIX/exfWJRGUpVT5BA1nSFGiGLyHNevsWJnMNRL2o6q2WggdfQJ8yApuV8T
         J9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739814246; x=1740419046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJEQnNzyerVZgPIqexLxIHlai98K7LAJ91eV7IWhhIo=;
        b=U9pxbFhAH0rJR4LWmeZNji0gVjOIxeKTXS1L7Ml9jyVBweoC3rjsGQQZD44gGi+JTr
         PKNFrcuhDVgiH1UAjyn0HiDD+r9wGix6frpIFoYdZ9Vh4VGzyu+ZTtNIv+60ajqBFyDz
         VI4oOYG6Py8TJ1tpGWJUeB98hINmOgkDHGOTp2JjDKE62KVyGgx54uNmxR8ftUHGITCE
         3YwPK66tcVxTdiWGZ1oJoHJhF+4X6z9IcCmlyZBahDIf9cQTBahaPDbS5TG8IIbB2dH5
         N32RpxGkm5Q1fH4RHA5iRdr7nx3vKV5c+wvi+wxpaJF+gRBXkcWed49IeDpmqXBxiGbZ
         Ve+A==
X-Forwarded-Encrypted: i=1; AJvYcCUSry5Q9oA6+f2tLAiRCxH25bdB+c1prOSugarlTMPL/IFaLn5K0JP28suK/CfsuOnA0Fuy4wjiCc7MRW+p@vger.kernel.org, AJvYcCVDpFzXMgCkhcoN682c2AZz9sLJGdIT9tQY6CncF3oXpfJibTSrJvxDINXTGTjuMPbBY2NJhg86Xp2fMm4C@vger.kernel.org, AJvYcCX5/HPrMMorqprzyquxS8C3Yr8mM3GKRoMdseXKg8TDg1vXr6DOtibPlqNtFIwJu4kRqWKxZudU5Cnp@vger.kernel.org, AJvYcCXCpp9Or7MWq1Xxixil8ArbxPxvqq7eEt+ljWBiR3B7JVP4/M+YjsypVU2TrJNaBO8lOD+yw2NRt3Rw6r9yQc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmnJauB/rQ4+HVN3s6jdj0d0oXyJi1pSyFPlB2XrE/xygLGp2
	kqgaKh069EyNT5HT/EjN5HtB/VS4nDSFBr2zNhw9rNO8ynH9VKRCONxw+u5oTEkKHZdpUkfLdiM
	PzLi7Z61R6YGhYejJkx9qxCzrBGM=
X-Gm-Gg: ASbGnct3/aDfWRExs6GnWW/eElweUh74By7emnk8uhAx2qrv9Ic/aIYGpyEmSF3Vbyv
	MJQHYJmkpwiBK/+m1rVD+QRGf1lskehuAUqTzjcPyCdOjP+ZDCWx2gcYSVHUYASGIf51dpttkRW
	cpjasbnaApSZSIGF3jCzLzFnFiAGiEuck=
X-Google-Smtp-Source: AGHT+IGvTTJx+4fmB6AiH15jyXQdH56zreYNvD8IuJPmSgHpB2B5M+YKesYWMnr39buRTcTkrufTrgW10VlcB2t4AYk=
X-Received: by 2002:a05:6512:12c4:b0:545:81b:1510 with SMTP id
 2adb3069b0e04-5452fe2cf34mr2727826e87.2.1739814245579; Mon, 17 Feb 2025
 09:44:05 -0800 (PST)
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
 <CANiq72kFpDt230zBugN12q978LRSJiZB5dJZszWkL2p7XqQ52w@mail.gmail.com> <CANiq72kjAx4a20cnE3XrJ-z4K=8pCRuc+TOa+WtcuUsdZ22tSA@mail.gmail.com>
In-Reply-To: <CANiq72kjAx4a20cnE3XrJ-z4K=8pCRuc+TOa+WtcuUsdZ22tSA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 12:43:28 -0500
X-Gm-Features: AWEUYZnFvQEX9h2gQjKgTPirDmHanhzbOTBFPiisQ8hREXZBp_w-sIzV1ECjzO4
Message-ID: <CAJ-ks9nZNzrPbK577ibUUjs_aE_o5QrpZbRuwCTEKuuSKG6ZHQ@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 12:36=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 17, 2025 at 6:24=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > I understand the rationale -- what I meant to ask is if you saw that
>
> By the way, I don't agree with the rationale, because it sounds to me
> like optimizing for `git blame` readers, while pessimizing for normal
> readers.
>
> We do a lot of `git blame` in the kernel, especially since our Git log
> is quite good, but we still read the files themselves more... I can
> imagine ending up with a lot of extra lines over time everywhere, it
> could dissuade small fixes and so on.

I almost addressed this in my original reply - I regret that I didn't.

I agree with you that optimizing for git blame while pessimizing for
normal readers is not what we should do. I don't agree that putting
boilerplate on its own line is a pessimization for the normal reader -
in my opinion it is the opposite. Trivial expressions of the form

let foo =3D foo.cast();

can be very easily skimmed by a reader, whereas an expression of the form

unsafe { <type as trait>::associated_type::function(foo.cast()) }

become more difficult to read with every operation that is added to it.

As always, this is just my opinion.

