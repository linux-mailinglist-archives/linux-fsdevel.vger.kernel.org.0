Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7764E23A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 21:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLOUOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 15:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLOUOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989430F71
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671135244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SAnb8xM8pzY328qotBad3LRnalliWFM+XFPh7Dppkw=;
        b=iDb/pL5ePJG4trr7MqQMDUZbs4EmD+kwBxd+pCCy5/YM/WTB51EwlV8A95JpGB8faV5S/8
        XkGnq8nfxZGjKmPJuscOiOxh/8cOO5nSIXQLdd8nzQlKGgFPk4dOokO62IrB/7MTpzNF3W
        f9TpENA2e9dpV/QyTGehsE2XFSkn5Z0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659--cR2oq0eNWKRh7tB7HJGLA-1; Thu, 15 Dec 2022 15:14:03 -0500
X-MC-Unique: -cR2oq0eNWKRh7tB7HJGLA-1
Received: by mail-yb1-f199.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so13958ybc.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 12:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SAnb8xM8pzY328qotBad3LRnalliWFM+XFPh7Dppkw=;
        b=F0hYhpqFCapet26j1TQEuWxlQeuWNwOKB86kiKQdPazNWIoxBg19FkI2reTyPyyPgl
         iYQm5DkrFoWPCxG8xfg8zaahcH+W4ts+KfDN76Q/JRvf6DBqtyi2tI1z54cao6lbGsX/
         7oMKLQlsp2u/+qmfntPRH3ju2rEHfjXHnFXH9KCLfBoQSU5P2jbBOFMO334p3k5uI0rF
         inFrF8obeXz4qihFqfxzP6DDme2PjRQFTjmkmzh0YIl1kQJxRZ2A6GyjTbDR0xoXb9p0
         +kxnwY03OXeX/9VJIhkS8GZh3Vc1GjgFrskVM1dxWHuCyMAsnMmhLFmA2nLKGf3rxdzj
         iThg==
X-Gm-Message-State: ANoB5pmn0BHcgtPvdLhVYmTTdZY/VFSEhyeQKCz0f8GTvJQjQyckJG9E
        YQtwJFysfevrpyYRunWFd+5Jsw6MKfF5j8RdWXIpdyFa8LhQdmgnv/N04U4cNIliywljx8idi1h
        T1QanPdKoMGicpx6WiR2+ph59Epto0gl0BcLKzpRdog==
X-Received: by 2002:a25:5d5:0:b0:6f9:5e19:4729 with SMTP id 204-20020a2505d5000000b006f95e194729mr43103238ybf.311.1671135242060;
        Thu, 15 Dec 2022 12:14:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6J2MzYzMecMxwHefxxY6C66d+L8mAnjoVE3bvCq16qlNYB82xOiMyGxoxXsR3gvnJDlvCwzqfKxxd1HTPgniE=
X-Received: by 2002:a25:5d5:0:b0:6f9:5e19:4729 with SMTP id
 204-20020a2505d5000000b006f95e194729mr43103232ybf.311.1671135241744; Thu, 15
 Dec 2022 12:14:01 -0800 (PST)
MIME-Version: 1.0
References: <Y5l9zhhyOE+RNVgO@infradead.org> <20221214102409.1857526-1-agruenba@redhat.com>
In-Reply-To: <20221214102409.1857526-1-agruenba@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 15 Dec 2022 21:13:50 +0100
Message-ID: <CAHc6FU7pgH+nLS_0WFx8aFBenKtNy0z6DBiyAUSdjix0t57t5g@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: Move page_done callback under the folio lock
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:24 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Move the ->page_done() call in iomap_write_end() under the folio lock.
> This closes a race between journaled data writes and the shrinker in
> gfs2.  What's happening is that gfs2_iomap_page_done() is called after
> the page has been unlocked, so try_to_free_buffers() can come in and
> free the buffers while gfs2_iomap_page_done() is trying to add them to
> the current transaction.  The folio lock prevents that from happening.
>
> The only current user of ->page_done() is gfs2, so other filesystems are
> not affected.  Still, to catch out any new users, switch from page to
> folio in ->page_done().
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/bmap.c         |  7 ++++---
>  fs/iomap/buffered-io.c |  4 ++--
>  include/linux/iomap.h  | 10 +++++-----
>  3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index e7537fd305dd..c4ee47f8e499 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -968,14 +968,15 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
>  }
>
>  static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> -                                unsigned copied, struct page *page)
> +                                unsigned copied, struct folio *folio)
>  {
>         struct gfs2_trans *tr = current->journal_info;
>         struct gfs2_inode *ip = GFS2_I(inode);
>         struct gfs2_sbd *sdp = GFS2_SB(inode);
>
> -       if (page && !gfs2_is_stuffed(ip))
> -               gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
> +       if (folio && !gfs2_is_stuffed(ip))
> +               gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
> +                                      copied);
>
>         if (tr->tr_num_buf_new)
>                 __mark_inode_dirty(inode, I_DIRTY_DATASYNC);

This is still screwed up. We really need to unlock the page before
calling into __mark_inode_dirty() and ending the transaction. The
current page_done() hook would force us to then re-lock the page just
so that the caller can unlock it again. This just doesn't make sense,
particularly since the page_prepare and page_done hooks only exist to
allow gfs2 to do data journaling via iomap. I'll follow up with a more
useful approach ...

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 91ee0b308e13..d988c1bedf70 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -714,12 +714,12 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>                 i_size_write(iter->inode, pos + ret);
>                 iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>         }
> +       if (page_ops && page_ops->page_done)
> +               page_ops->page_done(iter->inode, pos, ret, folio);
>         folio_unlock(folio);
>
>         if (old_size < pos)
>                 pagecache_isize_extended(iter->inode, old_size, pos);
> -       if (page_ops && page_ops->page_done)
> -               page_ops->page_done(iter->inode, pos, ret, &folio->page);
>         folio_put(folio);
>
>         if (ret < len)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 238a03087e17..bd6d80453726 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -116,18 +116,18 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> - * and page_done will be called for each page written to.  This only applies to
> - * buffered writes as unbuffered writes will not typically have pages
> + * and page_done will be called for each folio written to.  This only applies
> + * to buffered writes as unbuffered writes will not typically have folios
>   * associated with them.
>   *
>   * When page_prepare succeeds, page_done will always be called to do any
> - * cleanup work necessary.  In that page_done call, @page will be NULL if the
> - * associated page could not be obtained.
> + * cleanup work necessary.  In that page_done call, @folio will be NULL if the
> + * associated folio could not be obtained.
>   */
>  struct iomap_page_ops {
>         int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
>         void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
> -                       struct page *page);
> +                       struct folio *folio);
>  };
>
>  /*
> --
> 2.38.1
>

