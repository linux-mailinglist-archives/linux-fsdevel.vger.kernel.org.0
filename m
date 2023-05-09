Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7756FCB8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjEIQnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEIQnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0E1BD3;
        Tue,  9 May 2023 09:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 053F462C5C;
        Tue,  9 May 2023 16:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4528C433EF;
        Tue,  9 May 2023 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683650628;
        bh=GH4ozPy6BUps1/YzqMqfSKcfN/+aGxS7E5VYZMBfEkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHZcLTJ6DhykdVVMqHJKEDZm2sxaYZVHw0gZWB8Q2QiIf9fGDT+Ii/NXmKjks2rg4
         9L3hMi4JKoEbtWSM5aR0t9iz+mvr97o7YV8lEYhrg95CfDcf3na0yv/OwaW7ct/QQE
         xtOapeboqMo+rZ8zieUimyvOKnnG0ZTzMdjIaYfVlxK3IARoSXgIrTDo8zQsiVx2II
         lN6KQB4U+RpSNFKHXFxWEIK6/1ewhUl3BDYu1f60a9M3Q/PaJWzGNkK7/QU9Kv8au2
         xb3ZuDsLzYM9vgzrykTdbuzqci7XtLBQJc9CTrh5moVUabH5ETISbwqpNuW9HWlal2
         GYJrgl+D4PE9A==
Date:   Tue, 9 May 2023 09:43:45 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/12] mm: page_alloc: squash page_is_consistent()
Message-ID: <20230509164345.GC4135@kernel.org>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
 <20230508071200.123962-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508071200.123962-6-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 03:11:53PM +0800, Kefeng Wang wrote:
> Squash the page_is_consistent() into bad_range() as there is
> only one caller.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/page_alloc.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9a85238f1140..348dcbaca757 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -517,13 +517,6 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>  	return ret;
>  }
>  
> -static int page_is_consistent(struct zone *zone, struct page *page)
> -{
> -	if (zone != page_zone(page))
> -		return 0;
> -
> -	return 1;
> -}
>  /*
>   * Temporary debugging check for pages not lying within a given zone.
>   */
> @@ -531,7 +524,7 @@ static int __maybe_unused bad_range(struct zone *zone, struct page *page)
>  {
>  	if (page_outside_zone_boundaries(zone, page))
>  		return 1;
> -	if (!page_is_consistent(zone, page))
> +	if (zone != page_zone(page))
>  		return 1;
>  
>  	return 0;
> -- 
> 2.35.3
> 
