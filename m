Return-Path: <linux-fsdevel+bounces-36210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC129DF687
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F5B216E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19361D7E21;
	Sun,  1 Dec 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWgX+UmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847B1D31A2
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Dec 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733072105; cv=none; b=b1USk8XWZIJZlh2tA3rD4F1hRkMY/xoR3DbaXBA4sN/SZD15q+ADVSiOFfre8QXWPARtauj0vpR5WBA4rrCAzYNLsXUNw4iFxMydZiTbWpu7hTxkLYJ0iAdvKk3gA2xx0eJ/pk8K2GYF3lzmZ90YHRRa/C6wyu/Dj4SKA4Jtcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733072105; c=relaxed/simple;
	bh=Wu7aLMR8bgAYmwBV8FIHf7YQhTXWw6T7z4NKroXjPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Onbpi/ME2QsCuzzpnZjBtAMiANspFnlTb1g0g/D0lz9DO6NMTtZNErLkpYbia99Ktr/74UGYevNMH7gsLckAyyP5bgNxjY7vnHKNRKyH1a7jl5xzr0B1pBXl4JEkQFpGtCU22z1RsLf9eyypvLyJNHzR5HcnV5u68QjsZCeup+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UWgX+UmK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0bf77af4dso2319907a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733072101; x=1733676901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5z2s0WfIwLJLVHUR6snQ9W2d5ktmXbetex9wVs407g=;
        b=UWgX+UmK7LRq2nzfgf8gr/9CZ8HOdaG+5xpojOoWeoMM2IoisRw2+ud7d8tyoGTIdu
         vAMuYwkmfxizWOFTqUSsyhLyMb4mMu48iT/UnBPKi5y08UIjbksto0rPlnvcF6WOSwoB
         G0dEFkX1alr4fVTRq+ZNCmomMaodvBfS2Yzyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733072101; x=1733676901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5z2s0WfIwLJLVHUR6snQ9W2d5ktmXbetex9wVs407g=;
        b=J78HtJQsJocxS05sBJ+PISNemXd7ctV7ibe7T7hSEebWj7Zt9h7iLOmUTbpaVV4E11
         e6k4nC20rZDkHwbWtbBUphnDTJwfFkSSvOKMzJSAxm58T0xyxuGYEKx2/tIwUGrmIEZy
         TGunUsVqvGfY7JSBaEJDJiVj85lkpmnCHKxMXm5RD6ku2BaRqJEjZZavrtPHVsxZuYBM
         0Bm/tTFaDmr+L6A3nSFfcErwEwpZmRtFn2p+Oj15Bve3Sf9tnI7r1N0a8LzTR38MPdbW
         EzPxsXxwutkTvlSC6rpvzz7X4r6V1rAXIXM2fdzawe9BLqF9qnlymMYW9qhL+yLQwfnu
         G3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWk/KOd9XJeKMZ+k8lZ6+SVUvMUeiy8Kzm4fVCBlGkuUc6S5C8jUxgEp4TaWe6aiPcJnfovhulvLgNJqFRO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5yqpflq2arxPQEnTaYUJx9KxdAfcmKx5taVzaA2Oysm/33WW
	ukjcNJmuNrdR4pTF3JnqdQJYq5QYf3iqAo4FCrcH2r9ghuxN4zoWrjkk3iA5nXxcI9q6Nab31wq
	zSDw=
X-Gm-Gg: ASbGnctrrItDw7X0RptS6P87Ac3hfq1lSDq/RVq4UQmxf0t4tXLcq4TZhGKUtJOt+mR
	wSE4jviePCE1ZaHVaUieNuMkaXgqPst8LRQ8Gdr1MTalEtDU/sonm8cS6m5H/ecHtyNy7fUJlmO
	TzaPUVjJoRjUTAEgrLIGX18ub60R8GH1oF9nDpbt+OXSPw0I1V3CWosKm3cCQQucn643R2QkcZo
	nRw4yq1cUMQgO9F0HLRhG58yQEoEYPB6VM8AcaToghrswKcp61ezZ6rfsRi0Aha6vPEFSfzfCQI
	TJ7R2Ajx/UlyqAjflpAl9bSW
X-Google-Smtp-Source: AGHT+IF2umvGx74UL50XK8V+EPB9iZyVQSVsNfwU86s5wPR+mNQ0BNnuB7Y7qbLUjhIsRRtXY3r3QA==
X-Received: by 2002:a05:6402:528d:b0:5d0:d34a:514 with SMTP id 4fb4d7f45d1cf-5d0d34a0972mr4825326a12.21.1733072101339;
        Sun, 01 Dec 2024 08:55:01 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0cfde6c82sm1620003a12.53.2024.12.01.08.54.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 08:54:59 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa503cced42so514250866b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 08:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5iAZNg5a5sZYYC0aurdIawKZVXTP1ssNZdsWesN5oYR7n9cDMPOGKD14SsKMUJaRB37JqR0CubxnMlb1q@vger.kernel.org
X-Received: by 2002:a17:906:3d29:b0:aa5:1699:e25a with SMTP id
 a640c23a62f3a-aa580ee98eamr1451183366b.10.1733072098046; Sun, 01 Dec 2024
 08:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
 <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com> <20241201-konglomerat-genial-c1344842c88b@brauner>
In-Reply-To: <20241201-konglomerat-genial-c1344842c88b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 08:54:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Message-ID: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 06:17, Christian Brauner <brauner@kernel.org> wrote:
>
> /*
>  * Hold rcu lock to keep the name from being freed behind our back.
>  * Use cquire semantics to make sure the terminating NUL from
>  * __d_alloc() is seen.
>  *
>  * Note, we're deliberately sloppy here. We don't need to care about
>  * detecting a concurrent rename and just want a sensible name.
>  */

Sure. Note that even "sensible" isn't truly guaranteed in theory,
since a concurrent rename could be doing a "memcpy()" into the
dentry->d_name.name area at the same time on another CPU.

But "theoretically hard guarantees" isn't what this code cares about.

The only really hard rule is that the end result in comm[] needs to be
NUL-terminated at all times (and hey, even *that* is arguably a "don't
print garbage" rule rather than something truly fatal), and everything
else is "do the best you can".

Could we take the dentry lock to be really careful? Sure. We simply
don't care enough, and while other parts of execve() are much more
expensive, let's not.

              Linus

