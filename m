Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61647DF33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhLWGzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWGzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:55:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFBC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kF4sNyn9ejq9BtQYgVVIDSuUx7Z2F5fcvy9sdc+/3x8=; b=AVQp79haHjGsW4kCnihJQXQaYa
        5PGGlGwhKiMPzy41/ftnhAo4LRo38jrDmmhgYC5bJBqTQXPr07FOWTt+Lbpym2XAcK1lShjCeTGjw
        f2f7mPSY6ZbjH8v12KsFwhso8o/1MEV3P8hxG6exZ2XJc75XYoafT1PHhRRS5jbt9ScARu2VHffve
        aYFkasTYFhcL0BUxnowiv9WnHMFxriszbhVTXI6TZ1QTeNh0SU8b5l/JU9ZVJkvvhfuCucURxONkA
        Zkv7F8KfhwQg0w1C9yvn2W/uoDFgjdzF/PXDzvgLaUS8mUuax981TkJfoaX8MA/LETiJ5ZURr9AqQ
        oFTmxOQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I0W-00BwuU-Rc; Thu, 23 Dec 2021 06:55:20 +0000
Date:   Wed, 22 Dec 2021 22:55:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/48] iov_iter: Add copy_folio_to_iter()
Message-ID: <YcQdWKCGHK5dZfWz@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:14AM +0000, Matthew Wilcox (Oracle) wrote:
> +static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
> +		size_t bytes, struct iov_iter *i)
> +{
> +	return copy_page_to_iter((struct page *)folio, offset, bytes, i);
> +}

I think we had this 2 or three series ago, but these open coded casts
are a bad idea.  I think we need a proper and well documented helper for
them.
