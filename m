Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FF960BC1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiJXV0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiJXV00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:26:26 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954228F24E;
        Mon, 24 Oct 2022 12:32:56 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i127so12110617ybc.11;
        Mon, 24 Oct 2022 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ewURVtEZDzlu0i+gVIVlIwdo2AKdKjYywGZcJK82PeY=;
        b=pvb2n989P4g452NhPl3a7ovLcs0nrAlug6GLmwQOWVXp8sZf4hJMVc75J+1AdeaR5B
         jTPfEsL3DxRnXGA7sUdDXsbNz9yiIRbkdJnpbTPKyuqZjCtxmSrHQ8G13WCC1Iuw5z+o
         sb4RzMo24wxwjit5EZW/pEDJsdJvyK01K/zuT64THd3AukYqfUeJn+21U43e4WOGV7AE
         TRjlBL3V1r6EQNYSf744jlDgboUSn44k7FA4sUf3fJvYekNs22FOZgtNlymJimDJwZ6+
         t25uP2Y+j8/iUSZasJ8p1q+kJXQcLGIToESALHyDssHFEsfrxGDSk2to5cSEMGM1zWKn
         AmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewURVtEZDzlu0i+gVIVlIwdo2AKdKjYywGZcJK82PeY=;
        b=eCMf2kHbPew0J4JQHk0FNS0l3Xf9pT7J317HUfEnhJMz1et8O7Z0QTMDkeI+vLCyqz
         Yjm7SzyQ2y3/vfCPz9tb8TwNQKj7aH1zNalPlWnfOScbuSbYVRDoJA8kXISGV1A97SOe
         C71EHI4zOgBaJm32IjlUu6PX2pkVqSZMUr/tmcbWGqY/s7NtNclGtMpB3BEJhgcQj0HB
         0lKEE5PlT3e7vBaGFQJDUsV4UCD1k33QYXGjUqud2bSjVq8mckojopkngwt0aV/gbBrB
         UNe/DAgSazjkuX2YCz1TNmfIln+kenG9hg/moAkFklHYQDJcASMtve7E2hl2FgSEO5zb
         tQtw==
X-Gm-Message-State: ACrzQf1KmBzM+U2k3zn2O6OrcDMHDjAi5jXIlIG4zA8ZawHc8/oztVu8
        aW8acizlaQ/N/94wkvaXNaWMs2ZuvbB3L0Gr7aK7FdfqHVeI6Q==
X-Google-Smtp-Source: AMsMyM6B6fNnp2prURoNrQAhN6Lbp6rH2u1B/iqqAEW6OHySGJ/tzUiCXpuF8+v7sMB52Tmf+g8Xaw+7Yytz7WdTgT4=
X-Received: by 2002:a25:3bd0:0:b0:6ca:6428:ac94 with SMTP id
 i199-20020a253bd0000000b006ca6428ac94mr16397507yba.462.1666639881517; Mon, 24
 Oct 2022 12:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-12-vishal.moola@gmail.com>
In-Reply-To: <20221017202451.4951-12-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 24 Oct 2022 12:31:10 -0700
Message-ID: <CAOzc2pwKoyy4i4zBKhvoKmN8cezUxjDhjYZnK9GLcJniQVPoGA@mail.gmail.com>
Subject: Re: [PATCH v3 11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        jaegeuk@kernel.org, chao@kernel.org
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
> Convert function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/f2fs/node.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 983572f23896..e8b72336c096 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1728,12 +1728,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>                         unsigned int *seq_id)
>  {
>         pgoff_t index;
> -       struct pagevec pvec;
> +       struct folio_batch fbatch;
>         int ret = 0;
>         struct page *last_page = NULL;
>         bool marked = false;
>         nid_t ino = inode->i_ino;
> -       int nr_pages;
> +       int nr_folios;
>         int nwritten = 0;
>
>         if (atomic) {
> @@ -1742,20 +1742,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>                         return PTR_ERR_OR_ZERO(last_page);
>         }
>  retry:
> -       pagevec_init(&pvec);
> +       folio_batch_init(&fbatch);
>         index = 0;
>
> -       while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> -                               PAGECACHE_TAG_DIRTY))) {
> +       while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
> +                                       (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
> +                                       &fbatch))) {
>                 int i;
>
> -               for (i = 0; i < nr_pages; i++) {
> -                       struct page *page = pvec.pages[i];
> +               for (i = 0; i < nr_folios; i++) {
> +                       struct page *page = &fbatch.folios[i]->page;
>                         bool submitted = false;
>
>                         if (unlikely(f2fs_cp_error(sbi))) {
>                                 f2fs_put_page(last_page, 0);
> -                               pagevec_release(&pvec);
> +                               folio_batch_release(&fbatch);
>                                 ret = -EIO;
>                                 goto out;
>                         }
> @@ -1821,7 +1822,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>                                 break;
>                         }
>                 }
> -               pagevec_release(&pvec);
> +               folio_batch_release(&fbatch);
>                 cond_resched();
>
>                 if (ret || marked)
> --
> 2.36.1
>

Following up on these f2fs patches (11/23, 12/23, 13/23, 14/23, 15/23,
16/23). Does anyone have time to review them this week?
