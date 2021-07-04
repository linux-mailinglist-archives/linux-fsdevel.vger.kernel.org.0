Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA93BAE94
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGDTHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhGDTHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 15:07:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3DC061574
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 12:04:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k8so21484129lja.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB3iPjvsLmzaoRWILKBeqEhsvipX4wObhsZWf88uyy8=;
        b=Sm3IX5+2C7aHnIadADgPZjCpqw07tS7g18KL91fj6GX289o6lpGvmu4mOQiuanLJ7g
         mz+MTyQ1gPuk168IjXBPr9xLekkyOzzEy3IxpzwBxRPtXO29lukvWotEzmD0fnODCRD6
         w1GGbI0C/NuEdSu+9pjjamzxTVkluVG5+xCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB3iPjvsLmzaoRWILKBeqEhsvipX4wObhsZWf88uyy8=;
        b=kpjmiqmLjKpqu1nS3oVf5eiBFmIQQLev0DWdxrFTeAKb5nT3lDzKsMJXRTrCOKQl1A
         5OvojQhUS6UcqGECpmcq+FPD4fYBNYP02qrwDMpMtqOh7vlslKld4hnruxzzTcvcpGob
         65lvfjq2AVBd2/HUdeIxyJWl7fosaPiPS0/Vmuec4gCK1xIj8p7qN0qmLY506sXr6Q9d
         AJ1QnkTtrE2LeG7PzkdnPfAWwtnehXfuwws/U8TxjYrIQdMCQG11awkciRZhF/nk+lJT
         s0kWT+2roxsIhjJvi0OGbGzUbTdGiWRnLI+EdD9Au7/XyxTOr9vYDZ6w4E6uuxzFe846
         EDwQ==
X-Gm-Message-State: AOAM5327pvyie1XkJ2S+FsslCOgI8mGaap3IAYYHRcqUdEpXQl8ZgjG/
        Mqai1Da9xu0Rs/UXCqzA6Sa7sa5/3ydbERDaeBw=
X-Google-Smtp-Source: ABdhPJyKCOO4j9nLY69Z4C/zG5+JIgR06v36nPxVp0y4+tjyKNrsCcDIOqNlmL78830D0d9+N+Eghw==
X-Received: by 2002:a05:651c:c7:: with SMTP id 7mr8204267ljr.101.1625425487183;
        Sun, 04 Jul 2021 12:04:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u19sm1201634ljl.99.2021.07.04.12.04.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 12:04:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f30so28409602lfj.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 12:04:45 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr7491282lfc.201.1625425485251;
 Sun, 04 Jul 2021 12:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
In-Reply-To: <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 12:04:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
Message-ID: <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 4, 2021 at 11:54 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> No, I still see the same warning, with the same traceback. I did make sure
> that the code is executed by adding a printk in front of it.

And that printk() hits before the WARN_ON_ONCE() hits?

Funky. That sounds to me like something is then doing
set_fs(KERNEL_DS) again later, but it's also possible that I've been
dropped on my head a few too many times as a young child, and am
missing something completely obvious.

Can somebody put me out of my misery and say "Oh, Linus, please take
your meds - you're missing xyz..."

                 Linus
