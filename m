Return-Path: <linux-fsdevel+bounces-74515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF16D3B504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 895CC30223E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D3329C73;
	Mon, 19 Jan 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dII3zRRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270032E721
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845585; cv=pass; b=aOcUAqmTS6L0aAPCLZQG6DGfF49t3ukUfCWnb43B/12aZuAkRj7PS+pq8y0nb+P09kiHP7fLhTgg+nM9o+lzBNfwMCpeb3vHvjwqoUOr1Op6EGszB2LwbwKpQ8Na7pjH/eFm0ncmmawODj3ujnr/ESSdOl6rnzrtYoiJGIZeZ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845585; c=relaxed/simple;
	bh=fHiHG3XGd6NwWX9Uy0EYY9n0lY7YFx/20ows0FCUdeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwOjM9Z1LhYsR2Sale4ZSrXYclX5p1dbCT1krl+5x9l7qZW5ZBTlpIqn9G+il6IecNtaTkI+ddlfaggF7ojeiPhsH48DByyHJka36cJ2flTtTMNhOuW/qUvNPzuX3/Y3sIfqWi/55phW7r4xTeItMhyZm+ZKt88Sac8DN3My33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dII3zRRS; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6c1ec0dd6so268124eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 09:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768845584; cv=none;
        d=google.com; s=arc-20240605;
        b=iZZflYaeu+VaBEOu93wQQcHxpCa8HIArAg/SyWk5d0HrtSnYyTlGw1i6pYeWToPUN9
         YSIGDx4zeRGKtC6C8Wxu59g519JestmlIlANge2PUjR21UB7x2ZzRMPHtEBCW/EY1d7Y
         ian7ypUdUsai+IF7J1YRSEZUJtEyW0lkyQ1KHq1c3FRxBtGqTgt1sHaUP6/RS4LYFsFB
         FOp/OG184oBf9StRTi16te9F30+YkFJDFTKZAAZSMbjgWbljQRKg7pGnZroll0mYKpcB
         3EwefcHcmmgHua6QCFEIpV6NpI0BwAr/5C8CZP1m84q1sRYLOcCbGO5KN8JJDajMzyM+
         Zjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JlWBG2gf5cflL1pmTjExB8oZFgP76EDRjk1UwBZmEDk=;
        fh=iPANJNMT0TDeKVoGvLOcrTmT6ot8usQCrCQKDpxStuE=;
        b=RFY4vAkxENbg5KG3PlORJhKe7+ZTQ3VUQby5FW7gZetwMaKjJWKIudnIXWJv0SMzps
         1hBbqnAPJBtzHYjY0X41uY8426+p4dY2uEyVe2QM0BIafP9UEYpxmnSmtuuWL2mxIQbX
         an/U/o6t4HDZobwizp0NBgx3BCt3yBkvSHsYd3uebosBsbmxUnWYVMM9oMV2Kj4EI9Zz
         0Jl0QUiNq40I3CJxafpy4Dl0SLHh99eqpu7mr4OR3W1DBNAm5+tpb+53RlREAS0q8P/m
         ZUqHTF7vgcFtgu7JLCrdFBRqUgMuEffpcTn9IZm25DAImZdEApPWPXZ/rPvyh/JQErRL
         55SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768845584; x=1769450384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlWBG2gf5cflL1pmTjExB8oZFgP76EDRjk1UwBZmEDk=;
        b=dII3zRRSwXOC0hGKPazhNzc40s1nV2FPNUi+9jbYkYh0lMw/xohoj04JuZQcWzzJh7
         tubXvVvLQw0M4e40BI2L/8in8+iRmw3WV3OUNk4JVXsJKbTriNvG2DFjepawnbeR4J2w
         jeSzFra8xz4ZQpSDvzeMpZSEJBVJDDs62icCpSMZGFMbKHaXvH+G/LtmM7ZJ3E2IdDCR
         q38HUX9QvCiKjRH6dtoWwJLR2gYAGeKPrm2Qgk4kNnKGRV2ev9IQ7t2F+JFWMaK6TAb2
         vG0tYTZ9yuEVCESDr9YyIQ/kI9fxvYV/tmf1h0iymnuNjaNoHuYkZ75kyfC4Re3CUfQ8
         k2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768845584; x=1769450384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JlWBG2gf5cflL1pmTjExB8oZFgP76EDRjk1UwBZmEDk=;
        b=klHjZTOg6oIMPrX/4wrrtd72CqfHMxpEUVUuH5z82Q2SGDWp05TrRE1dC9HcgD+e8K
         Cq1GzJodCKger9Czu+y7E4FkkbbjvpGquVgZDyQWrvV23xVCKilFoSiTifN/KUF3B4NH
         4ariya3oKe662+/BOxWTMt9BLT0ICKWQuMB2FU1nXZz3l8ZCpeUf776IV2VFfvEsYaMm
         INTMzzbwwFXXLQkG0Jz55MYt4iL16G668e2I5pv5ZrtwsrHddYXCrQV4BPS11cuaEmW9
         N7q6KN0hFmt0+Yg1K9qm5jWq8lYJCU4Ao4BJcakXKX9quBEXIU6JotGlS2d8w5E7duqs
         G52Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYelk6H4iIRMoqECfUYGbHzM0KnefbY6mLtLV0xJsCdKCOLRaPuT5sDEvXp6fVI2b9k3Jo5ZBLFyG8QlU0@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXYfF0adxwkQB2p5oi4WPeC2O2pp7MOeOqmtTJegUzIoGAzA3
	JGJE2x3PX0b15XRS6P0W4wXJGglPT/fKZSCO5Q5vmzYyjA2+hih4ZI5pGD8LW7+18o2r5NjsDpp
	5Mlu3Ie5X6j5oK7Lvl4bIb/37aXWpey8=
