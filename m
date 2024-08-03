Return-Path: <linux-fsdevel+bounces-24930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8EF946B80
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E5A1C21125
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 23:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37D6A8CF;
	Sat,  3 Aug 2024 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d79svJi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53C200AE
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722729126; cv=none; b=gEnztHVqh9njW5kwthHhgn0ujcDsLqMVeUfp1DWtevUYzXUA/DeDWYY/szj8ZZrlQFeeyrs2Rosgrt/XkQnfQx0txTRSyJXAKuROO7mymUUtQIZaG4ZYKR1wvVyL4ljj0gqaNaW0hBS7CDZP2OM5QZRIKLEytDkEKJ0hGYul+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722729126; c=relaxed/simple;
	bh=n8E/byJrsUqaSv+ayvPPh2aMs5QC0+Nni+Q9vV76clE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iykJvdilNlNs26fmCIYmgTxhJ0tMKajrAQsApTSmUxUFzCrZ+Q2bt5/LpQ28+xhItjVThROgeQSORCFCcj3q2lSOUv4E1atnSoWL6mJzhqRxXL2EPH6spCnucId+LtL65EGpXoggPvpYgW3bN7jtp103xTlGwkFEGx8kywk9zWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d79svJi0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so13019415a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722729122; x=1723333922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDi2UeNQKyJu7GHXgXnV6KtHs2BM4hPbqMY7M+8Wk5k=;
        b=d79svJi0DrFKoQB4NNDNcKk3d+LRoslqHgieV4xo8ARfo5y/i9euAeIi85i0IgKbex
         8QzgY/e73irTWDVHI0zRAJiX0E9oVhKcKRS1oIFDgKfPldvKK8lbq20WlwwJ38v31AC0
         iMK/s4xn9j9xY31/WhhABHG8mQ1P4vtV3luWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722729122; x=1723333922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDi2UeNQKyJu7GHXgXnV6KtHs2BM4hPbqMY7M+8Wk5k=;
        b=IuL4JThXJLxn+OiFLMQd31doZ2KE623vUdFub0SysMD70bxIFaWtaQGvsGGzJesi7W
         QhM2TIGPuCe+rWaGIvqBvG8lmLNwFz18NPNvOj2ENPFt5s1c0IZHJBeWU+i8ncHlXbuT
         ZYlbt9kvdBcf9+OlbEhGnwfo7qcxd1PRnYDU9PHRzq+JCgULtP09y3V6CxUmJIqlHCDA
         5+hxNETKbyAu1d6qaBE2g6SjZhSkXFLmvQVMCAxmS2rKg3yTq8Kkx/ZhlBP2n4I8kp/k
         91TCLY2OL5iSg342f0f3uR0v8lSp0X9XGTBE0JaE9fs8E5MHDMC1lOi8IFbJWx92dERJ
         K6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWtu7kK7kVFecMauV2uP3LlIXiVz0+ZMzcvogE2BRF69eJpWcrG//KbyMhd5q3qVnNh77HKKuQb42dwoFvupkglNa0We45914Od8GYUbA==
X-Gm-Message-State: AOJu0YxGEZFoCKZYH23cWJAYlZH/GoNcNEF6pZygYy63vB3fvbOJLLnZ
	DjiY5kcRO54vAzSbqwuPalAhkXd0TP5bUF6RgrisXiuECnsZI2ZW0j/qzRGu6WYp11Nyx1qy7nh
	UIG14Pg==
X-Google-Smtp-Source: AGHT+IFfIqoMH5ezOS1cIhA5MM4mpzRXXeTsaWdKV8pmlOvDJAR/hiGj7ar7V3Dey7MweVgHnKaQGw==
X-Received: by 2002:a17:907:6089:b0:a7d:3de1:4abd with SMTP id a640c23a62f3a-a7dc5018a3bmr603090966b.39.1722729121788;
        Sat, 03 Aug 2024 16:52:01 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437a5sm267306366b.101.2024.08.03.16.52.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 16:52:01 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so13821593a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 16:52:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBbwu7VjayoCHOI9XyjOIugncvwWj7W3+NZtXij9t6Y60fLob+74W4ovs2QFawVmJKNseavlgywuD6jPGYx5n7v2WExrGpW7aoFcCGNg==
X-Received: by 2002:a50:eb0b:0:b0:5a2:8802:8e10 with SMTP id
 4fb4d7f45d1cf-5b7f36f556amr5482311a12.8.1722729120799; Sat, 03 Aug 2024
 16:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803225054.GY5334@ZenIV>
In-Reply-To: <20240803225054.GY5334@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Aug 2024 16:51:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
Message-ID: <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
Subject: Re: [PATCH] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Aug 2024 at 15:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +               unsigned int n = open_files / BITS_PER_LONG;
> +               if (n % BITS_PER_LONG) {
> +                       unsigned long mask = BITMAP_LAST_WORD_MASK(n);
> +                       new_fdt->full_fds_bits[n / BITS_PER_LONG] &= mask;
> +               }

Ouch. I hate this.

And yes, clearly this fixes a bug, and clearly we don't maintain the
full_fds_bits[] array properly, but I still hate it.

The fact that we had this bug in the first place shows that our
full_fds_bits code is too subtle, and this makes it worse.

I really would prefer to do this in copy_fd_bitmaps() instead.

Also, your comment says

                 ... nothing of that sort happens to open_fds and
                * close_on_exec, since there the part that needs to be copied
                * will always fall on a word boundary.

but it doesn't really explain *why* those things are on a word boundary.

So I think part of the commentary should be that we always make sure
that the normal bitmaps are full words (pointing out the

       ALIGN(min(count, max_fds), BITS_PER_LONG)

in sane_fdtable_size), and then explaining that the reason the
'full_fds_bits' bitmap is special is that it is not a bitmap of file
descriptors, it's a bitmap of 'words of file descriptor bitmaps'.

So yes, the full_fds_bits bitmap is very special indeed, and yes, we
got this all wrong, but I feel like the bug is in copy_fd_bitmaps(),
and the fixup should be there too...

In fact, I think the full_fds_bits copy in copy_fd_bitmaps() should
just be entirely rewritten. Even the initial copy shouldn't be done
with some byte-wise memcpy/memset, since those are all 'unsigned long'
arrays, and the size is aligned. So it should be done on words, but
whatever.

And the full_fds_bits case should use our actual bitmap functions.

So instead of

        cpy = BITBIT_SIZE(count);
        set = BITBIT_SIZE(nfdt->max_fds) - cpy;
        memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
        memset((char *)nfdt->full_fds_bits + cpy, 0, set);

I think the code could (and should) do just

        cpy = count / BITS_PER_LONG;
        max = nfdt->max_fds / BITS_PER_LONG;

        bitmap_copy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
        bitmap_clear(nfdt->full_fds_bits, count, max - cpy);

or something like that.

Doesn't that seem more straightforward?

Of course, it's also entirely possible that I have just confused
myself, and the above is buggy garbage. I tried to think this through,
but I really tried to think more along the lines of "how can we make
this legible so that the code is actually understandable". Because I
think your patch almost certainly fixes the bug, but it sure isn't
easy to understand.

           Linus

