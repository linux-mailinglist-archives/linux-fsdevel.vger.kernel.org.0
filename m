Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E034D667D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjALR5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 12:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjALR4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:56:20 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220259334;
        Thu, 12 Jan 2023 09:16:13 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id t15so19496646ybq.4;
        Thu, 12 Jan 2023 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ueu49HbYyw3uKaxLdkdNJFDLhnVwdUbocDy8yp3uK6U=;
        b=NC4oLmKyiU3uGHOrCu0neAT7WGQm+evGATS22zDmNdb+/2NhuIG0f1cXd+Oo71x2x/
         d9fjT4jYSUOUBJWL+/XfoQRQcJircib0hCIQNig7qcjc8w6s9NDKCE8BxNIxJ/QIPawr
         cGDcDEgYwNMISqTlSdoe2gi9E7vXeiwnnDNv9jj5eXpGknHXsQrJmwtldQVLWCvhl3ZG
         lIyceotTUmoEX6Dvf7U4pSHAwxk6VUESS1YrPAshFBx/sv/5P+3kMTg7lyJXQYkVLv/j
         nhYbgnk5O/zNb7Ew31BfnKA81FkIZ4oEZPonWMG3EVzYgOtn38OFepH0Ci/+hw4YNxsB
         DwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueu49HbYyw3uKaxLdkdNJFDLhnVwdUbocDy8yp3uK6U=;
        b=g2I9aUEIrBrUc3z2BzZDtmh6uy7nLPCOudd/f8+E6Q6wCsUvPi8VwR2w7TyR6Gkr2y
         qRYZ1+wXXyE4NQWz4bRDjJiGPv5S4nqCTSKqgQnT7bmx7Bw7adep11UHcr7kYiRv7vme
         IbA4Pr/ueHqSC48LBHNPvW9I6matmoEKcPoJUYFOVYzs8ri0J//FrnO//cPz4t5AFKcy
         QW1R4bYiRYqy5ENFpWbi775+he+8IzYrRyjnNwLCuoBxPZCPLWFazy2H7f+gGfoIjscU
         J0WSS5pwOw6Obgt4rxQqBQOIIoFeT8xFUX3pCCNWdbwc6IdRetglaSiF16wvOb0jlgth
         3hBQ==
X-Gm-Message-State: AFqh2kqZwgwV119Jfc+5GJVr8K5qc7j2orMzr+Nu4I0PnidJaYGRhZJX
        XXq84hiFcyHpvUIfojJBcGZL4t+0VdQv3fzg0+Fwux0J
X-Google-Smtp-Source: AMrXdXt4S29867pWpNEcWUZVtr/uqb3UM4fpVgRhzCkqlx5R6lghcyEfD/1N+9wnCtzwrdSh12ePIMINBFYAmF+ldAs=
X-Received: by 2002:a25:abea:0:b0:762:b86:e82e with SMTP id
 v97-20020a25abea000000b007620b86e82emr8539372ybi.407.1673543771906; Thu, 12
 Jan 2023 09:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20230104211448.4804-1-vishal.moola@gmail.com> <20230104211448.4804-11-vishal.moola@gmail.com>
In-Reply-To: <20230104211448.4804-11-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 12 Jan 2023 09:16:00 -0800
Message-ID: <CAOzc2pwoY74wdgCn2b=u391BNDmzOQ32e7yDt-ULwoNkhZ_4ig@mail.gmail.com>
Subject: Re: [PATCH v5 10/23] ext4: Convert mpage_prepare_extent_to_map() to
 use filemap_get_folios_tag()
