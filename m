Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124DC1AD764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgDQH23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 03:28:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45351 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgDQH20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:28:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id i22so670688otp.12;
        Fri, 17 Apr 2020 00:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAlxRW45me+SFTqp2fMa5KvZpf6cMRTo76EH5fkTTvc=;
        b=T8RvlSE0CoW2/ucpNcN3ufjhCCk8wpFi1WceqsbknanNI27mF3UL7sRQ90y9nHLckb
         GxLtxG/MLWc/7D7FNcVO03/bWn0CRD3wU6g8RBrTVhg2a0kTgkTmqEdOyxWOESZh22T0
         uGZVyokJR//7/YQYTxnO/hOcjmc+eAvEsOR0pCSoq7Igm6GZvb4zHvDTK4UwnZXB8EeN
         KAdfmyquu3O45M5wLUfmBq97XXXKqomORgN/UnSY9TUdox4PxPwMJwjHy7mtqu6dRtQv
         drKIipc35fCwiNQHOPWN61zZpPw33QAoQQX9ERcF3n4pm4jA7l9WP9a2C0mTmWk3hB37
         +9sg==
X-Gm-Message-State: AGi0Pua6aUY2Xvm3S2T8ksi7QEXjSlhKvPNzo2NomZxo9a5jVdgPZEMz
        n/Ly0BfrV2zBFhVNQ+yjQyf4lpDr9fuL6tUlIgo1wQ==
X-Google-Smtp-Source: APiQypK7KuRAoPktsLMQh2Me8mfNzHEYpwL9p+AMo7Mc+i20vMVMtApNzN65ngvXei2FszcvDlo15xrOTNLy+/p43Ec=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr1548442otk.250.1587108505576;
 Fri, 17 Apr 2020 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200416220130.13343-1-willy@infradead.org>
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Apr 2020 09:28:14 +0200
Message-ID: <CAMuHMdWxhVoPCZ5+=Pf1LFpdE9vPv9GGTqTYMQP9oFz7eCxDaQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Make PageWriteback use the PageLocked optimisation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Fri, Apr 17, 2020 at 12:01 AM Matthew Wilcox <willy@infradead.org> wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> PageWaiters is used by PageWriteback and PageLocked (and no other page
> flags), so it makes sense to use the same codepaths that have already been
> optimised for PageLocked, even if there's probably no real performance
> benefit to be had.
>
> Unfortunately, clear_bit_unlock_is_negative_byte() isn't present on every
> architecture, and the default implementation is only available in filemap.c
> while I want to use it in page-writeback.c.  Rather than move the default
> implementation to a header file, I've done optimised implementations for
> alpha and ia64.  I can't figure out optimised implementations for m68k,
> mips, riscv and s390, so I've just replicated the effect of the generic
> implementation in them.  I leave it to the experts to fix that (... or
> convert over to using asm-generic/bitops/lock.h ...)
>
> v3:
>  - Added implementations of clear_bit_unlock_is_negative_byte()
>    to architectures which need it

I have two questions here?
  1. Why not implement arch_clear_bit_unlock_is_negative_byte()
     instead, so the kasan check in asm-generic is used everywhere?
  2. Why not add the default implementation to
     include/asm-generic/bitops/instrumented-lock.h, in case an arch_*()
     variant is not provided yet?

Note that you did 1 for s390.
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
