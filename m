Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE160BBF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiJXVTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiJXVSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:18:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19D57566;
        Mon, 24 Oct 2022 12:24:48 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-369c2f83697so86961827b3.3;
        Mon, 24 Oct 2022 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNQKfFH/J4u1O0RDYXKWFImeY+htr9CT0XG4blIptF8=;
        b=BZ07ttqeleBSPnDK6U+YYl4PqDUBbDSEX+WjIwTCayimKOvCWQ7QJMsRTbYZsiVgqd
         EPz3Kssuzqwb+DuV01u77FroRmxl2Oh6cZq5to1O1dgnkU1zmgohLPGe1Vnqvzt4EEfq
         UidgeyS0Y9tA7MFOSRR/Hl408Q6977DSlBV5an5pjChLODwH4qrSLz+huTxqO2oeeugs
         Y5lojn/s8STiv9jUlWIiLpxr1Ml7lBHDrgQGF6DCe76VDPmKxmi79ylCmm7nM5tyKHUQ
         XKsULy6TfrVTx89x+MSxKDo6XFVnqqivPcXKUNiJ2AXL3gDfjx2EKDTvO6VMcUmcvqOP
         zWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNQKfFH/J4u1O0RDYXKWFImeY+htr9CT0XG4blIptF8=;
        b=uSaBudvZBCOVfJGC4D+t2LbZyvlAEhlwN3ldg41gLMXnoNZqGJLa7Q5+ZAN1li3wKl
         i/BLpJg4HQLW0D71PvBb6PQaDxZfugRY0DneODCI//rcLYIr73LD2Tl/Bdy7o1mCtYcn
         +pgIa709NnfnQvhtUAWQ2zjjpD53kwsTKi9bWSsSOX1FM5o2yncnkY2JphZJQofNjeGc
         iZiZ8ThNnCVYInMr/hmbp2a4j490k87v7JrA2gq2sStwMy1MOEDYTkXIY3azcqJE3rhT
         dF/WTX9oWSsX/NSGa7omRyXVW83YkSyxSOx0PmiVrwuYI7ggpP/j6Ri0SHUKcKOSkfjo
         P2Nw==
X-Gm-Message-State: ACrzQf1sow6xW7qEDrMWDW2ZdheyH8dL+c0ICSoWXkFXpmz06kjwfnGo
        MtFkgkksokjWuLbPZGhq9dDaAPpNYES2uISH+eY8NC1uiRs=
X-Google-Smtp-Source: AMsMyM4zQHncqMnc13JolI9a0bQPoGwvoozFFIXgkb0S+8TY5Wbz7IROxLSB7QZhSNOK0oJhcsH0Lm1a9opE48XevoI=
X-Received: by 2002:a81:71c6:0:b0:36a:5682:2c44 with SMTP id
 m189-20020a8171c6000000b0036a56822c44mr14280778ywc.308.1666639398914; Mon, 24
 Oct 2022 12:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-18-vishal.moola@gmail.com>
