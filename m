Return-Path: <linux-fsdevel+bounces-31083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E0991AE7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADF2B20CFB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCF165F16;
	Sat,  5 Oct 2024 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YA/B0rGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3225763
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164567; cv=none; b=DTSGvv48U8hQE6EYPDTQbVmejbqsHbgXioQvA0HcVMCdFZxlNb0rdIKw9p4uXPx8kWS2WNdxOGT8Gkk3++Fx0qRALtrxvW7ci00bfraPe/Fnsr8dBzBpS1Bb/drm5a6TfKDoz998TDOErmr/IIhtFgkU0j+fLJq5wmbDu9h54IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164567; c=relaxed/simple;
	bh=UTRfvvOCXrfGy4iPK4XUz20bhTvwSv6Q9UxqaTN90Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4R/2g7GfhKA3keOWvH8PrQT7JvE6QrNXOVUj9YErma56vhh0Tc8DDlTx14fba2HZ7My8G/GGFotJZbc3Hfl/L6bKuQBRySQqVLN8SLLwIFefwBK15FXP9vwfwfVz7gdldyvDuFJCgL5/8b18uTS98WTQXZKB7Wyzx4aOHspfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YA/B0rGQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86e9db75b9so474921266b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728164563; x=1728769363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6dVwYXsRDS3cmSy5asXBf4etlRziD1Cv1wp8lJPJ+M=;
        b=YA/B0rGQuQ40WI9/ny5O2GuTS9wdWVHP0Y7KSpxe3dKcxyK9DGnINIWgUwsIXl54xh
         /Kc5ZLB2IU9CrQXJutZ3fvZURxjjYS6nmpqoyRbmE7FqCVipCeluvbGY4KHH4AqDcs3v
         tbV6t3JE/G0VHVYYey3kyJrl4O+nsdtohhQ9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728164563; x=1728769363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6dVwYXsRDS3cmSy5asXBf4etlRziD1Cv1wp8lJPJ+M=;
        b=XVuLVczCH4QnVT8iNYpxPl+LS0Iouvg9MDUDdCbwgfThPZ4dT7YC/ZzwPWevpvop6t
         7wBgjakIxBoyWLNG0sq6w6WE3NUJlIOHTThOMv4keAHxvUjIJfH/jU0i4gUjaa1tc9Ho
         plUicS1KOEzYxHi9lbJBOTCRCNG60iaYmuNSBzh/ujUIw5ge6Zn8JsSLARTfql0oqq/H
         MYO1HRUG7+i5Hbmln+/qq9xBJL2A2/vCOS0qLv2qTRWBsFPEuP39C6xKOy4eklEgUbYE
         gJDjCbFxM942v7BGs9hbqP1IxDSGXMQUMPW1ivEFSTEeI7FQ6Un+EUUitKbobmhZ8act
         aC8A==
X-Gm-Message-State: AOJu0YwACWB3eDewcOSS99zG88U6YCx2tGSA/l+/nUw3SzFaj1i4vNih
	WRPH6gAVGitRQeXMNqYZ65IqBv9WK260Oy0q28EF5d8aJANfnHJtNO40Fqcb2l97UG9gmi3OwB2
	YFlYIbw==
X-Google-Smtp-Source: AGHT+IH82XBhD+z9v7eR34Y4JIrr1ljl/aQ/ZLi3NsUpfSTs8Vpuafny8LYoElkAZZ7F2cLiSBsYzg==
X-Received: by 2002:a17:907:2da6:b0:a99:4d50:6ae1 with SMTP id a640c23a62f3a-a994d506c64mr6368666b.20.1728164562866;
        Sat, 05 Oct 2024 14:42:42 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9940a0b4e5sm96456766b.30.2024.10.05.14.42.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 14:42:42 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c87853df28so4341604a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 14:42:42 -0700 (PDT)
