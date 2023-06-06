Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83227250C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 01:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbjFFX0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 19:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbjFFX0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:26:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFBA10D4
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 16:26:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so57835431fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686093974; x=1688685974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2FxAGdDZl5bgEmc1sdGZWqw52ArESB47KTKiPcLPLY=;
        b=VJSPZQAPizAr7CFQFRUuDISOpjQ0ltuXz7UN4Ab+0mqiOke4nA1UHE4Sv3PpURk+gA
         uf/wVXZUvSswUWcdK1FOz+uDdwI902ZdYt+NWjXdHguyuNR4FPgvgRgy8T6/B2YqoKil
         YtVXcNQabSsL5Qjvflg8PDOLA5upkH2cecynLgDviK+VdmA3X3kI2ThsMTNqPfCBwoxG
         ilMB49X+NKJjHi6qEmEVJ7DnOWPSdBfIRXAmprN85eS4cfWaP763j2QXAQMefabx+eOT
         veGO37EO4dTtm+mPPJbZ/o8jRVI6fN2kpA0oaJiWZeT/ZbSbaLvK0fjCfv+UeHhcBIue
         CuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093974; x=1688685974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2FxAGdDZl5bgEmc1sdGZWqw52ArESB47KTKiPcLPLY=;
        b=aMEh4jJbYucv6SQVnI0fuRbhEiv8XYnPE42JLR4jvew/f+lNViBFxe3zsVElrBYWgF
         ZDFNfZ0poiCwh6OZSLtHqoJVO2YyqOchbusERP77NMC8XxwnZKEACN7CiUMwdhUhZgj+
         7EzDvF34Kv7lXTVANw7+C5CeJM1IVFQH17tow0PwfeeebPLibzbn/LS7S5IqpkthNJ7i
         2Pq9Wb0423vtLzGUz/G7ehRL2IYgOQTNauuzZo0mkREmBqjVlkQihCp/T+C4X46zrvj5
         oyX+lM4WOw4/mZ5gjkKM0H5hRX0r3/q/5x5IZ4UdyZNelJeVL99UOOLrL3f5zh6U757I
         tvWA==
X-Gm-Message-State: AC+VfDw1KobuZlttCDS39yGoORN/1wH7X/6CmKDAR85Yd7Po+hZkjI0m
        UfUVjpysnE3MvJflhdj/ATO6AuZeVAVLKEN5jk4=
X-Google-Smtp-Source: ACHHUZ6SfjaRP3YtOFCNS4yCdkaqCJ8teFuVo8Ikffok1F9vmEH88dw9R12b5x5lWvL8FyzMuYNeHdepsTrMY/MYU40=
X-Received: by 2002:a2e:7e03:0:b0:2af:1622:a69 with SMTP id
 z3-20020a2e7e03000000b002af16220a69mr1857907ljc.48.1686093974222; Tue, 06 Jun
 2023 16:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230606223346.3241328-1-willy@infradead.org> <20230606223346.3241328-8-willy@infradead.org>
In-Reply-To: <20230606223346.3241328-8-willy@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 7 Jun 2023 01:26:03 +0200
Message-ID: <CAHpGcMJgZ3ik4NBW5fY-3nZcQRF+GCfJ=S9+mtndokOi8Lc1fA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] buffer: Convert block_page_mkwrite() to use a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
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

Am Mi., 7. Juni 2023 um 00:48 Uhr schrieb Matthew Wilcox (Oracle)
<willy@infradead.org>:
> If any page in a folio is dirtied, dirty the entire folio.  Removes a
> number of hidden calls to compound_head() and references to page->mapping
> and page->index.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d8c2c000676b..f34ed29b1085 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2564,38 +2564,37 @@ EXPORT_SYMBOL(block_commit_write);
>  int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>                          get_block_t get_block)
>  {
> -       struct page *page = vmf->page;
> +       struct folio *folio = page_folio(vmf->page);
>         struct inode *inode = file_inode(vma->vm_file);
>         unsigned long end;
>         loff_t size;
>         int ret;
>
> -       lock_page(page);
> +       folio_lock(folio);
>         size = i_size_read(inode);
> -       if ((page->mapping != inode->i_mapping) ||
> -           (page_offset(page) > size)) {
> +       if ((folio->mapping != inode->i_mapping) ||
> +           (folio_pos(folio) > size)) {

This should probably also be 'folio_pos(folio) >= size', but this was
wrong before this patch already.

>                 /* We overload EFAULT to mean page got truncated */
>                 ret = -EFAULT;
>                 goto out_unlock;
>         }
>
> -       /* page is wholly or partially inside EOF */
> -       if (((page->index + 1) << PAGE_SHIFT) > size)
> -               end = size & ~PAGE_MASK;
> -       else
> -               end = PAGE_SIZE;
> +       end = folio_size(folio);
> +       /* folio is wholly or partially inside EOF */
> +       if (folio_pos(folio) + end > size)
> +               end = size - folio_pos(folio);
>
> -       ret = __block_write_begin(page, 0, end, get_block);
> +       ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
>         if (!ret)
> -               ret = block_commit_write(page, 0, end);
> +               ret = block_commit_write(&folio->page, 0, end);
>
>         if (unlikely(ret < 0))
>                 goto out_unlock;
> -       set_page_dirty(page);
> -       wait_for_stable_page(page);
> +       folio_set_dirty(folio);
> +       folio_wait_stable(folio);
>         return 0;
>  out_unlock:
> -       unlock_page(page);
> +       folio_unlock(folio);
>         return ret;
>  }
>  EXPORT_SYMBOL(block_page_mkwrite);
> --
> 2.39.2
>

Thanks,
Andreas
