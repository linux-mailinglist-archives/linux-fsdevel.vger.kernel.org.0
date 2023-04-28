Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4F6F18C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 15:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjD1NFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1NFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:05:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65780BA
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 06:05:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so60359075e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682687121; x=1685279121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSt0RtlbxiTLFgZswm8SDrrlvl863ws9NMPFQoQtl8w=;
        b=AdZXk+fd10lkc7TgYOIiv3Pw9RDzM+biEMuQOnl8cbAiGNuARsaxOlYKSHE+3hA7Gp
         vX7F/dT/KHkxrIGHP+rDCzfVVxfq9JF8TF0g14TKgUZxzS+F/Li2OCLifB1YbPGA5LjQ
         ODHB/CvH1vxFibUPzQot3ZP5nWpXJbkqV0udXZDI0aHqX8fb7aaX2X5Dy6Znih3/Virv
         8po9+BE2z4/pyK4qSKOkHGQYXQiGGlQKOYCY3wgJeYSBMPshe27e7mnUygOu6N1SxBTq
         zwZIxGUOc74rCVrpGKjZBRHF0wM+VKKC+4AK7S893s3hPVl6K+HkQN7EFgf2wPyIhbE0
         qBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682687121; x=1685279121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSt0RtlbxiTLFgZswm8SDrrlvl863ws9NMPFQoQtl8w=;
        b=jchod6gtsg+jcI8EiX11o6RGode2Cy5FHpQbRm5qF5TzKEUbW9+lQyR7gCrgXy4+rY
         9lrbaNVKDeS1dsWOlHIW8tD9t1e5YqG+0cxDpDiyVETrFfI+w/jf+5xKlHWhiTk3mIxq
         5eL7zp2ESCeVIxPbGJ1zk7+cVJQOFBOYtETVUBirJBA9zlYIWWgu0kpyfm/tnDVR/1Qw
         1+toK+9oPwCMYh+EHeor0wD7WDwAaqz9kwX/1QDL90tv/ViLKzVuTCLjGCf8C3WEdsrw
         k/ihNTwIubJmG3ntsqMkw1UKGCkTVHdFmFNEgGZXJRwFeGMIfbNmw2fxmMLjM9bVKmGw
         Ypqw==
X-Gm-Message-State: AC+VfDwKJIVqYRSHAFviSaKdqVlve6sGc5phyXdjx2KYaN4Thrndfnpm
        LpXtN0BNU2wWh6kyhQ1fff8=
X-Google-Smtp-Source: ACHHUZ71kI22W54XJU+TbhqzB0BMpzy+527375BLxEaYpZFQ/nEBzz0uGq2wkun4djs/UT23uCYAPw==
X-Received: by 2002:a1c:7502:0:b0:3f1:6880:3308 with SMTP id o2-20020a1c7502000000b003f168803308mr4275013wmc.1.1682687120542;
        Fri, 28 Apr 2023 06:05:20 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003f31d44f0cbsm3489708wmg.29.2023.04.28.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:05:19 -0700 (PDT)
Date:   Fri, 28 Apr 2023 14:05:19 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-ID: <c7556659-30fa-4a33-aa20-643d60ba9278@lucifer.local>
References: <20230428124140.30166-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
>
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/vmscan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> This was the non-controversial part of my series [1] dealing with pinned pages
> in filesystems. It is already a win as it avoids crashes in the filesystem and
> we can drop workarounds for this in ext4. Can we merge it please?
>
> [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf3eedf0209c..401a379ea99a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			}
>  		}
>
> +		/*
> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> +		 * No point in trying to reclaim folio if it is pinned.
> +		 * Furthermore we don't want to reclaim underlying fs metadata
> +		 * if the folio is pinned and thus potentially modified by the
> +		 * pinning process as that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +
>  		mapping = folio_mapping(folio);
>  		if (folio_test_dirty(folio)) {
>  			/*
> --
> 2.35.3
>

This seems very sensible and helps ameliorate problematic GUP/file
interactions so this seems a no-brainer.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
