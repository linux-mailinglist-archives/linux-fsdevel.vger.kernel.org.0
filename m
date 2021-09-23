Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4104154CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 02:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhIWAqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 20:46:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:14258 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238631AbhIWAqr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:46:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223381050"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="223381050"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:45:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="474900207"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:45:15 -0700
Date:   Wed, 22 Sep 2021 17:45:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210923004515.GD3053272@iweiny-DESK2.sc.intel.com>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpaTBJ/Jhz15S6a@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpaTBJ/Jhz15S6a@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:18:52PM +0100, Matthew Wilcox wrote:

...

> +/**
> + * page_slab - Converts from page to slab.
> + * @p: The page.
> + *
> + * This function cannot be called on a NULL pointer.  It can be called
> + * on a non-slab page; the caller should check is_slab() to be sure
> + * that the slab really is a slab.
> + *
> + * Return: The slab which contains this page.
> + */
> +#define page_slab(p)		(_Generic((p),				\
> +	const struct page *:	(const struct slab *)_compound_head(p), \
> +	struct page *:		(struct slab *)_compound_head(p)))
> +
> +static inline bool is_slab(struct slab *slab)
> +{
> +	return test_bit(PG_slab, &slab->flags);
> +}
> +

I'm sorry, I don't have a dog in this fight and conceptually I think folios are
a good idea...

But for this work, having a call which returns if a 'struct slab' really is a
'struct slab' seems odd and well, IMHO, wrong.  Why can't page_slab() return
NULL if there is no slab containing that page?

Ira

