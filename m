Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04AC413036
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhIUIhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhIUIhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:37:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EBFC061574;
        Tue, 21 Sep 2021 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ry5JWAFApZLjeeE9aqkpHVQPnxR6bpUBw5yVBoOfe+o=; b=lkUXldocLAwB8PYYIwHIh82a38
        ri1Armm0Jqh9JgHvfXCGoZvXmtVgZM+iqrr5x9H0eJiWM08dIn9pJQm9i8ESVOiHDtHqhigHYZb5F
        XMgV7bKTqvgWctZJBgBW0lhfUQwuNyB/YsfJeQwSVdhZt/MpNK5FTW/BQZk4IUa6nE/53aMGVIQ1Z
        CEKG3ifsAneuG51J8dT78NmFu7/2RVEiXDptpf8eSj4KrCD0nKFgWQYLWlmeuLHPgpKrK3QCHrHHp
        g7v7eyohNg2Rzm55Livy1MYxh4wsQGR0YRF09fOQ/extXqpKCNGdVN63t1mwXMpEQxeDXWdaUKJ22
        V8wC8ZbA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSbEt-003djt-Qx; Tue, 21 Sep 2021 08:35:03 +0000
Date:   Tue, 21 Sep 2021 09:34:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] dax: prepare pmem for use by zero-initializing
 contents and clearing poisons
Message-ID: <YUmZL9qs0ZJ3ESBW@infradead.org>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865031.417973.8372869475521627214.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192865031.417973.8372869475521627214.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:30:50PM -0700, Darrick J. Wong wrote:
> +	case IOMAP_MAPPED:
> +		while (nr_pages > 0) {
> +			/* XXX function only supports one page at a time?! */
> +			ret = dax_zero_page_range(iomap->dax_dev, start_page,
> +					1);

Yes.  Given that it will have to kmap every page that kinda makes sense.
Unlike a nr_pages argument which needs to be 1, which is just silly.
That being said it would make sense to move the trivial loop over the
pages into the methods to reduce the indirect function call overhead
