Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC459346450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCWQDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhCWQDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:03:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m59UZWXfLRd0rO3ZUPVC1bRgtsSO+J63cyZVGfi/nRE=; b=amH4eqTwef6dVrvHenjYMF2QHe
        VBb9Q2JjD7+u3m0l1l4SKU/xLU1xjk3kmO/2yva7BgvxS69jjx2AZUNxUFEjkh/Qi6pe1J1nGiSvl
        EfyjTb0RpmLROj5wb6ij8NoVPFu0El5Fyy0g2RuiipkXZg1xfYEErUtkQE/miIfMPBLIDr5CwXa5l
        10RQSBb587QnmctXWSAZdvIDpcdd6eE6oGFMB/lOsAoTkRINXxOjti1r88wXh//AgeitaJZFpof4O
        8TI0VDCxuR8Hi+0WM0LHQYcWp4LAI7kx8LEp4/0mf8BNYWfKWmh4SMebMhGVqNDLZd3euxsowQMnp
        Wo0GLxzw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOj9p-00AEQz-29; Tue, 23 Mar 2021 15:41:34 +0000
Date:   Tue, 23 Mar 2021 15:41:25 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: set_page_dirty variants
Message-ID: <20210323154125.GA2438080@infradead.org>
References: <20210322011907.GB1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322011907.GB1719932@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:19:07AM +0000, Matthew Wilcox wrote:
> I'd like to get it down to zero.  After all, the !mapping case in
> set_page_dirty() is exactly what we want.  So is there a problem
> with doing this?
> 
> +++ b/mm/page-writeback.c
> @@ -2562 +2562 @@ int set_page_dirty(struct page *page)
> -       if (likely(mapping)) {
> +       if (likely(mapping && mapping_can_writeback(mapping))) {
> 
> But then I noticed that we have both mapping_can_writeback()
> and mapping_use_writeback_tags(), and I'm no longer sure
> which one to use.  Also, why don't we mirror the results of
> inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK into
> a mapping->flags & AS_something bit?

Probably because no one has bothered to submit a patch yet.
