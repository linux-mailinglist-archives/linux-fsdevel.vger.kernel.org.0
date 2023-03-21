Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0A6C372F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCUQml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUQmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:42:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3952F4F;
        Tue, 21 Mar 2023 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ZSrO5HfUDDvVDUVlIZHkBuyCCML2UkxvJRJ9KEJLhk=; b=RBr90U8d8R2//lzQVrs2XIOu06
        wm/t0hKvw5A8K/IeZy630OjGmr9hFVHf9yEBF+ctPwqdJE/+ac1K2octWNtoLB+7rEtxrvMZ8+tI2
        QakA8J0aCrCWs/z+5UkmFP3ephpfhctIoAhxp5oCgCgMoAh9/AT4mCkY0tTVrIz117uxPa7uF1SzD
        14h+7U2GM0IharEp7v6H05zdTEaZCxdzQK9jxVGxqErSABu75Fu6dNpKa8q3FeUiJzNGn2P3/OEti
        e1XVTfYs+IAobW/R3uizHNVwrXOwJsvHJ+hxYiSFKq3f1h9vMHEnspfZrfa7y5rS3rJfMfQXXcACs
        mIjbVy4Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pef3k-00D6kx-2P;
        Tue, 21 Mar 2023 16:42:04 +0000
Date:   Tue, 21 Mar 2023 09:42:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     brauner@kernel.org, frank.li@vivo.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <ZBneXNi/QMWmxOSa@bombadil.infradead.org>
References: <226a6fc1-f6f4-4972-b76e-774094ffb821@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226a6fc1-f6f4-4972-b76e-774094ffb821@p183>
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

On Tue, Mar 21, 2023 at 05:37:10PM +0300, Alexey Dobriyan wrote:
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
> > And is it intended to be moved into a completely separate file?
> > Feels abit wasteful for 20 lines of code...
> 
> It is better to keep all sysctls in one preallocated structure
> for memory reasons:
> 
> 	header = kzalloc(sizeof(struct ctl_table_header) +
>                          sizeof(struct ctl_node)*nr_entries, GFP_KERNEL_ACCOUNT);

For memory reasons we are actually phasing out the older APIs which
required an empty array at the end, which we then kmalloc for, and in
the future will just use ARRAY_SIZE(). In the end that will save us
an entry per each sysctl registered. The rationate for this commit log
sucks. It should be fixed to take into consideration other moves as can
be seen in older git log kernel/sysclt.c moves.

  Luis
