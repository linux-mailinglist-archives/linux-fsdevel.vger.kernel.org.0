Return-Path: <linux-fsdevel+bounces-32015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C799F3E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9322B1F209B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B11FAEEA;
	Tue, 15 Oct 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMMrAVjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029C1F9EAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012762; cv=none; b=BSIZva334o/AIZHpDzaBoxgisYrPKSTQWcO41XTF6E0pqxy04HoPWtVNi8RGFHG98tr1cpkoNFBwlsZd1f4657v1R+MTC5jOneUtxqao4BnPvbn/B6P4Exb6WHyD5I/NLsu7ihEnaJzGkEcPmGFVHuO8L02561qDFIC9gTyyF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012762; c=relaxed/simple;
	bh=O4uKXUDjN+z2W9PEujWbY8qqByQDFOkH3r++MBAHigU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LstIjEyc3+sfGUA2F8cKlxDbV/1Zpw+VHzVze/XnaM6ox6PBllSBDz2AzngxGBgCx8xqBYYCwS7xaYEthECiBqM5oEuhI9hSW7uRgVjTycsvbOdKCh3Aea8SP8k3qcIwNogIYsrhQyJ2FOdKZgGohtTJuU5UiA1xxhJd8dsH82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMMrAVjV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4fd00574so54671f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729012758; x=1729617558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4uKXUDjN+z2W9PEujWbY8qqByQDFOkH3r++MBAHigU=;
        b=PMMrAVjV6oImg9Crry3IvEOJ7Xb0UjV9aDnqUrm21qzz7qvYGKsuAk+F/lAH5urEG9
         /3+zl4QbUh5pQjKS/pecJrkqQyeVi9ecrR9NTK8H/hiAFmOIwZQ65ZhfI+r20KqsG9di
         iUvYnULkjRKvnNo77MdyQsM8OOerpaD8ACJDi6Gov7FOF417gtShJvUwt1HNc8OjJ9Hz
         NoKCiVKhsuE61k7RzPNVQXzeOmVROdxdNs7wEHXoR8r/4jiLZvUrbrrxOBZYqnurTiXe
         ej2tBtqy9lP6K6ku2RS1sLGensS5jeGIt55P9UJEo/ivHpxXa6dK3JiHbyYYbpJ1KCtU
         zkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729012758; x=1729617558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4uKXUDjN+z2W9PEujWbY8qqByQDFOkH3r++MBAHigU=;
        b=NSGPXzWg3F0+Ye2xfClW6aRhnSe4lw71BAS4ynq7hH9+X3WRhI0+v+deOoemgQRnUT
         bL5fdkVDGsf2HVYbehY9Bkw6agjGDMPVlkHKqdoO7oGVBqvh+dxGymHp0Rd+I2K5tB8l
         K1qBvMW+l74m7ZqjQxron8Bz6LI+XSJj2Kr7xGxQzzehpATBAxjOFkClj0awcD5MRGe4
         pw+UEQ+QrBRr4H5H/k5QwGwWLf+TM+v9LsBNbkOGI+TKYiEhQJ62WWO7kXDg95frlnNr
         nZc/yccqlev6667SoLJN0EXxKVhemx7xpc7tHV/+JYZLBG6zvcWYvu0zup75nABAlCq7
         uJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVFQafA8UmDHsLNxa6UYELJVsgcrbEEoF4wB/72HxZ/76RwV/wjT52M0lHRT/yZpfDnGK0tOsV7i8xhi/t0@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6oT/mjwDbai0KkzQtLeom+GSfFFKc1+LLwlktM/vYU/YeyCN
	tP8qCCLE2AjY1knQteD/MTsKjR5eYM4lPzfxF9c7KpcmQidtIJpgNbVd/ZjahiZt/07T+LW/26C
	+4G/Q4wHjXATEubxJClfB2w2Ft0eD4KEzztT+
X-Google-Smtp-Source: AGHT+IFig9d4dT3memJwkNn7Iymd1aBOpKbqdU4BcA844xOhFXKOWBjaSdlMzFLKjew30l0syH1KLFiJSVMcwKEiyDc=
X-Received: by 2002:a05:6000:12c5:b0:37d:4706:f721 with SMTP id
 ffacd0b85a97d-37d552d2c64mr15099258f8f.27.1729012758376; Tue, 15 Oct 2024
 10:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com> <20241015-ohnehin-lorbeerblatt-f6629b558f4f@brauner>
In-Reply-To: <20241015-ohnehin-lorbeerblatt-f6629b558f4f@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Oct 2024 19:19:06 +0200
Message-ID: <CAH5fLgiwNR4tmzMMX9-+EYqDBUZQVLPEGhEjiEL5Db=mm51LGA@mail.gmail.com>
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:06=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Oct 15, 2024 at 02:02:12PM +0000, Alice Ryhl wrote:
> > The `Task` struct has several safety comments that aren't so great. For
> > example, the reason that it's okay to read the `pid` is that the field
> > is immutable, so there is no data race, which is not what the safety
> > comment says.
> >
> > Thus, improve the safety comments. Also add an `as_ptr` helper. This
> > makes it easier to read the various accessors on Task, as `self.0` may
> > be confusing syntax for new Rust users.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > This is based on top of vfs.rust.file as the file series adds some new
> > task methods. Christian, can you take this through that tree?
>
> Absolutely.

Thanks!

