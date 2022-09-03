Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2B5AC02A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiICRip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiICRi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:38:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9153D2B;
        Sat,  3 Sep 2022 10:38:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b19so5233073ljf.8;
        Sat, 03 Sep 2022 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xX2O58QMupv9rWIX/wz0TD9J8Ed7HqVnisBNPZl6V04=;
        b=P/hsH1QKS4072Gai1EmOGCnjPTQWZiiOiE+P26T80mgV0tbTOnkDXKC3nEWi1Xoe/A
         Hs7LLFSp+fCaJRWZVqv/8C2xzImMvLQoTDYUfx6u9PmIwXRQtB9n4gGmx+GH0S1f7zYT
         EpKdDfbdqDAHgNmhwbrPGp06lVMfmsEbewBLDb/B+dQfW30xzF8F2l2F/gidKFJKBG6M
         xlYX6S3WMrWsrSfVCDpCmKqprjSkUDidSKYHiXrhQ6jx9rWQ1os07RE+QbroswHSap0D
         gOYyJOlFnRdNpKj+sEkb2UqwaGfM6EvoZTNoU3eDmRl2MoAiXkF/RCfX0IxvBDH8/V+n
         XD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xX2O58QMupv9rWIX/wz0TD9J8Ed7HqVnisBNPZl6V04=;
        b=imTLFN8Eux+H9bfSleRewZH/5DsXR08iBnirAYp8x+S0JfQBmlHrGXNN1Nh3DlOYwp
         iSeScOiatLAIcV2QQXWsycH5nExk+rxB7Gkx6Ev0k1BvXc21ku/gWYj5FLIY1t5mlZja
         TSwe0rI583L76zVdWL3yggKQ37/9MuBrEevDRIVGFOno+Jhq5scwA/9LE8kAMCWjgaTj
         PfK7Bok2vlWQQRKSOAMgPnfhlim5fcJjXBJ3UOt4hNNz76LLd0JTGIQj75rnqGhWgnF+
         q7lscpM8EwUz1wAj239CIOgDRmwmY13nyjxc4Rx2pG73MR5Tn50WhfRZn4YPo818v1Vy
         uf3w==
X-Gm-Message-State: ACgBeo3Cc2Y2VegKEuKQ/9rp0/0ZPZVf1OZ2nGmHq1yGZ41nC/+3e2Gx
        dLQxqi1fUAL/Rjn/aDiOfT5enZ6HDPLHglijCyY=
X-Google-Smtp-Source: AA6agR7+UPXECkLr9xecEnlHY9jJP9Sk53/z1csaRMZh+iBcI4PkxC6eajktqUCZxUcf8SInATP1uw7iY4QjQlwWETk=
X-Received: by 2002:a2e:b8d5:0:b0:25f:e94d:10a2 with SMTP id
 s21-20020a2eb8d5000000b0025fe94d10a2mr13425885ljp.274.1662226704352; Sat, 03
 Sep 2022 10:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220901220138.182896-1-vishal.moola@gmail.com> <20220901220138.182896-19-vishal.moola@gmail.com>
In-Reply-To: <20220901220138.182896-19-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 4 Sep 2022 02:38:06 +0900
Message-ID: <CAKFNMo=YwdFOQNUuwNvYn6u41C8A2M905-nDkEFRejPZ2_svYg@mail.gmail.com>
Subject: Re: [PATCH 18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers()
 to use filemap_get_folios_tag()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 2, 2022 at 7:07 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/segment.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 0afe0832c754..e95c667bdc8f 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -680,7 +680,7 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
>                                               loff_t start, loff_t end)
>  {
>         struct address_space *mapping = inode->i_mapping;
> -       struct pagevec pvec;
> +       struct folio_batch fbatch;
>         pgoff_t index = 0, last = ULONG_MAX;
>         size_t ndirties = 0;
>         int i;
> @@ -694,23 +694,26 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
>                 index = start >> PAGE_SHIFT;
>                 last = end >> PAGE_SHIFT;
>         }
> -       pagevec_init(&pvec);
> +       folio_batch_init(&fbatch);
>   repeat:
>         if (unlikely(index > last) ||
> -           !pagevec_lookup_range_tag(&pvec, mapping, &index, last,
> -                               PAGECACHE_TAG_DIRTY))
> +             !filemap_get_folios_tag(mapping, &index, last,
> +                     PAGECACHE_TAG_DIRTY, &fbatch))
>                 return ndirties;
>
> -       for (i = 0; i < pagevec_count(&pvec); i++) {
> +       for (i = 0; i < folio_batch_count(&fbatch); i++) {
>                 struct buffer_head *bh, *head;
> -               struct page *page = pvec.pages[i];
> +               struct folio *folio = fbatch.folios[i];
>
> -               lock_page(page);
> -               if (!page_has_buffers(page))
> -                       create_empty_buffers(page, i_blocksize(inode), 0);
> -               unlock_page(page);

> +               head = folio_buffers(folio);
> +               folio_lock(folio);

Could you please swap these two lines to keep the "head" check in the lock?

Thanks,
Ryusuke Konishi


> +               if (!head) {
> +                       create_empty_buffers(&folio->page, i_blocksize(inode), 0);
> +                       head = folio_buffers(folio);
> +               }
> +               folio_unlock(folio);
>
> -               bh = head = page_buffers(page);
> +               bh = head;
>                 do {
>                         if (!buffer_dirty(bh) || buffer_async_write(bh))
>                                 continue;
> @@ -718,13 +721,13 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
>                         list_add_tail(&bh->b_assoc_buffers, listp);
>                         ndirties++;
>                         if (unlikely(ndirties >= nlimit)) {
> -                               pagevec_release(&pvec);
> +                               folio_batch_release(&fbatch);
>                                 cond_resched();
>                                 return ndirties;
>                         }
>                 } while (bh = bh->b_this_page, bh != head);
>         }
> -       pagevec_release(&pvec);
> +       folio_batch_release(&fbatch);
>         cond_resched();
>         goto repeat;
>  }
> --
> 2.36.1
>
