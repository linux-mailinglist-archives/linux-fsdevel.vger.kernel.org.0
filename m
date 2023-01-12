Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486BF667D33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbjALSAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 13:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbjALSAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:00:08 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B15E0BF;
        Thu, 12 Jan 2023 09:20:02 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e76so19458633ybh.11;
        Thu, 12 Jan 2023 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+c881Dpe/85Aq62y2qtNDOsySQkmPy3VHLSOKalLuM=;
        b=Pc/Xg/kvl8DhMy2mV5DSv0JY0A6VI9FAm0F9VYc/dWZQyf9ydWoM7408OMWs2Kt4+S
         eCo3wgwd+MlvDDhfoUGkDIHkrJCrglJGkVPgM1Oz/eqrjqRxIUt6ATz63+Zu6orRFNgG
         FQGLvnnrHoT7dPPaTZzgvM7ZMRU4T4kxqvK2dz+jrBacryTz+KXjnEm1lE9Im5xoXhH6
         uaeXjEyPwqRZI6/5GVgzLBgcQ8qcs+by+yaLr7atp5Urs68114vwsX10TNqGRNH04pMs
         QclnYeakKcSogdPbUF9XgR9U7I3ZKCshjFY/gZue60/KZOW51I77izQ6dwI6z0pu5/hK
         x6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+c881Dpe/85Aq62y2qtNDOsySQkmPy3VHLSOKalLuM=;
        b=VDaqOA08Dm5H79a2XQauxlLeiIwYmNVaZ11oQvcBhE6nWnUgIBx1IpBMRkT/lBa1dt
         eGSBZgy9hi7DcHoe+i5UE2WtPJVZdKmpqp9WHovW/5de0uNyG/1WMdH1Ro1zhX4jvDEO
         ZaxyZ7WsPWXFpeCm/kbh6y5hFBz1i8NvOi9NA+pqkNvNAIUu51rh1MfrGyN3cCiPp0Wc
         T8x2HCn/ZWXpC/Bk4jeh4+5ylYpns5JzGVYKwG/MXvC6NgkjWaT6IquLDfBX2I1VB7gO
         ZKX/MSAa95yt8Oth45WCJprkFyekCfekbfudJobSYt6PQplcvJNdZ957Od8xcsLQ3VX2
         rpyw==
X-Gm-Message-State: AFqh2kp/O7oF3w3q4s9aoAvr5fSGxJLk37f2aBMaOvFhm+N2H1NtDF/D
        z3eeBHT0G8PHPMhE59QuabMNPqJue1uSmMVHxt3Nl38KcYUYPQ==
X-Google-Smtp-Source: AMrXdXsAU7a6oM1sLrHI9+oxo29VzkKN9mlRylNCqKeDfYmz3uqWRlBtx5f1lx9/AgauD4UB5gGLFmj2h4TGKEvLRKQ=
X-Received: by 2002:a25:8a:0:b0:7ca:7f22:5c15 with SMTP id 132-20020a25008a000000b007ca7f225c15mr196720yba.219.1673544001120;
 Thu, 12 Jan 2023 09:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20230104211448.4804-1-vishal.moola@gmail.com> <20230104211448.4804-10-vishal.moola@gmail.com>
In-Reply-To: <20230104211448.4804-10-vishal.moola@gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 12 Jan 2023 09:19:50 -0800
Message-ID: <CAOzc2pw9WCgHyA2epbz5=HEWN4bFzD4C7zL2452J_egv7iSLrw@mail.gmail.com>
Subject: Re: [PATCH v5 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
To:     linux-fsdevel@vger.kernel.org, pc@cjr.nz, tom@talpey.com
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
> This is in preparation for the removal of find_get_pages_range_tag(). Now also
> supports the use of large folios.
>
> Since tofind might be larger than the max number of folios in a
> folio_batch (15), we loop through filling in wdata->pages pulling more
> batches until we either reach tofind pages or run out of folios.
>
> This function may not return all pages in the last found folio before
> tofind pages are reached.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/cifs/file.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 22dfc1f8b4f1..8cdd2f67af24 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2527,14 +2527,40 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
>                           unsigned int *found_pages)
>  {
>         struct cifs_writedata *wdata;
> -
> +       struct folio_batch fbatch;
> +       unsigned int i, idx, p, nr;
>         wdata = cifs_writedata_alloc((unsigned int)tofind,
>                                      cifs_writev_complete);
>         if (!wdata)
>                 return NULL;
>
> -       *found_pages = find_get_pages_range_tag(mapping, index, end,
> -                               PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
> +       folio_batch_init(&fbatch);
> +       *found_pages = 0;
> +
> +again:
> +       nr = filemap_get_folios_tag(mapping, index, end,
> +                               PAGECACHE_TAG_DIRTY, &fbatch);
> +       if (!nr)
> +               goto out; /* No dirty pages left in the range */
> +
> +       for (i = 0; i < nr; i++) {
> +               struct folio *folio = fbatch.folios[i];
> +
> +               idx = 0;
> +               p = folio_nr_pages(folio);
> +add_more:
> +               wdata->pages[*found_pages] = folio_page(folio, idx);
> +               folio_get(folio);
> +               if (++*found_pages == tofind) {
> +                       folio_batch_release(&fbatch);
> +                       goto out;
> +               }
> +               if (++idx < p)
> +                       goto add_more;
> +       }
> +       folio_batch_release(&fbatch);
> +       goto again;
> +out:
>         return wdata;
>  }
>
> --
> 2.38.1
>

Could someone review this cifs patch, please? This is one of the
2 remaining patches that need to be looked at in the series.