To:     linux-fsdevel@vger.kernel.org, tytso@mit.edu
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Jan 4, 2023 at 1:15 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Converted the function to use folios throughout. This is in preparation
> for the removal of find_get_pages_range_tag(). Now supports large
> folios. This change removes 11 calls to compound_head().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/ext4/inode.c | 65 ++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 33 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9d9f414f99fe..fb6cd994e59a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2595,8 +2595,8 @@ static bool ext4_page_nomap_can_writeout(struct page *page)
>  static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  {
>         struct address_space *mapping = mpd->inode->i_mapping;
> -       struct pagevec pvec;
> -       unsigned int nr_pages;
> +       struct folio_batch fbatch;
> +       unsigned int nr_folios;
>         long left = mpd->wbc->nr_to_write;
>         pgoff_t index = mpd->first_page;
>         pgoff_t end = mpd->last_page;
> @@ -2610,18 +2610,17 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>                 tag = PAGECACHE_TAG_TOWRITE;
>         else
>                 tag = PAGECACHE_TAG_DIRTY;
> -
> -       pagevec_init(&pvec);
> +       folio_batch_init(&fbatch);
>         mpd->map.m_len = 0;
>         mpd->next_page = index;
>         while (index <= end) {
> -               nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> -                               tag);
> -               if (nr_pages == 0)
> +               nr_folios = filemap_get_folios_tag(mapping, &index, end,
> +                               tag, &fbatch);
> +               if (nr_folios == 0)
>                         break;
>
> -               for (i = 0; i < nr_pages; i++) {
> -                       struct page *page = pvec.pages[i];
> +               for (i = 0; i < nr_folios; i++) {
> +                       struct folio *folio = fbatch.folios[i];
>
>                         /*
>                          * Accumulated enough dirty pages? This doesn't apply
> @@ -2635,10 +2634,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>                                 goto out;
>
>                         /* If we can't merge this page, we are done. */
> -                       if (mpd->map.m_len > 0 && mpd->next_page != page->index)
> +                       if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
>                                 goto out;
>
> -                       lock_page(page);
> +                       folio_lock(folio);
>                         /*
>                          * If the page is no longer dirty, or its mapping no
>                          * longer corresponds to inode we are writing (which
> @@ -2646,16 +2645,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>                          * page is already under writeback and we are not doing
>                          * a data integrity writeback, skip the page
>                          */
> -                       if (!PageDirty(page) ||
> -                           (PageWriteback(page) &&
> +                       if (!folio_test_dirty(folio) ||
> +                           (folio_test_writeback(folio) &&
>                              (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
> -                           unlikely(page->mapping != mapping)) {
> -                               unlock_page(page);
> +                           unlikely(folio->mapping != mapping)) {
> +                               folio_unlock(folio);
>                                 continue;
>                         }
>
> -                       wait_on_page_writeback(page);
> -                       BUG_ON(PageWriteback(page));
> +                       folio_wait_writeback(folio);
> +                       BUG_ON(folio_test_writeback(folio));
>
>                         /*
>                          * Should never happen but for buggy code in
> @@ -2666,49 +2665,49 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>                          *
>                          * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
>                          */
> -                       if (!page_has_buffers(page)) {
> -                               ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
> -                               ClearPageDirty(page);
> -                               unlock_page(page);
> +                       if (!folio_buffers(folio)) {
> +                               ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
> +                               folio_clear_dirty(folio);
> +                               folio_unlock(folio);
>                                 continue;
>                         }
>
>                         if (mpd->map.m_len == 0)
> -                               mpd->first_page = page->index;
> -                       mpd->next_page = page->index + 1;
> +                               mpd->first_page = folio->index;
> +                       mpd->next_page = folio->index + folio_nr_pages(folio);
>                         /*
>                          * Writeout for transaction commit where we cannot
>                          * modify metadata is simple. Just submit the page.
>                          */
>                         if (!mpd->can_map) {
> -                               if (ext4_page_nomap_can_writeout(page)) {
> -                                       err = mpage_submit_page(mpd, page);
> +                               if (ext4_page_nomap_can_writeout(&folio->page)) {
> +                                       err = mpage_submit_page(mpd, &folio->page);
>                                         if (err < 0)
>                                                 goto out;
>                                 } else {
> -                                       unlock_page(page);
> -                                       mpd->first_page++;
> +                                       folio_unlock(folio);
> +                                       mpd->first_page += folio_nr_pages(folio);
>                                 }
>                         } else {
>                                 /* Add all dirty buffers to mpd */
> -                               lblk = ((ext4_lblk_t)page->index) <<
> +                               lblk = ((ext4_lblk_t)folio->index) <<
>                                         (PAGE_SHIFT - blkbits);
> -                               head = page_buffers(page);
> +                               head = folio_buffers(folio);
>                                 err = mpage_process_page_bufs(mpd, head, head,
> -                                                             lblk);
> +                                               lblk);
>                                 if (err <= 0)
>                                         goto out;
>                                 err = 0;
>                         }
> -                       left--;
> +                       left -= folio_nr_pages(folio);
>                 }
> -               pagevec_release(&pvec);
> +               folio_batch_release(&fbatch);
>                 cond_resched();
>         }
>         mpd->scanned_until_end = 1;
>         return 0;
>  out:
> -       pagevec_release(&pvec);
> +       folio_batch_release(&fbatch);
>         return err;
>  }
>
> --
> 2.38.1
>

Could someone review this ext4 patch, please? This is one of the
2 remaining patches that need to be looked at in the series.
