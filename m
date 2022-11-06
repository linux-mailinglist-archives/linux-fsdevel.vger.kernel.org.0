Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6961E26C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 14:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKFNq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 08:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFNqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:46:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B21026
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Nov 2022 05:46:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b2so23963105eja.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Nov 2022 05:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvHQw3MpKj2ew4Zx/51KfKsxcxJrFJHe+YH+/eJYORk=;
        b=N9HjxklYjNnVUpsQa7gObZNQIWxnPEfkN9h9tvbSf93K+9IBDhZrWm5fEN3Rkw8lJU
         G3vs/KXs2ZAXg9NN+9S/f+Y2ZeKzsbozQ3glkgiBuFCzEsQPCPX1zgg98zjNf+sG3z2b
         ndESYkRIYVlPy4FH/IQiT+D3WYyDmpHFsPjUhnJBRBT9+K2Pb95goVC8TDMYiVm99n7u
         VGvOvrLEuu5V0KGcG3529n0VP0AJaiprJ/S1nbnG4bLTflyApzny5mWY6M78FFbVmfp6
         nFCtwIQVM9JhHqQ5+Ra34PjRNbHLB4UbFncNssCaA5T1VSUCgFDGHIFx98az5sW/17RS
         d6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvHQw3MpKj2ew4Zx/51KfKsxcxJrFJHe+YH+/eJYORk=;
        b=KHBqOZ3kDbXM+COljiMLKa52PhnJNhZWouv8Xp6pAT68UEO8LCzo/3sZ1vR2jmlXiL
         DOMIocX6zF3gJxNMdMAFj2s4QwgCO4wkdxSMDFDuZDyZg9ftA8XHKrEFh9JFouD3yLuV
         nwlkqj37efmg2mAHH6kGo/TeXD9HzV1fTM8bekpn9YxWHrO3JxNIVIfsliVZg+JrMLwQ
         LMW5puvVv10YyMtP+YDcYNquFH3n2WvIfuz0Tl/tbY0WJKiH2W/ZC8HghYFqXTjfu10q
         TXy+AdxB68hu+ZdYn4iv+60LzCz3kgPAqLcucv1eQ1h4tr+QY5EYATaTqgZovrdtuW3O
         /30w==
X-Gm-Message-State: ACrzQf3tHsxZNg/0s6pO1lH6CVcIQRcj8xlYaFQ+GW6K3w7oweliZUUm
        vPHxeNcp5FiVCBhSoanO+0P9kMMfXYg0YmToXBYr9g==
X-Google-Smtp-Source: AMsMyM78WuDidk5mI0iEui7TMptFInZ54NSTtJrPLDVW2NaWzWUctfakaLoEEaiVIvZFa+8OCij0apca/1fIBEpqNUM=
X-Received: by 2002:a17:907:31c1:b0:742:28a3:5d08 with SMTP id
 xf1-20020a17090731c100b0074228a35d08mr42823663ejb.112.1667742382309; Sun, 06
 Nov 2022 05:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20221105025342.3130038-1-pasha.tatashin@soleen.com> <20221106133351.ukb5quoizkkzyrge@box.shutemov.name>
In-Reply-To: <20221106133351.ukb5quoizkkzyrge@box.shutemov.name>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Sun, 6 Nov 2022 08:45:44 -0500
Message-ID: <CA+CK2bDK=oUYM-HZsYfZoq_n5BQMGpysMq395WK78r+SwYk99A@mail.gmail.com>
Subject: Re: [PATCH] mm: anonymous shared memory naming
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 6, 2022 at 8:34 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sat, Nov 05, 2022 at 02:53:42AM +0000, Pasha Tatashin wrote:
> > Since:
> > commit 9a10064f5625 ("mm: add a field to store names for private anonymous
> > memory")
> >
> > We can set names for private anonymous memory but not for shared
> > anonymous memory. However, naming shared anonymous memory just as
> > useful for tracking purposes.
> >
> > Extend the functionality to be able to set names for shared anon.
> >
> > / [anon_shmem:<name>]      an anonymous shared memory mapping that has
> >                            been named by userspace
> >
> > Sample output:
> >         share = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> >         rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
> >                    share, SIZE, "shared anon");
> >
> > /proc/<pid>/maps (and smaps):
> > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024
> > /dev/zero (deleted) [anon_shmem:shared anon]
> >
> > pmap $(pgrep a.out)
> > 254:   pub/a.out
> > 000056093fab2000      4K r---- a.out
> > 000056093fab3000      4K r-x-- a.out
> > 000056093fab4000      4K r---- a.out
> > 000056093fab5000      4K r---- a.out
> > 000056093fab6000      4K rw--- a.out
> > 000056093fdeb000    132K rw---   [ anon ]
> > 00007fc8e2b4c000 262144K rw-s- zero (deleted) [anon_shmem:shared anon]
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/filesystems/proc.rst |  4 +++-
> >  fs/proc/task_mmu.c                 |  7 ++++---
> >  include/linux/mm.h                 |  2 ++
> >  include/linux/mm_types.h           | 27 +++++++++++++--------------
> >  mm/madvise.c                       |  7 ++-----
> >  mm/shmem.c                         | 13 +++++++++++--
> >  6 files changed, 35 insertions(+), 25 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 898c99eae8e4..8f1e68460da5 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -431,8 +431,10 @@ is not associated with a file:
> >   [stack]                    the stack of the main process
> >   [vdso]                     the "virtual dynamic shared object",
> >                              the kernel system call handler
> > - [anon:<name>]              an anonymous mapping that has been
> > + [anon:<name>]              a private anonymous mapping that has been
> >                              named by userspace
> > + path [anon_shmem:<name>]   an anonymous shared memory mapping that has
> > +                            been named by userspace
>
> I expect it to break existing parsers. If the field starts with '/' it is
> reasonable to assume the rest of the string to be a path, but it is not
> the case now.

This is actually exactly why I kept the "path" part. It stays the same
as today for  anon-shared memory, but prevents pmap to change
anon-shared memory from showing it as simply [anon].

Here is what we have today in /proc/<pid>/maps (and smaps):
7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024  /dev/zero (deleted)

So, the path points to /dev/zero but appended with (deleted) mark. The
pmap shows the same thing, as it is looking for leading '/' to
determine that this is a path.

With my change the above changes only when user specifically changed
the name like this:

7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024  /dev/zero
(deleted) [USER-SPECIFIED-NAME]

So, the path stays, the (deleted) mark stays, and a name is added.

Since this is anon memory, we can get rid of the /dev/zero path part
entirely and only print the name when the user specified one, but this
would change the output in pmap command to show all anonymous shared
memory as simply [anon].

Pasha

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
