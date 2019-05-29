Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6922DEAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfE2Nlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 09:41:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41768 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfE2Nlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 09:41:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id m18so1449664qki.8;
        Wed, 29 May 2019 06:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4Hu2BykjV2XUgQjXYreykG9CRGtaQihhtWlraD16NE=;
        b=sl4DM5ZdnaEZ7230fYjDZKFkNHlXI2r1MHAbH/EzdU4PTZaFWfnRXcbUxeHsZUrOWr
         eg3HmJaxtFeFVEfNEbwz+Vfuy2iZbcNM09i33cxV4P+uR8/fQji3bDwDQNzFAgfHW8tc
         zSxfK2Cdhi9KbsqPUpOPKzmFZv2OO6wJRgY8dN90EuR3MzbO3J3RrHemZ+Gh7HTFoN3D
         30W/kXjEqFGxkhE/cYqneBhjQ3KX+Lrbf0O/fi7O06T7lxcaKpwR0Yn0nfKFLRWHpOp+
         TYGbBNJmHrX5zAtsn1UrIrxfsOwqyK7ZoO1xMMLDOY7LbZuT/ltL7HI+4LD+aefmYehj
         8GmQ==
X-Gm-Message-State: APjAAAUhzCfy010lSBqK1n8hFlt+KWriO7ZKizIpYvSJAKISEOWqQIsM
        DpQiHDcqaxTLAoHWjAL5hRUc013QGXt9mn+g6IE=
X-Google-Smtp-Source: APXvYqwI32DYHBzUvKVuPe+aOANmgUoQBTNNnfm9jjZUjMGmB4YKECE25ibchquT1Q2cVjHAmLwbc+ySXwB2JGCPHNI=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr80895478qkk.182.1559137308118;
 Wed, 29 May 2019 06:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
 <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org> <CAK8P3a0b7MBn+84jh0Y2zhFLLAqZ2tMvFDFF9Kw=breRLH4Utg@mail.gmail.com>
 <889fc718-b662-8235-5d60-9d330e77cf18@linux-m68k.org>
In-Reply-To: <889fc718-b662-8235-5d60-9d330e77cf18@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 May 2019 15:41:31 +0200
Message-ID: <CAK8P3a0zj126XSGjMbiDJDkY8sF+6JNWH0VsJEUAga6OGHV0vg@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Greg Ungerer <gregungerer00@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sergei Poselenov <sposelenov@emcraft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 2:29 PM Greg Ungerer <gregungerer00@gmail.com> wrote:
> On 29/5/19 10:05 pm, Arnd Bergmann wrote:
> > On Tue, May 28, 2019 at 12:56 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> >> On 27/5/19 11:38 pm, Jann Horn wrote:
> >>> On Sat, May 25, 2019 at 11:43 PM Andrew Morton
> >>> <akpm@linux-foundation.org> wrote:
> >>> Maybe... but I didn't want to rip it out without having one of the
> >>> maintainers confirm that this really isn't likely to be used anymore.
> >>
> >> I have not used shared libraries on m68k non-mmu setups for
> >> a very long time. At least 10 years I would think.
> >
> > I think Emcraft have a significant customer base running ARM NOMMU
> > Linux, I wonder whether they would have run into this (adding
> > Sergei to Cc).
> > My suspicion is that they use only binfmt-elf-fdpic, not binfmt-flat.
> >
> > The only architectures I see that enable binfmt-flat are sh, xtensa
> > and h8300, but only arch/sh uses CONFIG_BINFMT_SHARED_FLAT
>
> m68k uses enables it too. It is the only binary format supported
> when running no-mmu on m68k. (You can use it with MMU enabled too
> if you really want too).

My mistake, I meant to write 'the only architectures /other than m68k/",
which you had already mentioned above.

    Arnd
