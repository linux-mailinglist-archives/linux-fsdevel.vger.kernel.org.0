Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30D60BC08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiJXVXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiJXVXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:23:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFEEF6800;
        Mon, 24 Oct 2022 12:29:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f205so12169709yba.2;
        Mon, 24 Oct 2022 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msuUebF694+hZC0rqt6N8CJWQi+fRr7tKzxI1kK1XSA=;
        b=Nbh/LUYRRXN+W8H+09HFirleOER72S3l+cyZmuDy+8Pib1Gn+U4wfzzFfRtAjMjFcF
         fvo3jJ3RCWGObovpQORWc3/9IkNJGMgPUfku6KvUFl6cu6AMUPfoT9oK95yTGj66jhjH
         7WGhQNpuF6d0iem0QTBy19EivSDPd2VqHFxQ3x16D8kkerWE0rDHVR2hrPPsFrR5kbrm
         D3RRZ03JmkZtNZSKaozG5JauPmqkajAnvSOqe8wpHj28aX62NhSnkQiYABEysxpon0kM
         LH9dhzEwQZXR7plJ46sFDvDg1wrk4joIrl4DRR8/CJkQwJDkuqnpXoWVFb+tCDqZEjny
         JZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msuUebF694+hZC0rqt6N8CJWQi+fRr7tKzxI1kK1XSA=;
        b=giOSsn6YjPnMCp9DGaqik+7hm0Hba0FhNqI+yBgk7ttJ2Y2oyMh9WKqz4AG9Uw8LSg
         6hNaGRdu5+9/IIa6+i8c+1rSOvLnSMRdEE3DRgsp71d7h4cgsY+m2b6LiZ/3zd1/aNua
         gOgw6nEdFUrCgWEz6FjxVGrTyPXRdN+4PcOz9LzUUcFB3BmGf+GEbkaOsKNUXchlJgLk
         QuENJ4lpgjqfPugivwcwdMTtZUn28X5y1Tq9zewUZaQ/1hkKLkOma2X+b8uznKBmoc5e
         EorCvo3waOEKVy+kMu9V1wjUgUkc8uNMcyn6iHW4Z1NbnSq1LlIA37bqV+sw14IuJyTg
         0xdA==
X-Gm-Message-State: ACrzQf23ED63pDEfljhwnmiDs+YlYdulK0uJET7cN9VtjGDy3PXyXI72
        cpNBdEGEt3Ko6u/3MWp/9hHf9mSS5wEsc5l9z9uBAXWcPm4=
X-Google-Smtp-Source: AMsMyM5vg8N9dDW35cXYnRV0vMdNWWQOk5I20+pSLu1UdubJKDDQpcDyA6OCK60nRt7T9Q9hMWGXE3CrFggT3+iul/0=
X-Received: by 2002:a5b:9c5:0:b0:6ca:d6da:30c1 with SMTP id
 y5-20020a5b09c5000000b006cad6da30c1mr8707218ybq.372.1666639612737; Mon, 24
 Oct 2022 12:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-11-vishal.moola@gmail.com>
In-Reply-To: <20221017202451.4951-11-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 24 Oct 2022 12:26:41 -0700
Message-ID: <CAOzc2pz53R5ZT0=U8uav9=FL7_rn+6pUrkfeTZ-bx5_3Pac-xg@mail.gmail.com>
Subject: Re: [PATCH v3 10/23] ext4: Convert mpage_prepare_extent_to_map() to
 use filemap_get_folios_tag()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org, tytso@mit.edu
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

On Mon, Oct 17, 2022 at 1:25 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Converted the function to use folios throughout. This is in preparation
> for the removal of find_get_pages_range_tag(). Now supports large
> folios.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/ext4/inode.c | 55 ++++++++++++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2b5ef1b64249..69a0708c8e87 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2572,8 +2572,8 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
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
> @@ -2587,18 +2587,17 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
> @@ -2612,10 +2611,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
> @@ -2623,16 +2622,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
> @@ -2643,33 +2642,33 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
>                         /* Add all dirty buffers to mpd */
> -                       lblk = ((ext4_lblk_t)page->index) <<
> +                       lblk = ((ext4_lblk_t)folio->index) <<
>                                 (PAGE_SHIFT - blkbits);
> -                       head = page_buffers(page);
> +                       head = folio_buffers(folio);
>                         err = mpage_process_page_bufs(mpd, head, head, lblk);
>                         if (err <= 0)
>                                 goto out;
>                         err = 0;
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
> 2.36.1
>

Does anyone have some time to look over this ext4 patch this week?
Feedback is appreciated.
