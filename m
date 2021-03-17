Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110D933F69E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCQRVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhCQRVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:21:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79337C06174A;
        Wed, 17 Mar 2021 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aZBesko0L2dLYUae48wU74XHUup8GCRSf+aPZedgtJk=; b=IZYkq1TdY42T5Bvl3xE61WR1SD
        GR/5U8EhQJTK9y20f3Nwg9B2QuYK7L0tcrs9PxoX4LcxNZz+fRJTIWLa4rcZsuUELYSDn259br6n+
        CHJ1FKtSWoyS259HNed9Gb9n9UQ1oOiKl96pKmk7A7q9ra85oQp8KWSfwdaoo8DIHuytLYly70HOo
        7FUxC/uxz/UIGb0EGvFEyZlrgDk08rZaQM0/D0b6s5uHIRxEeVuT4kV/tlNkpMC4VN+Owd94Etfqs
        kbtcWRqpe1kighYOS7UXtbnzh21ZW7EJKaX3ARH8sCJxYRtU0ys7WIIh5BuCa6Pj1tdSxY5/tQ9DD
        EPXDQkYQ==;
Received: from [2001:4bb8:18c:bb3:e3eb:4a4b:ba2f:224b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZqT-001u9b-2R; Wed, 17 Mar 2021 17:20:46 +0000
Date:   Wed, 17 Mar 2021 18:20:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 08/25] mm: Handle per-folio private data
Message-ID: <YFI6YOe2uU/n2vR6@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline void attach_page_private(struct page *page, void *data)
> +{
> +	attach_folio_private((struct folio *)page, data);
> +}
> +
> +static inline void *detach_page_private(struct page *page)
> +{
> +	return detach_folio_private((struct folio *)page);
> +}

I hate these open code casts.  Can't we have a single central
page_to_folio helper, which could also grow a debug check (maybe
under a new config option) to check that it really is called on a
head page?
