Return-Path: <linux-fsdevel+bounces-36757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884499E8FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714021883CE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5143216E02;
	Mon,  9 Dec 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J20+ecBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622A14F12D;
	Mon,  9 Dec 2024 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739583; cv=none; b=inIZqvfSRdmrZvliNYlJVBAaeSMU3FADn7b1JARED48CIgXvou1sTCJg03M3ErMqUc1+kKB0AdFft1I6I5VXfrxfT51TmBYYDwlcYECpdlSsumsQu6E5+FWLw3CAPGx2/tG6M9Dj+jfBJfbDpyPQRDyqdb1RkZ8FmxL0a9TLRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739583; c=relaxed/simple;
	bh=z1wSWDjvMJFRWSRQOJKagKS6SuLXHk6TSVtxoyaDLyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlnFRMgUnJkf/NkfNJhL+DcSjaiNOXwWGFBCJL0Xh6bsBwu+NkSFxpRuBGWLLe6o03Ml/ld1kPjVPg8cugJj7C80L5TWjN+qKztxxI22JCmj67ScAFBr92eJTcaFHStURORgw0saYgiir5xF4a6BnG07IwTulFpXHzT8UVpBGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J20+ecBk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee7c059b97so745433a91.0;
        Mon, 09 Dec 2024 02:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733739581; x=1734344381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1wSWDjvMJFRWSRQOJKagKS6SuLXHk6TSVtxoyaDLyg=;
        b=J20+ecBkTWqF4ZwC4mR4PWd2as962Drm0kjoU83Se9Kc8L5ANcC1Sw/X0W6xWAlyOQ
         OoE2ehtLNvBrEek/McN701I7OZvyRjN6+CCkWTObmBNuGSJNksIR8N5qjUuloBfWUw64
         8y7/5Lz0y4RmVXoLCN34ulG0LMza3leiY0rC+0ouWhEdB6qHRMjvoatB8M5UFCBL+/C9
         xLPKkj4eG/Moo1YDK7V2JoBO25rvfy5nDr+g7n5Jr/2jLqTnshHiw9Mpa0Upv8Zz9wES
         3w3nd7NfWw6sAq92QcecOb00sgPeDknbUjK8bVFNYGO50C7on2hiOHeaMIb1SW92S8Gy
         YVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733739581; x=1734344381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1wSWDjvMJFRWSRQOJKagKS6SuLXHk6TSVtxoyaDLyg=;
        b=JteDCYbS3sXnPWjPABHg7WX3XF/OyvQxx2xpedz2chC/EUkOQkVrAeVjjCpbfnV1p5
         KJPoBkamEdWb+t9NDtJaN3bnbeDBF+wqfYkxx6psYiK+UiB1Ocf3MIoGsDD6RxBscP6J
         qb8RdpNun62ZXot0vlC9OE5Yb+CnpUg4LiwfUc1VOXj3zfwVrjgRrsegS5l/upn4FUnQ
         oBfIGP9luyQKqtWbRFxNDQvuvhGpVvK/sUWCe/9VRECr9l0783zcBf9qAL79I6ugEbhH
         AW+0PKlWBDZsAKdm3XnwuudhX6QF9ShvKlrX1jPtaozHCr7jb6gx0hf/ohVcBMQ8q4Xe
         czKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4U5/14IQe86Ff8/yMaZoePBfxi62c2yiE0eGz68OjuhorLCIE41iCMkhXOXqxV8YtIZq2c6gDjkM1iNj/W1w=@vger.kernel.org, AJvYcCUi6DCOpKgh9N+Vp9hg6f/EPJ2zSw707ENlhknI/FkFBB5wmhIgRQ38t+xNwfF0xtR/Xy9Q2sG9V0nvx0Mn@vger.kernel.org, AJvYcCWIKNwgdz8beTCZp/oLvNXa+azw6q4Fw3GMx/E4lhQTWKZaY8h27DkC9AQDW1Mk+iYNFdDHfE0LC3TwlNi9@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQHmoxJW1f2eLjyOVNMjjk83LcKrfltua3A8C/x3ZXl4tIi1E
	yJtVTsxNt6jhH1YeBo9XADGHdbrEMK8JERvfvqtR2W33D8W2nqoIxBSAON8yjRE9ShV1MOiIVVS
	ArCgQb+rKbdAtJd8V6qNcYbXjf1k=
X-Gm-Gg: ASbGncsNPEKwvDXKXD7Lzk5UNGWdGgXTlZkxV6U6NmT95uw7NaPBBBMi+kzGTKJU5TW
	7ImfI5oJ6frnHeklxwnOctBGa1gHTxEA=
X-Google-Smtp-Source: AGHT+IGMIpXimekxtcimU3/MT89KqPhZCEAdgz9ycTU7negk90TO9t5x+Ov4Ejos3dt75c4Yz8vP8cp7Ssa8XnKv7x0=
X-Received: by 2002:a17:90b:4a8d:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2ef6ab104bamr7545327a91.5.1733739581228; Mon, 09 Dec 2024
 02:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com> <2024120936-tarnish-chafe-bd25@gregkh>
In-Reply-To: <2024120936-tarnish-chafe-bd25@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Dec 2024 11:19:28 +0100
Message-ID: <CANiq72mw4A7PG3Gu6T50u+U3gbUFd=82WL557NUo-7jkQf1xPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Additional miscdevice fops parameters
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:43=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> So these should go through my char/misc branch now, right?

That would be ideal, yeah -- thanks!

Cheers,
Miguel

