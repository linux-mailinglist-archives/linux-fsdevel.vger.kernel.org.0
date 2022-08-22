Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDA59C672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiHVSd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiHVSdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:33:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F6491F4;
        Mon, 22 Aug 2022 11:32:57 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r10so7426267oie.1;
        Mon, 22 Aug 2022 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1xmFogWnIvNdwdlTrmK1SuS0i1HcmsumGSpd55c4S+w=;
        b=CDJxFqDsz6m7yWC8X5zRoIOEGYNzekCGsaOVwkt6QczVj+STJ1R922UNcn3Oq9GUkY
         2UlYqMlLOAaZibfiiSSqAZslrtE/X+Ec3Ym9+QXTwJIP2ToNlqpq3TeR5JEm8ieo+Kub
         SjufC2NY3OMN791+w34Co01GCTlYi6rcaQHkLizmBqr9kOJs1OpwMiM94mGRtnjkEQIN
         0SBLacC2QHAblNrceey4IaD4tM/7stLpiRRtQ3/ColisGrPXJr5ojJn78dA8/Vs/Sc3Q
         r+k2MESQINePiU2imFYlSc4vkr4xHmOiDaY1yx5OlnD5e2y7zq9uxdUX7cFsmZHXC+N0
         gOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1xmFogWnIvNdwdlTrmK1SuS0i1HcmsumGSpd55c4S+w=;
        b=Qx49LTJUCHZ8Eazk0716nSGaMOUWLH5EMgbMwN4JKbALiBn8Scj0lEO0ILWLjm5ugG
         XN0MQglRQqxfXtAEpDlDKBsZCHtMYKAPoUa/s4VC3Ylq+j2pGsHKahchxe17MVI/odcQ
         8SJYADNsTF3UnaXxj6Gg4wkPOgkfZbVtNZlR2oGQZSSYn9j/JQec3/Lin9Z1+Er07lfn
         gnRSAeQhUTOvggjCtpufARJSU4Vk75Prq/Gt/ygmSyp1Um6bv2lu0qAbgZBOh3J1BpAk
         pIt0+4gETv3ppVIqygCAJ/3RilLrWh93QU6dAqUdjyc0idfN82gUGk+Rjt1KhgCWaDV6
         cDnQ==
X-Gm-Message-State: ACgBeo03vdQAwzlBQREELiMVXfld9kT6cSD6x+V20S6kafOt2Fkf8xpV
        j3zGLs1qDLek7EXBQuBvkjPHEllD8ceP8FntIvYgkJMAXflYPw==
X-Google-Smtp-Source: AA6agR4vtM0FyDcPYwh7ADQGjGUQShqkGdAo04DYUDZFMQVDgFU+/mrcQsSqoiz3gGxDcd0r/01ksxOHm3ktF3jWSE8=
X-Received: by 2002:a05:6808:1c03:b0:345:20f7:926d with SMTP id
 ch3-20020a0568081c0300b0034520f7926dmr8709061oib.47.1661193176554; Mon, 22
 Aug 2022 11:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220816175246.42401-1-vishal.moola@gmail.com> <20220816175246.42401-3-vishal.moola@gmail.com>
In-Reply-To: <20220816175246.42401-3-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 22 Aug 2022 11:32:45 -0700
Message-ID: <CAOzc2pwCRrz55Swikywucq=yO3t6zGM9gx+qMuqF89vo6kdCKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] btrfs: Convert __process_pages_contig() to use filemap_get_folios_contig()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:53 AM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Convert to use folios throughout. This is in preparation for the removal of
> find_get_pages_contig(). Now also supports large folios.
>
> Since we may receive more than nr_pages pages, nr_pages may underflow.
> Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
> with this check instead.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8f6b544ae616..f16929bc531b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1882,9 +1882,8 @@ static int __process_pages_contig(struct address_space *mapping,
>         pgoff_t start_index = start >> PAGE_SHIFT;
>         pgoff_t end_index = end >> PAGE_SHIFT;
>         pgoff_t index = start_index;
> -       unsigned long nr_pages = end_index - start_index + 1;
>         unsigned long pages_processed = 0;
> -       struct page *pages[16];
> +       struct folio_batch fbatch;
>         int err = 0;
>         int i;
>
> @@ -1893,16 +1892,17 @@ static int __process_pages_contig(struct address_space *mapping,
>                 ASSERT(processed_end && *processed_end == start);
>         }
>
> -       if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
> +       if ((page_ops & PAGE_SET_ERROR) && start_index <= end_index)
>                 mapping_set_error(mapping, -EIO);
>
> -       while (nr_pages > 0) {
> -               int found_pages;
> +       folio_batch_init(&fbatch);
> +       while (index <= end_index) {
> +               int found_folios;
> +
> +               found_folios = filemap_get_folios_contig(mapping, &index,
> +                               end_index, &fbatch);
>
> -               found_pages = find_get_pages_contig(mapping, index,
> -                                    min_t(unsigned long,
> -                                    nr_pages, ARRAY_SIZE(pages)), pages);
> -               if (found_pages == 0) {
> +               if (found_folios == 0) {
>                         /*
>                          * Only if we're going to lock these pages, we can find
>                          * nothing at @index.
> @@ -1912,23 +1912,20 @@ static int __process_pages_contig(struct address_space *mapping,
>                         goto out;
>                 }
>
> -               for (i = 0; i < found_pages; i++) {
> +               for (i = 0; i < found_folios; i++) {
>                         int process_ret;
> -
> +                       struct folio *folio = fbatch.folios[i];
>                         process_ret = process_one_page(fs_info, mapping,
> -                                       pages[i], locked_page, page_ops,
> +                                       &folio->page, locked_page, page_ops,
>                                         start, end);
>                         if (process_ret < 0) {
> -                               for (; i < found_pages; i++)
> -                                       put_page(pages[i]);
>                                 err = -EAGAIN;
> +                               folio_batch_release(&fbatch);
>                                 goto out;
>                         }
> -                       put_page(pages[i]);
> -                       pages_processed++;
> +                       pages_processed += folio_nr_pages(folio);
>                 }
> -               nr_pages -= found_pages;
> -               index += found_pages;
> +               folio_batch_release(&fbatch);
>                 cond_resched();
>         }
>  out:
> --
> 2.36.1
>
Just following up on these btrfs patches (2/7, 3/7, 4/7). Does anyone have
time to review them this week? Feedback would be appreciated.
