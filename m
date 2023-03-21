Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F96C38F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 19:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCUSKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCUSKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:10:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF7B5098D;
        Tue, 21 Mar 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rNKm/FBXON69zfkdwg//RKhKlf2JyDi+UDBM9ckgKRg=; b=47A0euJJt653yC1Zr//T2LCZsF
        VxQD/qUkuk7KqkLXEAgfcALylKhcWlwO4HBPhsCKu/BcK9QPry6z8D9EwWJlvt1KSjNZ2IMYnf2Fw
        zW9B0BkVxuDhRN8UB35h5Hb0f3pPhvstn1MG1O+YLauv/OG5eRauTYaaUCXDjyLXp6QFpA8gLy8BQ
        IJ0PTCRe/EsN4o1M02BlARQWDgIlUJEe6bOTJfmHC9oepaKIgA5/vDFFXPbJqRpG3+dVhGl7iP57U
        7eJp7J/v+Ix2UOwnnLO02xKpPle9MhYkuxE0cM1vxRKWv3A2zkxq0xTNT2dfHvMgZhBziM7eTN/Ee
        Ty+FZILQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pegRG-00DJjO-00;
        Tue, 21 Mar 2023 18:10:26 +0000
Date:   Tue, 21 Mar 2023 11:10:25 -0700
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
Message-ID: <ZBnzEY2PLbUtMKqX@bombadil.infradead.org>
References: <20230321130908.6972-1-frank.li@vivo.com>
 <ZBneeOYHKBZl8SGe@casper.infradead.org>
 <ZBnho5yPbXIQs752@bombadil.infradead.org>
 <ZBnnFtKVgAFQ4yeo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnnFtKVgAFQ4yeo@casper.infradead.org>
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

On Tue, Mar 21, 2023 at 05:19:18PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 21, 2023 at 09:56:03AM -0700, Luis Chamberlain wrote:
> > On Tue, Mar 21, 2023 at 04:42:32PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
> > > > +static struct ctl_table drop_caches_table[] = {
> > > > +	{
> > > > +		.procname	= "drop_caches",
> > > > +		.data		= &sysctl_drop_caches,
> > > > +		.maxlen		= sizeof(int),
> > > > +		.mode		= 0200,
> > > > +		.proc_handler	= drop_caches_sysctl_handler,
> > > > +		.extra1		= SYSCTL_ONE,
> > > > +		.extra2		= SYSCTL_FOUR,
> > > > +	},
> > > > +	{}
> > > > +};
> > > 
> > > Could we avoid doing this until we no longer need an entire zero entry
> > > after the last one? 
> > 
> > That may be 2-3 kernel release from now. The way to use ARRAY_SIZE()
> > really is to deprecate the crap APIs that allow messy directory sysctl
> > structures.
> 
> I'm OK with waiting another year to commence this cleanup.  We've lived
> with the giant tables for decades already.  Better to get the new API
> right than split the tables now, then have to touch all the places
> again.

We can do that sure.

  Luis