X-Received: by 2002:a17:907:3e8e:b0:a86:9644:2a60 with SMTP id
 a640c23a62f3a-a991bce5b80mr729133166b.6.1728164561788; Sat, 05 Oct 2024
 14:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
In-Reply-To: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 14:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
Message-ID: <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 12:17, Christian Brauner <brauner@kernel.org> wrote:
>
> Note that atomic_inc_not_zero() contained a full memory barrier that we
> relied upon. But we only need an acquire barrier and so I replaced the
> second load from the file table with a smp_load_acquire(). I'm not
> completely sure this is correct or if we could get away with something
> else. Linus, maybe you have input here?

I don't think this is valid.

You go from  this:

        file = rcu_dereference_raw(*f);
        if (!file)
                return NULL;
        if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
                return ERR_PTR(-EAGAIN);
        file_reloaded = rcu_dereference_raw(*f);

to this:

        file = rcu_dereference_raw(*f);
        if (!file)
                return NULL;
        if (unlikely(!rcuref_long_get(&file->f_count)))
                return ERR_PTR(-EAGAIN);
        file_reloaded = smp_load_acquire(f);

and the thing is, that rcuref_long_get() had better be a *full* memory barrier.

The smp_load_acquire() does absolutely nothing: it means that the load
will be done before *subsequent* memory operations. But it is not a
barrier to preceding memory operations.

So if rcuref_long_get() isn't ordered (and you made it relaxed, the
same way the existing rcuref_get() is), the CPU can basically move
that down past the smp_load_acquire(), so the code actually
effectively turns into this:

        file = rcu_dereference_raw(*f);
        if (!file)
                return NULL;
        file_reloaded = smp_load_acquire(f);
        if (unlikely(!rcuref_long_get(&file->f_count)))
                return ERR_PTR(-EAGAIN);

and now the "file_reloaded" thing is completely pointless.

Of course, you will never *see* this on x86, because all atomics are
always full memory barriers on x86, so when you test this all on that
noce 256-thread CPU, it all works fine. Because on x86, the "relaxed"
memory ordering isn't.

So no. You can't use atomic_long_add_negative_relaxed() in the file
handling, because it really does require a proper memory barrier.

Now, I do think that replacing the cmpxchg loop with
atomic_long_add_negative() is a good idea.

But you can't do it this way, and you can't use the RCUREF logic and
just extend it to the file ref.

I would suggest you take that whole "rcuref_long_get()" code and *not*
try to make it look like the rcuref code, but instead make it
explicitly just about the file counting. Because the file counting
really does have these special rules.

Also, honestly, the only reason the file counting is using a "long" is
because the code does *NOT* do overflow checking. But once you start
looking at the sign and do conditional increments, you can actually
just make the whole refcount be a "int" instead, and make "struct
file" potentially smaller.

And yes, that requires that people who get a file() will fail when the
file count goes negative, but that's *good*.

That's in fact exactly what we do for the page ref count, for the
exact same reason, btw.

IOW, I think you should make "f_count" be a regular "atomic_t", and
you should make the above sequence actually just more along the lines
of

        file = rcu_dereference_raw(*f);
        if (!file)
                return NULL;
        ret = atomic_inc_return(&file->f_count);
        file_reloaded = smp_load_acquire(f);

and now you've got the right memory ordering, but you also have the
newly incremented return value and the file reloaded value, so now you
can continue on with something like this:

        // Check that we didn't increment the refcount
        // out of bounds or from zero..
        if (ret > 1) {
                struct file *file_reloaded_cmp = file_reloaded;
                OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
                if (file == file_reloaded_cmp)
                        return file_reloaded;
        }

        // Uhhuh, we got some other file or the file count had
        // overflowed. Decrement the refcount again
        fput(file);
        return ERR_PTR(-EAGAIN);

and I think that might work, although the zero count case worries me
(ie 'fput twice').

Currently we avoid the fput twice because we use that
"inc_not_zero()". So that needs some thinking about.

               Linus

