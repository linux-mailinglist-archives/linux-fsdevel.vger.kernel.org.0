Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067A2214D4F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGEPIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 11:08:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726894AbgGEPIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593961715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ew/OdjOd95BOa3dKjs/VTo1bRUIFHTAarG64/Xhncjs=;
        b=Shsz8lRn2yRDOqpfG+/oDgTNsosY0pyQIu6+9acraUzyNpffGHywwQkxCtc1feDXR9UA1H
        +Jzul8mZkcGVYplwWW4WwLhsHW17BSS+SbSi5zk1nWAnbbNndi8p68bP9/LKvESY11xtoI
        P9BcWNOllj0uBG9tgpy2uA2bTclnAjE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382--UzxtdJHMw-1nTwAQbu_Cg-1; Sun, 05 Jul 2020 11:08:34 -0400
X-MC-Unique: -UzxtdJHMw-1nTwAQbu_Cg-1
Received: by mail-ot1-f72.google.com with SMTP id a3so8103755otf.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2020 08:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew/OdjOd95BOa3dKjs/VTo1bRUIFHTAarG64/Xhncjs=;
        b=CfUhU1nO+ZcMKDccogQK9MiDvsSnJ8d4Ybb5Fz/f0eGTCVHykBfPVUCDZG1BxefB0y
         6QPlaCFQKgP7SX/zp3p//05I6K0gGHS1ojw3mJIQT/+YxYc2cKabHpjZnBhPbKA3GRc3
         iYaSxP4fSuxFmDBlSY/sqU/L9y6PtsqxSvvXWGQNG3rrgVWqSLDpQkpUjKOBUTsOk3sw
         FoVKOsr9axYwNfwxcpYZcZOucmO3t95qba3YRvsCPQ+jn3wLgnh+1vxXfFBW6DLtoIAt
         7gNtBn8KrjYvvZMKDQJE1hNoxi1XrPgAcnn+zinwBmnBhKY6ixflsiyxK/JglAdLHOBF
         g38g==
X-Gm-Message-State: AOAM532QMvnEjpE7oE9oSsmV9O4faTDJve/40Hfvfn8ouR/yZgZUHORJ
        bKLSqkwGUfuhKwgM5tlM7d/scm3OYWjTmwAFW+vxl2iN+nWDL3w5nailKMGd+DcJxip0VRtaqbT
        J7EgJjnqgin1fw33Y918LsZ+nxGTnnlok7qzgOI8UTg==
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr33097430otg.58.1593961713307;
        Sun, 05 Jul 2020 08:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRg3eAq/NtdI3fapt+nPvYFvGVXas6I8K/gwkuEhNAnNsRgfDspzv3RMomr27ExhtxybgWpGD6uUv4bO06Ei4=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr33097413otg.58.1593961713041;
 Sun, 05 Jul 2020 08:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200703095325.1491832-1-agruenba@redhat.com> <20200703095325.1491832-2-agruenba@redhat.com>
 <20200703114108.GE25523@casper.infradead.org>
In-Reply-To: <20200703114108.GE25523@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 5 Jul 2020 17:08:21 +0200
Message-ID: <CAHc6FU7HvPqpBSRQJfbgBgQpjFzYfWfTwq+F-tOUq+-Jc8efQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 1:41 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 03, 2020 at 11:53:24AM +0200, Andreas Gruenbacher wrote:
> > Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> > shouldn't trigger any filesystem I/O for the actual request or for
> > readahead.  This allows to do tentative reads out of the page cache as
> > some filesystems allow, and to take the appropriate locks and retry the
> > reads only if the requested pages are not cached.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> > @@ -2249,9 +2253,18 @@ EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> >   *
> >   * This is the "read_iter()" routine for all filesystems
> >   * that can use the page cache directly.
> > + *
> > + * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall
> > + * be returned when no data can be read without waiting for I/O requests
> > + * to complete; it doesn't prevent readahead.
> > + *
> > + * The IOCB_NOIO flag in iocb->ki_flags indicates that -EAGAIN shall be
> > + * returned when no data can be read without issuing new I/O requests,
> > + * and 0 shall be returned when readhead would have been triggered.
>
> s/shall/may/ -- if we read a previous page then hit a readahead page,
> we'll return a positive value.  If the first page we hit is a readahead
> page, then yes, we'll return zero.

How about this?

 * The IOCB_NOIO flag in iocb->ki_flags indicates that no new I/O
 * requests shall be made for the read or for readahead.  When no data
 * can be read, -EAGAIN shall be returned.  When readahead would be
 * triggered, a short read (possibly of length 0) shall be returned.

> Again, I'm happy for the patch to go in as-is without this nitpick.

Thanks,
Andreas

