Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67040C499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhIOLxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 07:53:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhIOLxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:53:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 90FC422230;
        Wed, 15 Sep 2021 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631706715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ezTag8FBwZoPE0mbLQd/8vVA5u9wYyKzzA2BAaeCdqk=;
        b=Oowyq/u6gqCCB5BKOXaYHANJZj9rQRrGvyHHnoqL1aX++Prhi3F/s+TF/6PlPAURkDAXvl
        jxiuM8flPGKlG5a4+hCKS9+5+lPuySlLZeGkY6QQYlSV4ysoNL+WVXmZzvpHIYF6CSaq3+
        C35NZQnKrXWKI6wrCyqiIDtxYChJ3d4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F0C9A3B8F;
        Wed, 15 Sep 2021 11:51:55 +0000 (UTC)
Date:   Wed, 15 Sep 2021 13:51:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] MM: improve documentation for __GFP_NOFAIL
Message-ID: <YUHeWnKtR0WMNGo8@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838436.13293.8832201267053160346.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163157838436.13293.8832201267053160346.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-09-21 10:13:04, Neil Brown wrote:
> __GFP_NOFAIL is documented both in gfp.h and memory-allocation.rst.
> The details are not entirely consistent.
> 
> This patch ensures both places state that:
>  - there is a cost potentially imposed on other subsystems
>  - it should only be used when there is no real alternative
>  - it is preferable to an endless loop
>  - it is strongly discourages for costly-order allocations.
>

Yes this is a useful addition to the documentation. Thanks!

> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/core-api/memory-allocation.rst |    9 ++++++++-
>  include/linux/gfp.h                          |    4 ++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index 5954ddf6ee13..9458ce72d31c 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -126,7 +126,14 @@ or another request.
>  
>    * ``GFP_KERNEL | __GFP_NOFAIL`` - overrides the default allocator behavior
>      and all allocation requests will loop endlessly until they succeed.
> -    This might be really dangerous especially for larger orders.
> +    The allocator may provide access to memory that would otherwise be
> +    reserved in order to satisfy this allocation which might adversely
> +    affect other subsystems.  So it should only be used when there is no
> +    reasonable failure policy and when the memory is likely to be freed
> +    again in the near future.  Its use is strong discourage (via a
> +    WARN_ON) for allocations larger than ``PAGE_ALLOC_COSTLY_ORDER``.
> +    While this flag is best avoided, it is still preferable to endless
> +    loops around the allocator.
>  
>  Selecting memory allocator
>  ==========================
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 55b2ec1f965a..101479373738 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -209,6 +209,10 @@ struct vm_area_struct;
>   * used only when there is no reasonable failure policy) but it is
>   * definitely preferable to use the flag rather than opencode endless
>   * loop around allocator.
> + * Use of this flag may provide access to memory which would otherwise be
> + * reserved.  As such it must be understood that there can be a cost imposed
> + * on other subsystems as well as the obvious cost of placing the calling
> + * thread in an uninterruptible indefinite wait.
>   * Using this flag for costly allocations is _highly_ discouraged.
>   */
>  #define __GFP_IO	((__force gfp_t)___GFP_IO)
> 

-- 
Michal Hocko
SUSE Labs
