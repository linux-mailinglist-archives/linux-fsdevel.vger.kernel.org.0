Return-Path: <linux-fsdevel+bounces-66608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB50C261E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183684F412B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82025334B;
	Fri, 31 Oct 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9UQI5y6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720C280327
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927920; cv=none; b=tEiWnl7GvYAeX2MW0JH8pmuQDcSzZn0P/FkLyGCIlQxSh4oX4VtQAagnFP44hFfKraSjWeWH5YQZRU4B5bJt0U4dEQiuJtkQmiMsDoksNcMXQNbYmNUulgNQiWnRgJ+6ouPFvJbkamhD5IaMk8AqLaqjpQr6/fB8Qrt4E8lJ9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927920; c=relaxed/simple;
	bh=8RX6Dbpiq3dCPXxN/J33SXBc20l/3zBbyGrlOyx9sZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyY5oc975K+27SRWR+z9gbeBtyGVidaD4oJOZ13RfR7jDAzmGhtuw6+ew6hYJsbQ2XgBzHLDFkupK1dIJGTlaQkY0PAw1xNhUIyq57+dQ91M3wctE0HS+xQhbQW1M7rHBJ3YYexHSlQTnV6q604AGGm5REnK70IHB+hJIXULYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9UQI5y6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so5012244a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927917; x=1762532717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpYe/7mq49sINy5nrhbkqdvXniyS9DNZSIVJcYyqnRE=;
        b=U9UQI5y6Pagk3mHe5vp3mpp5Ep4VGvnbWVjyeCBNa2ZaHGBuDMZGvdNeDdymCFuBnK
         iPM3YLQ68bdK60vfJZQ+WXfl5Y5JJ20t4F/JoZU7L1HmT24LYG4xEpOq87JMuT53/RD5
         y72oWuNWfhLdlW5Aag8K5rCsmwOJc0w0fNYaVn71Ex2hWml4qpUGjFw1N2GcqGYvntPR
         g+9+M9Ct3I3gyKjmD8HpF0UJrLktemUA3bxaiVX3Q3TSKKj4DwtIfmDKJAyuUb4ChNdb
         3rDeaZqoOZxpxUkYKrbffz4M9ISRJCycNye9quRBMgSfdpvrh6rCsLfTVPLtZPpnUbwo
         PBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927917; x=1762532717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpYe/7mq49sINy5nrhbkqdvXniyS9DNZSIVJcYyqnRE=;
        b=ac24iDynJ9/aptW8OP9Hu0PemHb7ziDpO7z6JyS9X/9W8FDn6YosSk4/DEZeLoEoXI
         xvsN3pK2kwLoETJu+/duZ4N+hoCFaDiVzyB8TxCl/1nvLC9fshwBnSYHEUkCagY8a6YY
         UpmFQaDLZwNVa95f8RtJOJ+wXxiIypQyirzUi6yl8pQKb1413SdfjvkGAoyfXIhijXyf
         xwy25048AiDDYmVNqOvgiSl7IEUZX0BS98BK2uySEp+kLE4IMJE0S0od4tsxe+0hO/lE
         u01+A4pPdmbJuluiHIfJT/utsk/ECUaRvtQy85iQxdl/psGzk5gAlEENb8vm2XATzo/G
         MGkA==
X-Forwarded-Encrypted: i=1; AJvYcCXtKJpiY2QZ3wMV6RAqSfcG6RQZDF7P60zaXvxVJXkEIZ4LTyR2lBcYZAex96E5f27n6Yqo4GfWUsbr0nvA@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKXoHEunqVKHQFa0zX6iC27m4KbWCRTD4ZnAn6OHvCU+AMMVA
	wWm0yUPjyaDUnevMtx2CBQ7kLM9mJM2tpL3Pqf+MuDkN9hzupfDfL6VN6bGB95NgjmuHv/jUAqQ
	1D2PAB8n63T4i07kXeFGr52sOK86cTUM=
