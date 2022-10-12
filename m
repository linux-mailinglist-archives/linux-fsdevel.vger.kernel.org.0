Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDA5FC8D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJLQCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJLQCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:02:49 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B47D7E00;
        Wed, 12 Oct 2022 09:02:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id n74so20508478yba.11;
        Wed, 12 Oct 2022 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asbHjkVq5tGvEOMEjV9ZiHWtFmPxbiR4kRuKse54pkE=;
        b=GJCkUj45ysR5PWKAoFVSiykTGzMPnLo7iIm8PQBiKkSGIpAoY8z3lLZ7VqcT3Q/4DE
         Rx9e1c8nASOlA9vhaSUFnpuZofVkB2rBNxaVDUcpzQNGm8zaVuok6R2L6NcyptC+Rw5C
         l0QW3g+F2e5dCyMe48zNt+Nh5FbWtFm6V/rpC0yAQ0EOJzdcKsaCprhr8gXxNr6354pX
         r3TLirMhw4R95vm9CbnKmFlb9j+kN9yYSyg9FkMRxEn7oJdM+JeAQIDm0VeNmHAzgUOJ
         2xpKoUhiDEa4OSXc6UKNG1SijFamYZcMSdml0A15iuQ9r55XPMHGV+URaTpuRm8k0vEf
         Kt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asbHjkVq5tGvEOMEjV9ZiHWtFmPxbiR4kRuKse54pkE=;
        b=FpO+jX+eU8Ndk1ngoJ7SitzACLrUsC0Zp4c9XgCHV+ScnbmtsFf6d/2/0hXz0+aC7g
         tmD91nkJzGnUid2hw5kJP1zQIhgkYg412A6G85pmyw5Sqa4+lilnnQALYeBssvbA8OhS
         WBnuAamsvZR1wiqQM5ByCEHU3MNFH8UE0OdKol+ufFE7FhScm7VkLOAyPBvmEbJGkwhw
         pUZkpGzNy3oE1KK0pSJ0GfzDTe3YvI8A1tGda0icH+2BIBVw4qOJM0IjCH660U1az7A4
         MiJL6m/sNwoU6hK2mT2BnEw0A+sNjhDTlL7L/rmvm/yaAoD0WqAJMG9Gk03VBjpjyq4Q
         qxXQ==
X-Gm-Message-State: ACrzQf1kofJmkBHsmnmBz96mzJzAemwwEvV8hvo6X5XN677L7gDqfckS
        uWGQ6I0hxu155Pj5r9Xx/Tv0I6IZiQzOnNayGFE=
X-Google-Smtp-Source: AMsMyM47Z2EbVh2iAoH30O/3krbN+Ms479nxBxsgawEUtxRwaa8PQ5hRU6FGwSZQr1W5HWSzIoghIof7HdTQwu72lcQ=
X-Received: by 2002:a05:6902:150b:b0:6bf:4752:eeb1 with SMTP id
 q11-20020a056902150b00b006bf4752eeb1mr25996044ybu.323.1665590567936; Wed, 12
 Oct 2022 09:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221011215634.478330-1-vishal.moola@gmail.com>
 <20221011215634.478330-2-vishal.moola@gmail.com> <Y0YiEon0G3b/00dG@casper.infradead.org>
In-Reply-To: <Y0YiEon0G3b/00dG@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 12 Oct 2022 09:02:36 -0700
Message-ID: <CAOzc2pyZ9qHzEmNzYXjUu93wRpmW4af_e0eG=_AvNMzjU_V=CA@mail.gmail.com>
Subject: Re: [PATCH 1/4] filemap: find_lock_entries() now updates start offset
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 7:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 11, 2022 at 02:56:31PM -0700, Vishal Moola (Oracle) wrote:
> > @@ -2116,7 +2118,16 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
> >               folio_put(folio);
> >       }
> >       rcu_read_unlock();
> > +     nr = folio_batch_count(fbatch);
> > +
> > +     if (nr) {
> > +             folio = fbatch->folios[nr - 1];
> > +             nr = folio_nr_pages(folio);
> >
> > +             if (folio_test_hugetlb(folio))
> > +                     nr = 1;
> > +             *start = folio->index + nr;
> > +     }
>
> Hmm ... this is going to go wrong if the folio is actually a shadow
> entry, isn't it?

You're right! I missed that.

> > +++ b/mm/shmem.c
> > @@ -922,21 +922,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> >
> >       folio_batch_init(&fbatch);
> >       index = start;
> > -     while (index < end && find_lock_entries(mapping, index, end - 1,
> > +     while (index < end && find_lock_entries(mapping, &index, end - 1,
> >                       &fbatch, indices)) {
> >               for (i = 0; i < folio_batch_count(&fbatch); i++) {
> >                       folio = fbatch.folios[i];
> >
> > -                     index = indices[i];
> > -
> >                       if (xa_is_value(folio)) {
> >                               if (unfalloc)
> >                                       continue;
> >                               nr_swaps_freed += !shmem_free_swap(mapping,
> > -                                                             index, folio);
> > +                                                     folio->index, folio);
>
> We know this is a value entry, so we definitely can't look at
> folio->index.  This should probably be:
>
> +                                                       indices[i], folio);
>
> > @@ -510,20 +509,18 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
> >       int i;
> >
> >       folio_batch_init(&fbatch);
> > -     while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
> > +     while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
> >               for (i = 0; i < folio_batch_count(&fbatch); i++) {
> >                       struct folio *folio = fbatch.folios[i];
> >
> >                       /* We rely upon deletion not changing folio->index */
> > -                     index = indices[i];
> >
> >                       if (xa_is_value(folio)) {
> >                               count += invalidate_exceptional_entry(mapping,
> > -                                                                   index,
> > -                                                                   folio);
> > +                                                               folio->index,
> > +                                                               folio);
>
> Same here.  I'd fix the indent while you're at it to get more on that
> second line and not need a third line.
>

Turns out I had misunderstood what a value entry was. I now understand
why we do in fact need the indices array. I'll fix the first 2 patches and
drop the last 2.
