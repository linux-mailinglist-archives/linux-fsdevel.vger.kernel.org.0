Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0526EC42B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 05:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjDXDux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 23:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDXDuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92167E67;
        Sun, 23 Apr 2023 20:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMKfR83C0B9dH2cTA6vwCV+ysD6ryGT7DeWsaB7/c50=; b=N0bDuxkmi9sVSIOfVXutZqafhZ
        0AVoZT5UTfmlDIZIveXnpkydkBXLTY6lQ+kGH3SbF4/FPb5f+byVW8CZ/sQaLwhzhSKz4YXmxK/pR
        47m8xz+tbvD+KpDB6UIQhZTkGm9OMf2MNroA6WguHK3l75As47J05GKaLwVgJ8Enzo8jGR4OrwVH1
        wNGUejgNjW8RcnAj74fzudaKH9Ja28uweMncZl9j7ohZf4GZPf9QVjvJRsw1WuEUNsHYdlQCOgkxq
        DmEnii623QUp5pfcLLs1KTEuXJ8Qk5y9gxy998/CUSojHgP7qg+n68aHQE4/AKrYqXrxM0r13YrKO
        u816BZ+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pqnDp-00046U-JS; Mon, 24 Apr 2023 03:50:37 +0000
Date:   Mon, 24 Apr 2023 04:50:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
Message-ID: <ZEX8jV/FQm2gL+2j@casper.infradead.org>
References: <20230424030756.1795926-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424030756.1795926-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:07:56AM +0800, Yajun Deng wrote:
> Instead of define an index and determining if the zone has memory,
> introduce for_each_populated_zone_pgdat() helper that can be used
> to iterate over each populated zone in pgdat, and convert the most
> obvious users to it.

I don't think the complexity of the helper justifies the simplification
of the users.

> +++ b/include/linux/mmzone.h
> @@ -1580,6 +1580,14 @@ extern struct zone *next_zone(struct zone *zone);
>  			; /* do nothing */		\
>  		else
>  
> +#define for_each_populated_zone_pgdat(zone, pgdat, max) \
> +	for (zone = pgdat->node_zones;                  \
> +	     zone < pgdat->node_zones + max;            \
> +	     zone++)                                    \
> +		if (!populated_zone(zone))		\
> +			; /* do nothing */		\
> +		else
> +
