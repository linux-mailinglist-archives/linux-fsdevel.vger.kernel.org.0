Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2902E3FA144
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhH0Vu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0Vuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:50:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A7AC0613D9;
        Fri, 27 Aug 2021 14:50:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b10so10509807ioq.9;
        Fri, 27 Aug 2021 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KgsOnOEWi0MydDQEQeoijmzmgKNc1F+KLYNS6ypl+A=;
        b=pHgixE2ebBEB316+s2X4JrzcqBhs+OqSZbzs5UREnQhRwsvyKxglF5MmqM6cLMPsyA
         quXyeg1KwG5P0AitBoTnZ43vRU9FRQsboYhDg1N3KINprdkIbzoNRaRvCWP/81pk6hez
         /Jue7oYOXui1uppyfoo3sECB+Wl/2Lavu0osaiEGXFZmy+6XS+MLKVsanDWZMFAy8GHc
         YHlx5S6LCHUq292jhfJMONk+Jik3a6uijo8O8bnzApZhNSCG/I4FFZy52l90MgN6ZaBG
         ULElUfz+NcWN1CXWcsXnBktInckZDFQFg6i2xHxE44qaviMX72kWDQo8YRVWHpebNBJC
         FnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KgsOnOEWi0MydDQEQeoijmzmgKNc1F+KLYNS6ypl+A=;
        b=UIairHg5qpek1FcPju3MT03K7uYJUPFLrqugiIogtH5R0bXulDpyU+bRgQNaW1Y7I5
         iIwXLtPvpTYELoXLz2QomHUG/9C1EPBgOz+J1UDJbPSfMIbiPKWGmuU435xuXEF44oSV
         gtcWkpRc9POyEonP1sRTgWQRKesnbY29crNDRdU+agw+5V9k/ShhOUKKhkpNZp+FP5WR
         vatVl8xsfIYbx7nC2Ljd7ofE1f+XwRK5a2h1sMLjASsM8qec8oopYK3MLD5+kfJrQ5bc
         P+TY4EthpysoU5ew5NmUeUfab4ltjck3II894YfZHAuti06ZdJuHUi22PFAAhp06SFz1
         zRow==
X-Gm-Message-State: AOAM530mK0RLB6FRtV883BlB3NIomFHYmf0rmL7s8w9k8LrZZjz+TqPQ
        P8m4znb1GZiIBYXccZuCMH+5CGx3sdrpTq2+KzY=
X-Google-Smtp-Source: ABdhPJzJRGOyoNLCUh6UJoKqoQ4Dj1Fl+MXsZg1MLQAg7cot2efKXxtZYUDwPF993DcRv83yJHOc/5bL3LKXA7e/b5o=
X-Received: by 2002:a02:cf05:: with SMTP id q5mr9936733jar.132.1630101004796;
 Fri, 27 Aug 2021 14:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-17-agruenba@redhat.com>
 <20210827183018.GJ12664@magnolia> <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
 <20210827213239.GH12597@magnolia>
In-Reply-To: <20210827213239.GH12597@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:52 +0200
Message-ID: <CAHpGcMKwQCFOGgmA4pQBLNL8Q-uoX2AGBLsW19aRrv0d_UDrcw@mail.gmail.com>
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 27. Aug. 2021 um 23:33 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
> On Fri, Aug 27, 2021 at 10:15:11PM +0200, Andreas Gruenbacher wrote:
> > On Fri, Aug 27, 2021 at 8:30 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > On Fri, Aug 27, 2021 at 06:49:23PM +0200, Andreas Gruenbacher wrote:
> > > > Add a done_before argument to iomap_dio_rw that indicates how much of
> > > > the request has already been transferred.  When the request succeeds, we
> > > > report that done_before additional bytes were tranferred.  This is
> > > > useful for finishing a request asynchronously when part of the request
> > > > has already been completed synchronously.
> > > >
> > > > We'll use that to allow iomap_dio_rw to be used with page faults
> > > > disabled: when a page fault occurs while submitting a request, we
> > > > synchronously complete the part of the request that has already been
> > > > submitted.  The caller can then take care of the page fault and call
> > > > iomap_dio_rw again for the rest of the request, passing in the number of
> > > > bytes already tranferred.
> > > >
> > > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > > ---
> > > >  fs/btrfs/file.c       |  5 +++--
> > > >  fs/ext4/file.c        |  5 +++--
> > > >  fs/gfs2/file.c        |  4 ++--
> > > >  fs/iomap/direct-io.c  | 11 ++++++++---
> > > >  fs/xfs/xfs_file.c     |  6 +++---
> > > >  fs/zonefs/super.c     |  4 ++--
> > > >  include/linux/iomap.h |  4 ++--
> > > >  7 files changed, 23 insertions(+), 16 deletions(-)
> > > >
> > >
> > > <snip to the interesting parts>
> > >
> > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > index ba88fe51b77a..dcf9a2b4381f 100644
> > > > --- a/fs/iomap/direct-io.c
> > > > +++ b/fs/iomap/direct-io.c
> > > > @@ -31,6 +31,7 @@ struct iomap_dio {
> > > >       atomic_t                ref;
> > > >       unsigned                flags;
> > > >       int                     error;
> > > > +     size_t                  done_before;
> > > >       bool                    wait_for_completion;
> > > >
> > > >       union {
> > > > @@ -126,6 +127,9 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> > > >       if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> > > >               ret = generic_write_sync(iocb, ret);
> > > >
> > > > +     if (ret > 0)
> > > > +             ret += dio->done_before;
> > >
> > > Pardon my ignorance since this is the first time I've had a crack at
> > > this patchset, but why is it necessary to carry the "bytes copied"
> > > count from the /previous/ iomap_dio_rw call all the way through to dio
> > > completion of the current call?
> >
> > Consider the following situation:
> >
> >  * A user submits an asynchronous read request.
> >
> >  * The first page of the buffer is in memory, but the following
> >    pages are not. This isn't uncommon for consecutive reads
> >    into freshly allocated memory.
> >
> >  * iomap_dio_rw writes into the first page. Then it
> >    hits the next page which is missing, so it returns a partial
> >    result, synchronously.
> >
> >  * We then fault in the remaining pages and call iomap_dio_rw
> >    for the rest of the request.
> >
> >  * The rest of the request completes asynchronously.
> >
> > Does that answer your question?
>
> No, because you totally ignored the second question:
>
> If the directio operation succeeds even partially and the PARTIAL flag
> is set, won't that push the iov iter ahead by however many bytes
> completed?

Yes, exactly as it should.

> We already finished the IO for the first page, so the second attempt
> should pick up where it left off, i.e. the second page.

Yes, so what's the question?

Thanks,
Andreas