In-Reply-To: <20221017202451.4951-18-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 24 Oct 2022 12:23:07 -0700
Message-ID: <CAOzc2pya9kuNYT3Uff3wVmrZ3JVSnFs2kwH5CK8ite6Qn67mRg@mail.gmail.com>
Subject: Re: [PATCH v3 17/23] gfs2: Convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        rpeterso@redhat.com, agruenba@redhat.com
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
> Converted function to use folios throughout. This is in preparation for
> the removal of find_get_pgaes_range_tag().
>
> Also had to modify and rename gfs2_write_jdata_pagevec() to take in
> and utilize folio_batch rather than pagevec and use folios rather
> than pages. gfs2_write_jdata_batch() now supports large folios.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/gfs2/aops.c | 64 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 05bee80ac7de..8f87c2551a3d 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -195,67 +195,71 @@ static int gfs2_writepages(struct address_space *mapping,
>  }
>
>  /**
> - * gfs2_write_jdata_pagevec - Write back a pagevec's worth of pages
> + * gfs2_write_jdata_batch - Write back a folio batch's worth of folios
>   * @mapping: The mapping
>   * @wbc: The writeback control
> - * @pvec: The vector of pages
> - * @nr_pages: The number of pages to write
> + * @fbatch: The batch of folios
>   * @done_index: Page index
>   *
>   * Returns: non-zero if loop should terminate, zero otherwise
>   */
>
> -static int gfs2_write_jdata_pagevec(struct address_space *mapping,
> +static int gfs2_write_jdata_batch(struct address_space *mapping,
>                                     struct writeback_control *wbc,
> -                                   struct pagevec *pvec,
> -                                   int nr_pages,
> +                                   struct folio_batch *fbatch,
>                                     pgoff_t *done_index)
>  {
>         struct inode *inode = mapping->host;
>         struct gfs2_sbd *sdp = GFS2_SB(inode);
> -       unsigned nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
> +       unsigned nrblocks;
>         int i;
>         int ret;
> +       int nr_pages = 0;
> +       int nr_folios = folio_batch_count(fbatch);
> +
> +       for (i = 0; i < nr_folios; i++)
> +               nr_pages += folio_nr_pages(fbatch->folios[i]);
> +       nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
>
>         ret = gfs2_trans_begin(sdp, nrblocks, nrblocks);
>         if (ret < 0)
>                 return ret;
>
> -       for(i = 0; i < nr_pages; i++) {
> -               struct page *page = pvec->pages[i];
> +       for (i = 0; i < nr_folios; i++) {
> +               struct folio *folio = fbatch->folios[i];
>
> -               *done_index = page->index;
> +               *done_index = folio->index;
>
> -               lock_page(page);
> +               folio_lock(folio);
>
> -               if (unlikely(page->mapping != mapping)) {
> +               if (unlikely(folio->mapping != mapping)) {
>  continue_unlock:
> -                       unlock_page(page);
> +                       folio_unlock(folio);
>                         continue;
>                 }
>
> -               if (!PageDirty(page)) {
> +               if (!folio_test_dirty(folio)) {
>                         /* someone wrote it for us */
>                         goto continue_unlock;
>                 }
>
> -               if (PageWriteback(page)) {
> +               if (folio_test_writeback(folio)) {
>                         if (wbc->sync_mode != WB_SYNC_NONE)
> -                               wait_on_page_writeback(page);
> +                               folio_wait_writeback(folio);
>                         else
>                                 goto continue_unlock;
>                 }
>
> -               BUG_ON(PageWriteback(page));
> -               if (!clear_page_dirty_for_io(page))
> +               BUG_ON(folio_test_writeback(folio));
> +               if (!folio_clear_dirty_for_io(folio))
>                         goto continue_unlock;
>
>                 trace_wbc_writepage(wbc, inode_to_bdi(inode));
>
> -               ret = __gfs2_jdata_writepage(page, wbc);
> +               ret = __gfs2_jdata_writepage(&folio->page, wbc);
>                 if (unlikely(ret)) {
>                         if (ret == AOP_WRITEPAGE_ACTIVATE) {
> -                               unlock_page(page);
> +                               folio_unlock(folio);
>                                 ret = 0;
>                         } else {
>
> @@ -268,7 +272,8 @@ static int gfs2_write_jdata_pagevec(struct address_space *mapping,
>                                  * not be suitable for data integrity
>                                  * writeout).
>                                  */
> -                               *done_index = page->index + 1;
> +                               *done_index = folio->index +
> +                                       folio_nr_pages(folio);
>                                 ret = 1;
>                                 break;
>                         }
> @@ -305,8 +310,8 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
>  {
>         int ret = 0;
>         int done = 0;
> -       struct pagevec pvec;
> -       int nr_pages;
> +       struct folio_batch fbatch;
> +       int nr_folios;
>         pgoff_t writeback_index;
>         pgoff_t index;
>         pgoff_t end;
> @@ -315,7 +320,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
>         int range_whole = 0;
>         xa_mark_t tag;
>
> -       pagevec_init(&pvec);
> +       folio_batch_init(&fbatch);
>         if (wbc->range_cyclic) {
>                 writeback_index = mapping->writeback_index; /* prev offset */
>                 index = writeback_index;
> @@ -341,17 +346,18 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
>                 tag_pages_for_writeback(mapping, index, end);
>         done_index = index;
>         while (!done && (index <= end)) {
> -               nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> -                               tag);
> -               if (nr_pages == 0)
> +               nr_folios = filemap_get_folios_tag(mapping, &index, end,
> +                               tag, &fbatch);
> +               if (nr_folios == 0)
>                         break;
>
> -               ret = gfs2_write_jdata_pagevec(mapping, wbc, &pvec, nr_pages, &done_index);
> +               ret = gfs2_write_jdata_batch(mapping, wbc, &fbatch,
> +                               &done_index);
>                 if (ret)
>                         done = 1;
>                 if (ret > 0)
>                         ret = 0;
> -               pagevec_release(&pvec);
> +               folio_batch_release(&fbatch);
>                 cond_resched();
>         }
>
> --
> 2.36.1
>

Would anyone familiar with gfs2 have time to look over this patch (17/23)?
I've cc-ed the gfs2 supporters, feedback would be appreciated.
