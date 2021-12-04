Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EFC468314
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 08:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbhLDHSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 02:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbhLDHSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 02:18:53 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45633C061751;
        Fri,  3 Dec 2021 23:15:28 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id j7so4914664ilk.13;
        Fri, 03 Dec 2021 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgN8KONcWqA2MiLnfJyKEX1oVvHO1FTO0YDM0hD6rZc=;
        b=kXQGzSLy7ptc4YKhBNGRjckI3dO2jdz0cVJve+WAM27ZV1r/teqBUaTcM6UnOunP3Q
         MR0HosCn55mZ5TSpwbRNN9W8YdzpVrxbb0k+OSQy/BZ5RgAZdAUdQSYrgDE8sDrXnSAP
         APeulamQ/TPXkuZS4mNcFGMB7UKKYzWvFugKf5YdWgTtz5S5tlLQwnx04Uwc5lsdtY8K
         Y70D5IMG+g6qLhqNXkR09/t6RXILIoWacvwfNQrrNPFiuHooE244Q2GZsCxcmMjAUQCe
         AKT1yg0PxwEW+r0AQJ65EkqVS+O4byyIxK3ZMBu2qoSywQJQ8CCi9NJzn/qjY8tNaIq1
         Zgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgN8KONcWqA2MiLnfJyKEX1oVvHO1FTO0YDM0hD6rZc=;
        b=OfK2ACBgu9LwXEy/hwtHGB0X0Q2Mxma7V78icK4hytGGtSxozax/d+EVN0R7CCQeJy
         YxAWBG2b04zUG63f+e9RioOqPKQFmFqTlaLMgtjnt/EhlqKIpRU7w34AocO1CQG8LMk0
         t2U3afXwAIwHhBHOBQ+dnggvfEW1KI89RKJS2kXnupKwG9SkReSIb2eexJ3Ma5BRwAEG
         A6hHcgTE1HEBpWwP0uWxowUJ4D6amB05eqAP5bBVegY1BB5uy/Qglpr1SHjlP0nFkF5P
         6bHy88E5VaDbp8tisoZx9jJxD8/JSRBmuCrM5smrE1uHS+eZEx7rAlyFHFaLQRZMOoU1
         9CLA==
X-Gm-Message-State: AOAM5303NVH/s4NfwlNgGBIIUBwg/5ETRMM7TWqM5fDWASxRYU4ceKso
        OLw23gy0Js4sGTbnubq276tqTo+1zik/l6U1CZnFUUil/Rg=
X-Google-Smtp-Source: ABdhPJy+0uI+qRZXt3rb1nG3a6JvQp0F3szkqt1ot5Kv/FTwsNFUfa405gPKLUT1aoSTlsWh+JiDbxvrX0LkqfNymcU=
X-Received: by 2002:a05:6e02:1ba8:: with SMTP id n8mr24043483ili.254.1638602127280;
 Fri, 03 Dec 2021 23:15:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMBWrQnfGuMjF6pQfoj9U5abKBQpaYtSH11QFo4+jZrL32XUEg@mail.gmail.com>
In-Reply-To: <CAMBWrQnfGuMjF6pQfoj9U5abKBQpaYtSH11QFo4+jZrL32XUEg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 4 Dec 2021 09:15:16 +0200
Message-ID: <CAOQ4uxipkWdJaBTYem_VVyZpxkgf5yfrY5xru8Agfe+BS7S0eQ@mail.gmail.com>
Subject: Re: overlay2: backporting a copy_file_range bug fix in Linux 5.6 to 5.10?
To:     Stan Hu <stanhu@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 8:20 PM Stan Hu <stanhu@gmail.com> wrote:
>
> A number of users have reported that under certain conditions using
> Docker and overlay2, copy_file_range() can unexpectedly create a
> 0-byte file: In https://github.com/docker/for-linux/issues/1015.
>
> We started seeing mysterious failures in our CI tests as a result of
> files not properly being copied.
>
> https://github.com/docker/for-linux/issues/1015#issuecomment-841915668
> has a sample reproduction test.
>
> I analyzed the diff between 5.10 and 5.11 and found that if I applied
> the following kernel patch, the reproduction test passes:
>
> https://lore.kernel.org/linux-fsdevel/20201207163255.564116-6-mszeredi@redhat.com/#t
>
> This landed in this merge commit and this commit:
>
> 1. https://github.com/torvalds/linux/commit/92dbc9dedccb9759c7f9f2f0ae6242396376988f
> 2. https://github.com/torvalds/linux/commit/82a763e61e2b601309d696d4fa514c77d64ee1be
>
> Could this patch be backported for kernels 5.6 to 5.10?

This problem is a regression from bug (missing update size of dest
file) in commit
1a980b8cbf00 ("ovl: add splice file read write helper")

The commit you want to backport fixes that problem, but introduces
another regression later fixed by commit
9b91b6b019fd ("ovl: fix deadlock in splice write")

So you'd need to backport both to end up with the correct
implementation of ovl_splice_write()

Thanks,
Amir.
