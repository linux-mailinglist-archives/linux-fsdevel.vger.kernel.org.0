Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE964B52E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350857AbiBNOMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 09:12:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBNOMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:12:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507D38F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 06:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eI59ke6gXuoz7Ax7P7XbsKcM+twDNT+lUmdNnjxlU6k=; b=W4LBl1cXnw+UxWapb1bO38e0u8
        9YWERgqOHC99OHxq7RrcSDix0pdVvdc4oIYHTHG147f7BHr/hTU/lPu/hKdCpIwmKeytJEhuzfve1
        zMs3LkGJsfges5TFbMvGlgN2YGtLqLX9OyYkV0wZmJEdnOlzBPYhHnOA9lje20UrVod4cG0YTV/64
        fi1kAndPwe+a+AKYA2IBYvA3kCcs8YAU12EFq0HIX8AqHZBz69QLoXBHFOrzY30IuAuK917GIv8vP
        7+h66bcI8R1eHe3uZ6QAEDlBqM0nrtIoC1ThYb+nJB0t5mVJgwpZt7zAUMNZtkiVrIzbdEqGHhNg0
        ++thItLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJc5D-00CyQm-MB; Mon, 14 Feb 2022 14:12:03 +0000
Date:   Mon, 14 Feb 2022 14:12:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 42/56] fscache: Convert fscache_set_page_dirty() to
 fscache_dirty_folio()
Message-ID: <YgpjM7odm8/uMSQa@casper.infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
 <20220209202215.2055748-43-willy@infradead.org>
 <916059c1-548e-fd29-92b6-f4384d07b29f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <916059c1-548e-fd29-92b6-f4384d07b29f@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 13, 2022 at 11:02:06PM -0800, John Hubbard wrote:
> I was just reading through this in case my pin_user_pages() changes
> had any overlap (I think not), and noticed a build issue, below.

I agree; unlikely to have any conflicts with mm things in this patchset.
This should be purely fs.  There's obviously more conversions coming in
the aops api, but I thought this was a good start.

Still need to do writepage, readpage, write_begin, write_end,
releasepage, freepage, migratepage, isolate_page, putback_page,
is_dirty_writeback, and _maybe_ error_remove_page.  sendpage is
also something I'll need to look at.

> >   }
> > -static inline int ceph_fscache_set_page_dirty(struct page *page)
> > +static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
> > +		struct folio *folio)
> >   {
> > -	return __set_page_dirty_nobuffers(page);
> > +	return filemap_dirty_folio(folio);
> 
> I believe that should be:
> 
> 	return filemap_dirty_folio(mapping, folio);

Indeed it should; thanks, fixed.  allmodconfig doesn't test all code
paths ;-)
