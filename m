Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19EF597815
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiHQUfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiHQUfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:35:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5CEAA3E5;
        Wed, 17 Aug 2022 13:35:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso9216795otv.1;
        Wed, 17 Aug 2022 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gxYbz4vgkJrv2ZDG6l+fEiYODdiBDS379CnGFFAEQCA=;
        b=Uf8/JMbJrj//7ezxkLb/aOXHNfyJLkuRC5MHSWStBXI5zX+Ljl+T4G26MZfdmT1tUi
         +oeuYc/4J7ElSoHOITcjQmHHNZ0zB4Iy7OwLx+YyLIQweEfcsND7lCCAZSmi8i5C8vw9
         po0DE79mAnRSmOOjCV/ixl2HQZc3Da7CEuVmlR5GKJkGwdDuqqbBeIkO4KfOLKyJzPFp
         je0dwtAPPYsg2UrjWkl3DIcBtXtC5rcJWvqu+HZVhlySw6WuSgH+WiMZuKots3a/6eFH
         5rFUFIxXVlm+aeJTzYiKktnFYJqoaji+uf+n35Annv4EB6aCJBWzj7nFMo9tHnzOHvLT
         V9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gxYbz4vgkJrv2ZDG6l+fEiYODdiBDS379CnGFFAEQCA=;
        b=F1QiAvZudC0ps9cgIPgAUvsfdvcyYz4A+d49ItmZQXSHLP8xH7fnReJ/+N164mQ7mq
         4O89LTrD2BoMonNiA5VWkqfiDpEFeWYxTIK5ZuXoMn3d/NIgd+8OqctFKXSWaP8C/Uh1
         9jiJUNQ4UV5lJR9I0uSzbVdOt1oXGKQoEzy+bztoAwltpVF1rA10G6reEfFGUqMaNGIH
         LcCGmQTSpW+qVQQm6/tsggXk8Y4CbhZPv9WlnFMMUmNQ9x4SljdCvuEcm+imbkn6FhYg
         zsHPaiOYHtZgEGf/MrwfCMMjke/VCsY4diY07+3rf0X4EkPeKTlJ86FazEdGuywGSXOf
         Pltg==
X-Gm-Message-State: ACgBeo09aY4z2ViR/WRQb6X7VoWwi/IO295eTsvHRtvRanaUJ7WuUP5X
        AAuhZIsmoyKzGUEQaQmJMgIZDfzvNtI6X5IT0HxogIvVloo=
X-Google-Smtp-Source: AA6agR6fWtVoNrOD7JgMSokpy8oT8f5OQpwjiqzz0CiLyVnI5Kvr+Ua/5vUIOYrZCE8GFyy5YCy81xhLnbftN4xBEzY=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr3925360otv.26.1660768513316; Wed, 17
 Aug 2022 13:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220816175246.42401-1-vishal.moola@gmail.com>
 <20220816175246.42401-6-vishal.moola@gmail.com> <CAKFNMome2DoupJxiNT4YtuMDLUgUD1aevHSExd+M+Q+ghXwaEw@mail.gmail.com>
