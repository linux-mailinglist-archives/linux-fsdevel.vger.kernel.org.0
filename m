Return-Path: <linux-fsdevel+bounces-20190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796DB8CF682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 00:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF81F21929
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E6139D07;
	Sun, 26 May 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PaJeakmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C56C15D
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716761819; cv=none; b=qT5Kf86y9yh5tU35uQYtsdbRL/134ZDpWz4t3QUH+CmBo1LnzkW3oODD68AfzG5LtiBeYo6ltstQO7hS4W++U9xyolV5lbRAR5AG/IyleElyJq5QBEv1SbNHZ4bqkx6Camsud+n1yEK3tE2FYgkhxGTc8gA6GCLRsqIZgWGD6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716761819; c=relaxed/simple;
	bh=cJJPOPhaSnsG9a5ZvYQMl/CwRR+CoGzIrsqGAa81OUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYL0whDHqsmlyHDnO3WeIwRPEyRekplTK8wxycUY3J5FidHYS9ti6ZfjDMuwYYTo1cJaDmtc2QvKU4trloNGOfFFESUsvgc9dy6UxYm+xTEye6YiKm21Km37/1vvhSZVmlg+tshYwOOFE7dCO1t1ReZbpJTvTuo+5znTaUjL1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PaJeakmI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529597d77b4so2602940e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716761815; x=1717366615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj9aRr4TiFbyRovrKUlKbqQvT+nJ7qhCAc9UhOWM9Fs=;
        b=PaJeakmIFTdhRWC6J9Rt7vJ+Aczv/UQEDHDnyMVtGc0853FDzG6UuXmzgi7/KP9ZHq
         nYlkW5sbSLFaBak5tcmsnkI8vivH2oELrVclXlA9Z+9E7a2xnk8mz4/sVs1J/Nv7lKap
         m64v88Y1qgEUFVHZiudcFpv1w4QmfnGAu3M9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716761815; x=1717366615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj9aRr4TiFbyRovrKUlKbqQvT+nJ7qhCAc9UhOWM9Fs=;
        b=ZzT+qDc9K6RQIgaXdwBgciG56m56d7bT5goT/tTDPHeft+KA5YY887NiWNJCwW0OMt
         5H6U1dcnEh7hu9tqx911RDrEfMVjkPNvMR/3absdMS2JUYf8Kp5Y099kphpRY/OBwhuo
         omHBGkM7Zr6E3g7fShOl1m2FkTQd8eAn21T1/5VQHuly7fMtQQfVfV+TT91XSdaj4R/K
         cbeN3vHeNcLEV9tekJU58YbOciqY5VgnNzuZBCTJ2RB0CSkUIYPTB62YLfBLQOfv804e
         uO3jMV4cg8oc3vjPro1Xo8+wDrIZGwo80lXp6YPivoLBz6qSzPHe+68+hR4J9Ggu+EsY
         oLww==
X-Forwarded-Encrypted: i=1; AJvYcCUVKHmSUrQI8rCRBhotIiLageAUgxM8jIVfk2yCfWGIfp7TCcrRvecbc5yaobwucz5CQWyokgrSkI+TwhhzODKS+cR+4Qd13ASSyLpdSw==
X-Gm-Message-State: AOJu0Yy9xdhI9mgGZuOanvIneYumR0UeWUsLHIML8BBTVWP6IUer8K11
	XQtqJOI+6wlen+g8WVtUO4oKImFOBSPr2gvyWWQJuN4F9xi0g7pZ4jF8XEh4ZXdwa+QzOE6U9uW
	IkRSgEg==
X-Google-Smtp-Source: AGHT+IGP4lLSGuXnMD9ydbuP+697Sjr4V8QotQ2hMwDHvHln2yPf6VMakschlP9yTPR9wTR7uplJng==
X-Received: by 2002:a19:2d06:0:b0:51d:70d9:f6ce with SMTP id 2adb3069b0e04-529668c4c8emr4855028e87.53.1716761814859;
        Sun, 26 May 2024 15:16:54 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852495debsm5018286a12.69.2024.05.26.15.16.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 15:16:54 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6267778b3aso164254766b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 15:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8PTdXtaX+qStw5azP8tcb0jzGw59hBkRhY/ZkgSlptnSoipbJHnWL51KtuJikHwY1RkRPV8zgHpS1e0hamKvHkt11BUlztX4fPysElA==
X-Received: by 2002:a17:906:48d8:b0:a59:a7b7:2b8e with SMTP id
 a640c23a62f3a-a62643e0787mr526403766b.29.1716761813805; Sun, 26 May 2024
 15:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV>
In-Reply-To: <20240526192721.GA2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 15:16:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
Message-ID: <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 12:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Not really.  The real reason is different - there is a constraint on
> possible values of struct fd.  No valid instance can ever have NULL
> file and non-zero flags.
>
> The usual pattern is this:

[ snip snip ]

Ugh. I still hate it, including your new version. I suspect it will
easily generate the extra test at fd_empty() time, and your new
version would instead just move that extra test at fdput() time
instead.

Hopefully in most cases the compiler sees the previous test for
fd.file, realizes the new test is unnecessary and optimizes it away.

Except we most definitely pass around 'struct fd *' in some places (at
least ovlfs), so I doubt that  will be the case everywhere.

What would make more sense is if you make the "fd_empty()" test be
about the _flags_, and then both the fp_empty() test and the test
inside fdput() would be testing the same things.

Sadly, we'd need another bit in the flags. One option is easy enough -
we'd just have to make 'struct file' always be 8-byte aligned, which
it effectively always is.

Or we'd need to make the rule be that FDPUT_POS_UNLOCK only gets set
if FDPUT_FPUT is set.

Because I think we could have even a two-bit tag value have that "no fd" case:

 00 - no fd
 01 - fd but no need for fput
 10 - fd needs fput
 11 - fd needs pos unlock and fput

but as it is, that's not what we have. Right now we have

  00 - no fd or fd with no need for fput ("look at fd.file to decide")
  01 - fd needs fput
  10 - fd pos unlock but no fput
  11 - fd pos unlock and fput

but that 10 case looks odd to me. Why would we ever need a pos unlock
but no fput? The reason we don't need an fput is that we're the only
thread that has access to the file pointer, but that also implies that
we shouldn't need to lock the position.

So now I've just confused myself. Why *do* we have that 10 pattern?

Adding a separate bit would certainly avoid any complexity, and then
you'd have "flags==0 means no file pointer" and the "fd_empty()" test
would then make the fdput) test obviously unnecessary in the usual
pattern.

             Linus

