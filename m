Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5005F25E18A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIDSnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgIDSnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:43:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CFC061245
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2020 11:43:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so9129280ljo.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2020 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGVkw+VA7Ozv3hFmklGnXOESB94iioBKwZC/vClHWhs=;
        b=OrfWsLi5zsx7qv2p1cK4X32zmscuCKlgmthoMdeY0cg3rmZpFdM3J9SvTCb9h5NnO9
         l0B0liyZtyXuNnV2gWB/4L3fr4ZoZu9bcbKCQOsRIl87cavO0SjGkvX9fTqXGzvbc3Rk
         8ry1Oj9UgjhZbRiLcVNkm18IHcMLIsEb6rQfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGVkw+VA7Ozv3hFmklGnXOESB94iioBKwZC/vClHWhs=;
        b=DLyxN38WrsHP5YBBUAEvzzMyhtv3l6tBJctEufcF2+JQKij7hEli9FZVmbr8DGq0nj
         Iu2nDAJSz10VkRe7zdTVMJYXveDc25QmR+kO90pG2qOifxkU+uuos/FM9xwcGLW+wjyk
         b+RmAffhMVC3tzcguQJYd582pIEMkoZz90SMusHN++b6Yl9SMa9x0af+p2vw+IWFAGt+
         vbJnlzmHiFytM7rA8nYxx9WKYw8bQjdhSud5pHSbOM+hYoGZ5KyfHBeYOdrY6f4cTFvW
         hMv2NOV8gP/84GRTeCYuo1W2mpjz47sAuOnpj/z561O91lwHwFGpqVQiuXflaR9BuUJ8
         9uTg==
X-Gm-Message-State: AOAM530jKxC11+2H8fJonVg9vVTQmgyVonmtKn6CyAG9S+pXFYRds1Bh
        rc7+gkfowUq5y5K1b4fbew1yRDh2B3zN9g==
X-Google-Smtp-Source: ABdhPJyqQP15pLqU5JikpbuGjfIphE1nABdLoqV6sakCJDgFkd1z3UIMfz7e4+/YB6AK4cQ03bvAow==
X-Received: by 2002:a2e:8193:: with SMTP id e19mr4996624ljg.80.1599244980846;
        Fri, 04 Sep 2020 11:43:00 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h16sm1461549lfc.63.2020.09.04.11.42.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 11:42:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y4so9128001ljk.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2020 11:42:58 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr3675523ljh.70.1599244978377;
 Fri, 04 Sep 2020 11:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200904060024.GA2779810@gmail.com>
 <20200904175823.GA500051@localhost.localdomain>
In-Reply-To: <20200904175823.GA500051@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Sep 2020 11:42:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUUBnp9JSK+u8gYQ-RpMZxgd3UfvpihCPA_vSN_8G8Mg@mail.gmail.com>
Message-ID: <CAHk-=wjUUBnp9JSK+u8gYQ-RpMZxgd3UfvpihCPA_vSN_8G8Mg@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 4, 2020 at 10:58 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> set_fs() is older than some kernel hackers!
>
>         $ cd linux-0.11/
>         $ find . -type f -name '*.h' | xargs grep -e set_fs -w -n -A3

Oh, it's older than that. It was there (as set_fs) in 0.10, and may
even predate that. But sadly, I don't have tar-balls for 0.02 and
0.03, so can't check.

The actual use of %fs as the user space segment is already there in
0.01, but there was no 'set_fs()'. That was a simpler and more direct
time, and "get_fs()" looked like this back then:

  #define _fs() ({ \
  register unsigned short __res; \
  __asm__("mov %%fs,%%ax":"=a" (__res):); \
  __res;})

and all the setting was basically part of the kernel entry asm and. Lovely.

                 Linus
