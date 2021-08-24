Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE63F69CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhHXT0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhHXT0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:26:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEAC0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:25:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g13so47695928lfj.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZJyYVORrCiAyJfqjWHoPU9PIFZ88DitsmtYgIA7rQ4=;
        b=KtXnGitBkvxfOgqJRNuwi+8709mbnBLpqTuREEhVvpbMPwWaovy2KY9NAyJLvsfAEZ
         1V1wAe8ouRjxf9LTndxeO7Z+UHxlIm0NFECFKbrxrI2kT1jgXK9GwPGvsFC73in9KpWb
         1oiPXuvWItsl7evaUnfeF/dDHy6N+uJbuNkFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZJyYVORrCiAyJfqjWHoPU9PIFZ88DitsmtYgIA7rQ4=;
        b=UEzx2njtZP3n+7/+dvbh28f8h1/XMfIpAu+EXq2LWAqk8x356x3Ukjw3WUDEvjQOee
         64t8gChGJeddDN8Ctj+oLsP2rC0mwNZmOZOmiYtJ9ztzsauyZuDPwxT+27JH2MsB2JJI
         Vlolqbya8cH3WOTT7rIaX4wlzRIlC76+l6ny92ahfLi+VVN7srK0XQip48BEwYePqgTu
         ISUahVNP6hRUaKsK4uI8XVjVBtsOChsBY+hBHASTWDOpMTEWDRNLFZ3y7l53JvCxKfMb
         Yj+B2Dr/FOVzOX4O/E2/s1IIRZVX5ArKXP1iAQduYe8cNIytk+Ky/0RUDwhLmPkF1A87
         t/Zg==
X-Gm-Message-State: AOAM532eSW5fKoTahDTxro5DRsD9Loi9IkLu7j8JE/mNjyS0rbtfYm5o
        MPzmL0x/HnxMM0Y7jen5PVDjvnuUtWCtnH21
X-Google-Smtp-Source: ABdhPJw9T+xsQB8Hv1kiAiKzIHSa0EXPbjFdXxw5YEL0Rsa/RXtfOeRS0x5FFmx0zus8iHLADMUMOg==
X-Received: by 2002:a05:6512:748:: with SMTP id c8mr4458161lfs.259.1629833132014;
        Tue, 24 Aug 2021 12:25:32 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h22sm1297905lfu.70.2021.08.24.12.25.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:25:31 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id k5so47749701lfu.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:25:31 -0700 (PDT)
X-Received: by 2002:ac2:4da5:: with SMTP id h5mr16581349lfe.40.1629833131285;
 Tue, 24 Aug 2021 12:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com> <1966106.1629832273@warthog.procyon.org.uk>
In-Reply-To: <1966106.1629832273@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:25:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
Message-ID: <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:11 PM David Howells <dhowells@redhat.com> wrote:
>
> "page_group"?  I would suggest "pgroup", but that's already taken.  Maybe
> "page_set" with "pset" as a shorthand pointer name.  Or "struct pset/pgset"?

Please don't do the "shorthand" thing. Names like "pset" and "pgroup"
are pure and utter garbage, and make no sense and describe nothing at
all.

If you want a pointer name and don't need a descriptive name because
there is no ambiguity, you might as well just use 'p'. And if you want
to make it clear that it's a collection of pages, you might as well
use "pages".

Variable naming is one thing, and tere's nothing wrong with variable
names like 'i', 'p' and 'pages'. The variable name should come from
the context, and 'a' and 'b' can make perfect sense (and 'new' and
'old' can be very good names that clarify what the usage is - C++
people can go pound sand, they mis-designed the language keywords).

But the *type* name should describe the type, and it sure shouldn't be
anything like pset/pgroup.

Something like "page_group" or "pageset" sound reasonable to me as type names.

                      Linus
