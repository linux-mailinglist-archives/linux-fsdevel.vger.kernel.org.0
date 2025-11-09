Return-Path: <linux-fsdevel+bounces-67622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF2C4490C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4613AFE5B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC87F26C3A2;
	Sun,  9 Nov 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H+iAGw3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152AA1FC8
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727368; cv=none; b=X65DCnBpS0HTFJFTqsWAB5tYUUyZK+KTwuAWIY5T46Kut2aVo8ZtEKE9i1WPe8fhrM6zRhKxTxoEJaDx+NM4fdVS04Xaumv19P3YaOupA+nxAbqF1Nd6XxWRU7eorsFpJ1EObX7wuV+s1YMDdjy0/Nk9dDzRO/Ltx5jui4S1QU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727368; c=relaxed/simple;
	bh=XyKRq+klY1XpCUw5LERZ+VW2+vF/uljQ+cnRU4sIHJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/mRNhM2/nJv2CSg9POzDZl1CHtA35GZA5gs0MxUCV4EbYh5QIjxXT+UhOUDrud7kIjqYW1z5xDd+B87ik0tU1TbWiqjnNeyjnub/iqtRQn/vGpPlAuQfn5siE8MtJ4MuXCge0pfUn7b4C4JRAzx7DB604JVBqnxjdCizDo9fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H+iAGw3W; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d402422c2so488299166b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762727364; x=1763332164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPZie8eb8w8Uk6fiaOTQBcY1xriqA9OV/bgfwL+5Tjg=;
        b=H+iAGw3WZ8/mcUNCqCYcLbSN05Lkwprzv2wm6tnE0Y+pCwsTV/JswZALzrEZv1CCDd
         V3tFE6r8JSdi2QOBlX4fMJ0Tf5+T9wChdcr2t0zozx+DJ+NA7L3VG8F0fhNm2eOcmaam
         hkyCSMsXNJjKO0WhYxaMNm+ZJZyAYb3GGR7XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762727364; x=1763332164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPZie8eb8w8Uk6fiaOTQBcY1xriqA9OV/bgfwL+5Tjg=;
        b=AhqSCqE+ywA9Lf1P8iT/apFlgHRI84kKHFGnPcD+KSqiBSszPmzZFoN+JeHWHJRB9H
         ESjDnCsOl2sILU0y8+QTIfx36a10s74BcWQX6jCa+1Y3k0zLX2/qLN4RTEsfErc4snSJ
         NUpr6CeTk/jD3pTGUHGib6SJqw/AUpJXU2W9HJYDjXw37s1LJZt0ohqxaQY6IrpK4QOr
         w6EuZBU3xF1tNgmzB8Q2P2UYo0r/Npl+sMqhLZkTm8zbp2eghrQlZjQXW/lyxJsXHSKu
         ouliTKH6UIw1f86kJuy39N9g4KEqdYwwlAAhGPlZ7IzpbVxuYFoI2Mr3FfCsA2bsyV4f
         FDlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVkHB/U5HE+g3O51doTF5DtzrTnI3YIjVX7KEry/J6LxGUb+5Cyjt7AOUoJJETKa85vuBnM2hjdR/8BxHC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DtFfKiHifVSxMOLYpiPwfS1pYQUtzz6XSmvaJC0tycUWvNES
	JzaEcHB5nO2kduj61kb7uf9XEkIMKUb10E7EndSRZQFiMaMfwyE/cGr2K/gN8W4857hKIlt/VDg
	+0Z5je+o=
X-Gm-Gg: ASbGncss76KdOZNjp14iwYHUiOPE7Op1waJjM8MePPyH/FDYaEqv8YV0B8YWkZdctqj
	cCynAihk0yP1mFS/lfOqgqP8v+GquPlO6iiJHrOS9UNZUacT7/ZxRazDg++lNkIyv501qhk5BhR
	u991CzBg4bjxl+oP0ykZW5RdBbNwF70gD2nWilC6xuKL74LuiYaSss7u0AWNdlnGMjkHSXlUdoQ
	vfk3ijySbwjOubKM0t0UL1prwJCkGa3M82SrstqYA/f1M1wd9YfMIMbjjdve4bp/OnPpH43FmBN
	2/gw/fa97G29JhWYvqvC10vWo9qOGZqhyMDDqB0xseh+By4rEpvhqPmrCeN+/yWWvzK4VezXpJX
	BpEUGRnns+MZCpXF/NYdy6WCKErNjsRvD4kmr+iumFXA7XbSGMj9qOv7cNpM+sdfHnmoimgFCiG
	LWKOlm4556+dS+e5Tqx4uuUV8t1r0nRhqfXtgMH/YeXjPKjIzkRIxODF3BAYOx
X-Google-Smtp-Source: AGHT+IHpN/+z1xX+zLePJOYz/PlmCJ1NYlFJyP37JgJjGz2cLx/ZhnzhUwQ5RcFZnpjWA2YX7DDmVQ==
X-Received: by 2002:a17:907:9409:b0:b72:947e:358e with SMTP id a640c23a62f3a-b72e0286ef4mr624361366b.1.1762727364192;
        Sun, 09 Nov 2025 14:29:24 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e457sm907258866b.43.2025.11.09.14.29.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:29:22 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b403bb7843eso432940666b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:29:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXF8FNRpC3KK65sAXtN0NfdElPNCeoup1uCHp0Mpy0bOXCfOt5XEXywth8fXfOrEqOpQyvcWpl/5I0xVCAd@vger.kernel.org
X-Received: by 2002:a17:907:7e91:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b72e04ca2a7mr646520366b.45.1762727361843; Sun, 09 Nov 2025
 14:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com> <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
In-Reply-To: <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 14:29:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
X-Gm-Features: AWmQ_blmodcy0umvH9FZdE7IOt16sLGm5PW6HtUqYPgjmzsWiwn8iRr6Hrq0I0s
Message-ID: <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:18, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> You would need 256 bytes to cover almost all of this.

Why would you care to cover all of that?

Your very numbers show that 128 bytes covers 97+% of all cases (and
160 bytes is at 99.8%)

The other cases need to be *correct*, of course, but not necessarily
optimized for.

If we can do 97% of all filenames with a simple on-stack allocation,
that would be a huge win.

(In fact, 64 bytes covers 90% of the cases according to your numbers).

              Linus