X-Gm-Gg: AZuq6aKz9wmzurHe7dq60Gree8PRBUKNsX9bEud0UHQU71Uj/+maFDDqmAkB13yPUYz
	ydlJFFxmKCUfDyLiKk8urV0cMtYQxLN8Lhs6H3qzBlVwo22XLthr0JM8Uy1JYP8pSek8wQex/N5
	nGdOFS2X7ZrSANaTIdSnpjpT3Yzb120MzlFhrZSk7myHr64MsqBb5KkMf3yUCaUE8JLf+MtXzsa
	ZaDAOteUCsG/lcWaAm6QZuMbGIZxTzuP09h8qw2mmP7l7ho27Wwykgdn1b2DSVGIfBlQ6y3gZ+a
	9rOXzdOfyg+MklUSKL5OvzIcuJfgsOs3ugLD0FiP2PKwU4X2C9wM9ck6zFflGruMIN5aWwVyKKt
	pShHxxh6OYn/t
X-Received: by 2002:a05:7300:aa8d:b0:2ae:5d59:3ef6 with SMTP id
 5a478bee46e88-2b6b410a06bmr4815258eec.9.1768845583491; Mon, 19 Jan 2026
 09:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
 <CAJ-ks9kDy2_A+Zt4jO_h-=yzDjN024e1pmDy4kBrr5jsbJxvtQ@mail.gmail.com> <CAJ-ks9nZA84HYL_7+raFvcS1G77O7FyHk7_fsPMYuv2K1Ecp8w@mail.gmail.com>
In-Reply-To: <CAJ-ks9nZA84HYL_7+raFvcS1G77O7FyHk7_fsPMYuv2K1Ecp8w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 18:59:31 +0100
X-Gm-Features: AZwV_Qhp4p-_hjdKH_I_kqS4f4SnusBiM1f0nziIRKxUS8EC-vyWKyseHtN4Ck0
Message-ID: <CANiq72nFuR+W=sKMgmxx3VjxtrWGb66N3UBP6ZDG1hhhU9Bf9A@mail.gmail.com>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 1:53=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Alexander or Christian: could you please take this through vfs or
> would you be ok with it going through rust-next?

Either seems good to me, thanks!

For context, this is part of a long migration:

    https://github.com/Rust-for-Linux/linux/issues/1075
    https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a9152403778=
3@gmail.com/

Cheers,
Miguel

