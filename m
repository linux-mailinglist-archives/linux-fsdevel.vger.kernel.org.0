Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E657596839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 06:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiHQEds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 00:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQEdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:33:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458171725;
        Tue, 16 Aug 2022 21:33:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so17614283lfs.0;
        Tue, 16 Aug 2022 21:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nOdb6n13ohDqgquF5+hz9jSYLtO6Hr9UX14Xr/YTGlM=;
        b=dMkCJ8QcXk8CCKs+JMzTMBHDLD4h16lKjhPfa818z1aMbkmqmpn4lSJ/hn0QuEWAWS
         OdymGqhTo4Pn/bNpk8llqrNNi6dl8VAXbfkDlgq0LGsfqFbAcRfU/QkVvvQTJ7XjPdlo
         G+V2u884J/ZowvVBoBep11BxqGF+P30pLFDrYUsxDKLvHcyrL3YTPIhXXvypH5+ZedHM
         Q6nLlNLv4ELt/1W812op/++Q7j7T/KiIOBtNGNFaXYckan6OxeLrFHGSmGqS9Sv/ONIM
         vOholq/pwx6EFwcprMgfhLQiGkgA1WhOigSaEZYsgkNRN8sM2DbUANkpN8czCaKsVb/N
         LnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nOdb6n13ohDqgquF5+hz9jSYLtO6Hr9UX14Xr/YTGlM=;
        b=OsWWGCltHbq4mCPfNKmMeUnoPo8nL2aWSTpUCULgcJ6uHA1/MkzE0mhb9MdNLvMrbR
         qzJy8VYknUaVoqKpuaUYK0YttVY1loZub+QFigT5CaEOktrZFtuG+eB9Uxu60/MBZna5
         0kEn/mGZjyQVf72103GM8mBtaOJEyhyvF4oLRKzOLZLcOV+ywCQBwRP/ZnY1tEAgiKf8
         9zWvy6G02rWI3AcEwvwRRMY/R+bpGXNA58X92i3WBQOwGkwnVmLBrW4Dd4Q2zF3ldM4w
         HDTRBeQv+kUSnVWAuS2CNOjetpxmDq34hvxPdpEZSYhQqu8mOd+qt/ll6gH5ajXNHRpp
         5FuA==
X-Gm-Message-State: ACgBeo0sr+qfR+HvFg7/OL6DrgeUfAUgjrvLSJ2g99h330+DtXvN9VPz
        D4M9qwj3uif0rpaLFAb4XgAjO7Td4TyXHoPar3Lh1sVmggeuVA==
X-Google-Smtp-Source: AA6agR4ayOuxJuJF95sigIXKXvupZgqxuRi33BQPTzqVIVjNi8KVzdUB91zyQecU/E0l18dwY2r2S77NesDl86NyYpE=
X-Received: by 2002:a05:6512:12c7:b0:48b:3bc4:10f4 with SMTP id
 p7-20020a05651212c700b0048b3bc410f4mr7766818lfg.411.1660710824597; Tue, 16
 Aug 2022 21:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220816175246.42401-1-vishal.moola@gmail.com> <20220816175246.42401-6-vishal.moola@gmail.com>
In-Reply-To: <20220816175246.42401-6-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 17 Aug 2022 13:33:27 +0900
Message-ID: <CAKFNMome2DoupJxiNT4YtuMDLUgUD1aevHSExd+M+Q+ghXwaEw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to
 use filemap_get_folios_contig()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
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

On Wed, Aug 17, 2022 at 2:54 AM Vishal Moola (Oracle)  wrote:
>
> Converted function to use folios throughout. This is in preparation for
> the removal of find_get_pages_contig(). Now also supports large folios.
>
> Also cleaned up an unnecessary if statement - pvec.pages[0]->index > index
> will always evaluate to false, and filemap_get_folios_contig() returns 0 if
> there is no folio found at index.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>
> v2:
>   - Fixed a warning regarding a now unused label "out"
>   - Reported-by: kernel test robot <lkp@intel.com>
> ---
>  fs/nilfs2/page.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index 3267e96c256c..14629e03d0da 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -480,13 +480,13 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
>                                             sector_t start_blk,
>                                             sector_t *blkoff)
>  {
> -       unsigned int i;
> +       unsigned int i, nr;
>         pgoff_t index;
>         unsigned int nblocks_in_page;
>         unsigned long length = 0;
>         sector_t b;
> -       struct pagevec pvec;
> -       struct page *page;
> +       struct folio_batch fbatch;
> +       struct folio *folio;
>
>         if (inode->i_mapping->nrpages == 0)
>                 return 0;
> @@ -494,27 +494,24 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
>         index = start_blk >> (PAGE_SHIFT - inode->i_blkbits);
>         nblocks_in_page = 1U << (PAGE_SHIFT - inode->i_blkbits);
>
> -       pagevec_init(&pvec);
> +       folio_batch_init(&fbatch);
>
>  repeat:
> -       pvec.nr = find_get_pages_contig(inode->i_mapping, index, PAGEVEC_SIZE,
> -                                       pvec.pages);
> -       if (pvec.nr == 0)
> +       nr = filemap_get_folios_contig(inode->i_mapping, &index, ULONG_MAX,
> +                       &fbatch);
> +       if (nr == 0)
>                 return length;
>
> -       if (length > 0 && pvec.pages[0]->index > index)
> -               goto out;
> -
> -       b = pvec.pages[0]->index << (PAGE_SHIFT - inode->i_blkbits);
> +       b = fbatch.folios[0]->index << (PAGE_SHIFT - inode->i_blkbits);
>         i = 0;
>         do {
> -               page = pvec.pages[i];
> +               folio = fbatch.folios[i];
>
> -               lock_page(page);
> -               if (page_has_buffers(page)) {
> +               folio_lock(folio);
> +               if (folio_buffers(folio)) {
>                         struct buffer_head *bh, *head;
>
> -                       bh = head = page_buffers(page);
> +                       bh = head = folio_buffers(folio);
>                         do {
>                                 if (b < start_blk)
>                                         continue;
> @@ -532,18 +529,16 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
>

>                         b += nblocks_in_page;

Here, It looks like the block index "b" should be updated with the
number of blocks in the
folio because the loop is now per folio, not per page.

Instead of replacing it with a calculation that uses folio_size(folio)
or folio_shift(folio),
I think it would be better to move the calculation of "b" inside the
branch where the folio
has buffers as follows:

                if (folio_buffers(folio)) {
                        struct buffer_head *bh, *head;
                        sector_t b;

                        b = folio->index << (PAGE_SHIFT - inode->i_blkbits);
                        bh = head = folio_buffers(folio);
                        ...
               } else if (length > 0) {
                       goto out_locked;
               }

This way, we can remove calculations for the block index "b" outside
the above part
and the variable "nblocks_in_page" as well.

Thanks,
Ryusuke Konishi

>                 }
> -               unlock_page(page);
> +               folio_unlock(folio);
>
> -       } while (++i < pagevec_count(&pvec));
> +       } while (++i < nr);
>
> -       index = page->index + 1;
> -       pagevec_release(&pvec);
> +       folio_batch_release(&fbatch);
>         cond_resched();
>         goto repeat;
>
>  out_locked:
> -       unlock_page(page);
> -out:
> -       pagevec_release(&pvec);
> +       folio_unlock(folio);
> +       folio_batch_release(&fbatch);
>         return length;
>  }
> --
> 2.36.1
>
