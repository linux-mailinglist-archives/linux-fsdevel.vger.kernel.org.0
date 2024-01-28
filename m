Return-Path: <linux-fsdevel+bounces-9263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A816283FA45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449951F22604
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFD3C49D;
	Sun, 28 Jan 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U3FCvQDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BE3C47B
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479692; cv=none; b=lbR4lEyNXZiYm2LKhDwMyVJW/BnvHGFanCzFi5uJR5+V2vnbrirCsb+VFVe3xN9RNaBr92/aCFDEQfedcBgHIIDTC6GbLX8cDaQsnCMMLsVmtQcJYHtwKZNfZMh6DTqOx8mRSIwco+Pi7QlMuS7tXC1KpS8u/OecpHSQd+AIO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479692; c=relaxed/simple;
	bh=QrkyxoSXHYJTqgfXOZsbnZEyWO+kRuXGCx6MVdeKjaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki7LA4YY+hVSCLEEJJ9zUz2aQnL6+s99zxZz5WZJEJDIGZ0QMS2OQVnxJl5RKhVkTSXAok5WpBSSsyN5LF3SZQ05n6c9EOal8TkjizLVn2DyXT0IwQkdIowhewk7BE65nwrumb/gyRFqj3bFU8k4m3CqXhBEhT7dyok0CiFcaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U3FCvQDV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a358ec50b7cso92209466b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706479687; x=1707084487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5EVcmzkmBCRT4EQRf6hOGTNZV4Vu2foNdqvfEoib8=;
        b=U3FCvQDV8wlDZNQrqgPMR6yoI5S4khe4tysgj6L1hYlLrS8Yp2vPLESMrGSTMsSNFH
         1YrqbYeyaCyP9sQ2P6H/4qOcgNYURSTigbIB/fxKQDgnXnrKqIGetSyt+iFkXrg9zyU0
         7D/XwV8lW5yjohpaJATlmJFH1UnSln/8DreEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706479687; x=1707084487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w5EVcmzkmBCRT4EQRf6hOGTNZV4Vu2foNdqvfEoib8=;
        b=MEcANo6m8NSmBcfR60wslCX/dY+vKQBoAG/YXGzJODj5tU5+O5U9Uzs3UwplSiJqia
         b8/akgXLI17bQt0qbBGQP0o7fZsh5NgY090PpoABRsJ18X/mMK6+4Pb8H9OVIbsK/APu
         SecH5T7K2zqo4c2nmjPkqBJV4STDXIYdfWSocrlH/2ioBO+CaSeL54xgHMkrlTLNCZM9
         LYsCdEcaaGKp8MzOGSnbnJf4C4xJ7gFmzhBaYPY6jUHspmqgp6veLFxhtVynoZU8OwN0
         DMr0IVcuqpANxXYpreYupPHigFoJ5CotcmU9/kr9Jb2gx5g+IMEazGaO2KQK1z4ESjy5
         dDpA==
X-Gm-Message-State: AOJu0Yygo59wRV6w4mVQCd23dR3Msao99yV1Gg9/aIQFozJQgmUKNmKC
	jJMQ17x5/f28pEMeKn8SmxMuc4A1XjJmrxQfOr/lSBtb6my0Vpt6RKbinboOVBWve0qk2i+/lTX
	AW6MPeg==
X-Google-Smtp-Source: AGHT+IFNw7VVHoMDYuT7gvwOAZ14TBGgX7xTUEB6K5De0QBtOR9jw4NLQlnwjd3D7Sni1oMnyGgf1Q==
X-Received: by 2002:a17:907:a710:b0:a35:8b62:42e2 with SMTP id vw16-20020a170907a71000b00a358b6242e2mr1986778ejc.7.1706479687602;
        Sun, 28 Jan 2024 14:08:07 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id f19-20020a17090624d300b00a2f15b8cb76sm3210098ejb.184.2024.01.28.14.08.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:08:06 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so3609936a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:08:06 -0800 (PST)
X-Received: by 2002:a05:6402:94a:b0:55c:93c1:4a50 with SMTP id
 h10-20020a056402094a00b0055c93c14a50mr4633321edz.13.1706479686311; Sun, 28
 Jan 2024 14:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
 <20240128161935.417d36b3@rorschach.local.home> <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
In-Reply-To: <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:07:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com>
Message-ID: <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 13:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That's just wrong.
>
> Either you look things up under your own locks, in which case the SRCU
> dance is unnecessary and pointless.
>
> Or you use refcounts.
>
> In which case SRCU is also unnecessary and pointless.

So from what I can see, you actually protect almost everything with
the eventfs_mutex, but the problem is that you then occasionally drop
that mutex in the middle.

The one valid reason for dropping it is the readdir callback, which
does need to write to user space memory.

But no, that's not a valid reason to use SRCU. It's a very *bad*
reason to use SRCU.

The thing is, you can fix it two ways:

 - either refcount things properly, ie when you do that lookup under your lock:

        mutex_lock(&eventfs_mutex);
        ei = READ_ONCE(ti->private);
        if (ei && ei->is_freed)
                ei = NULL;
        mutex_unlock(&eventfs_mutex);

   you just go "I now have a ref" to the ei, and you increment the
refcount like you should, and then you dcrement it at the end when
you're done.

Btw, what's with the READ_ONCE()? You have locking.

The other option is to simply re-lookup the ei when you re-get the
eventfs_mutext anyway.

Either of those cases, and the SRCU is entirely pointless. It  really
looks wrong, because you seem to take that eventfs_mutex everywhere
anyway.

             Linus

