Return-Path: <linux-fsdevel+bounces-66603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A7C26020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25D8534871D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2A3002C1;
	Fri, 31 Oct 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WaAq1KKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3352ED17B
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926694; cv=none; b=rQAEiRxy+pG+OYfQnIszE1p/s/+y9eLPd0nyFkHly+czDtsr0iw0Psw9ZAGna9H7F/CT22L7gdBCQrOpLSV41+y08iXNNX556YjOoMup838Ot3xI5hll3wbJsIlUlWj/tGZtnBe1wJ110zd3mj7xSTK2LtUvYkrKp/EdO2zfLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926694; c=relaxed/simple;
	bh=tB2xm0tHoFpBrehX5ultMyNxbTezXcjRnBrfqVxMnrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1uH1qaaWx5p77bDDfaw5LjyOT5ugXALH29PVFCq6P67EXsK6nX//C1T/suSX3eIIgZNO1gg/E0MIL3auS82LOGyrub+SX9sUCbhdWcwfmmwPEUFkaptLK6fJI+2AvOqk9Wfga2IbrGeRkU8kT0U+vPQ+YwxbrRqYjwEKsJdIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WaAq1KKY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so491656266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761926690; x=1762531490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60wW3RdT/GxZgMsGz0dv4U+v3VStlN+NgjbyhA221jo=;
        b=WaAq1KKYS+dDnhPh/U/7KvILvcBrD3JNnr6zCrXJZGzqvpiZx4qAYLV57167fNt0Ir
         RPrKymyQr+H2I6z+e4C8NJK43gNlIjSb1cjgX9eRCVoQmLxkcUli+pEmdwPl/jvNL+N8
         OiGdJ3l4LPOnqWqi/ej0k+PVsrwhRgVMrXFlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926690; x=1762531490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60wW3RdT/GxZgMsGz0dv4U+v3VStlN+NgjbyhA221jo=;
        b=E2yRUr/oYgu3SeH05GzRXKfWIlKwTjPP77aebB+jex4XMBCF54YnbxweEkDOf08tQq
         3PfR4EU7qF9CakkV5KRlCp+cwfe59Dy1+9dc3upoEVJpGwV+UZur/jaYxOpQeE9Nlfoj
         ETUjDkh/tLaJCOg1Hmn0IgDixjePX1cK2dcG4VLVLwVGloo3WG8nmRcF4kjZIk4fvuhR
         zYlXsMXKtoLW94mJyCgXhFtUR3e1WryHUBT44rwU4nQocOMtqpZTCOn+SLGCRkNKSKug
         /F4LHa3/T56xUX2FZYx/Z2QDu23p6AjD57HH+jRa1CGvHKNj/0vMRD3z0V434/UDzKfR
         FFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkqj9DsWRV5MbHNZN66a+/ijXAdl9wv+yPCRE7l3vFIAxSeFZqRLo4TLM+one+cY1fgPuEFmAS4mHbBLKH@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHp3HpsyovpdjLQi0LET9FBHJ8vrXiSX5jg9/W4v6DZ9EvEt+
	sgcSAMsj8/WnBC2qVG0LRUo6fSFc+BWrpT3Pz+Xjy8dlcZi7pwbYOueWSJejbftgw6YQDxEoLtb
	L2Oceggs=
X-Gm-Gg: ASbGncuzk+/vew6VvzryFDBrT1DQeQ1pj81mMv+3S0YmbHgvudSzI/2cickD2H9WGil
	s1wDwtbyXrWQRKrEjb9hbI9npUE8NOMqP+NZaUqHIlF3OsbngEeBB3nJIDdQvIjzRVEsJNcjxRt
	3xaLm7bs7nciF10W0ZMCx4mQjrzPu1+boh0Ddtuo2upKk9949vYdZGzfIqkI9r66BCGzh362rfz
	3RARIS3RT9kHI+4G0XPw+kPYHaxiMYLFkHs2mGoJR3En7qgu2Sf8y7x4A7gptNuem2+xFsY9cfu
	xwCA+ENuBYw+YzhPrEzI7c99XASOlatjZ/2vr7UNvyWB5kdL5NkV9MU1M7zEnIbBU39lqqW3xt6
	Znhx/qH7NrFFTorGNQVD3EWP4BsioijnyL3vJgcuiDu+mjnXSZQed8ES97GY+To/3k8408x8d4f
	tZungObRR/LO/2PRCZXkPcV73z2xwfFhq0rc05FFRO24EZHYqh3m5OzB92Ntc/
X-Google-Smtp-Source: AGHT+IHV/kkexu1qkwxvquIdWQEdw9PiA5EQBjUB7+pwfogP17PX6rgL2qyFNT8tnHuSPQndnUr0Eg==
X-Received: by 2002:a17:907:980f:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b70701bb7c0mr375780266b.24.1761926689835;
        Fri, 31 Oct 2025 09:04:49 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c3add2sm203513066b.37.2025.10.31.09.04.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:04:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so4679828a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 09:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/lcm6XjPs2+SxyBJJVtPlsXBMx7bjd5eS9BCJ0knFI834pmpruONDzRfR2xlsbxx7He1o9sScUaimrp6d@vger.kernel.org
X-Received: by 2002:a05:6402:1e94:b0:634:ad98:669e with SMTP id
 4fb4d7f45d1cf-64076f67832mr3110351a12.3.1761926688856; Fri, 31 Oct 2025
 09:04:48 -0700 (PDT)
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
In-Reply-To: <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 09:04:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
X-Gm-Features: AWmQ_bnRDX2Gol1yij6lUw-TnphkeV13i2oTAsPwXYUAWwp3tGTy0FOLWSc_Muc
Message-ID: <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 08:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I slept on it and I think the pragmatic way forward is to split up
> runtime-const.h instead.

I don't think that would be wrong, but I do think the real bug was to
include runtime-const.h in any headers at all.

It should only be included by C code that is always built-in.

And it's all my fault and due to incompetence: this was introduced by
me in commit 86e6b1547b3d ("x86: fix user address masking
non-canonical speculation issue").

The original runtime const design was for core code optimization only,
and I just didn't think about the module case when I did that thing.

Sadly, this goes beyond just the trivial "access_ok()" - which can
trivially be fixed by just making it out-of-line. It ends up impacting
user address masking too.

It so happens that all our can_do_masked_user_access() optimizations
are in core code, so it's not an *actual* bug, just a potential one,
but it's one that Thomas' patches to do the nice scoped user accesses
will likely make much more common, just because his interface is so
much more convenient.

End result: I think your patch to just use

  #ifdef MODULE

in the header was the right one. Except instead of that

+#ifdef MODULE
+#define __USER_PTR_MAX USER_PTR_MAX
+#else

thing, I think the right thing to do is to just do

  #ifdef MODULE
   #include <asm-generic/runtime-const.h>
   #undef runtime_const_init
 #else
   #include <asm/runtime-const.h>
  #endif

in the x86 uaccess_64.h header file.

Let me think about this a bit more, but I feel really bad about having
missed this bug. I'm relieved to say that it looks largely harmless in
practice, but it really is me having royally messed up.

                  Linus

