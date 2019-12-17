Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9C112373E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLQU0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 15:26:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45852 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLQU0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:26:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so3300818ljc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1T7+oLmgUY62ytPiNODIrz1cZeW8gAZnOGieJ8ZkwA=;
        b=B25Yd0xdGvGJ4bCIEr4Bgw/88tBjEJ0OPfoVc5YLKvIjM26jyP64rHYwIIEVDLTF0T
         74GwFgIu0A96nSZ33TTCFUmysZjkwE8bDL13x64JVHMOo8K7cEIepUclqLbfA2V4o+Gz
         t+TIx/86gc/llbykG0MWlhLehR8Su42SrUwv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1T7+oLmgUY62ytPiNODIrz1cZeW8gAZnOGieJ8ZkwA=;
        b=ai+6r1kw+VL2ykF7W2oW855dJSA6n47Xmfon6ECEEfqWShc+MDJy2E10BG3WCkJRUA
         O0elAVff9DuNV46/Jo7TzFjXNW0SPkU0t0oEEBT5jqwqO6nsZtqkW2JfwrPSzEPZod73
         YDTnilvGl8R3+Kow0xFvEvwtBfXInuBNU3uNa20riWCaDy0bmpcv8wRSFR5xp8JesIAx
         /Mi7r5850CGeZ0H4dj9QwpqY9m/zUD2JVPvlCUiVOG2C9ZBHkkLQIB5a5q9ruQCBFug3
         Um4+f2pFCuL+LYF76xJxeifSXU6C+DtWXQ7VkOU6yS/Su7i92qAPVcDWtXXZD69JoIZS
         75pQ==
X-Gm-Message-State: APjAAAVZn7WGOJunuIwn6HXRbK+EsJ8HKvrbF7BJ/vtIDKVscib0XzHR
        YmELiaemKZd9GglnL1K0nEcMvVaDrXI=
X-Google-Smtp-Source: APXvYqypHnwFUjKBIYP3yElK3ublHRrDVyaZCK2vlpSVlKVNGyen1n/px+52bQYPY9SiYfEMvt7Q0g==
X-Received: by 2002:a05:651c:1a2:: with SMTP id c2mr4599796ljn.121.1576614403798;
        Tue, 17 Dec 2019 12:26:43 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id c189sm11314855lfg.75.2019.12.17.12.26.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:26:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u1so1559951ljk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 12:26:42 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr4707040ljg.82.1576614402189;
 Tue, 17 Dec 2019 12:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20191217143948.26380-1-axboe@kernel.dk> <20191217143948.26380-5-axboe@kernel.dk>
 <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 12:26:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
Message-ID: <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
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

On Tue, Dec 17, 2019 at 11:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> 'loff_t length' is not right.

Looking around, it does seem to get used that way. Too much, though.

> > +       loff_t pos = data->pos;
> > +       loff_t length = pos + data->len;
>
> And WTH is that? "pos + data->len" is not "length", that's end. And this:
>
> >         loff_t end = pos + length, done = 0;
>
> What? Now 'end' is 'pos+length', which is 'pos+pos+data->len'.

But this is unrelated to the crazy types. That just can't bve right.

> Is there some reason for this horrible case of "let's allow 64-bit sizes?"
>
> Because even if there is, it shouldn't be "loff_t". That's an
> _offset_. Not a length.

We do seem to have a lot of these across filesystems. And a lot of
confusion. Most of the IO reoutines clearly take or return a size_t
(returning ssize_t) as the IO size. And then you have the
zeroing/truncation stuff that tends to take loff_t. Which still smells
wrong, and s64 would look like a better case, but whatever.

The "iomap_zero_range() for truncate" case really does seem to need a
64-bit value, because people do the difference of two loff_t's for it.
In fact, it almost looks like that function should take a "start ,
end" pair, which would make loff_t be the _right_ thing.

Because "length" really is just (a positive) size_t normally.

                Linus
