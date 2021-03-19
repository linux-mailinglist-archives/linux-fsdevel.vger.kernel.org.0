Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4634273E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 21:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCSU4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSUzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:55:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E46C061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 13:55:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u4so13575255ljo.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gSNHi6NTmtoKVPXfvXjUk8vksN+CdXfq9GZf+lE6jM=;
        b=bUGF4gcA+WukYQXfGQLoGyybVAjlhABK6I/XqjqtqYvJ4D7eQPjfRnQeRuio9j5bEz
         cyzSyc3J6pa5V0lLZzzKp7+aZH433a3GUMmcdCJNw0OSjNw6QOKQ1QaLomw3Qc3ajfcP
         pOBwf4lY3oMRCDjHadRcMRbVaj2tYTuB7VRqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gSNHi6NTmtoKVPXfvXjUk8vksN+CdXfq9GZf+lE6jM=;
        b=qLMCNpEfAPdVFAoE72FOe9rAyGLE2DLDWoWZzaVqgjAMcMcqc8zrwM/QAGFJ87P0ba
         W2HYGPkTtuWleFjSD9f92WZ88M2h6zC0JBE4Z/eqsA9z0JHzYGz0x8YEjXLAu7ITW52J
         ZMByuPjtzMTp2hexO/cZIPvbhyEsL2qtmYp9PfY4SbxUuVOiOw4qaP6m7gpMWZ18pLOw
         UsOEJhUYHyqvzlY3X4fydivw7QKHZ3mhkVbRHLhlTJwamy7WCCHLvDi74qJ6PqgvfGMy
         gv1ARQYHbh/S5X6hKBr4V9xsxrLCgxqHk30+IHEDV/vD4doaio+ifvDxzuUy2SDhAb/O
         tIgw==
X-Gm-Message-State: AOAM531rL9dh+c0WA6EfvU3o0YjudCwfzIUAvqqjIXEiP71RUD9yEX97
        RDniw1MStvuNeCaE0l6PW4YY1kbyU3y17Q==
X-Google-Smtp-Source: ABdhPJyFdUSfO9ezL0nSblOgDfFPCre9Us/M0sAJJHaneYQhRDAkEb4UARmYqw5Kqoh9lVfLWkpp9Q==
X-Received: by 2002:a2e:864d:: with SMTP id i13mr1978645ljj.48.1616187336042;
        Fri, 19 Mar 2021 13:55:36 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 197sm897339ljf.70.2021.03.19.13.55.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:55:34 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id q13so12004115lfu.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 13:55:34 -0700 (PDT)
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr1755762lfg.487.1616187334375;
 Fri, 19 Mar 2021 13:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com> <YFUJLUnXnsv9X/vN@relinquished.localdomain>
In-Reply-To: <YFUJLUnXnsv9X/vN@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 13:55:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
Message-ID: <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 1:27 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> For RWF_ENCODED, iov[0] is always used as the entirety of the struct. I
> made the helper more generic to support other use cases, but if that's
> the main objection I can easily make it specifically use iov[0].

Honestly, with new interfaces, I'd prefer to always start off as
limited as possible.

And read/write is not very limited (but O_ALLOW_ENCODED and
RWF_ENCODED at least helps with the "fool suid program to do it"). But
at least we could make sure that the structure then has to be as
strict as humanly possible.

So it's not so much a "main objection" as more about trying to make
the rules stricter in the hope that that at least makes only one very
particular way of doing things valid. I'd hate for user space to start
'streaming" struct data.

> > Also I see references to the man-page, but honestly, that's not how
> > the kernel UAPI should be defined ("just read the man-page"), plus I
> > refuse to live in the 70's, and consider troff to be an atrocious
> > format.
>
> No disagreement here, troff is horrible to read.
>
> > So make the UAPI explanation for this horror be in a legible format
> > that is actually part of the kernel so that I can read what the intent
> > is, instead of having to decode hieroglypics.
>
> I didn't want to document the UAPI in two places that would need to be
> kept in sync

Honestly, I would suggest that nobody ever write troff format stuff.
I don't think it supports UTF-8 properly, for example, which means
that you can't even give credit to people properly etc.

RST isn't perfect, but at least it's human-legible, and it's obviously
what we're encouraging for kernel use. You can use rst2man to convert
to bad formats (and yes, you might lose something in the translation,
eg proper names etc).

Almost anything else(*) is better than troff. But at least I can read
the formatted version.

          Linus

(*) With the possible exception of "info" files. Now *there* is a
truly pointless format maximally designed to make it inconvenient for
users.
