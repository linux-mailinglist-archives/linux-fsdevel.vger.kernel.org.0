Return-Path: <linux-fsdevel+bounces-9430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4F8412E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621C81F2385F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761A1EB42;
	Mon, 29 Jan 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OsOLphgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2328DDE
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554733; cv=none; b=kspD083r9ITP9ntraylrHzVm4iPATvSQCDFySHMVlOuTOKaC6PmLft0icyWtV10+55f34KI+aGVbEP624p6aHHxGP0YVNZEuwHcIn796pMgbVW1FFSMXrtH9lF09sJ0UlNPWDgYHRXpEvtypThhocAO6TAhz7ZV5wvY0YPyfWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554733; c=relaxed/simple;
	bh=eKMFg7i7+7j+e8Iv0NW7ko6n3ZkbnwSwN9MN8KR3iQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFoMDXTNVTlOoDgFul4qZNnx/ds6spV8dT6NpG2iMNZXuDR5H6wU24evS2VNkCFoasyQWTkFA1UqoyWI0qMM70VZ05PgQ19xxa4yzUraJiUJUd/5ZuNtrDjdxIX3MTRyhunSd/jVNGpGuFgANq8XO9RNdkmvukeXNk+RbpwwRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OsOLphgX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d057003864so1147401fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 10:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706554729; x=1707159529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAIeftpjE3O3z+PB+PSTo+RPyGVLY9cTuEJCruuNk/w=;
        b=OsOLphgXcvY9l4lR1zql4yODBK9CiHilNprHE23ita63pWGQxXOny/0C4QEPHkJL4w
         7nHUPf1MNloA2saNS/w1AKU5vBU6rqBmubOBGGuKZeypMJSUr/HtqU08a+kxfahD/FFS
         xA7TZouk9GaxShnH83jZhmiIqb7JOItvxa1KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554729; x=1707159529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAIeftpjE3O3z+PB+PSTo+RPyGVLY9cTuEJCruuNk/w=;
        b=YmOKMVQAvKJ9tAOrVrmDQ78M0jSNn7nhmXHjYS8Y9ySlagI2itmj1ONBLD2F3Mx9mh
         xaI0fNtS8L0nms3LG0pUAhSHfXdDXG3LHh8q1DO/yfcGIWbInmLqotJcMHZwo8IhQMqj
         XDVRbvirHhUTN00g62WjqME7gXFyQtfc84oRkeqSY0AOXzvSPK5iGxBL8SNZZhmo59pN
         QzKA5QYYZW4cqrZpp0flE4bm5Qq8GLBHovAsPe9gYEpI+rdKcoJ/zJ8RSFoSKq5Yql2b
         nGQRRLqDu3FP7dEEkI2OtFwcpe1z+VPMSrFm+foeShftdprqbndZ7BGgusBwxM3ZU2NZ
         S4+w==
X-Gm-Message-State: AOJu0YzIEMfmz3iN8awjiNZwwirB/oC5zAwO10tCPOQvidd31DDCaoT0
	RtIWcck7itV8aa56plbfwqL6VUZxlcJvtRDb+JxHFI3bC+h17tFYF/MhZvXt3xXcNsYRVNJSJ0v
	QowyLZQ==
X-Google-Smtp-Source: AGHT+IGVFna17cbnjDlFiAzd1lFEugS8bQoVzrFwz8i74tIC8IxZifzm1JhmYPLXXoT+U1mR8i6liA==
X-Received: by 2002:a05:651c:14f:b0:2cd:fafc:1700 with SMTP id c15-20020a05651c014f00b002cdfafc1700mr3743622ljd.53.1706554729183;
        Mon, 29 Jan 2024 10:58:49 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm1286600ljz.7.2024.01.29.10.58.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 10:58:48 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so36254351fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 10:58:48 -0800 (PST)
X-Received: by 2002:a05:651c:150b:b0:2cc:9ec8:fc5a with SMTP id
 e11-20020a05651c150b00b002cc9ec8fc5amr5318335ljf.39.1706554727677; Mon, 29
 Jan 2024 10:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
 <29be300d-00c4-4759-b614-2523864c074b@efficios.com> <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
 <3120f1f0-eaf8-4058-9a65-bdbee28c68c9@efficios.com>
In-Reply-To: <3120f1f0-eaf8-4058-9a65-bdbee28c68c9@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 10:58:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8BrZEzjJ5kUyZzHPZmFqH6ooMN1gRBCofxxCfucgjaw@mail.gmail.com>
Message-ID: <CAHk-=wg8BrZEzjJ5kUyZzHPZmFqH6ooMN1gRBCofxxCfucgjaw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 08:00, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This breaks "cp -aH" and "cp -aL".

Do we care? Do we have a user that cares? Has anybody ever hit it?

Why would you ever do anything like that to tracefs filesystem?

In other words: my point is that tracefs just isn't a regular
filesystem. Never was, never will be.

And people should be *aware* of that. We should not say "hey, if it
doesn't work like a normal filesystem, it's a bug".

Try "cp -aL" on /proc, and guess what? It won't work all that well
either. For entirely *different* reasons. You'll get some variation of
"Input/output error"s, and insanely big files and quite possibly
you'll end up with recursive copying as you try to copy the file that
is /proc/self/fd/<output>.

It's just a nonsensical operation to do, and if somebody says "I can't
copy /proc on my system" it's a PEBKAC, not a kernel problem.

The "no regressions" rule is not about made-up "if I do this, behavior changes".

The "no regressions" rule is about *users*.

If you have an actual user that has been doing insane things, and we
change something, and now the insane thing no longer works, at that
point it's a regression, and we'll sigh, and go "Users are insane" and
have to fix it.

But if you have some random test that now behaves differently, it's
not a regression. It's a *warning* sign, sure: tests are useful.

So tests can show when something user-visible changed, and as such
they are a "there be monsters here" sign that maybe some user
experience will hit it too.

So I agree that "just use the same inode number" changes behavior. I
agree that it can be a bit of a danger. But these "look, I can see a
difference" isn't an argument.

And honestly, I have now spent *days* looking at tracefs, and I'm
finding core fundamental bugs that would cause actual oopses and/or
wild pointer accesses.

All of which makes me go "this code needs to be simpler and *cleaner*
and stop making problems".

In other words: tracefs is such a complete mess that I do not care one
*whit* about "cp -aL". I care about "this is actual kernel
instability".

           Linus

