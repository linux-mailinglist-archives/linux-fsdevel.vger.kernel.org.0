Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4725CCA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 23:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgICVsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 17:48:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728705AbgICVsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599169681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBrynNccaVwKMAHtYaWvrpJ0iV4f205Vo+3SkjyLb1M=;
        b=Ap0hSm4ZRbCZPPb8HnHArfmsdOXCL9IO6L6wTkTdN9yQzhPEEkuOD+W047pnvsUjSn/lcb
        Jl3/EMs9Jxrx9NqsR+GSl0m2McY2bEoAkM3PGhmnReKfoKp2Npdl35N/whFX2c3PqAcpWt
        0gTHA7TLG/MC9UYysdLtHNhAgtcdaeY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-Hi1bGjoKM4WAW-nqWJHYbw-1; Thu, 03 Sep 2020 17:47:57 -0400
X-MC-Unique: Hi1bGjoKM4WAW-nqWJHYbw-1
Received: by mail-wr1-f70.google.com with SMTP id 3so1564672wrm.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2020 14:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBrynNccaVwKMAHtYaWvrpJ0iV4f205Vo+3SkjyLb1M=;
        b=kw/NDRPVIjLaJwBxJ+uA9KRc/OmCG2KAh5BT/7JLbLOt5PyQZRkyDw4VEuc3GD3rtu
         LzLrrGfQyC7GZZ4s1CzgVIyG/juTE9N0KWx3JMs045MskrI/x98eR4JYYsTcYBT4rd6C
         N3QoQTwSxxIEYXLnL+amHDKPzfMxmQJJs+ahgy4GRuEIKodGgxSwH9+5XDVqHsPDuBjM
         ym+c4asELkDLOb4/WS7379xLWgT+/LLYg929m5m6qnfMJigNGzuXDuiYixqve3CVP9l1
         +J3Im9tX1zYe/Q2IROuz45Eicv0I0Vp68FyCgp43QUGtnEgbcm3SH8Ja1jutBSfxmjUz
         T2zw==
X-Gm-Message-State: AOAM531hobmhoDUwQppQr50fYqpWjYqt6zUUxX7MQZGU1js45qJlTb60
        u0kjwe3DrGTGBWVvWIBRwGwGUDizT2zyk1k5R1HSUoCoqYoXvEy2l49h8X5rHzzuzHfqc08/Vq2
        x8ZG+D3wl9o6dAEYj3neUjDi+kystoyvm4EKi9KAOOQ==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr4395613wmh.152.1599169676209;
        Thu, 03 Sep 2020 14:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfurQNCgokDtRoLPRuHgAybZLnKZ8B+2PgntmWzIP1k1DncX3kyUDbDZW6vrGvGz+eL5DynJVwhOUzgUE9+X8=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr4395604wmh.152.1599169676019;
 Thu, 03 Sep 2020 14:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200903165632.1338996-1-agruenba@redhat.com> <695a418c-ba6d-d3e9-f521-7dfa059764db@sandeen.net>
In-Reply-To: <695a418c-ba6d-d3e9-f521-7dfa059764db@sandeen.net>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 3 Sep 2020 23:47:44 +0200
Message-ID: <CAHc6FU5zwQTBaGVban6tCH7kNwr+NiW-_oKC1j0vmqbWAWx50g@mail.gmail.com>
Subject: Re: [PATCH] iomap: Fix direct I/O write consistency check
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:12 PM Eric Sandeen <sandeen@sandeen.net> wrote:
> On 9/3/20 11:56 AM, Andreas Gruenbacher wrote:
> > When a direct I/O write falls back to buffered I/O entirely, dio->size
> > will be 0 in iomap_dio_complete.  Function invalidate_inode_pages2_range
> > will try to invalidate the rest of the address space.
>
> (Because if ->size == 0 and offset == 0, then invalidating up to (0+0-1) will
> invalidate the entire range.)
>
>
>                 err = invalidate_inode_pages2_range(inode->i_mapping,
>                                 offset >> PAGE_SHIFT,
>                                 (offset + dio->size - 1) >> PAGE_SHIFT);
>
> so I guess this behavior is unique to writing to a hole at offset 0?
>
> FWIW, this same test yields the same results on ext3 when it falls back to
> buffered.

That's interesting. An ext3 formatted filesystem will invoke
dio_warn_stale_pagecache and thus log the error message, but the error
isn't immediately reported by the "pwrite 0 4k". It takes adding '-c
"fsync"' to the xfs_io command or similar to make it fail.

An ext4 formatted filesystem doesn't show any of these problems.

Thanks,
Andreas

> -Eric
>
> > If there are any
> > dirty pages in that range, the write will fail and a "Page cache
> > invalidation failure on direct I/O" error will be logged.
> >
> > On gfs2, this can be reproduced as follows:
> >
> >   xfs_io \
> >     -c "open -ft foo" -c "pwrite 4k 4k" -c "close" \
> >     -c "open -d foo" -c "pwrite 0 4k"
> >
> > Fix this by recognizing 0-length writes.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/direct-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index c1aafb2ab990..c9d6b4eecdb7 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -108,7 +108,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >        * ->end_io() when necessary, otherwise a racing buffer read would cache
> >        * zeros from unwritten extents.
> >        */
> > -     if (!dio->error &&
> > +     if (!dio->error && dio->size &&
> >           (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
> >               int err;
> >               err = invalidate_inode_pages2_range(inode->i_mapping,
> >
>

