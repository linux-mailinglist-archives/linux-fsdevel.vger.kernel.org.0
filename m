Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235BC312936
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBHDOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 22:14:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:54680 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBHDOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 22:14:06 -0500
IronPort-SDR: qF6qbT1D+jf+Ql9FkUfsju2+NMb8z36osjzA+gmRb6mEo4RbaOpUK3UyN5hrljT9HbRxVZfBJ6
 k0wXceDVScqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="168776056"
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="168776056"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 19:13:26 -0800
IronPort-SDR: A3pDqCd2bAsYlR8EzAis+Qq08CpEUmTrzodn/1aArdK2/p53n/tJ7v4fiZzvuvTiM+vlJpxvx5
 m5atZCYGe7aQ==
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="395183906"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 19:13:24 -0800
Date:   Sun, 7 Feb 2021 19:13:24 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20210208031324.GE5033@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210205232304.1670522-2-ira.weiny@intel.com>
 <BYAPR04MB49655E5BDB24A108FEFFE9C486B09@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655E5BDB24A108FEFFE9C486B09@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 07, 2021 at 01:46:47AM +0000, Chaitanya Kulkarni wrote:
> On 2/5/21 18:35, ira.weiny@intel.com wrote:
> > +static inline void memmove_page(struct page *dst_page, size_t dst_off,
> > +			       struct page *src_page, size_t src_off,
> > +			       size_t len)
> > +{
> > +	char *dst = kmap_local_page(dst_page);
> > +	char *src = kmap_local_page(src_page);
> > +
> > +	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> > +	memmove(dst + dst_off, src + src_off, len);
> > +	kunmap_local(src);
> > +	kunmap_local(dst);
> > +}
> > +
> > +static inline void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
> How about following ?
> static inline void memcpy_from_page(char *to, struct page *page, size_t
> offset,
>                                     size_t len)  

It is an easy change and It is up to Andrew.  But I thought we were making the
line length limit longer now.

Ira

> > +{
> > +	char *from = kmap_local_page(page);
> > +
> > +	BUG_ON(offset + len > PAGE_SIZE);
> > +	memcpy(to, from + offset, len);
> > +	kunmap_local(from);
> > +}
> > +
> > +static inline void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
> How about following ?
> static inline void memcpy_to_page(struct page *page, size_t offset,
>                                   const char *from, size_t len)
> > +{
> > +	char *to = kmap_local_page(page);
> > +
> > +	BUG_ON(offset + len > PAGE_SIZE);
> > +	memcpy(to + offset, from, len);
> > +	kunmap_local(to);
> > +}
> > +
> > +static inline void memset_page(struct page *page, size_t offset, int val, size_t len)
> How about following ?
> static inline void memset_page(struct page *page, size_t offset, int val,
>                                size_t len)  
> > +{
> > +	char *addr = kmap_local_page(page);
> > +
> > +	BUG_ON(offset + len > PAGE_SIZE);
> > +	memset(addr + offset, val, len);
> > +	kunmap_local(addr);
> > +}
> > +
