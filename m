Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6D4067DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhIJHlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhIJHlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:41:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708DC061574;
        Fri, 10 Sep 2021 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OKoWGsqHXDMYyu+uV7rTXmu0osZyZbPhrGNN3ToBOTk=; b=rpO3mglPTdCGsKxRrM0B0CQ2D0
        I6u7uKG05K/d12zEbb5ksbimIcVlcbmz0VBvyMNJ2v16NGPibVDB3nRtiE9yrmhDDVqbBD59eKvsb
        K+dtqQR56MVyblMZCXrwo/3zQ2OyvbuGeh5s87lDq39FvtsLu+SKUmJbqS370RZPFSY3VkR92nxpv
        LLHBeMdtrLIfe8wLcUOjLUqNgt5ssIui/qmKqGon+hgI8EwJYTP8djPb9osTbGy2731CWns6UQUmQ
        hIDwUOXkSIVKyRSlRcr8M6ZcYZsGt1qQpU489r08j0v2QHnVLCcSM1/r6cpnLYn4phAaAgzfngnc4
        rl3xVTUg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOb5g-00An2r-Uc; Fri, 10 Sep 2021 07:37:21 +0000
Date:   Fri, 10 Sep 2021 08:36:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
Message-ID: <YTsLFKtUWPNcFo9c@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-17-agruenba@redhat.com>
 <YTnwZU8Q0eqBccmM@infradead.org>
 <CAHk-=wgF7TPaumMU6HjBjawjFWjvEg=116=gtnzsxAcfdP4wAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgF7TPaumMU6HjBjawjFWjvEg=116=gtnzsxAcfdP4wAw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:22:56AM -0700, Linus Torvalds wrote:
> I think you misunderstand.
> 
> Or maybe I do.
> 
> It very much doesn't force sync in this case. It did the *first* part
> of it synchronously, but then it wants to continue with that async
> part for the rest, and very much do that async completion.
> 
> And that's why it wants to add that "I already did X much of the
> work", exactly so that the async completion can report the full end
> result.

Could be, and yes in that case it won't work.
