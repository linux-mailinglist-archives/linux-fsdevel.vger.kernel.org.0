Return-Path: <linux-fsdevel+bounces-62145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CBB858B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3191C21B3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B430F7FF;
	Thu, 18 Sep 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEj4rZ0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D330C0EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208564; cv=none; b=RedHdq/NMejxaho9FMjlCKvpvsUomSFoB7OGC7lDg9MLsVi1+PKeMzeIjmrCQGbPRe5GAkC+yY5uW4VdvpQ3UruAsbUWcV3pmoTY6Dgvn6+MqHEpM2XfYyntyYk6DLthmb/kn/4PopY1bfTGRO1YC3f3HAEHg/3zeGkrf7nuErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208564; c=relaxed/simple;
	bh=ba1MwCUdfJFXcSWZiNzRoEiVzaEaDWkPBHTa1hTJBYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfzQyGR6BMtqedDyx4GRB9PoxKj6noPMMrs6Kle5Jxcdgxqn2mm2bxiRHDJ8lQIp5FFa2XSyo1frtntXNP4aLVqcOpAouJhZbmyjWmqLo9w+5K36wWHgmzeRGPUIWX/If+BViHA5dNcM72dwOYKW5NzZiRPSkPiwkfBtAaXTP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEj4rZ0A; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so549010f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758208561; x=1758813361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba1MwCUdfJFXcSWZiNzRoEiVzaEaDWkPBHTa1hTJBYo=;
        b=LEj4rZ0AMMHZtyZb7j4NI80UbI8Hm2EJxa6ttVE3ctMkO3eWqr+UnWSfQ4nqP8XhTO
         42D5/rYI0zMcEVxNEbjxIhoq88cAPlFxbq2FFEc4clsh3lnBuF7hCjMxw/OjfOp5MOGG
         sy0gU9Q49I6bAOddDS7wA/sdZkQ6Jj7lkCrOAJUqo989hOP35bt1/tPKP2+92M3aQ34q
         JF8ByXlJxriHb97XqqGZ/hul1kc4yFpET1osP5BfKywGldDAKQqisDEjTtlHOCYhP/4C
         SmyfCmcXOUcmCg2OXNL8aCa+bug7BBreQjv5V8mQnBAup322sp6W+gnqCrK85uL/HXZP
         ce2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208561; x=1758813361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba1MwCUdfJFXcSWZiNzRoEiVzaEaDWkPBHTa1hTJBYo=;
        b=EQoiuiZVGbzcNn8QqOWMoFileVV1hYXgpQuIE7enYVZy70UFoKWSdGqe/EX+Z+5b5L
         GCDlnWd3ePu3poOwBI03HhVQTHy6Kku+YbWUovHJzdpeqRMg1qTTSImOYktMwwsMlJmD
         mjIrU+UaP3EPnpKVt9P1juJGET0PLH1vnhlerUIDsP6QDc4oNA0sF1tE0qcfY11THtCx
         GR4L4EpCK6CZ3sQM+Tu3iGIh8CHmEOtNF7KCRNdUYO+6TRV4n8Ru0UvPTitB8WKPii4d
         Pl5wok9nisI/MqVlgh5RGpn3FO3hujigXSvsRYZU2xubQ2QUAvfOzE4U86k+iRJMdLEf
         zfAg==
X-Forwarded-Encrypted: i=1; AJvYcCXFsFaeDtdP4W6+vpo8A6ge9bEL6PeU0GCHevPBdZhkBRr7LWwT8Vmf+Jeq9KLXg0NrkV7fggXvyAVVtaR9@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgChU84Y5ar6Y9mDwsqKVXamdUNtssDENWt6wGpe927ajMw2y
	NpUk9+kpdeSL1rpvQCx49k7r5frscsUAF8x5jkHnqqb1dMQRLjvQKzflForsbKGtf0/sqNoW5vK
	rGy/7fD6RbJPLo6xnogby/+5jH2pi+OdV4xXEvqts
X-Gm-Gg: ASbGncvuEWhnVMKiSZtIhqNx4zVOaOpLMM0gcmXzNwpShI5EsA4nQmKtdeIYbgglfJZ
	biBwhJds3IX/bMAVcDDy0TWuV/ilb+niLLDV/jbyh7LJeGcclkRRsZLxKyGkDh7kgPLjFICM8J/
	JOZfMf1FjBDvcbc2HLBktO7HeQPNNmrS6j8s2lQOvKhM9d6vOOd+jBkdZPiv3RGkiRevj0GIQFW
	WT2LVXXNxj2MRcr0T88+3wLEVMyLxj/VwqyVL7fGcp0tbuzpSXro/Jnx6F3CNPu
X-Google-Smtp-Source: AGHT+IFQAhGQVrc0ungSn0zq3CpjAET1I/cC3NgM5eoz7k2nl0+IyeFHuw/NaM/RjH1vzdmZSNxriNGDHHlStXtyh7I=
X-Received: by 2002:a05:6000:2885:b0:3e9:2189:c2c3 with SMTP id
 ffacd0b85a97d-3ecdfa4049amr5630267f8f.33.1758208561113; Thu, 18 Sep 2025
 08:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918144356.28585-1-manerakai@protonmail.com> <20250918144356.28585-3-manerakai@protonmail.com>
In-Reply-To: <20250918144356.28585-3-manerakai@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Sep 2025 17:15:48 +0200
X-Gm-Features: AS18NWDwxi2HM3ygSiKAYEcBCiKuhDKgr7oLvleUFCAaPsKX8Qf_0T36Xy0wwtE
Message-ID: <CAH5fLgiDJbtqYHJFmt-2HNpDVENAvm+Cu82pTuuhUvgScgM0iw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
To: ManeraKai <manerakai@protonmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:45=E2=80=AFPM ManeraKai <manerakai@protonmail.com=
> wrote:
>
> Added the general declaration in `FileOperations`. And implemented the
> safe wrapping for misc.
>
> Note: Renamed some raw pointer variables to `raw_<name>`. I'm not sure
> this way of naming is good or not. I would like your opinion.
>
> Signed-off-by: ManeraKai <manerakai@protonmail.com>

We already merged read_iter / write_iter functions for miscdevice this cycl=
e.

Alice