In-Reply-To: <CAKFNMome2DoupJxiNT4YtuMDLUgUD1aevHSExd+M+Q+ghXwaEw@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 17 Aug 2022 13:35:01 -0700
Message-ID: <CAOzc2pyDFVVBF3rmUK3_nWS=8rw4FieD40ivf904AfM8o_GWvQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to
 use filemap_get_folios_contig()
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 9:33 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> On Wed, Aug 17, 2022 at 2:54 AM Vishal Moola (Oracle)  wrote:
> >
> > Converted function to use folios throughout. This is in preparation for
> > the removal of find_get_pages_contig(). Now also supports large folios.
> >
> > Also cleaned up an unnecessary if statement - pvec.pages[0]->index > index
> > will always evaluate to false, and filemap_get_folios_contig() returns 0 if
> > there is no folio found at index.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >
> > v2:
> >   - Fixed a warning regarding a now unused label "out"
> >   - Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  fs/nilfs2/page.c | 39 +++++++++++++++++----------------------
> >  1 file changed, 17 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> > index 3267e96c256c..14629e03d0da 100644
> > --- a/fs/nilfs2/page.c
> > +++ b/fs/nilfs2/page.c
> > @@ -480,13 +480,13 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
> >                                             sector_t start_blk,
> >                                             sector_t *blkoff)
> >  {
> > -       unsigned int i;
> > +       unsigned int i, nr;
> >         pgoff_t index;
> >         unsigned int nblocks_in_page;
> >         unsigned long length = 0;
> >         sector_t b;
> > -       struct pagevec pvec;
> > -       struct page *page;
> > +       struct folio_batch fbatch;
> > +       struct folio *folio;
> >
> >         if (inode->i_mapping->nrpages == 0)
> >                 return 0;
> > @@ -494,27 +494,24 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
> >         index = start_blk >> (PAGE_SHIFT - inode->i_blkbits);
> >         nblocks_in_page = 1U << (PAGE_SHIFT - inode->i_blkbits);
> >
> > -       pagevec_init(&pvec);
> > +       folio_batch_init(&fbatch);
> >
> >  repeat:
> > -       pvec.nr = find_get_pages_contig(inode->i_mapping, index, PAGEVEC_SIZE,
> > -                                       pvec.pages);
> > -       if (pvec.nr == 0)
> > +       nr = filemap_get_folios_contig(inode->i_mapping, &index, ULONG_MAX,
> > +                       &fbatch);
> > +       if (nr == 0)
> >                 return length;
> >
> > -       if (length > 0 && pvec.pages[0]->index > index)
> > -               goto out;
> > -
> > -       b = pvec.pages[0]->index << (PAGE_SHIFT - inode->i_blkbits);
> > +       b = fbatch.folios[0]->index << (PAGE_SHIFT - inode->i_blkbits);
> >         i = 0;
> >         do {
> > -               page = pvec.pages[i];
> > +               folio = fbatch.folios[i];
> >
> > -               lock_page(page);
> > -               if (page_has_buffers(page)) {
> > +               folio_lock(folio);
> > +               if (folio_buffers(folio)) {
> >                         struct buffer_head *bh, *head;
> >
> > -                       bh = head = page_buffers(page);
> > +                       bh = head = folio_buffers(folio);
> >                         do {
> >                                 if (b < start_blk)
> >                                         continue;
> > @@ -532,18 +529,16 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
> >
>
> >                         b += nblocks_in_page;
>
> Here, It looks like the block index "b" should be updated with the
> number of blocks in the
> folio because the loop is now per folio, not per page.

Yup, thanks for catching that.

> Instead of replacing it with a calculation that uses folio_size(folio)
> or folio_shift(folio),
> I think it would be better to move the calculation of "b" inside the
> branch where the folio
> has buffers as follows:
>
>                 if (folio_buffers(folio)) {
>                         struct buffer_head *bh, *head;
>                         sector_t b;
>
>                         b = folio->index << (PAGE_SHIFT - inode->i_blkbits);
>                         bh = head = folio_buffers(folio);
>                         ...
>                } else if (length > 0) {
>                        goto out_locked;
>                }
>
> This way, we can remove calculations for the block index "b" outside
> the above part
> and the variable "nblocks_in_page" as well.

Sounds good, I'll do that.

> Thanks,
> Ryusuke Konishi
>
> >                 }
> > -               unlock_page(page);
> > +               folio_unlock(folio);
> >
> > -       } while (++i < pagevec_count(&pvec));
> > +       } while (++i < nr);
> >
> > -       index = page->index + 1;
> > -       pagevec_release(&pvec);
> > +       folio_batch_release(&fbatch);
> >         cond_resched();
> >         goto repeat;
> >
> >  out_locked:
> > -       unlock_page(page);
> > -out:
> > -       pagevec_release(&pvec);
> > +       folio_unlock(folio);
> > +       folio_batch_release(&fbatch);
> >         return length;
> >  }
> > --
> > 2.36.1
> >
