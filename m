Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D397459F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGCKRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGCKRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B9C9;
        Mon,  3 Jul 2023 03:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47A1360EAD;
        Mon,  3 Jul 2023 10:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27205C433C9;
        Mon,  3 Jul 2023 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688379422;
        bh=Ny5BGLb0fUO45nms2Ulce0zlZ8XNNtXNnuA6dwqjEBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N48t31dmHrvPkjWqY/Baq5NMlwFHpF/7g/ejXfLwkkPN42h5TOXItvma+bxHIp+jm
         Be0k1GcbbozhqawxgxQ9ckWmybPEkUlvoR9e3y1UyKVALxXzW/pPdkR9hHqr/iSdT4
         KtIfKN2z/s/hK/pY0Q2lVADesdGmfW/yun/6rNax7EQfnaHXhp7uGAetlmtb6hRiFF
         9pVWWJ+WHTLS+XS6sXe/ol5Nn/BuiOV3HkRU1rK+AcUuxMlj0YftQB0xU7RSHNZe3q
         YdkBiGSeWYiXLYG+WOf3YVelcAYE+XuLl6TwnNB5nt1TDV7sYP7EF9CUqrn7ooo++S
         butW0UvCnz+qA==
Date:   Mon, 3 Jul 2023 12:16:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrew Yang <andrew.yang@mediatek.com>, linux-mm@kvack.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, casper.li@mediatek.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: drop_caches: draining pages before dropping caches
Message-ID: <20230703-freifahrt-dachwohnung-49d858588e88@brauner>
References: <20230630092203.16080-1-andrew.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630092203.16080-1-andrew.yang@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Really more suitable for -mm to review.

On Fri, Jun 30, 2023 at 05:22:02PM +0800, Andrew Yang wrote:
> We expect a file page access after dropping caches should be a major
> fault, but sometimes it's still a minor fault. That's because a file
> page can't be dropped if it's in a per-cpu pagevec. Draining all pages
> from per-cpu pagevec to lru list before trying to drop caches.
> 
> Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
> ---
>  fs/drop_caches.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index e619c31b6bd9..b9575957a7c2 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -10,6 +10,7 @@
>  #include <linux/writeback.h>
>  #include <linux/sysctl.h>
>  #include <linux/gfp.h>
> +#include <linux/swap.h>
>  #include "internal.h"
>  
>  /* A global variable is a bit ugly, but it keeps the code simple */
> @@ -59,6 +60,7 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  		static int stfu;
>  
>  		if (sysctl_drop_caches & 1) {
> +			lru_add_drain_all();
>  			iterate_supers(drop_pagecache_sb, NULL);
>  			count_vm_event(DROP_PAGECACHE);
>  		}
> -- 
> 2.18.0
> 
