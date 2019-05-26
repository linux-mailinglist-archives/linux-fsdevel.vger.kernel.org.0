Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246E92A956
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfEZLGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 07:06:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEZLGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 07:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnRlIwzLsh5gtE410Wzg4R0DjN2uPpGflfJ056ZS7Vo=; b=KpKeoXxDjqBDfQZZgp1AuGzjs
        C3p5lYMN8SnDhpWYllf1E7TWYwBI6oGBT2jXgmJYCKD4gCtkUT6wAlQxetGESzhFLp0kixvl0PKz6
        sAIZ8McSchStRWXueMYMAzUEef1vD2eo20gCnaFS9GlxjNZ6NofnoZ95FC3RIG5QAZ5R47DmON+Qo
        JdOQPQ1LUXvgqEpgmOO5i6saVR6L0Xi+3VJ1CQlW12vxdRwBwl+0dLPYwev5/IQbIN2AjGvY27PsJ
        6Pv6/5pS3hIlEgR1RuK7uJxg+BLAGf0eWCGlaxQFawlyO5JV9eBonzUDeprQ1j6UJOqA3XCCfRY7o
        RH6eOeHcQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUqz2-00036Y-1M; Sun, 26 May 2019 11:06:32 +0000
Date:   Sun, 26 May 2019 04:06:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190526110631.GD1075@bombadil.infradead.org>
References: <20190525014522.8042-1-jhubbard@nvidia.com>
 <20190525014522.8042-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525014522.8042-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 24, 2019 at 06:45:22PM -0700, john.hubbard@gmail.com wrote:
> For infiniband code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(), or
> put_user_pages*(), instead of put_page()

I have no objection to this particular patch, but ...

> This is a tiny part of the second step of fixing the problem described
> in [1]. The steps are:
> 
> 1) Provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem. Again, [1] provides details as to why that is
>    desirable.

I thought we agreed at LSFMM that the future is a new get_user_bvec()
/ put_user_bvec().  This is largely going to touch the same places as
step 2 in your list above.  Is it worth doing step 2?

One of the advantages of put_user_bvec() is that it would be quite easy
to miss a conversion from put_page() to put_user_page(), but it'll be
a type error to miss a conversion from put_page() to put_user_bvec().
