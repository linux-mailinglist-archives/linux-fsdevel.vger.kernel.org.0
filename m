Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F53AC627
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhFRId7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhFRId5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:33:57 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5AC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 01:31:47 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i17so7755839ilj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lFwm1133mv6gxG1yIy3y8qPNcT3vkNGLZdF4eVbKc4I=;
        b=jHt/p+aVlcMOygY50yvW43NaSczEC3OyNJrGb3v1OHPn1V89uTvqQXK61I7zMR/1Pb
         vCn7+bq2nynS1GHsP4i39ckUJ2+Qd4KmPVmapIGlk9Ku7eBjEZwgi5D7RSbSo4D6jVat
         O3ASuJ8tVkYEUTq6zOOhdpC1YvIhaETytfu1t7GtW+NmkopC841Q6Qcpvfr4IJW8BudI
         G51ytOasxj5HMj6iqqp9U73pqFwKBTkDoxFFvzjgaVjCeTzN3dnsBdtY57tgaKzpK2k/
         Vg3qerhoUID546HGUMKidgDP/8iFWqnabCncJekSqGPewjRSYon4fTNnCm4FScCPzumc
         Ej+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lFwm1133mv6gxG1yIy3y8qPNcT3vkNGLZdF4eVbKc4I=;
        b=pDPTzB+NfHuxqYQbIhUk/5unfvNu1UN6QGIHSdJihh+ioaqjnkT0uZ4C5JaKepupkT
         mJSzKUIbS2+c3twfEO0mwCfo4C9zy8qVSqKZM31TahYIFayDPLziEoTgid6nQYBeaSUi
         sA1ELVrEzjcuUDQuF2lTDcVyJ3EBwKDdPOFq70+zBmgjD9m+umWZOdb0qwHXBd9/Khf+
         i7PzUP8EzxasjRwEOualUNvn3pUNt9LfqMkpqeY8Kl4ogexuEwG3eYLp5XZEJOtcSGv0
         bUTf7j+ZmCsFaeFUbZ69WqIv9njJyYWHP44xUFR5nZuN9l4NrEz7h/YCF62bCyKoK9Rc
         HaGA==
X-Gm-Message-State: AOAM531yvnqKKEDPTNvdIjVuIld88EL/a7X//0NqJ9pY/SncvirCYcEH
        akK/adGNnS9MfzPtOsE7rgBYt9jbkJfMQvPQQhfSnQ==
X-Google-Smtp-Source: ABdhPJxCJDhUsGS4lgP4T4pc9htmYI/CVF8R+RBqRDnuazrU3rpD4EH4CupNL8GEPU7n/znMLx51qUJMuIyg2AfczY8=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr6743092ils.302.1624005106809;
 Fri, 18 Jun 2021 01:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095309.3542373-1-stapelberg+linux@google.com> <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com>
In-Reply-To: <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com>
From:   Michael Stapelberg <stapelberg+linux@google.com>
Date:   Fri, 18 Jun 2021 10:31:35 +0200
Message-ID: <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Miklos

Thanks for taking a look!

On Fri, 18 Jun 2021 at 10:18, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 17 Jun 2021 at 11:53, Michael Stapelberg
> <stapelberg+linux@google.com> wrote:
> >
> > These new knobs allow e.g. FUSE file systems to guide kernel memory
> > writeback bandwidth throttling.
> >
> > Background:
> >
> > When using mmap(2) to read/write files, the page-writeback code tries t=
o
> > measure how quick file system backing devices (BDI) are able to write d=
ata,
> > so that it can throttle processes accordingly.
> >
> > Unfortunately, certain usage patterns, such as linkers (tested with GCC=
,
> > but also the Go linker) seem to hit an unfortunate corner case when wri=
ting
> > their large executable output files: the kernel only ever measures
> > the (non-representative) rising slope of the starting bulk write, but t=
he
> > whole file write is already over before the kernel could possibly measu=
re
> > the representative steady-state.
> >
> > As a consequence, with each program invocation hitting this corner case=
,
> > the FUSE write bandwidth steadily sinks in a downward spiral, until it
> > eventually reaches 0 (!). This results in the kernel heavily throttling
> > page dirtying in programs trying to write to FUSE, which in turn manife=
sts
> > itself in slow or even entirely stalled linker processes.
> >
> > Change:
> >
> > This commit adds 2 knobs which allow avoiding this situation entirely o=
n a
> > per-file-system basis by restricting the minimum/maximum bandwidth.
>
>
> This looks like  a bug in the dirty throttling heuristics, that may be
> effecting multiple fuse based filesystems.
>
> Ideally the solution should be a fix to those heuristics, not adding more=
 knobs.


Agreed.

>
>
> Is there a fundamental reason why that can't be done?    Maybe the
> heuristics need to detect the fact that steady state has not been
> reached, and not modify the bandwidth in that case, or something along
> those lines.

Maybe, but I don=E2=80=99t have the expertise, motivation or time to
investigate this any further, let alone commit to get it done.
During our previous discussion I got the impression that nobody else
had any cycles for this either:
https://lore.kernel.org/linux-fsdevel/CANnVG6n=3DySfe1gOr=3D0ituQidp56idGAR=
DKHzP0hv=3DERedeMrMA@mail.gmail.com/

Have you had a look at the China LSF report at
http://bardofschool.blogspot.com/2011/?
The author of the heuristic has spent significant effort and time
coming up with what we currently have in the kernel:

"""
Fengguang said he draw more than 10K performance graphs and read even
more in the past year.
"""

This implies that making changes to the heuristic will not be a quick fix.

I think adding these limit knobs could be useful regardless of the
specific heuristic behavior.
The knobs are certainly easy to understand, safe to introduce (no regressio=
ns),
and can be used to fix the issue at hand as well as other issues (if
any, now or in the future).

Thanks
Best regards
Michael
