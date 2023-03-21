Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0F6C3811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 18:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCURT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCURTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FC19AE;
        Tue, 21 Mar 2023 10:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C5661D55;
        Tue, 21 Mar 2023 17:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFA4C433EF;
        Tue, 21 Mar 2023 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679419184;
        bh=hvCgy/WFbjzmT9vviDRBBlhBz4fmojTYN1wTRwP7718=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MD4O3cmB+4/VQSR4jsZRfpRnQ01PJaSVnBusj8iA0wDmo6q8V6Ezagi2Tdswxx8Go
         ag1n6nLYEaqJAkFggk5PVwTM0lXuuaZ/eCXN3RyEtCPzTniWlHR2Ld7UcFDiN3PwA3
         lLC4pbjHvGSbore2NRYLxSlk/y6hSp3qKsAm3dJ7ExU+TAU4j2OeB74n+fgAGSG0Yf
         Ub39gNk+ANNdrzzwsDIrIRvQSzEcWCG2nMX0nicBcCBzJm3ZzH/iTDFTxhaYbx8mlj
         vigTT7r6rsC34g0GSFZS2NncXbFA/MtAMaQEYZImmKfUSwMhftl0MjXlZdXMuX6DSZ
         w8ICsPBqFoLcA==
Date:   Tue, 21 Mar 2023 18:19:38 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <20230321171938.z5seopfethaworsm@wittgenstein>
References: <20230321130908.6972-1-frank.li@vivo.com>
 <20230321142836.l6pymt4ygg2qhfvn@wittgenstein>
 <ZBndzRjJ8oNX7g6N@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBndzRjJ8oNX7g6N@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:39:41AM -0700, Luis Chamberlain wrote:
> On Tue, Mar 21, 2023 at 03:28:36PM +0100, Christian Brauner wrote:
> > On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
> > > This moves the fs/drop_caches.c respective sysctls to its own file.
> > > 
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > ---
> > >  fs/drop_caches.c   | 25 ++++++++++++++++++++++---
> > >  include/linux/mm.h |  6 ------
> > >  kernel/sysctl.c    |  9 ---------
> > >  3 files changed, 22 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> > > index e619c31b6bd9..3032b83ce6f2 100644
> > > --- a/fs/drop_caches.c
> > > +++ b/fs/drop_caches.c
> > > @@ -12,8 +12,7 @@
> > >  #include <linux/gfp.h>
> > >  #include "internal.h"
> > >  
> > > -/* A global variable is a bit ugly, but it keeps the code simple */
> > > -int sysctl_drop_caches;
> > > +static int sysctl_drop_caches;
> > >  
> > >  static void drop_pagecache_sb(struct super_block *sb, void *unused)
> > >  {
> > > @@ -47,7 +46,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
> > >  	iput(toput_inode);
> > >  }
> > >  
> > > -int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> > > +static int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> > >  		void *buffer, size_t *length, loff_t *ppos)
> > >  {
> > >  	int ret;
> > > @@ -75,3 +74,23 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> > >  	}
> > >  	return 0;
> > >  }
> > > +
> > > +static struct ctl_table drop_caches_table[] = {
> > > +	{
> > > +		.procname	= "drop_caches",
> > > +		.data		= &sysctl_drop_caches,
> > > +		.maxlen		= sizeof(int),
> > > +		.mode		= 0200,
> > > +		.proc_handler	= drop_caches_sysctl_handler,
> > > +		.extra1		= SYSCTL_ONE,
> > > +		.extra2		= SYSCTL_FOUR,
> > > +	},
> > > +	{}
> > > +};
> > > +
> > > +static int __init drop_cache_init(void)
> > > +{
> > > +	register_sysctl_init("vm", drop_caches_table);
> > 
> > Does this belong under mm/ or fs/?
> 
> To not break old userspace it must be kept under "vm" because the
> patch author is moving it from the kernel/sysctl.c table which used
> the "vm" table.
> 
> Moving it to "fs" would be a highly functional change which should
> require review from maintainers it would not break existing userspace
> expecations.

No, I was asking whether this belongs under the fs/ or mm/ directory.
But I misread the patch. I thought at first, that the patch moved the
file from the mm/ to the fs/ directory. But that's obviously not the
case... So ignore me.
