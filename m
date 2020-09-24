Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD62774D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgIXPIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgIXPIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:08:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFBC0613CE;
        Thu, 24 Sep 2020 08:08:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a2so3410933otr.11;
        Thu, 24 Sep 2020 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=J3AIUMq4VQ+nwppYrdB2uB5enD/t3MqDWc2lKAgmFJY=;
        b=FOOGXA1xGrIlcQpeEhKQnl5tfp1dHUGTLwLfaIkcmViSdovs5w8iGLA4FO8aADYQpO
         +tGJ0dfXHn++twEaQLENhlku2xY7mXfwOVIL8cx0mAdxknyRsICZ69XsTsQ9X29dJZbr
         Ig2yBrTL3tU5YdLBOBflQ9QjG6kfl5l+QIFUhYMMxWaJeDKd26i2Eh8A3qg+t2OTgAoW
         mbSPYsq7auZnc5lDjmKAXaZE5hN4YLXHKVZRQ+eV0cQXAHFNi6WJBI8sGpSqZA2KHcOq
         +/5HWZRjRXxwdrYTHv3/l9mHT0WXAFlstEsf+OMw6bAz1LXkR60a6PW1Ics0wVrxMsw8
         GdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=J3AIUMq4VQ+nwppYrdB2uB5enD/t3MqDWc2lKAgmFJY=;
        b=HV1dF90TWSO0kD3DMjI6wF+iKdiohym95xlN9wR1ZOXIV2AYurdV6H60OD+ba1/4J3
         a12m8ymijV6ha11wzbyO4hsQn5DR0wUxj9BbV61sADLs9wY8HklSl3HktrEh64kXQ4FN
         UX0ysjS6O5gVsoySNqXF1StKktDX7GvIigY23X7Swih/Bn5KrXiceMDhKxMQwcKFiiHX
         DR+F9s4BK0R8bZqmAfliJ8To49GIHEm+JipNTfRqbVgx3IzL5y1NOsxPLOh1RoSz44WY
         B8ugzSrdIRiKoXbDXW273b5RvlU26JnK84I8ksfpTuEjno/BVbCiAo63zc2UUy+vsTKD
         8JCQ==
X-Gm-Message-State: AOAM530OzHLBkaAHRtvTSzeGaff0+4AGjEVEMIzScg+8hYRc2cD4Xnqg
        dmGi3l7ponZAg+/hhzlPvLaOkbaxmtkQPzZBPQE=
X-Google-Smtp-Source: ABdhPJxqFhKvbqhXlcRJkEiOD+2fdLca+JkjGwGiGHlXfP0JYNeHoti4pUHwNODViwZ7ySnPgZrhF/DwZlULPIHF7eY=
X-Received: by 2002:a05:6830:13da:: with SMTP id e26mr102413otq.28.1600960094920;
 Thu, 24 Sep 2020 08:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200924125608.31231-1-willy@infradead.org>
In-Reply-To: <20200924125608.31231-1-willy@infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 24 Sep 2020 17:08:03 +0200
Message-ID: <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 2:58 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
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

This commit is also in Linux v5.9-rc6+ but does not cleanly apply.
Against which Git tree is this patch?
When Linux v5.9-rc6+ is affected, do you have a backport?

- Sedat -

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Qian Cai <cai@redhat.com>
> Cc: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8b6cca7e34e4..8180061b9e16 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -60,6 +60,8 @@ iomap_page_create(struct inode *inode, struct page *page)
>         iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
>                         GFP_NOFS | __GFP_NOFAIL);
>         spin_lock_init(&iop->uptodate_lock);
> +       if (PageUptodate(page))
> +               bitmap_fill(iop->uptodate, nr_blocks);
>         attach_page_private(page, iop);
>         return iop;
>  }
> --
> 2.28.0
>
