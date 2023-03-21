Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785C6C3777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCUQ4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCUQ4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:56:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8F3756B;
        Tue, 21 Mar 2023 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aWRXn4qd7nGpPUiNMqqImVVM3mu78Lrs3TrOsbvgJcA=; b=EcvwQ4+rTdqMikqp4h6IbYe7eq
        x+/vaeND8+Pnbide5qsQEu7wYbE4sWV7+0lhEEDCDYRV2P022yybUtLmdd5MufQcMXYw1RJ8r16sF
        sAOns7KcD48sCnMH+KouTPnh2hmZgMDxgUyVMFsNbvgWHWALUWu85iGi2ZUycA8MQWG7U4/aaEjdk
        fQYCMKCnePPcW9WTTpKSu0A+LWQfKQapAWjYxKLn49WjpJZqxZeSMcsWMxpnWhnJqnuabZ6LBwkp3
        YJf7QMmkf3Ash6d1yn/7K7EpJYmaIz3Remo7y74HflrHb7rGRZkPNsJo3E1QkOU9Vk+FU1OxRjjvk
        Braj4VWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pefHH-00D91D-2j;
        Tue, 21 Mar 2023 16:56:03 +0000
Date:   Tue, 21 Mar 2023 09:56:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <ZBnho5yPbXIQs752@bombadil.infradead.org>
References: <20230321130908.6972-1-frank.li@vivo.com>
 <ZBneeOYHKBZl8SGe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBneeOYHKBZl8SGe@casper.infradead.org>
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

On Tue, Mar 21, 2023 at 04:42:32PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
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
> 
> Could we avoid doing this until we no longer need an entire zero entry
> after the last one? 

That may be 2-3 kernel release from now. The way to use ARRAY_SIZE()
really is to deprecate the crap APIs that allow messy directory sysctl
structures.

> Also, please post scripts/bloat-o-meter results
> for before-and-after.

It should be one extry ~ ctl_table per move.

  Luis
