Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03260BC2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiJXVbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiJXVav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:30:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125FF97EDD;
        Mon, 24 Oct 2022 12:37:24 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-368edbc2c18so94377387b3.13;
        Mon, 24 Oct 2022 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OhQpzoeVGEwmo14h6MNRUCVjD46EBvZeUnXF6FjYKqc=;
        b=LWqs5CgYoI2G7bwSrxm509BXkoJoj4h1+NAumrnw8GvlsTUUX0V7puTaejDjA+a+Se
         JZxLEhr98Isu6X1gDcr7CkjpAxT8QlsxaP3cMesu5io+uJ/hiaxizHNPmkvonW4ZrSM3
         9FJelnA+mhjpIKDB4wzNLTg8Yl25Bz2AgN5mLB8NjrqH3r4M0xDO+raYYo0KOsCBYSik
         v9TQ8VEWW7hntj+Pu46z7CX8Gt3ApfbvP2i70kguAt+Ou14BtRsnM5RXks+7xrvrVctd
         Sdn2UK8OpZrhDItYKOmqTRxqsyQ+eocL2ZMu5oL7CUQlM4vOpL4lrxfytXhVZRRPAgrU
         MCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhQpzoeVGEwmo14h6MNRUCVjD46EBvZeUnXF6FjYKqc=;
        b=heEoh4/Yztkfi7Fe3Z+xAG6aD+gs7Q1C8tkpHBUoQVAaJI3ZtnFZgt+RJtQdfw9Pna
         GYBOS2afr4d3iYbwV/WwyAzKYhnqHafNwlCW1lwRdXuNSE4Kvs832YIieMQYZQuoYd7U
         PvEfI+3diuTorT4gH8TkmO3Pn5TNhtnVmhTtMNQ3h2bT4FMtnONuvuWxAhU8ZtGgbitu
         Cz0/bk4Peb7Yk3tEJ4mjWyVeolngNkTlEzibTDzUQf5v4CaEIeMf/wpF/1dkNl7yqYVL
         KxvCyUu78+sYNWI38UjvpzKlByQH4OwPAOe/l1rITpNP+m8EYRxCD1A/3Xsq+7tXMX6E
         /+5g==
X-Gm-Message-State: ACrzQf3E1V+PgAGtQ013UvJWJskVgrSwAuIdwl8ttVw+m7KNocO8Dlqv
        XEs66wR9OEwpP/GUP189U2w4nY8u9pLaNzglaNHck+9ZeCg=
X-Google-Smtp-Source: AMsMyM7XF706RQysgvnkUL+jiUes9sa+q4VpOE9nihO77SiOflxp7+5NwMrZHWz4l1+JriXP7Udvq8USTVKNN8z/wRE=
X-Received: by 2002:a81:71c6:0:b0:36a:5682:2c44 with SMTP id
 m189-20020a8171c6000000b0036a56822c44mr14328584ywc.308.1666640181761; Mon, 24
 Oct 2022 12:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-2-vishal.moola@gmail.com>
In-Reply-To: <20221017202451.4951-2-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 24 Oct 2022 12:36:10 -0700
Message-ID: <CAOzc2py2E_zFukvSv-BcDm+mJis44Zp0fksd49mudMkU52HpZA@mail.gmail.com>
Subject: Re: [PATCH v3 01/23] pagemap: Add filemap_grab_folio()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
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

On Mon, Oct 17, 2022 at 1:24 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Add function filemap_grab_folio() to grab a folio from the page cache.
> This function is meant to serve as a folio replacement for
> grab_cache_page, and is used to facilitate the removal of
> find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/linux/pagemap.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bbccb4044222..74d87e37a142 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -547,6 +547,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
>         return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
>  }
>
> +/**
> + * filemap_grab_folio - grab a folio from the page cache
> + * @mapping: The address space to search
> + * @index: The page index
> + *
> + * Looks up the page cache entry at @mapping & @index. If no folio is found,
> + * a new folio is created. The folio is locked, marked as accessed, and
> + * returned.
> + *
> + * Return: A found or created folio. NULL if no folio is found and failed to
> + * create a folio.
> + */
> +static inline struct folio *filemap_grab_folio(struct address_space *mapping,
> +                                       pgoff_t index)
> +{
> +       return __filemap_get_folio(mapping, index,
> +                       FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +                       mapping_gfp_mask(mapping));
> +}
> +
>  /**
>   * find_get_page - find and get a page reference
>   * @mapping: the address_space to search
> --
> 2.36.1
>

Following up on the filemap-related patches (01/23, 02/23, 03/23, 04/23),
does anyone have time to review them this week?
