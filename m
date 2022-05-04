Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E896F51AC2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376260AbiEDSGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359846AbiEDSGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27D3A5044E
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651684916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9A/JxfDphEFRK9OqQKOMXsWhEjsMhB8rG/XvbinFZU=;
        b=e7xnM/6LoJ3Txo/bLMJU22Gn/qKxVg1KRhRSYgWhuVB1alQA8ZLnOLPdtvCdrDn9pahLGb
        ZicptfVDijhgP4SxaNDj7xQqc9ed6hFC5HGe0xSzYYWWUT2AGBClCrhWy3Ct23n3Zna0Bi
        URuB9pUbvZQrN9ks1uGzF6rOZoUCNZw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-4XPObAYINKmVH6JX4K0aSg-1; Wed, 04 May 2022 13:21:55 -0400
X-MC-Unique: 4XPObAYINKmVH6JX4K0aSg-1
Received: by mail-lf1-f72.google.com with SMTP id a13-20020a19ca0d000000b0047233f64994so863556lfg.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 10:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9A/JxfDphEFRK9OqQKOMXsWhEjsMhB8rG/XvbinFZU=;
        b=3vomt/aak3TJp7aW8JkS9bCLEce1R+R2/NEXGJrp+BuszVzY+JLi58va3q1znwlIqy
         1lrBQFsHTzfbFQrwGMPKXWxLvyp2IMi/SCxVNvb0aC3d71EFeiiXNXCSfhlcSWQEP7Wl
         Q6sEdcr03R8h8/o9BKX/BgM6Be2SMAivS6izFrfzbQ12ndxd1wDAKHwPhp7WobeKKBc/
         ZjRwwhnbnCe88fyFhI/zdhgKVPh+GPKe3LSt6SPBWZekpAFzXnJ2ua/VxbEmCmNS6wmZ
         nO2Fldf/hXkAqInazw7rGdFsstKhfhqhPA4MB2Dnhj0+fA+zZRUclg/PD2nND4yu2ODJ
         a1Wg==
X-Gm-Message-State: AOAM5300LILs09q4E1lHcW9e2KMXqJ8qEaYouIjYsxCjaJravpmtFMMP
        TeocaNi1h7UqmTsE2Iap6twudLWaxw83P+PKAueJBDxQCP8z66s+T8yyPVs0zSK2j2U2CQNQbo8
        KGxcV5nQo11QbaenyGzdo6k9MvXGWDiKe8ilJFqzZOg==
X-Received: by 2002:a05:651c:215:b0:250:61f7:562 with SMTP id y21-20020a05651c021500b0025061f70562mr6386658ljn.437.1651684913293;
        Wed, 04 May 2022 10:21:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhw3gb5v/mEPKh7r8VwTipBuMAB0N+L8Xe+ybr+CLWdmUu9tAw3sH4a+Eq71qNR2A2iRLDgP2nnyXO3MfJFR4=
X-Received: by 2002:a5d:5547:0:b0:20c:7a44:d8e7 with SMTP id
 g7-20020a5d5547000000b0020c7a44d8e7mr5734255wrw.349.1651684902709; Wed, 04
 May 2022 10:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220503213727.3273873-1-agruenba@redhat.com> <YnGkO9zpuzahiI0F@casper.infradead.org>
 <CAHc6FU5_JTi+RJxYwa+CLc9tx_3_CS8_r8DjkEiYRhyjUvbFww@mail.gmail.com>
 <20220503230226.GK8265@magnolia> <YnHIeHuAXr6WCk7M@casper.infradead.org> <YnKMFNtBshOa1eWs@infradead.org>
In-Reply-To: <YnKMFNtBshOa1eWs@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 4 May 2022 19:21:31 +0200
Message-ID: <CAHc6FU4psuQKXgueM6wH9pPMho+J1Rr2Xpbxx16N6fpX0FuJvw@mail.gmail.com>
Subject: Re: [PATCH] iomap: iomap_write_end cleanup
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 4, 2022 at 4:22 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, May 04, 2022 at 01:27:36AM +0100, Matthew Wilcox wrote:
> > This is one of the things I noticed when folioising iomap and didn't
> > get round to cleaning up, but I feel like we should change the calling
> > convention here to bool (true = success, false = fail).  Changing
> > block_write_end() might not be on the cards, unless someone's really
> > motivated, but we can at least change iomap_write_end() to not have this
> > stupid calling convention.
>
> I kinda hate the bools for something that is not a simple
>
>         if (foo()))
>                 return;
>
> as propagating them is a bit of a mess.  I do however thing that
> switching to 0 / -errno might work nicely here, completely untested
> patch below:

