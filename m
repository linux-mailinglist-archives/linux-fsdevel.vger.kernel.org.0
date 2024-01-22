Return-Path: <linux-fsdevel+bounces-8438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A668365E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 15:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108C028289A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6383D96C;
	Mon, 22 Jan 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irKTd4gk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D33D960;
	Mon, 22 Jan 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935306; cv=none; b=OyxuIzVl+9Xe4AVkgAYqrUCPysArO4Fbgq2zLzYlLaIYseRJX5vZPHx5HEMvlQ5BcFrlsqfax0Qor4O6tpKvC1D8Rxc8VPSZsHEpc2oZ3zB705LUg73i9Rko8sxyTlT3HjGe2WMkQXeJBL4PYUEtQhT1M1a6wYdQO0/HW7SQlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935306; c=relaxed/simple;
	bh=Nzv63BCkoPcsqWEFiBswGPma2+8hRkcFkANtdVNFiro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGSehBz1IOZ3kCsiGh6ZAsam84fu7EtWZid538d9B3xUEdymeyhVEIlGOBet8I9jf4DqcvV6gtGvpe0dLFsJ93eUBv/sPoM2+lLXYx8MpjIg2VMvsFYDTnmZsdlsA6hatYO97VT/zcqS4dsr4kspJCcozj7HMkBAohhsylSYQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irKTd4gk; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4b77c843fbeso763403e0c.2;
        Mon, 22 Jan 2024 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935304; x=1706540104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjET904TYP/WwjxV83kzot+nYVG1EoymjQ+8BNv7pUg=;
        b=irKTd4gkA03NZZVeM+/uKOrtuTDuhfZGNTPv+4PXyozitZjwgDy3DQr0RZnUJCQp6s
         Hejww2vV/09+jnJ3t0hF0zeuSH7T+k4L21M46HH1AUr18CU8aPVWthostlrvji+RAFML
         iBwIyoGylSSZM3DjQ3pHTQZKyiDobfFpyORIOpXKqPHhYrSzwz53hpOBlecYrQWbJkDW
         IRLBsD8F1ITGIs7EtlGMlvejp0IzSKweMdIYeIwFpJqgohcpoPB8n1vJweDSW+R7ZXQF
         gqQsIzuJdRX0npzgXYRFM8qdwL69JYDTVDbJ8aEla1KoIeijsLKUieQeKU9jbIV2iWof
         pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935304; x=1706540104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjET904TYP/WwjxV83kzot+nYVG1EoymjQ+8BNv7pUg=;
        b=sHV5P878w8KVDO9S0OgyjuJwuOS8lvmJmtWRe6CENZvEvqEpeLm/t63a2QvmrVNWSL
         2s4i/7pkUbQSzZCQvenPnkgWOS9wddYoUPt8AKJ9lxciHi6mCCNSWlwDVcn3qCFLFHJp
         BuTBbAeJtjaAMqz8eiK2U897rMUF9eVEYpWHA/cgQypVDNOSIHuawHSSObxfdW5hi1Ez
         rK8VVyd621ELz76n/iwuH1GqpGkWQ8PZsNk/eRpB74Yt0e9up0JoQLC3MxShit/YW1jO
         JHyr30TXIL+9Z/9jf5TNzOD77Hy9FI7OCP+IKZ4XQBLB+UX0Ip+1Y2y9wNmmaBa1Uc1D
         yNSQ==
X-Gm-Message-State: AOJu0YzB19NpXg+I64KPIsH/lCY+LJaFpS+ZvnrKGPJfNFJWMDUSQ1De
	L7wx0LlxyYZzdSSKZfT5UEqZ6ip3HuQepNgtyNrnRvMk+s5mYRVvlKByagVh1DfVbmjzIRebKvZ
	CDH5EfvidFXqkeE8AcCOo1cgn1QM=
X-Google-Smtp-Source: AGHT+IExbbr5WjMkq6GXFtSkH5uHwA9GL8oL5jWqvfZ9dk2l185iqKslGfr7EIvhkIFxu3lsDyPY/N1lddLUY9GBAnk=
X-Received: by 2002:ac5:c957:0:b0:4b6:b867:c83f with SMTP id
 s23-20020ac5c957000000b004b6b867c83fmr1344493vkm.22.1705935304361; Mon, 22
 Jan 2024 06:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
In-Reply-To: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Mon, 22 Jan 2024 14:54:52 +0000
Message-ID: <CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
To: Jan Bujak <j@exia.io>
Cc: ebiederm@xmission.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:16=E2=80=AFPM Jan Bujak <j@exia.io> wrote:
>
> Hi.
>
> I recently updated my kernel and one of my programs started segfaulting.
>
> The issue seems to be related to how the kernel interprets PT_LOAD header=
s;
> consider the following program headers (from 'readelf' of my reproduction=
):
>
> Program Headers:
>    Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
>    LOAD  0x001000 0x10000   0x10000   0x000010 0x000010 R   0x1000
>    LOAD  0x002000 0x11000   0x11000   0x000010 0x000010 RW  0x1000
>    LOAD  0x002010 0x11010   0x11010   0x000000 0x000004 RW  0x1000
>    LOAD  0x003000 0x12000   0x12000   0x0000d2 0x0000d2 R E 0x1000
>    LOAD  0x004000 0x20000   0x20000   0x000004 0x000004 RW  0x1000
>
> Old kernels load this ELF file in the following way ('/proc/self/maps'):
>
> 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> 00011000-00012000 rw-p 00002000 00:02 131  ./bug-reproduction
> 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
>
> And new kernels do it like this:
>
> 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
> 00011000-00012000 rw-p 00000000 00:00 0
> 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
> 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
>
> That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
> sections to which it tries to write to, and since the kernel doesn't map
> them anymore it crashes.
>
> I bisected the issue to the following commit:
>
> commit 585a018627b4d7ed37387211f667916840b5c5ea
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Thu Sep 28 20:24:29 2023 -0700
>
>      binfmt_elf: Support segments with 0 filesz and misaligned starts
>
> I can confirm that with this commit the issue reproduces, and with it
> reverted it doesn't.
>
> I have prepared a minimal reproduction of the problem available here,
> along with all of the scripts I used for bisecting:
>
> https://github.com/koute/linux-elf-loading-bug
>
> You can either compile it from source (requires Rust and LLD), or there's
> a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny=
,
> so you can easily check with 'objdump -d' that it isn't malicious).
>
> On old kernels this will run fine, and on new kernels it will segfault.

Hi!

Where did you get that linker script?

FWIW, I catched this possible issue in review, and this was already
discussed (see my email and Eric's reply):
https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShx=
bHHA@mail.gmail.com/

This was my original testcase
(https://github.com/heatd/elf-bug-questionmark), which convinced the
loader to map .data over a cleared .bss. Your bug seems similar, but
does the inverse: maps .bss over .data.

--=20
Pedro

