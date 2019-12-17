Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1F11235DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfLQTkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:40:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43458 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLQTkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:40:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so12279283ljm.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFRWpBT/yna7msZCz1h2wfxEJHa/dpTRSDTuMPZJuko=;
        b=aMhd1gYr/CaA40gJd+Y5v2iKz3PpftHLH7meUakQxXR667vcpSEeG+f7RRgZ9EScB8
         QPC5XzSuBsPm691KBjptv6ye07x5hIgbc7KafGV8ZlGArW6KOkIPnZeOx0iU0AevTOka
         8z9zZfU3hjnoqjS219RuVLiUlb7YJo5q+60u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFRWpBT/yna7msZCz1h2wfxEJHa/dpTRSDTuMPZJuko=;
        b=XSH9XaE5gzifYjmexeTvyw1MUm7UGz0dzOVcXiSG2HpUMEzEvI3WdzBn7wvVw3rR0u
         KEkM2uxsxn88AUzzpDsKtslHeR90jlvGDgo+pYxUKaZpWCmPS2k2YaYVscp+jYAqvQvM
         CXNkLpEkdt2BTuvc0s8HkW/+4fZiSFKX1K9cpUk9UES9rT1L/xHUkOrNJxYGeFfyo9eI
         oFp/KL1/+DyyxihydZz/P8GQGjmojtv8tmg+NG0K/NpWtxECzZit6kS1Vcr+Zpxs1RlP
         WEAiQW9gP/8jX18aqAV8EsGaC99+DRyynBUJLwyWCbhRjcT1Gc63UcanhuLIrU3fbARm
         cR3A==
X-Gm-Message-State: APjAAAVlEbymun9tjaemsFKew9iqARCcuRDVetcCCz+tmacB9AqiGknq
        Hu3Xg2+5+5OvlefiNKFyC2aYoDT+BXc=
X-Google-Smtp-Source: APXvYqwlDNJ/hqyz4r56O/Y/KpMNBqgyPB+W+j7LQ0ucLiYuJvn0AespLmbI5EpaC0IKXH9vSaVUIg==
X-Received: by 2002:a2e:7f08:: with SMTP id a8mr4329705ljd.164.1576611598120;
        Tue, 17 Dec 2019 11:39:58 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s13sm392385lje.35.2019.12.17.11.39.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:39:57 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id m6so12311784ljc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:39:57 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4517160ljj.148.1576611596942;
 Tue, 17 Dec 2019 11:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20191217143948.26380-1-axboe@kernel.dk> <20191217143948.26380-5-axboe@kernel.dk>
In-Reply-To: <20191217143948.26380-5-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 11:39:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
Message-ID: <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] iomap: add struct iomap_ctx
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> We pass a lot of arguments to iomap_apply(), and subsequently to the
> actors that it calls. In preparation for adding one more argument,
> switch them to using a struct iomap_ctx instead. The actor gets a const
> version of that, they are not supposed to change anything in it.

Looks generally like what I expected, but when looking at the patch I
notice that the type of 'len' is crazy and wrong.

It was wrong before too, though:

> -dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,

'loff_t length' is not right.

> +       loff_t pos = data->pos;
> +       loff_t length = pos + data->len;

And WTH is that? "pos + data->len" is not "length", that's end. And this:

>         loff_t end = pos + length, done = 0;

What? Now 'end' is 'pos+length', which is 'pos+pos+data->len'.

WHAA?

> @@ -1197,22 +1200,26 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  {
> +       loff_t ret = 0, done = 0;

More insanity. "ret" shouldn't be loff_t.

dax_iomap_rw() returns a ssize_t.

> +       loff_t count = data->len;

More of this crazy things.

>  iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,

This was wrong before.

> +struct iomap_ctx {
> +       struct inode    *inode;
> +       loff_t          pos;
> +       loff_t          len;
> +       void            *priv;
> +       unsigned        flags;
> +};

Please make 'len' be 'size_t' or something.

If you're on a 32-bit architecture, you shouldn't be writing more than
4GB in a go anyway.

Is there some reason for this horrible case of "let's allow 64-bit sizes?"

Because even if there is, it shouldn't be "loff_t". That's an
_offset_. Not a length.

            Linus
