Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8359336EE40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhD2Qhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhD2Qhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:37:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D7FC06138C
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 09:36:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m7so66355014ljp.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jy1gsfA2QLvOvx7TBvVpUXXLbyGvmt6zTTbfyCza5Q=;
        b=e4nJJe8AlWJAidgWI6OhihjcNqgwz0DPI5Rl5bu5T1BqIhh4NlFmQJRL449TeVMK5y
         ChHE9s6lfcj3/LCDVQtcCqr9Wmb1XcpRoGlvPNWK/jjagajCseaN2xGpyJacHDtsZaYY
         4xMHvg4nD4E30NOL+TVcLYCkKH7UYRgfAT6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jy1gsfA2QLvOvx7TBvVpUXXLbyGvmt6zTTbfyCza5Q=;
        b=jtmy3sC0UCYSfMpjfbCDtkLB2m0bBwXlaiJNmW4C6qQT5HnxVSpnZb4W4Uu8aVtYN5
         tJMJyworcpsFRU//kKiWdSapaZrv/jJuVa8xvaqpmNH3DeNVjQycfZn5NLvjF+g6piTB
         ZK3EXrgKK7frJOpecxnM3Vm/9AQ2IT4K98iCOofBBdCrBTBkvhbTocz6KoM2FOvVzYbR
         PfF+dq2sjSjUJ55dDUgboL2Wt40XlQfeJKsFap4c8Rc5h2a7eYeg6Ft26x1CtZlnyL5I
         vXI8eg5qgKxSDPKxbsSxJ9WOA9rdsTxg+EfnqjcL/FlN8u/ZXWZ1XyY0gnmknrUeO71j
         3nNw==
X-Gm-Message-State: AOAM533a3PsXt/HTvQEn5H8g9jSu2gy/hgNdflLHoJubLkMcptiKrGHw
        XhoeQ8UvUXYyjopa9zIUW0UClaGTR33vllE5
X-Google-Smtp-Source: ABdhPJxe/OE+08JqxdrQBgteSNDLvEYjUt794aaZcz4KQhtAPHuVp2m1nm0vjwQOLBYIoDirL+NKQA==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr386002ljp.380.1619714203386;
        Thu, 29 Apr 2021 09:36:43 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t12sm24153lfl.254.2021.04.29.09.36.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:36:39 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j4so66354032lfp.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 09:36:39 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr273122lfe.41.1619714198332;
 Thu, 29 Apr 2021 09:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
 <20210429100508.18502-1-arek_koz@o2.pl>
In-Reply-To: <20210429100508.18502-1-arek_koz@o2.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 09:36:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYiKOYTtU6DifULbj0tmFLJf2Va5ScZW0dCgWi8=-c1A@mail.gmail.com>
Message-ID: <CAHk-=wgYiKOYTtU6DifULbj0tmFLJf2Va5ScZW0dCgWi8=-c1A@mail.gmail.com>
Subject: Re: [PATCH v2] proc: Use seq_read_iter for /proc/*/maps
To:     "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 3:04 AM Arkadiusz Kozdra (Arusekk)
<arek_koz@o2.pl> wrote:
>
> Since seq_read_iter looks mature enough to be used for /proc/<pid>/maps,
> re-allow applications to perform zero-copy data forwarding from it.

I'd really like to hear what the programs are, and what the
performance difference is.

Because I'm surprised that the advantages of splice would really be
noticeable. I don't _dispute_ it, but I really would like this to be
actually _documented_, not just "Some executable-inspecting tools".

What tools (so that if it causes issues later, we have that
knowledge), and what are the performance numbers?

             Linus