X-Gm-Gg: ASbGncuXfhw2/Pzjy/XYpfoNxUrijc99uvoTf5US5D0MIlESVILoV55V7nCYzLQNBUm
	iwFDIzJc5juCGWZHSkJ5SNeiVj7V7f/JJaEiVI2hgcdH7LeaVE7Oe7z5PP0p5OBxcIUdcvqL1Rm
	l+uH6UW1DeFwOtOt9p2vP2fqNRkhb5zsiH4DPZg5vMlFi8pvC0E9pRjhTIU56AcPhCujwnddoRc
	89xkzYGSoO+aaHgjMhIbRPfc36Hod6kedxo0L5VzxmcmC+kY1KJ+I/ry0VIsDX0bZmhyeqQWne9
	vJZ5uVrHVvob6OS5Rl0LUI9V8Q==
X-Google-Smtp-Source: AGHT+IGuREERpP9JnpVQxE2gx2N8ATYZhyw+bQKD7/ebUCH+Mrw5ZxZqHBK0mqRWetMsnJ5y47gWO+g8EPh6uo/ICFg=
X-Received: by 2002:a05:6402:2744:b0:63c:343:2485 with SMTP id
 4fb4d7f45d1cf-64076fe6cd9mr3672370a12.3.1761927916424; Fri, 31 Oct 2025
 09:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
 <20251031-liehen-weltoffen-cddb6394cc14@brauner> <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
 <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
In-Reply-To: <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 31 Oct 2025 17:25:03 +0100
X-Gm-Features: AWmQ_bkK66nXWWUBfCViwvAvnwp-VB0qpGt3aWzeH7OijeWkiVZsNRWYzD9jixw
Message-ID: <CAGudoHFC9vfHZsgjvib=Hy8wNom27wYG+iJz=5G_6zNQHF2ndA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:04=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 31 Oct 2025 at 08:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I slept on it and I think the pragmatic way forward is to split up
> > runtime-const.h instead.
>
> I don't think that would be wrong, but I do think the real bug was to
> include runtime-const.h in any headers at all.
>

I think that was the right call, just that realities of going past
amd64 caught up with the header mixing the dependency-lean (if you
will) access with dependency-heavy patching of it.

Again with names_cachep as an example: there are different spots which
use it. On paper, fs.h can include the right header(tm) and everyone
is transparently covered. Without that every single .c file has to be
adjusted.

But that's only few spots, so one could argue that's a minor inconvenience.

Suppose one was trying to make systemic use of of the machinery for
other stuff. For sake of argument, say everything marked
ro_after_init?

With a lean header it will be feasible to sneak it in to something de
facto included everywhere.

[snip]
> End result: I think your patch to just use
>
>   #ifdef MODULE
>
> in the header was the right one. Except instead of that
>
> +#ifdef MODULE
> +#define __USER_PTR_MAX USER_PTR_MAX
> +#else
>
> thing, I think the right thing to do is to just do
>
>   #ifdef MODULE
>    #include <asm-generic/runtime-const.h>
>    #undef runtime_const_init
>  #else
>    #include <asm/runtime-const.h>
>   #endif
>
> in the x86 uaccess_64.h header file.
>

While I can concede __USER_PTR_MAX naming is not the best here, I
think your approach looks weird but it also complicates things.

I take the intent would be still to fail compilation if
runtime-const.h is included. The file is there for the premier
platforms, but most platforms still resort to
asm-generic/runtime-const.h. I think it would be beneficial to have
that sucker also cause compilation failure if included for a module.
That way someone developing on a non-mainstream platform is less
likely to post a patch bogus on this front.

> Let me think about this a bit more, but I feel really bad about having
> missed this bug. I'm relieved to say that it looks largely harmless in
> practice, but it really is me having royally messed up.
>

Sure, there is no rush whatsoever. The original patch was meant to be
a 5 minute detour and it is not holding up any work.

