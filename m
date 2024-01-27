Return-Path: <linux-fsdevel+bounces-9221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E483EFE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F971C21976
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDF2E64E;
	Sat, 27 Jan 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h/wNPzfV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8E2E635
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385708; cv=none; b=BQBau53WoSzsYoRnZimqBeGgBo0Uump/m/KDVkDoK2S+RTxvL2IvsACTU9Ih/brYcyJ14nujAOxiWH1/wpo3Bp7SO4rl6X2bx19BQZ2S9deUUUS/p7G9Asn2aYRybfYh8bdNgJVjcd07r8p0CcHFztPSFehLuvLezy3GlwvIJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385708; c=relaxed/simple;
	bh=N4yM4Sx3Bo4zjchytKwAIMFmf9vDnuWdHVbRYVkfw1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApNkTanM3Khn3eiD3YU3jlypnuTlSr5GE6/G6xHP4SBKxE3VVDm0uyv5wvIH+WVXN4IvXwDiefxvmQI7+GU66VhQGpisjz8PW44hc36pN9/JR1fy0BCjq62jiAp3LIQoo8clAZY4dOV6dl3q7fgtOCn93O0EP/2OhIqzvzNeIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h/wNPzfV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2a17f3217aso209764766b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 12:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706385704; x=1706990504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqDQR2DUv5doyugas4NFosE1WpuO2lGhHoJ/mTvORLE=;
        b=h/wNPzfV9Q1rRDUoWVacLyh4Xt9/kpTkRIzNlMlkiSLGRVt0vsEsUuaN6xD1FtkSls
         B9ib8hlnzQ1fbar84d7k99ecyQFLM1MxE4fTCDNwp/OWCzCAvVEG2/V/QjWJsfaba1Pp
         ykv62JFHVRl6WomEqwO3TRcIDpjio6xXv3lpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706385704; x=1706990504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqDQR2DUv5doyugas4NFosE1WpuO2lGhHoJ/mTvORLE=;
        b=Rp5jcfWKRkAWliaEW47yg866nBRrzT50SQV3JyhyM6wBVgJIwQ2UnK0GeLbl8+5MmF
         PXHYr2Sm3m1XMOe+/NPqI/lmpX4qTsPCs0blZ50ES0aeUFT7KLIoty7wgkoCWuh5HWfA
         Nz4fa1Acn1ei7X0KA6eSQQ0ZgqngyQ6jcOyQJADr2cbaXI9H7s2yIUCD3aykGK0hQ+Q+
         qYlKv4IztFlg9FzVBYM5Y7DIKO5EUBe5GHQRAENHbdjxh0GvideHOU8AC11NQpLip+F+
         TxoL62U9gGc/nzHs9ktw2je5g6DAOvEz4sXNTSsn193udE9YRUl/DlTl+eno8aD+FzLk
         tASg==
X-Gm-Message-State: AOJu0YyfUYnoyRG/0dVfVZnyETAdWg1xUxLZXTCeKsUjVYezaqP1Ha/0
	tY9rFxdSpddMeipvP3K2it1sT9A0XtponuiSD61zHbowUlhsY6K1p6zJPXt4d7kAtRB0sTWJzFm
	RO5SkIw==
X-Google-Smtp-Source: AGHT+IEELRbqvyTGJZr/Tg11x5Swr8WXxQimlypsvV5b2mFSH1T8KbUtXTCNRgP0fn4ZEzoJJhPyig==
X-Received: by 2002:a17:906:5919:b0:a34:bcc3:1982 with SMTP id h25-20020a170906591900b00a34bcc31982mr2021701ejq.46.1706385704383;
        Sat, 27 Jan 2024 12:01:44 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id pw20-20020a17090720b400b00a2e9f198cffsm2044745ejb.72.2024.01.27.12.01.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 12:01:43 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a539d205aso1641679a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 12:01:43 -0800 (PST)
X-Received: by 2002:a05:6402:3137:b0:55e:b30c:e0db with SMTP id
 dd23-20020a056402313700b0055eb30ce0dbmr1269613edb.35.1706385702705; Sat, 27
 Jan 2024 12:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <9b34c04465ff46dba90c81b4240fbbd1@AcuMS.aculab.com>
In-Reply-To: <9b34c04465ff46dba90c81b4240fbbd1@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jan 2024 12:01:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgX6VV4nEpC7+f=QZq6VDrJxVJd_7vVfJdhq5aWDHM0oQ@mail.gmail.com>
Message-ID: <CAHk-=wgX6VV4nEpC7+f=QZq6VDrJxVJd_7vVfJdhq5aWDHM0oQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: David Laight <David.Laight@aculab.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jan 2024 at 07:27, David Laight <David.Laight@aculab.com> wrote:
>
> Doesn't Linux support 64bit inode numbers?
> They solve the wrap problem...

Yes, but we've historically had issues with actually exposing them.

The legacy stat() code has things like this:

        tmp.st_ino = stat->ino;
        if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
                return -EOVERFLOW;

so if you have really old 32-bit user space, you generally do not
actually want to have 64-bit inode numbers.

This is why "get_next_ino()" returns a strictly 32-bit only inode
number. You don't want to error out on a 'fstat()' just because you're
on a big system that has been running for a long time.

Now, 'stat64' was introduced for this reason back in 2.3.34, so back
in 1999. So any half-way modern 32-bit environment doesn't have that
issue, and maybe it's time to just sunset all the old stat() calls.

Of course, the *really* old stat has a 16-bit inode number. Search for
__old_kernel_stat to still see that. That's more of a curiosity than
anything else.

          Linus