This doesn't really strike me as better, just different.

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8bc0989cf447fa..764174e2f1a183 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -685,13 +685,13 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>          * redo the whole thing.
>          */
>         if (unlikely(copied < len && !folio_test_uptodate(folio)))
> -               return 0;
> +               return -EIO;
>         iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
>         filemap_dirty_folio(inode->i_mapping, folio);
> -       return copied;
> +       return 0;
>  }
>
> -static size_t iomap_write_end_inline(const struct iomap_iter *iter,
> +static void iomap_write_end_inline(const struct iomap_iter *iter,
>                 struct folio *folio, loff_t pos, size_t copied)
>  {
>         const struct iomap *iomap = &iter->iomap;
> @@ -706,23 +706,22 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
>         kunmap_local(addr);
>
>         mark_inode_dirty(iter->inode);
> -       return copied;
>  }
>
> -/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> -static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> +static int iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>                 size_t copied, struct folio *folio)
>  {
>         const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>         const struct iomap *srcmap = iomap_iter_srcmap(iter);
>         loff_t old_size = iter->inode->i_size;
> -       size_t ret;
> +       int ret = 0;
>
>         if (srcmap->type == IOMAP_INLINE) {
> -               ret = iomap_write_end_inline(iter, folio, pos, copied);
> +               iomap_write_end_inline(iter, folio, pos, copied);
>         } else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> -               ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> -                               copied, &folio->page, NULL);
> +               if (block_write_end(NULL, iter->inode->i_mapping, pos, len,
> +                                   copied, &folio->page, NULL) < len)
> +                       ret = -EIO;
>         } else {
>                 ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
>         }
> @@ -732,8 +731,8 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>          * cache.  It's up to the file system to write the updated size to disk,
>          * preferably after I/O completion so that no stale data is exposed.
>          */
> -       if (pos + ret > old_size) {
> -               i_size_write(iter->inode, pos + ret);
> +       if (!ret && pos + len > old_size) {
> +               i_size_write(iter->inode, pos + len);
>                 iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>         }
>         folio_unlock(folio);
> @@ -741,10 +740,11 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>         if (old_size < pos)
>                 pagecache_isize_extended(iter->inode, old_size, pos);
>         if (page_ops && page_ops->page_done)
> -               page_ops->page_done(iter->inode, pos, ret, &folio->page);
> +               page_ops->page_done(iter->inode, pos, ret ? ret : len,
> +                                   &folio->page);
>         folio_put(folio);
>
> -       if (ret < len)
> +       if (ret)
>                 iomap_write_failed(iter->inode, pos, len);
>         return ret;
>  }
> @@ -754,7 +754,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>         loff_t length = iomap_length(iter);
>         loff_t pos = iter->pos;
>         ssize_t written = 0;
> -       long status = 0;
> +       int status = 0;
>
>         do {
>                 struct folio *folio;
> @@ -792,26 +792,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>                 copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>
>                 status = iomap_write_end(iter, pos, bytes, copied, folio);
> -
> -               if (unlikely(copied != status))
> -                       iov_iter_revert(i, copied - status);
> -
> -               cond_resched();
> -               if (unlikely(status == 0)) {
> +               if (unlikely(status)) {
>                         /*
>                          * A short copy made iomap_write_end() reject the
>                          * thing entirely.  Might be memory poisoning
>                          * halfway through, might be a race with munmap,
>                          * might be severe memory pressure.
>                          */
> -                       if (copied)
> +                       if (copied) {
> +                               iov_iter_revert(i, copied);
>                                 bytes = copied;
> +                       }
>                         goto again;
>                 }
> -               pos += status;
> -               written += status;
> -               length -= status;
> +               pos += bytes;
> +               written += bytes;
> +               length -= bytes;

Ought to turn 'status' into 'copied' here, not 'bytes'.

>
> +               cond_resched();
>                 balance_dirty_pages_ratelimited(iter->inode->i_mapping);
>         } while (iov_iter_count(i) && length);
>
> @@ -844,7 +842,6 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>         const struct iomap *srcmap = iomap_iter_srcmap(iter);
>         loff_t pos = iter->pos;
>         loff_t length = iomap_length(iter);
> -       long status = 0;
>         loff_t written = 0;
>
>         /* don't bother with blocks that are not shared to start with */
> @@ -858,20 +855,21 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>                 unsigned long offset = offset_in_page(pos);
>                 unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>                 struct folio *folio;
> +               int status;
>
>                 status = iomap_write_begin(iter, pos, bytes, &folio);
>                 if (unlikely(status))
>                         return status;
>
>                 status = iomap_write_end(iter, pos, bytes, bytes, folio);
> -               if (WARN_ON_ONCE(status == 0))
> -                       return -EIO;
> +               if (WARN_ON_ONCE(status))
> +                       return status;
>
>                 cond_resched();
>
> -               pos += status;
> -               written += status;
> -               length -= status;
> +               pos += bytes;
> +               written += bytes;
> +               length -= bytes;
>
>                 balance_dirty_pages_ratelimited(iter->inode->i_mapping);
>         } while (length);
> @@ -925,9 +923,9 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>                 folio_zero_range(folio, offset, bytes);
>                 folio_mark_accessed(folio);
>
> -               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> -               if (WARN_ON_ONCE(bytes == 0))
> -                       return -EIO;
> +               status = iomap_write_end(iter, pos, bytes, bytes, folio);
> +               if (WARN_ON_ONCE(status))
> +                       return status;
>
>                 pos += bytes;
>                 length -= bytes;
>

Thanks,
Andreas

