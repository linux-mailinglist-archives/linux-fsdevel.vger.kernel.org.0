Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF42C8E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgK3T11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 14:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgK3T1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:27:25 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC9C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:26:45 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so7055561plo.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5UnMpQBYHotCDTkXRugfxn86+0MbQOFfnDSvdnd4GfQ=;
        b=jwRI+RZHUvwb1CP4nQm75YJO0k3drE7J0VsbbONg4HJ0P6fp4hjRDhCyve6Jg5oots
         ImF51/TaBnSfChuyclD/Kha+r+KSni+VtCv5vaImPAx4+ePME3uk4htaE0c5W1C4Kmow
         uh3PdxmKRCJoZe2q8AOHPR4SWU2wMvpXnULBI97Py0rjc8ncRbHlmGXJ8JrOpyPBYr+m
         RVAIsQ7BNTkcwhSNQadBtLurDnw4+0Er9XVV42lVO59FrOSnAvXIJ59VitG4iq0OpqKw
         IPF+Vg6k65jmFjur7dgmDiX2ei5pRnhqipHa2B0KV4KyWvq8Joy7gcbSlHmJgrZfUElM
         mVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5UnMpQBYHotCDTkXRugfxn86+0MbQOFfnDSvdnd4GfQ=;
        b=NWwDDBpwAnEDArr+NX9NxenYkwGA5a3BL3iQ5EyheSkR0X+IyuTKQMTDY1B5nH3aEY
         XS1OS7UjPSoi31zhDStYSNoUruv//c3w/l75AsJrLRWt6L28LZZIFgO+AZGorolp9Gjk
         FJlABG6GAziRauPvSbDoyKXsbyKOI24cGZdVy8GLVHHfaIT19w5z1EtG3CcMTewEm+uj
         QgtG7GaiGDbwNVUSXEZjtTFvIjL5wvOTLXtt5A0vqlwAmPHI6pJ3whbLhZGKGRbg2sVh
         JN3zBQDOUBblFj3WpjnHuVpUDr7Z8ujQ14W5n0dT5UM2E2k21/hDdDKgImPpAjag0jNJ
         YfXg==
X-Gm-Message-State: AOAM531+qsa/7Lw2GZiusAoezEaEnXbqqBZhgFInAhOLG6qppYdSs6Iy
        qsH6dlnbXVCRAY2b7aLbsGH3RHiTND7HKQ==
X-Google-Smtp-Source: ABdhPJxKgJMMz70YGWt+n1sthe/QFDOW1SrKkWKaEAAkTnFqKlM3zLJ5S/5KPnA5AUMHV1Cb71id5A==
X-Received: by 2002:a17:90a:14e5:: with SMTP id k92mr346329pja.169.1606764404409;
        Mon, 30 Nov 2020 11:26:44 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::b2be])
        by smtp.gmail.com with ESMTPSA id 21sm17640701pfw.105.2020.11.30.11.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:26:42 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:26:41 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jann Horn <jannh@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
Message-ID: <X8VHcZs6paUvQGkk@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
 <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
 <CAG48ez3rLFOWpaQcJxEE7BNXvxHvUQnvhhY-xyR2bZfhnmwQrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3rLFOWpaQcJxEE7BNXvxHvUQnvhhY-xyR2bZfhnmwQrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 12:41:23AM +0100, Jann Horn wrote:
> On Thu, Nov 19, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Nov 18, 2020 at 9:18 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > The upcoming RWF_ENCODED operation introduces some security concerns:
> > >
> > > 1. Compressed writes will pass arbitrary data to decompression
> > >    algorithms in the kernel.
> > > 2. Compressed reads can leak truncated/hole punched data.
> > >
> > > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > > possible to do the permissions checks at the time of the read or write
> > > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > > fcntl(). The flag is not cleared in any way on fork or exec. It must be
> > > combined with O_CLOEXEC when opening to avoid accidental leaks (if
> > > needed, it may be set without O_CLOEXEC by using fnctl()).
> > >
> > > Note that the usual issue that unknown open flags are ignored doesn't
> > > really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> > > O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
> [...]
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 9af548fb841b..f2863aaf78e7 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > >                 acc_mode = 0;
> > >         }
> > >
> > > +       /*
> > > +        * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
> > > +        * leaking encoded I/O privileges.
> > > +        */
> > > +       if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
> > > +               return -EINVAL;
> > > +
> >
> >
> > dup() can also result in accidental leak.
> > We could fail dup() of fd without O_CLOEXEC. Should we?
> >
> > If we should than what error code should it be? We could return EPERM,
> > but since we do allow to clear O_CLOEXEC or set O_ALLOW_ENCODED
> > after open, EPERM seems a tad harsh.
> > EINVAL seems inappropriate because the error has nothing to do with
> > input args of dup() and EBADF would also be confusing.
> 
> This seems very arbitrary to me. Sure, leaking these file descriptors
> wouldn't be great, but there are plenty of other types of file
> descriptors that are probably more sensitive. (Writable file
> descriptors to databases, to important configuration files, to
> io_uring instances, and so on.) So I don't see why this specific
> feature should impose such special rules on it.

I agree with Jann. I'm okay with the O_CLOEXEC-on-open requirement if it
makes people more comfortable, but I don't think we should be bending
over backwards to block it anywhere else.
