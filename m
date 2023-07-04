Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66374782A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGDSHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 14:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDSHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB2910C9;
        Tue,  4 Jul 2023 11:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3577861329;
        Tue,  4 Jul 2023 18:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2238BC433C7;
        Tue,  4 Jul 2023 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688494020;
        bh=ax5aSQO7Q8i6scQMJDEtYLdG7HxPbixeLmpQBL1NGoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LiSYfNW4TUnYtrQLCm6LWhvyq7sD/au+ZwfSvS7XN04La/WLKynldo0dtKtmTTBwL
         WunDie3WP/NVO2OTkEben6uoo40mXyy3iL4tIc0/SXP+KDsfcah/LL3k2H6Nid4f1F
         iT9+PXkbHIQqe5sPUk5oPnCMOivXMUqefaaSpfF8=
Date:   Tue, 4 Jul 2023 11:06:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <wsd_upstream@mediatek.com>, <casper.li@mediatek.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH] fs: drop_caches: draining pages before dropping caches
Message-Id: <20230704110659.3e1de8001f9208e7278352e8@linux-foundation.org>
In-Reply-To: <20230630092203.16080-1-andrew.yang@mediatek.com>
References: <20230630092203.16080-1-andrew.yang@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jun 2023 17:22:02 +0800 Andrew Yang <andrew.yang@mediatek.com> wrote:

> We expect a file page access after dropping caches should be a major
> fault, but sometimes it's still a minor fault. That's because a file
> page can't be dropped if it's in a per-cpu pagevec. Draining all pages
> from per-cpu pagevec to lru list before trying to drop caches.
> 
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

um, yes.  I'm suprised that this oversight has survived 20+ years.
