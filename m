Return-Path: <linux-fsdevel+bounces-31241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D19935B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB73F1F23D80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302E1DDA3B;
	Mon,  7 Oct 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KI+BLI8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E101D95AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324496; cv=none; b=TIuWsBrS2gkK9Vk+8XhOJttY3IwOUorS7MkXQnHUriGuAv/tySmmMFR98qa3K6tmoOA3iBhFUlTYi3D+uxNlPIGZF0UstCu73SUX5ylJ4A5NdFK5z7MBJ26fLissAlU4S6r2KhykjP3gSEYBqSYX+u3ZVBGEXaDyW78FkjzPVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324496; c=relaxed/simple;
	bh=yfuUJjzjgalQzTMqdCzIse8irGjkzyRxVlxfLjsXBas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px2Ai42DqliJSBNOUFSa4OcnVnVZ3yDDeEYTrnjvL0lFrEb500pbGHH6ZMaOjITSNb9EJejUtRe+0SAyU9OItM03rzHVX8g7M83wSnkE+/FdvbvRjWnT7/j/7mxXJienkvaGHCpVUVlZ+VVzUYTsm5heR7Jq9RHpfJSkxDk4Zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KI+BLI8d; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fad6de2590so70492951fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728324492; x=1728929292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+956eW6o5PbCXVEPgO/oU65LPaKXM/bDi8iWSsbQKhY=;
        b=KI+BLI8dlnlsFcYNQkOhd5tgRJrsXbmp0wQjXsig2GYgA7Q2XvGpyixWDqmCMy6kHK
         EJLAgyF5Sw5i90tBRy6n6AZXm9g+C8qCfmvmyq8t/qLaiQ5MUn6z94ztgU+Ize7sYMWj
         5LAZ5jjg1lLSN9FjuE0MFOgIVr2SwRViXz308=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728324492; x=1728929292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+956eW6o5PbCXVEPgO/oU65LPaKXM/bDi8iWSsbQKhY=;
        b=Ev/JHiwP91levXUle/PpxyOscdwZOHfr4cse+r9GSRtPV1Prrni+A0CwzcwodWb/sT
         gAI60nBaUoROMDLPHcy1UbelQog5rz3SUNF95pY7rInv8NwN3EwH7+rcbM1z5ZF4zvdg
         MZM1uJwnTT2l/85ZZK1T+rWv6ydnnbXxIDblEnfRA5VqfXvp8mdndmVsh8w8Gtw1O999
         9ytgyLHIcOUXQfQfFLgDi+xTbbDMLa7C6LjG+TNqjUJIRGxT/0fVFi5VlPBh2YfiwaTD
         YUcCuKVomrYRuq2Si8+ee+JZ5pNW/LqnfC7kNncXkdOT/InaUX0hK0S5QTofgcd901GG
         6u4g==
X-Gm-Message-State: AOJu0YyRgY4oZElp0TaHE9x3s8YhUVmPcs+o/sEF3Pa6s0WUQEH5avdu
	tXEdiMNr/pCSkJcSxBbGSlhpwBaHYFROBzrgGB62dA1nu/DkOSNfB9T9UyU8vx9QKYTVTm8qyMH
	ma1A=
X-Google-Smtp-Source: AGHT+IG5DK3ztoFDFdiCZ7bvOtN9IzBdtDRMS/IF6RFjuI+phDqa1ipUft8LJgA5W+O2XgkH0q2ZTQ==
X-Received: by 2002:a05:651c:2126:b0:2fa:d84a:bda5 with SMTP id 38308e7fff4ca-2faf3c0c416mr78161021fa.7.1728324492060;
        Mon, 07 Oct 2024 11:08:12 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9acbcd6sm9107721fa.53.2024.10.07.11.08.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:08:10 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so60965871fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:08:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3b98:b0:539:9ee4:baab with SMTP id
 2adb3069b0e04-539ab87dcbfmr8147422e87.30.1728324489216; Mon, 07 Oct 2024
 11:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org> <20241007-brauner-file-rcuref-v2-2-387e24dc9163@kernel.org>
In-Reply-To: <20241007-brauner-file-rcuref-v2-2-387e24dc9163@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 11:07:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3Nt6Fyu_YYuNoa+Xi4h__MxAjJs5M3YTHvTshehegzg@mail.gmail.com>
Message-ID: <CAHk-=wj3Nt6Fyu_YYuNoa+Xi4h__MxAjJs5M3YTHvTshehegzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: add file_ref
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 07:24, Christian Brauner <brauner@kernel.org> wrote:
>
> +static __always_inline __must_check bool file_ref_get(file_ref_t *ref)
> +{
> +       /*
> +        * Unconditionally increase the reference count with full
> +        * ordering. The saturation and dead zones provide enough
> +        * tolerance for this.
> +        */
> +       if (likely(!atomic_long_add_negative(1, &ref->refcnt)))
> +               return true;
> +
> +       /* Handle the cases inside the saturation and dead zones */
> +       return __file_ref_get(ref);
> +}

Ack. This looks like it does the right thing.

That said, I wonder if we could clarify this code sequence by using

        long old = atomic_long_fetch_inc(&ref->refcnt);
        if (old > 0)
                return true;
        return __file_ref_get(ref, old);

instead, which would obviate all the games with using the magic
offset? IOW, it could use 0 as "free" instead of the special
off-by-one "-1 is free".

The reason we have that special "add_negative()" thing is that this
*used* to be much better on x86, because "xadd" was only added in the
i486, and used to be a few cycles slower than "lock ; add".

We got rid of i386 support some time ago, and the lack of xadd was
_one_ of the reasons for it (the supervisor mode WP bit handling issue
was the big one).

And yes, "add_negative()" still generates simpler code, in that it
just returns the sign flag, but I do feel it makes that code harder to
follow.  And I say that despite being very aware of the whole
background to it all and somewhat used to this pattern.

Then file_ref_put() would do

        old = atomic_long_fetch_dec(&ref->refcnt);
        if (old > 1)
                released = false;
        else
                released = __file_ref_put(ref, old);

(inside the preempt disable, of course), and again I feel like this
would be more legible.

And file_ref_read() would just become

        unsigned long val = atomic_long_read(&ref->refcnt);
        return val >= FILE_REF_RELEASED ? 0 : val;

without that odd "+1" to fix the off-by-one, and for the same reason
file_ref_init() would just become

        atomic_long_set(&ref->refcnt, cnt);

with no off-by-one games.

I dunno. This is very much not a big deal, but I did react to the code
being a bit hard to read, and I think it could be friendlier to
humans..

                  Linus

