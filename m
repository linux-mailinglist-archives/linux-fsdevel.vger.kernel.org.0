Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05572D8A3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 23:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404433AbgLLWEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 17:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLWEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 17:04:02 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDDC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 14:03:21 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so20630599lfd.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeG0vpkEpwIGExM1yFSc2MXz+JopCSrqCsvOCLxjH2Q=;
        b=Qzs6h5Q+S2vKFNlhF1Mdjb5siMw8rj75vkKyXKctM23YozQc5U9RX0fXdhyNlf5MgV
         l0uqdvJyND6fZjK3spkPbN8vGx5LypcrskQUCRE21iCl0uOYyz+4NOKByazMpUzKlHS0
         fSXlTh2CgSm+O9KSh7kOZibzt1RDpAyCDPZL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeG0vpkEpwIGExM1yFSc2MXz+JopCSrqCsvOCLxjH2Q=;
        b=jr/FPXcbVp34/q2636KisIS5+d6LLi20eRWmBXvYAy2wVS9ente2GcQOPoWnsIYHFl
         WKYncDMjmjICty6HLG/x9wxweU+OzujpMz1sru7RvrIPbVJKVyJWKLw5nNrmwYMCe704
         TklUhlTqYpQhoeZSlUaOevEbw5KfXXSsUg15S6RG+H8XtUltK2SkkUgSxAXTjTF3hwv1
         i37hydHWQMkOwsMUPnT8d7cKzuD19HNpNnMUQykBNFdlwg/H+KnIK9UZ6HMLW46Xra2v
         uyUqlFdA63aQ8D2noD1HJeIjb5ySETunXfpzQm+reNlOcHJo7QZHbLM0S0mwfnafMnkg
         8EfA==
X-Gm-Message-State: AOAM532qd/50u22G+wy34lU9XB985ZaRMNJfVZ6Di6hQRloMfkD7c6M9
        0jLidpSzuBEoaxu85GgMGL7sZ3PS34mD0A==
X-Google-Smtp-Source: ABdhPJxeF7fFUZ+ZRqhEaTaETsU5APzApmls9TWKBQIno8bg293zWNlonuu8ItX91MfkHdX3UYFrNw==
X-Received: by 2002:a2e:8159:: with SMTP id t25mr1507862ljg.379.1607810600035;
        Sat, 12 Dec 2020 14:03:20 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u21sm1721462ljd.81.2020.12.12.14.03.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 14:03:19 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id y19so20586868lfa.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 14:03:18 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr7012393lfb.421.1607810598521;
 Sat, 12 Dec 2020 14:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20201212165105.902688-1-axboe@kernel.dk> <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com> <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
In-Reply-To: <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Dec 2020 14:03:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3Vzk3r+7Ydh0mzNCo3-gM1ubGYy_naAFmj1+z-_3_Wg@mail.gmail.com>
Message-ID: <CAHk-=wg3Vzk3r+7Ydh0mzNCo3-gM1ubGYy_naAFmj1+z-_3_Wg@mail.gmail.com>
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file open
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 12, 2020 at 1:25 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Do we ever do long term IO _while_ holding the direcoty inode lock? If
> we don't, then we can probably just ignore that side alltogether.

The inode lock is all kinds of messy. Part of it is that we have these
helper functions for taking it ("inode_lock_shared()" and friends).
Part of it is that some codepaths do *not* use those helpers and use
"inode->i_rwsem" directly. And part of it is that our comments
sometimes talk about the old name ("i_mutex").

The inode lock *can* be a problem. The historical problem point is
actually readdir(), which takes the lock for reading, but does so over
not just IO but also the user space accesses.

That used to be a huge problem when it was a mutex, not an rwlock. But
I think it can still be a problem for (a) filesystems that haven't
been converted to 'iterate_shared' or (b) if a slow readdir has the
lock, and a O_CREAT comes in, then new readers will block too.

Honestly, the inode lock is nasty and broken. It's made worse by the
fact that it really doesn't have great semantics: filesystems use it
randomly for internal "lock this inode" too.

A lot of inode lock users don't actually do any IO at all. The
messiness of that lock comes literally from the fact that it was this
random per-inode lock that just grew a lot of random uses. Many of
them aren't particularly relevant for directories, though.

It's one of my least favorite locks in the kernel, but practically
speaking it seldom causes problems.

But if you haven't figured out the pattern by now, let's just say that
"it's completely random".

It would be interesting to see if it causes actual problems. Because
maybe that could push us towards fixing some of them.

               Linus
