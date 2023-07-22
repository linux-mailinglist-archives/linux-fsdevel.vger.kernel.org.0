Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB375D804
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGVAHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGVAHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:07:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37857E44;
        Fri, 21 Jul 2023 17:07:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so4038296e87.2;
        Fri, 21 Jul 2023 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689984421; x=1690589221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YuIgZ0kCdlWgwOipolMH4qwbkf4qo8GzSPfjGjifT9M=;
        b=B3Hme8dqaOXMsrPG2++TgbuKnjnbxyHIC+ORugqmopZwL1w8TJEChZufUpZKZR1PQq
         tOIy46NPX7iBctrWcZ1cseEMzbjLLKRJD3MY6izVCeb7CUBHq1JFi8n8XXsXOzHMMCXH
         sx8gn6dzNjDKuNgfW5k8AGYZX6oKrCw1CkMimOwfAoj412POis87U/94PR+7owwkLeOg
         k2z88VJTw5RViiSFqp+7NcIass1DiRMrYcSyqFU3tm8WBa7FbhJmZeTOr1v9kRzFhloX
         XXbnQ4Bs79CaLpJjTTc8drlWVkncvsKx3tk6AqeExXG1KFqazjwMLuz+PnhJtnhSUTe3
         nYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689984421; x=1690589221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuIgZ0kCdlWgwOipolMH4qwbkf4qo8GzSPfjGjifT9M=;
        b=RZw/q8/b8HLM7DwJK/I0gPQ/dPGXRz+uXv3ROOMwvX6e1EhjNCryv5u92nu6GyHld4
         Lk+RqmpIqZHzUeH/DXLGACTpvx37Ft0/3oaAUE2c5ltpp7W8mV01NXzOOJNmCsf/T2vQ
         h5T/ehqjMz/qfsAkZI5ym5PlbZEewTFqva/W4bZGrgC01VgJUmtYobgX6U3sFzmSGc1k
         +Sf+C5Er5kE8cC24BY5b3zfCko6oTkXf6jcxScNETfiBgAe1nVdWsavEQyPId4WWDd0e
         B7HBcZp6waUczOsBNJL58DafXUl+bNtv1YhcLxBGXbC7ezjkEpf/9YhuyH4a86Mb99Sx
         Ibnw==
X-Gm-Message-State: ABy/qLZy45R+IjW1wehjv6p6AU56ld9fW+Z70GWCDILUracSflqaq6tQ
        eSd92GNltG/6z3dW7lIEYKiS48HlDaQKs/4RgX8=
X-Google-Smtp-Source: APBJJlEz6MOY64ghyriSbK69kEtmWUCnsBm/JE0LJAyd4kPsue89R5aANO77pQOMG5YK4KrXGWPnwyYh2eFGvZj7XYk=
X-Received: by 2002:a05:6512:3da7:b0:4fb:52a3:e809 with SMTP id
 k39-20020a0565123da700b004fb52a3e809mr3283162lfv.28.1689984421181; Fri, 21
 Jul 2023 17:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035512.4139457-1-willy@infradead.org> <20230713035512.4139457-2-willy@infradead.org>
In-Reply-To: <20230713035512.4139457-2-willy@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Sat, 22 Jul 2023 02:06:50 +0200
Message-ID: <CAHpGcM+LQyXBC64EC=YJv4SQAT3HudKzsYyxpCuK=VFGr0XTZA@mail.gmail.com>
Subject: Re: [PATCH 1/7] highmem: Add memcpy_to_folio() and memcpy_from_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Do., 13. Juli 2023 um 06:04 Uhr schrieb Matthew Wilcox (Oracle)
<willy@infradead.org>:
> These are the folio equivalent of memcpy_to_page() and memcpy_from_page().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 68da30625a6c..0280f57d4744 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -439,6 +439,50 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
>         kunmap_local(addr);
>  }
>
> +static inline void memcpy_from_folio(char *to, struct folio *folio,
> +               size_t offset, size_t len)
> +{
> +       VM_BUG_ON(offset + len > folio_size(folio));
> +
> +       do {
> +               char *from = kmap_local_folio(folio, offset);
> +               size_t chunk = len;
> +
> +               if (folio_test_highmem(folio) &&
> +                   (chunk > (PAGE_SIZE - offset_in_page(offset))))
> +                       chunk = PAGE_SIZE - offset_in_page(offset);
> +               memcpy(to, from, len);

We want memcpy(to, from, chunk) here.

> +               kunmap_local(from);
> +
> +               from += chunk;
> +               offset += chunk;
> +               len -= chunk;
> +       } while (len > 0);
> +}
> +
> +static inline void memcpy_to_folio(struct folio *folio, size_t offset,
> +               const char *from, size_t len)
> +{
> +       VM_BUG_ON(offset + len > folio_size(folio));
> +
> +       do {
> +               char *to = kmap_local_folio(folio, offset);
> +               size_t chunk = len;
> +
> +               if (folio_test_highmem(folio) &&
> +                   (chunk > (PAGE_SIZE - offset_in_page(offset))))
> +                       chunk = PAGE_SIZE - offset_in_page(offset);
> +               memcpy(to, from, len);

And also here.

> +               kunmap_local(to);
> +
> +               from += chunk;
> +               offset += chunk;
> +               len -= chunk;
> +       } while (len > 0);
> +
> +       flush_dcache_folio(folio);
> +}
> +
>  /**
>   * memcpy_from_file_folio - Copy some bytes from a file folio.
>   * @to: The destination buffer.
> --
> 2.39.2
>

Thanks,
Andreas
