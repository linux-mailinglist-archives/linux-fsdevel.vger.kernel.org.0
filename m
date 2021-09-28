Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736E41B29A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbhI1PHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 11:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241387AbhI1PHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632841560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTEeKi/UYmjYJkWNK0SGATQ/qYJFiOXPZZXq8sMSFeY=;
        b=M8+Joa+r6ouQ2sfjRmyjodtn5gJZgRJmXTDdx9McHeexvxiE11mljtk1g8yfxYuAoTXDWT
        4DWWf91s1hyueR9munn5FAM3wnK7FmxskmivrMAywxfwXZG1B23POIFG5Mh0LZO3DEufbJ
        q2BM23kA7/PjnJoiug0nloIx8jtIH88=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-w6tYGkp_ML2X4XjdeXcy8Q-1; Tue, 28 Sep 2021 11:05:58 -0400
X-MC-Unique: w6tYGkp_ML2X4XjdeXcy8Q-1
Received: by mail-wm1-f71.google.com with SMTP id p25-20020a1c5459000000b0030cac3d9db1so2165878wmi.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 08:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTEeKi/UYmjYJkWNK0SGATQ/qYJFiOXPZZXq8sMSFeY=;
        b=Bddyoa8yb+2i8BTneFMQhY2Cj8zLlxF5J0nfzBPil3kuEttjmQGEUg5KNta48va6Fu
         qTwWsyfJLzt3Q85/LDBJkUlSz7AjXsakkRJ3+hus+wudXrfriElfGkCP9NygPi1UdQBR
         6+tdNESltr0HW8WTv3MT1hBFKMu7F++uht3VJbU8cW/ykYlw3m9oFtEnfIISIOvaTkRR
         d5F4gCdM03RpmBxm2Yq7gE2e+d09n2AZF5knNGLUmZyuXzi/uNkdEWFiRC029dsunxak
         2tqAqgbpm6OpaqgrNzsigUT3s+Az90xOkAH4aKFDfmJBfhNQO+f1PQTG9tZFGBDIyscg
         X/UQ==
X-Gm-Message-State: AOAM533g3/8Aiq9lIN8WMIP03u8opKjWDixHo3GcLKkFO1vbJ+eNG/Fk
        sAEWeJiNSmDOdumA9avQd92Fsxa3+VPJbQu1GmTLgIgddy9hvRgkXuZwvidsnrhqNIhbAyVqD1V
        9Wky64vaDPh2/VpgYiHAdugSHbW97WhU7L0bNnpGbyA==
X-Received: by 2002:a1c:192:: with SMTP id 140mr5194535wmb.186.1632841557831;
        Tue, 28 Sep 2021 08:05:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45bDVa7yHh7ZlDdOqmKGhDvsP9wWie0zsYCjSZRICnWeTnJ+JMvq9BqN1jrAgmwTyXD/iZRUEiGUwLJEUR9A=
X-Received: by 2002:a1c:192:: with SMTP id 140mr5194517wmb.186.1632841557678;
 Tue, 28 Sep 2021 08:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-16-agruenba@redhat.com>
 <YTnuDhNlSN1Ie1MJ@infradead.org>
In-Reply-To: <YTnuDhNlSN1Ie1MJ@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Sep 2021 17:05:46 +0200
Message-ID: <CAHc6FU4_3m-f2T360Vq-WF=nkqDq9Zc+dekRt+wrcjvbUR1oSQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/19] iomap: Support partial direct I/O on user copy failures
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:22 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Aug 27, 2021 at 06:49:22PM +0200, Andreas Gruenbacher wrote:
> > In iomap_dio_rw, when iomap_apply returns an -EFAULT error and the
> > IOMAP_DIO_PARTIAL flag is set, complete the request synchronously and
> > return a partial result.  This allows the caller to deal with the page
> > fault and retry the remainder of the request.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/direct-io.c  | 6 ++++++
> >  include/linux/iomap.h | 7 +++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 8054f5d6c273..ba88fe51b77a 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -561,6 +561,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >               ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
> >                               iomap_dio_actor);
> >               if (ret <= 0) {
> > +                     if (ret == -EFAULT && dio->size &&
> > +                         (dio_flags & IOMAP_DIO_PARTIAL)) {
> > +                             wait_for_completion = true;
> > +                             ret = 0;
>
> Do we need a NOWAIT check here to skip the wait_for_completion
> for that case?

Hmm, you're probably right, yes. I'll add that.

Thanks,
Andreas

