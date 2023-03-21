Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA726C3714
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCUQjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUQju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:39:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B03268C;
        Tue, 21 Mar 2023 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ycwlWjK1cUtfsnTr97lPHy9bLPf8Ff9LLKdvYqykvYY=; b=wrVZ974+jz3x9up+alNPyiIjnC
        /mJl9S5EGt1onTqEAMLEkfVTGcUReagyOF7Fxa00dRA6VNKXaWUmuNFVLLjlH065mfkxeCGbhxj6f
        qbph7Q2EEYFIq/Z5PDa/qz1MPY5Vy1hBhg59E9PVg0hSNTDpNM+LXXcphUmutABTWlnDKvYPF5YHG
        N/RjybPLqB4DSBLv6OjmreTOlrDpSbfVi9dyoG/+41VeslScSk6LlRcsnm2lRO1ICz62FmgIDPYmP
        XAH3GT6hG0FrQD+dv8yjs8lp25EombKb7KRoqdfZtOryWHvRQO2GZaeNShKRUJJYMG0pGk+Zl7pjh
        FEO+ZmTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pef1R-00D6NS-0E;
        Tue, 21 Mar 2023 16:39:41 +0000
Date:   Tue, 21 Mar 2023 09:39:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <ZBndzRjJ8oNX7g6N@bombadil.infradead.org>
References: <20230321130908.6972-1-frank.li@vivo.com>
 <20230321142836.l6pymt4ygg2qhfvn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321142836.l6pymt4ygg2qhfvn@wittgenstein>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:28:36PM +0100, Christian Brauner wrote:
> On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
> > This moves the fs/drop_caches.c respective sysctls to its own file.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/drop_caches.c   | 25 ++++++++++++++++++++++---
> >  include/linux/mm.h |  6 ------
> >  kernel/sysctl.c    |  9 ---------
> >  3 files changed, 22 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> > index e619c31b6bd9..3032b83ce6f2 100644
> > --- a/fs/drop_caches.c
> > +++ b/fs/drop_caches.c
> > @@ -12,8 +12,7 @@
> >  #include <linux/gfp.h>
> >  #include "internal.h"
> >  
> > -/* A global variable is a bit ugly, but it keeps the code simple */
> > -int sysctl_drop_caches;
> > +static int sysctl_drop_caches;
> >  
> >  static void drop_pagecache_sb(struct super_block *sb, void *unused)
> >  {
> > @@ -47,7 +46,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
> >  	iput(toput_inode);
> >  }
> >  
> > -int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> > +static int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> >  		void *buffer, size_t *length, loff_t *ppos)
> >  {
> >  	int ret;
> > @@ -75,3 +74,23 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
> >  	}
> >  	return 0;
> >  }
> > +
> > +static struct ctl_table drop_caches_table[] = {
> > +	{
> > +		.procname	= "drop_caches",
> > +		.data		= &sysctl_drop_caches,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0200,
> > +		.proc_handler	= drop_caches_sysctl_handler,
> > +		.extra1		= SYSCTL_ONE,
> > +		.extra2		= SYSCTL_FOUR,
> > +	},
> > +	{}
> > +};
> > +
> > +static int __init drop_cache_init(void)
> > +{
> > +	register_sysctl_init("vm", drop_caches_table);
> 
> Does this belong under mm/ or fs/?

To not break old userspace it must be kept under "vm" because the
patch author is moving it from the kernel/sysctl.c table which used
the "vm" table.

Moving it to "fs" would be a highly functional change which should
require review from maintainers it would not break existing userspace
expecations.

> And is it intended to be moved into a completely separate file?

What do you mean by this?

> Feels abit wasteful for 20 lines of code...

Not sure what you mean by this either. The commit log sucks, please
review got log kernel/sysclt.c for much better commit logs for the
rationale of moving sysctls out out kernel/sysctl.c to their own
respective places.

  Luis
