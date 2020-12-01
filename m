Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509A92CAD67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgLAUcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbgLAUcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:32:19 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FCC0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 12:31:39 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so1911726pfu.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 12:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aRfIoDH6SpOoFySUw56att87W5eciSizkn4JbJqzDR4=;
        b=1hGNhkJRuSmAU/hWfo7mmSRvqYvgG9Cm9HC5n8J5igmW9tQtBDSj4EHY0WHlLOeMYR
         nUmhyk12gQsoEmyRQ1mGbYx35oc3tYmF/unkYgVVf4eiZxyOX7+qmGbYFsJ/HRP3Do9j
         SGVB1BaOgYBMkexohrM+uo+XBcOVXLFewyqtiEiv105WfMJjc1qGYyOLU+d3jSX58eNv
         3QMpCjJxD2FvoPWSV8O7oHt8pDUiRNSGDg39+ETRwOZarhEoUbMj8Vg2jwGUg7doA87l
         R1+kgBo1DCvs4sHDy6B47lcf2eNj6piUf2SjXPzcokP+swKZmMj3ndmh2WLY7ngiIHjI
         n2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aRfIoDH6SpOoFySUw56att87W5eciSizkn4JbJqzDR4=;
        b=VJRyCzaXtdhBIOSryAby/s63yE+0OzXEB9fFtDOAcOTspCJXP1bff5T4+lPrTg9fo5
         JTqWulHBEcw7YN7DzLJjGjk34qPTxU5n9jRfc396SQm1hSDaIda+PkJssBPKUGYfxlxc
         1ipllsGYk6AX2P/uZibuB5PlajCoAwtI6zN5ecACKGmCds1JcYHVQn6UgRVRlx7fnZND
         6JTTFN6ov+920Jjwkc4sJQYf/uPQdYiEGvIYJtGINqXVgJg+BEAAY9ASl5+1j1XqsaEO
         JO4IEdjw7RZ7jPDyurP4EO+OgrasKNvEWt6RHK+T30TX7R2M/jJ5MFH0iFhv3axIXAyJ
         eH2A==
X-Gm-Message-State: AOAM5325gmE3B+tbks4IZ0uft4PnzSZ/6pq0RiCp55f1PTI6MBjkFcR7
        7nucXEuOTLLfPiDwDfJeQaz3/g==
X-Google-Smtp-Source: ABdhPJwWbiQrBBkjkM4aAHOkVKL1NsjhuDIJks5dusjUuLVZkY3CNpNzyVoAb2FN0FxelXvPHovf7Q==
X-Received: by 2002:a62:3803:0:b029:198:28fb:d6d5 with SMTP id f3-20020a6238030000b029019828fbd6d5mr4342561pfa.28.1606854698365;
        Tue, 01 Dec 2020 12:31:38 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::b2be])
        by smtp.gmail.com with ESMTPSA id i10sm603657pfq.189.2020.12.01.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:31:37 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:31:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
Message-ID: <X8aoKLtZ9VCqu4Eg@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
 <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
 <CAG48ez3rLFOWpaQcJxEE7BNXvxHvUQnvhhY-xyR2bZfhnmwQrg@mail.gmail.com>
 <X8VHcZs6paUvQGkk@relinquished.localdomain>
 <CAOQ4uxhLG1b03nYEgefcAybvMem26mjG=6dcrD5djjYFSa-q1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhLG1b03nYEgefcAybvMem26mjG=6dcrD5djjYFSa-q1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:15:58AM +0200, Amir Goldstein wrote:
> On Mon, Nov 30, 2020 at 9:26 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > On Sat, Nov 21, 2020 at 12:41:23AM +0100, Jann Horn wrote:
> > > On Thu, Nov 19, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Wed, Nov 18, 2020 at 9:18 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > > > The upcoming RWF_ENCODED operation introduces some security concerns:
> > > > >
> > > > > 1. Compressed writes will pass arbitrary data to decompression
> > > > >    algorithms in the kernel.
> > > > > 2. Compressed reads can leak truncated/hole punched data.
> > > > >
> > > > > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > > > > possible to do the permissions checks at the time of the read or write
> > > > > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > > > > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > > > > fcntl(). The flag is not cleared in any way on fork or exec. It must be
> > > > > combined with O_CLOEXEC when opening to avoid accidental leaks (if
> > > > > needed, it may be set without O_CLOEXEC by using fnctl()).
> > > > >
> > > > > Note that the usual issue that unknown open flags are ignored doesn't
> > > > > really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> > > > > O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
> > > [...]
> > > > > diff --git a/fs/open.c b/fs/open.c
> > > > > index 9af548fb841b..f2863aaf78e7 100644
> > > > > --- a/fs/open.c
> > > > > +++ b/fs/open.c
> > > > > @@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > > > >                 acc_mode = 0;
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
> > > > > +        * leaking encoded I/O privileges.
> > > > > +        */
> > > > > +       if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
> > > > > +               return -EINVAL;
> > > > > +
> > > >
> > > >
> > > > dup() can also result in accidental leak.
> > > > We could fail dup() of fd without O_CLOEXEC. Should we?
> > > >
> > > > If we should than what error code should it be? We could return EPERM,
> > > > but since we do allow to clear O_CLOEXEC or set O_ALLOW_ENCODED
> > > > after open, EPERM seems a tad harsh.
> > > > EINVAL seems inappropriate because the error has nothing to do with
> > > > input args of dup() and EBADF would also be confusing.
> > >
> > > This seems very arbitrary to me. Sure, leaking these file descriptors
> > > wouldn't be great, but there are plenty of other types of file
> > > descriptors that are probably more sensitive. (Writable file
> > > descriptors to databases, to important configuration files, to
> > > io_uring instances, and so on.) So I don't see why this specific
> > > feature should impose such special rules on it.
> >
> > I agree with Jann. I'm okay with the O_CLOEXEC-on-open requirement if it
> > makes people more comfortable, but I don't think we should be bending
> > over backwards to block it anywhere else.
> 
> I'm fine with or without the O_CLOEXEC-on-open requirement.
> Just pointing out the weirdness.

I agree, it's weird to enforce it in one place but not in others, so I
think I might as well drop the O_CLOEXEC requirement altogether.
