Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5A4D6554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbiCKPyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 10:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiCKPxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:53:51 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154DB1CD7E9;
        Fri, 11 Mar 2022 07:51:47 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id r13so20007249ejd.5;
        Fri, 11 Mar 2022 07:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0QOdS1sMxvUzRYvahLqWBcTBPRVF3/VPDGumtpDOcQ=;
        b=BDheWuGFye9IiR1KGHqUTwkqweTfiCTEYX/DNvA+2sqyJFtsSb1vKBStMbIurshjIP
         5/D9BN5e8igaKU9esTafkMqZzhydhRFEqcX9uufk8qdM5F2CVG+VA2xrrbS0huG9cnHM
         SnA1iCB4PNAuKJnuJR8ppvklin1nK9iSS4u44ZZb48ptQW5+4ROcGxgQpSQSkfGqyVhs
         UfAC20/7xqUBUmisJEP3Xtkkrc2egZJC3UyJC+Wbw8/CsZPj1SunB+yyi/15ijwKfq/D
         YIjrUW7Tnia3e2FuXQkCh2OPlB80piCIG+h+JinWldmAeot31tISu/EFd5kzZfx3uGuA
         8/sg==
X-Gm-Message-State: AOAM530i8amohfbzPcUEM8B1TT/v1hIF0FZMpQ1tvad9xnpHC3Ojh1pp
        INHfiIyZtWSl0qxNhRiDT78q6+gehvnF1A==
X-Google-Smtp-Source: ABdhPJzo8iL4yZTpJU9GQSnP1+ZNVyW0eV4fvlgcCN8v/286An0s/RQv4YnJOdskbZ376f0itYm2Mg==
X-Received: by 2002:a17:907:6d14:b0:6d9:565a:ed0 with SMTP id sa20-20020a1709076d1400b006d9565a0ed0mr9074772ejc.331.1647013891268;
        Fri, 11 Mar 2022 07:51:31 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm3039654ejh.204.2022.03.11.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 07:51:30 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id q20so5363378wmq.1;
        Fri, 11 Mar 2022 07:51:30 -0800 (PST)
X-Received: by 2002:a05:600c:2250:b0:383:bab2:9df5 with SMTP id
 a16-20020a05600c225000b00383bab29df5mr8274340wmm.162.1647013890307; Fri, 11
 Mar 2022 07:51:30 -0800 (PST)
MIME-Version: 1.0
References: <164692725757.2097000.2060513769492301854.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692725757.2097000.2060513769492301854.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Fri, 11 Mar 2022 11:51:16 -0400
X-Gmail-Original-Message-ID: <CAB9dFdsROMZoE85dytrw_YynGArhC4d1pwNPfqbrMVGm8+jXMQ@mail.gmail.com>
Message-ID: <CAB9dFdsROMZoE85dytrw_YynGArhC4d1pwNPfqbrMVGm8+jXMQ@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix potential thrashing in afs writeback
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:47 AM David Howells <dhowells@redhat.com> wrote:
>
> In afs_writepages_region(), if the dirty page we find is undergoing
> writeback or write to cache, but the sync_mode is WB_SYNC_NONE, we go round
> the loop trying the same page again and again with no pausing or waiting
> unless and until another thread manages to clear the writeback and fscache
> flags.
>
> Fix this with three measures:
>
>  (1) Advance the start to after the page we found.
>
>  (2) Break out of the loop and return if rescheduling is requested.
>
>  (3) Arbitrarily give up after a maximum of 5 skips.
>
> Fixes: 31143d5d515e ("AFS: implement basic file write support")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/afs/write.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 85c9056ba9fb..bd0201f4939a 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -701,7 +701,7 @@ static int afs_writepages_region(struct address_space *mapping,
>         struct folio *folio;
>         struct page *head_page;
>         ssize_t ret;
> -       int n;
> +       int n, skips = 0;
>
>         _enter("%llx,%llx,", start, end);
>
> @@ -752,8 +752,15 @@ static int afs_writepages_region(struct address_space *mapping,
>  #ifdef CONFIG_AFS_FSCACHE
>                                 folio_wait_fscache(folio);
>  #endif
> +                       } else {
> +                               start += folio_size(folio);
>                         }
>                         folio_put(folio);
> +                       if (wbc->sync_mode == WB_SYNC_NONE) {
> +                               if (skips >= 5 || need_resched())
> +                                       break;
> +                               skips++;
> +                       }
>                         continue;
>                 }

Looks good in testing, the problem would show up in xfstests generic/285.

Tested-by: Marc Dionne <marc.dionne@auristor.com>
Acked-by: Marc Dionne <marc.dionne@auristor.com>

Marc
