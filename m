Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E396A6C3438
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCUO3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCUO3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:29:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8BE18B01;
        Tue, 21 Mar 2023 07:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE9AAB816ED;
        Tue, 21 Mar 2023 14:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420FAC433EF;
        Tue, 21 Mar 2023 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679408921;
        bh=C9tWPSPxpAovWG9pgJ3+pCfgaZCP6C07MisscEt1fvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyVymhlQyGqBhI29fgT4/tVju0gZrYCm68mUKlPik5mmh/VwR0d5fTsUkTbCkt0vH
         ynaGKo9KxTS/WcUHX9/F4uXU+74BemSnLwggXNxYdOk0ZAeGRLzSGD7wkiW3bR9H1X
         4bTuIGmi/iuxr81ai1bhRd9Fj+R59emaPjd7SO1QJq4OW4YYbciIItP27MBD9mDCNQ
         ZdMRIu8lWgdZrhb0PpfPgqDWGyEibzsPde1zuSzxC6OLn5LJt4a2rj4YN91pX2TY2u
         zW7I8f7thd+sX43p16k7qM5uIlLD779WxaDwKmYhutosqNOmD6F+p95idgiQP+hCEP
         vYuO9pbcjcvOA==
Date:   Tue, 21 Mar 2023 15:28:36 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <20230321142836.l6pymt4ygg2qhfvn@wittgenstein>
References: <20230321130908.6972-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230321130908.6972-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
> This moves the fs/drop_caches.c respective sysctls to its own file.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/drop_caches.c   | 25 ++++++++++++++++++++++---
>  include/linux/mm.h |  6 ------
>  kernel/sysctl.c    |  9 ---------
>  3 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index e619c31b6bd9..3032b83ce6f2 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -12,8 +12,7 @@
>  #include <linux/gfp.h>
>  #include "internal.h"
>  
> -/* A global variable is a bit ugly, but it keeps the code simple */
> -int sysctl_drop_caches;
> +static int sysctl_drop_caches;
>  
>  static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  {
> @@ -47,7 +46,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  	iput(toput_inode);
>  }
>  
> -int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> +static int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  		void *buffer, size_t *length, loff_t *ppos)
>  {
>  	int ret;
> @@ -75,3 +74,23 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  	}
>  	return 0;
>  }
> +
> +static struct ctl_table drop_caches_table[] = {
> +	{
> +		.procname	= "drop_caches",
> +		.data		= &sysctl_drop_caches,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0200,
> +		.proc_handler	= drop_caches_sysctl_handler,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_FOUR,
> +	},
> +	{}
> +};
> +
> +static int __init drop_cache_init(void)
> +{
> +	register_sysctl_init("vm", drop_caches_table);

Does this belong under mm/ or fs/?
And is it intended to be moved into a completely separate file?
Feels abit wasteful for 20 lines of code...
