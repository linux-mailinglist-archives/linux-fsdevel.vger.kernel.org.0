Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA227277519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgIXPVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgIXPVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:21:12 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E92C0613CE;
        Thu, 24 Sep 2020 08:21:12 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m7so4079371oie.0;
        Thu, 24 Sep 2020 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=1MhhyAb3Zs9iqnyKneq5mLo3yN5aMshA7gDAjSn6VmA=;
        b=Pbk2A+1sbKiLwBrc5SfzYZ+MtfjnKf9U77Ei0ALqAv8Uo9Q7dSK639pK4uRlMGLDu0
         ORt0Bn0PLrtE6ANJVQ/kvhpfeBn1p5rfpiavWR9+I6XLEamkMZbWJQ9PCCmOjZVLAXBN
         nW+mIC/On0h2RhhxXVi6AEqg1CwHcS9nWPl/3KI3flcw/gVKxMjOPUssxBd3RA3zRQIz
         2JPL122Km7kdxoi904taKlRtEDUqDjARP+061FS/fqbx/mpsq5FhqqaGsyDLYzXIMlLl
         FUE6ZgC6t4Zpaa0X5KCbwUU4WO5GTb4r4aQUZYMQ/CUcjeaWiWqJn42DMpkng75xsxum
         Pqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=1MhhyAb3Zs9iqnyKneq5mLo3yN5aMshA7gDAjSn6VmA=;
        b=ulkAg59AKBFVTNtv8qeJ9saAZVOWkKW5qfg9izI5W7tytcjWwWv0noz9IW5I6E3ySW
         dI5VEtUEH46HSyfkSCIOr3j4rPCzjv8oq6fJB/z89djFG9TCX+dL8LoGssZ6M7PabgR3
         9WP77uBtbg7dgnGXohymFUaLMCX0lHkMh5Cs+B9lDjXh2X9RdW8V7YAouT98kuPuEJdO
         MIuiGB9yFIOYSxlBj2aeeMNDFSW1VDGs/+LW2TByW4pL69L0Xy11J1fqtkJe8rGaIIjn
         2zOV/H5yzzMvq8RZO59wyvQf3pIF8zhjuYZYcfnCVxGDvuO7rY3x1LjgCEGAsP0Ei2Ot
         72ag==
X-Gm-Message-State: AOAM533aI1hOvphLgnCE7TpV0XC1Ilh1ZpWdTId4aCWdKXUodX9cCwCB
        oKttm/X5gqE9M9KctfH2gDN6f/lT7UenTzW/9SW3WeGPVCuZkA==
X-Google-Smtp-Source: ABdhPJxAXLM5Nu/qbzAEi0a1lwd9O/Ix4cgK2gzKoJSejXoRu1aRnuXfckOIDYlsisXB3uZoZ5pVOQ1tdeeSxsdeTQY=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr2781387oih.35.1600960871869;
 Thu, 24 Sep 2020 08:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200924125608.31231-1-willy@infradead.org> <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
 <20200924151538.GW32101@casper.infradead.org>
In-Reply-To: <20200924151538.GW32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 24 Sep 2020 17:21:00 +0200
Message-ID: <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 5:15 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 24, 2020 at 05:08:03PM +0200, Sedat Dilek wrote:
> > On Thu, Sep 24, 2020 at 2:58 PM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > For filesystems with block size < page size, we need to set all the
> > > per-block uptodate bits if the page was already uptodate at the time
> > > we create the per-block metadata.  This can happen if the page is
> > > invalidated (eg by a write to drop_caches) but ultimately not removed
> > > from the page cache.
> > >
> > > This is a data corruption issue as page writeback skips blocks which
> > > are marked !uptodate.
> > >
> > > Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> >
> > This commit is also in Linux v5.9-rc6+ but does not cleanly apply.
> > Against which Git tree is this patch?
> > When Linux v5.9-rc6+ is affected, do you have a backport?
>
> This applies to v5.8.  I'll happily backport this for any other kernel
> versions.
>
> From 51f85a97ccdd7071e5f95b2ac4e41c12bf4d4176 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Thu, 24 Sep 2020 08:44:56 -0400
> Subject: [PATCH] iomap: Set all uptodate bits for an Uptodate page
>
> For filesystems with block size < page size, we need to set all the
> per-block uptodate bits if the page was already uptodate at the time
> we create the per-block metadata.  This can happen if the page is
> invalidated (eg by a write to drop_caches) but ultimately not removed
> from the page cache.
>
> This is a data corruption issue as page writeback skips blocks which
> are marked !uptodate.
>
> Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Qian Cai <cai@redhat.com>
> Cc: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..810f7dae11d9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -53,7 +53,10 @@ iomap_page_create(struct inode *inode, struct page *page)
>         atomic_set(&iop->read_count, 0);
>         atomic_set(&iop->write_count, 0);
>         spin_lock_init(&iop->uptodate_lock);
> -       bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> +       if (PageUptodate(page))
> +               bitmap_fill(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> +       else
> +               bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
>
>         /*
>          * migrate_page_move_mapping() assumes that pages with private data have
> --
> 2.28.0
>

Great and thanks.

Can you send out a seperate patch and label it with "PATCH v5.9"?
I run:
$ git format-patch -1 --subject-prefix="PATCH v5.9" --signoff

Normally, I catch patches from any patchwork URL in mbox format.

Thanks.

- Sedat -

[1] https://patchwork.kernel.org/project/linux-fsdevel/list/
[2] https://patchwork.kernel.org/patch/11797229/ <--- XXX: [ PATCH v5.8 ]
