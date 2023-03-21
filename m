Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E76C380B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 18:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCURTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCURT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:19:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394B420A20;
        Tue, 21 Mar 2023 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PnM8qWjlChOypXMUKbb5rR1MAgOZHr38zSDi4wQUtEs=; b=itI+aaF5dGBBOFEsy3YiNOMlAl
        ZE6zedAsVcLZYFAXapSlq9yxYkdr5wnMV51b5hKQmGkc5YklHyH3sK1ZHMa4Rl006Ei/U+4z7jHt3
        Sam887otMU7ecUXQHbpOvg3xvZ9AGY09iUCXhxZnGAhAqrM4jG/PdSNmN/UaejAIFidYARFYs9koz
        D8UV0ZtBTnMoQI9DOoNYWEHfqb16FHxdarIBqDZCwwOhsiJ/0LYi+l9EivFjkhTjOvt+zlOKsezlU
        9mPYo8NWAKTaARBja5v7+ulcdCPLeVbfod0YpppcI0oeZSOgujuat80KSr+pkG/ZKhAbAJIspO45H
        MrAP5B2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pefdm-002E2a-1j; Tue, 21 Mar 2023 17:19:18 +0000
Date:   Tue, 21 Mar 2023 17:19:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <ZBnnFtKVgAFQ4yeo@casper.infradead.org>
References: <20230321130908.6972-1-frank.li@vivo.com>
 <ZBneeOYHKBZl8SGe@casper.infradead.org>
 <ZBnho5yPbXIQs752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnho5yPbXIQs752@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:56:03AM -0700, Luis Chamberlain wrote:
> On Tue, Mar 21, 2023 at 04:42:32PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
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
> > 
> > Could we avoid doing this until we no longer need an entire zero entry
> > after the last one? 
> 
> That may be 2-3 kernel release from now. The way to use ARRAY_SIZE()
> really is to deprecate the crap APIs that allow messy directory sysctl
> structures.

I'm OK with waiting another year to commence this cleanup.  We've lived
with the giant tables for decades already.  Better to get the new API
right than split the tables now, then have to touch all the places
again.
