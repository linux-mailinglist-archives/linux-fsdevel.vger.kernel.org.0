Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA9570E35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 01:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiGKXXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 19:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiGKXXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:23:01 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D06556D;
        Mon, 11 Jul 2022 16:23:01 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id d17so1473697qvs.0;
        Mon, 11 Jul 2022 16:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/q/fM8pNGaA4sNIIE9f0bEPPvZJEcYT1Nv2gU2H7qnM=;
        b=DH43PfgvO2Vp+AMP8vJHbck+6Pqy5UUqdD2H7+aU6J5AN2wicO1fb62Dp/OMmajpkc
         qVR3zhS7nNB6x6IJb9YS1ObTcLpOi8q91xYx6WBr4w/ThaFcU3gzz2KCX/c5n5nMD2L5
         qechc78Kkf4V9nx6m5muaMr/qxyQdy03fUPZSz9FKKIxNUHLpDDEyWNnAcv5TS0R8r2Z
         UFCmEY0MlMWnPSKaMg3Nel8n+IRSeTiAcMv3C1VwR/exv27JOTliXSeQ58p20QWTvDen
         DQf9/goZZJTMRUmYeX/An+sLTn4m+V5G8YjR9U+1q/HmJo0NyCFYpfgJqB/0up7sk0Ag
         QLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/q/fM8pNGaA4sNIIE9f0bEPPvZJEcYT1Nv2gU2H7qnM=;
        b=Eq7+zdEuo+AN+QCPsABJqqBj4cgSmqP8E+Cg9N6AgiErMlLPYHz8v2xISdzUdIld3X
         W9HyYU4verln7XoyqVPC3lF31pXhpLjVn1G+MmedawjJ8AOoOFw5IzI+7CxWT7jyBEch
         sFinh5KsBZXS/NOVrvEmN8hsLjsqG0AIx3RiZOmSmZ8r3i4Z9gext0V9sFuSmDa2gMnL
         TDA/TKz300QagqyB3AYWuPsWqhZVKmIM6qfg+UmfmVDIhmethunXW4auXfMIfdLXJk+O
         AobVUldVDvTfMq+8vEPxJvqDVM5Ny6Vp/oL5dtctGPy7xreTx8yUHmao5/QGEOqZmMZT
         GE5g==
X-Gm-Message-State: AJIora+QGZS09+MC5sRYmwT2qzSdrviPQDE7UWwUec044+P7cUqONuDA
        pJtkw15TyhY4yuXzpxPRDWV8qjl9uK2t+OvahnU=
X-Google-Smtp-Source: AGRyM1vnrYQM46zGtkGWwykcZ+hv0MaP+4jT834HK0M6B1yxWQKb5po7+H4f8Z/wUifUniMK2NXdhZPHi3yjNM0gaJw=
X-Received: by 2002:a05:6214:76d:b0:473:2a39:45fb with SMTP id
 f13-20020a056214076d00b004732a3945fbmr15539693qvz.129.1657581780221; Mon, 11
 Jul 2022 16:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220711041459.1062583-1-hch@lst.de> <20220711041459.1062583-3-hch@lst.de>
In-Reply-To: <20220711041459.1062583-3-hch@lst.de>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 12 Jul 2022 01:22:48 +0200
Message-ID: <CAHpGcMLFwN4toB2KD0EvPAgx3zchpGNfzUWfsJ-8dxmnOieCsQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] gfs2: remove ->writepage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
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

Am Mo., 11. Juli 2022 um 06:16 Uhr schrieb Christoph Hellwig <hch@lst.de>:
> ->writepage is only used for single page writeback from memory reclaim,
> and not called at all for cgroup writeback.  Follow the lead of XFS
> and remove ->writepage and rely entirely on ->writepages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/aops.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 106e90a365838..0240a1a717f56 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -81,31 +81,6 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
>         return 0;
>  }
>
> -/**
> - * gfs2_writepage - Write page for writeback mappings
> - * @page: The page
> - * @wbc: The writeback control
> - */
> -static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
> -{
> -       struct inode *inode = page->mapping->host;
> -       struct gfs2_inode *ip = GFS2_I(inode);
> -       struct gfs2_sbd *sdp = GFS2_SB(inode);
> -       struct iomap_writepage_ctx wpc = { };
> -
> -       if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl)))
> -               goto out;
> -       if (current->journal_info)
> -               goto redirty;
> -       return iomap_writepage(page, wbc, &wpc, &gfs2_writeback_ops);
> -
> -redirty:
> -       redirty_page_for_writepage(wbc, page);
> -out:
> -       unlock_page(page);
> -       return 0;
> -}
> -
>  /**
>   * gfs2_write_jdata_page - gfs2 jdata-specific version of block_write_full_page
>   * @page: The page to write
> @@ -765,7 +740,6 @@ bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask)
>  }
>
>  static const struct address_space_operations gfs2_aops = {
> -       .writepage = gfs2_writepage,
>         .writepages = gfs2_writepages,
>         .read_folio = gfs2_read_folio,
>         .readahead = gfs2_readahead,
> --
> 2.30.2
>

This is looking fine, and it has survived a moderate amount of testing already.

Tested-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

It should be possible to remove the .writepage operation in
gfs2_jdata_aops as well, but I must be overlooking something because
that actually breaks things.

Thanks,
Andreas
