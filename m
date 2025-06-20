Return-Path: <linux-fsdevel+bounces-52306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E7AE15B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 10:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACA07B162D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8423505B;
	Fri, 20 Jun 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlVovePR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A898229B37;
	Fri, 20 Jun 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407468; cv=none; b=P3u6bWGjgKqHkKIqSup9wQLM9FzuPt0nXu0D1CATPGCbNI8iT+LH7c8CeLv6yTZkYTeqJIgNHsgLQA+sd19QXKwGKj97idFWrH+tIsIEfKRhbd2MyDewaLTPkUwUe2l9VV+xBX48XptmQBnf4oYpCZQ4vBQQrtspKYpWoaSaKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407468; c=relaxed/simple;
	bh=M79qdjyFcMIF2bzxPERBalJxACFjERAR8WW4UCmsv9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVhDM+6lhYdt3A8NWSXzRtIDYY9356UXcczTTW/GashR/BnxlgsgfuPGosIjRv7tChACULkLfo6sj3jH/62/OaVtaJLOdZIAe/ok0xQGnF4lu8FEj2fHggHMWXqc3xe64//EhRV8NbjaweCwLj8WAL7p7Zl8Ixo8+/8oSPsmZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlVovePR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-312f53d0609so199116a91.1;
        Fri, 20 Jun 2025 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750407467; x=1751012267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LYsvWO9tG8U2acRJXqCf0P+DOXFB5p82cIbTlP+6RY=;
        b=XlVovePR803UWVWRkwEEpXB+B18qu/3HCrvnboXVruPzpVCXNvw5L5O/hu+dqmAYhN
         VzWxwpPKtI/fgrak3F4sfohSxalVXh7MHWnIZPMyQvsCw95LNNrzaFlY6VBFfqqi/BON
         T+xTQMKDdLAyhgUCW4J2x/kgEtfTXN8wSZ970jZgxn0O/+6E6kLeOuVZuGVbnNHckJtG
         QKttnKNRBrZ5wHnXAW7EBLcDddb/QGzz6WGTmW1ga7uQNeue+sVk1AD0ZgU8Oexmm600
         XYtbzo41SgrcdWwmzh2BI0+yngH5X80J7VH5CcNXt1SDDr4LG2rZyKmpAAnCVuhmZ6yt
         rDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750407467; x=1751012267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LYsvWO9tG8U2acRJXqCf0P+DOXFB5p82cIbTlP+6RY=;
        b=aHnqDAFOCxWaPgyOF8nR4PG7VwLfpOcVTWtpBTiRKk5YtRx8pXtvfbcHPH8bRGTZUP
         95cRBCFP51MXFDT6c/botFNDt4VboqALlvPUavOtPuTNB1oneSDw0V8kFIRnUtD57kR+
         Py4zzTRswPDEIl8DunEXscZg0zAuKyhRg634v6F4vzjDci952cmpl7x20nkUtCpC2ElV
         l8qe6HlRrMTA1R73vFsp7sZxYyhNKQ4GBxX4SJ6aE25mV6mS3m478oFecpiuCXUYilLW
         rql1e8B0fONHAOH9Mkfz9BxDKUfxSXH6IvPS0yQY7cdlDOYm916UlYlnKeL4aBE3Pjgv
         7RUw==
X-Forwarded-Encrypted: i=1; AJvYcCVWHA6FU30MA13Fao404/EvE1g5ycXKwmqjwPcYVbgYjGWI6uVZd+cbV14kkSA49omOyjZ9tbFABCg9Zmsr6Lk=@vger.kernel.org, AJvYcCXYU3k1+MGoFalnPvE2ZTyfn57rMBECKLjXAAV9zZ9M265hn0cQB+iMKwYiaS8VmjlITj0mdt6UlMCJMhVg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+y0ewltvRV4VcbvKsdYOe/7CqOVYBbxV73sF/QSFLUv/NJ/LI
	PrlkgztBfAtFiFEFFNPoLiwRkhCroTeO9Ny2MCriBhq2jqFlBK1UZ5B29NYdbQ68jIyMYFKBXNr
	tghHvuUzSrG+2pdgvjBojRSFtGD9eEOA=
X-Gm-Gg: ASbGnct2dedKQ88LFe73jez+jQqbVfeolS/K6Ksgscj9YtuvJv7Rct2IQla7xfsj0mY
	y2QUTGmC3HX4AH99Q8fg3s9K8gtd2qRO3A43v12rgQfl8Z8Y/PAwwKaGsTWNvocEba/DGPWM6TE
	p5WuMIMgvrRsxAPu9x182QmT8ydC5NhACm2QNl+EH1sLQ=
X-Google-Smtp-Source: AGHT+IHCpbbF0OjolC5fNNtGZMu64qXq0+kWis6MPa9aa+K6n6ZQKNH4aQkk6I+YvGvXkk7pJiPYcvcvrhgQoyLZCNc=
X-Received: by 2002:a17:90b:5305:b0:312:e987:11b0 with SMTP id
 98e67ed59e1d1-3159d8d99d5mr1299125a91.6.1750407466566; Fri, 20 Jun 2025
 01:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com> <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org> <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
 <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com>
In-Reply-To: <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Jun 2025 10:17:33 +0200
X-Gm-Features: AX0GCFtPVb6XQ8qz4wwIkFu5RiVKB8meYAJTSrqeeqm0Y7JmL7aQY77wObxME_k
Message-ID: <CANiq72nF+Hn-vPttAYDEjRvKa+-C=pGkkAKjMQmWB78Afq4HBg@mail.gmail.com>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "lossin@kernel.org" <lossin@kernel.org>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 11:49=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> But I would like to implement the step-by-step approach.

Like Benno mentions, it is hard to say how it will look with your
description, i.e. how you plan to "cut" things.

On one hand, it sounds like you don't plan to write VFS abstractions
-- did you check Wedson's work?

    https://lore.kernel.org/rust-for-linux/20240514131711.379322-1-wedsonaf=
@gmail.com/

i.e. it sounds like you want to replace parts of e.g. HFS with Rust
code while still going through C interfaces at some places inside HFS,
and that has downsides.

On the other hand, you mention "abstractions" around VFS concepts too,
so you may have something else in mind.

> Frankly speaking, I don't see how Read-Only version can be easier. :) Bec=
ause,
> even Read-Only version requires to operate by file system's metadata. And=
 it's
> around 80% - 90% of the whole file system driver functionality. From my p=
oint of
> view, it is much easier to convert every metadata structure implementatio=
n step
> by step into Rust.

Well, apart from having to write more operations/code, as soon as
there may be writers, you have to take care of that possibility in
everything you do, no?

Worst of all, I imagine you have to test (and generally treat the
project) way more carefully, because now your users could lose real
data.

Cheers,
Miguel

