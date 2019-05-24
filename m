Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF4291FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfEXHoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 03:44:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47089 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbfEXHoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 03:44:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so6005115qkb.13;
        Fri, 24 May 2019 00:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2hM4uRH+xcF6VZw3zZp57FHF0UiIEpfXR9WFJl84UE=;
        b=PYXq1Idzv0Di7KLMknzWpNB+eY+yAOjbVLGoI5HUbfbPvDLGbeqCylQHAYwjvuSa0e
         IkMKSeoe3IR3aNnjCBw+MHwc5WWQdgsseuj/aC59yOVLI4d0Twksyz4v5wc494lIhagG
         tI6f8JhIFaoCJFSmJxKQFc1dQ+AEZABwqBiQEMUXnGdfiMTZB2Gs3uPZ3vGAsGa/AdF7
         LCIl7WMuGS5y0Bo6e8XQO/aJiEDa/nlQqrbspcGRQGNzl23DvPUNFRrB+4NRjwo/OfAB
         atqkh0iKBC0EFrVTNrQ50gbR+7yV90h01bA/rQNSKkLlx5BjivcZnCzdDU1XcWXk/L1l
         WKfA==
X-Gm-Message-State: APjAAAXwfXByxZKYfWiMo9NPVH0LPLmzUDK7pZnqtwgzF0APfN1TY0OJ
        4eLsFdXsvJQkA4Q8mb4D3BVwKXzWUO3mq3l/+tQ=
X-Google-Smtp-Source: APXvYqy/WqyRL4BlbMWLM5GdeDgLkBJI6XwCNcVvXGonN+2oV2dtTQWrObje5U17OKbtEn0pWH9nlYsDR25/fOWgBDY=
X-Received: by 2002:ac8:2433:: with SMTP id c48mr70119188qtc.18.1558683849757;
 Fri, 24 May 2019 00:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190522155259.11174-1-christian@brauner.io> <67e4458a-9cc4-d1aa-608c-73ebe9e2f7a3@yandex-team.ru>
 <20190523163345.q5ynd2ytk7nxcvqf@brauner.io>
In-Reply-To: <20190523163345.q5ynd2ytk7nxcvqf@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 May 2019 09:43:53 +0200
Message-ID: <CAK8P3a26uvqmExJZsezhB+cp2ADM0Ai9jVUKWOFM6kg848bCKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] open: add close_range()
To:     Christian Brauner <christian@brauner.io>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Todd Kjos <tkjos@android.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 6:33 PM Christian Brauner <christian@brauner.io> wrote:
> On Thu, May 23, 2019 at 07:22:17PM +0300, Konstantin Khlebnikov wrote:
> > On 22.05.2019 18:52, Christian Brauner wrote:> This adds the close_range() syscall. It allows to efficiently close a range
> > >   22 files changed, 100 insertions(+), 9 deletions(-)
> > >
> >
> > It would be better to split arch/ wiring into separate patch for better readability.
>
> Ok. You mean only do x86 - seems to be the standard - and then move the
> others into a separate patch? Doesn't seem worth to have a patch
> per-arch, I'd think.

I think I would prefer the first patch to just add the call without wiring it up
anywhere, and a second patch do add it on all architectures including x86.

     Arnd
