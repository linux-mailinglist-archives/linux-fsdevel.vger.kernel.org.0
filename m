Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1F46E59A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhLIJdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 04:33:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:7772 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhLIJdq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:33:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298847424"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="298847424"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 01:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="606786633"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2021 01:30:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E245915C; Thu,  9 Dec 2021 11:30:16 +0200 (EET)
Date:   Thu, 9 Dec 2021 12:30:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: delete unsafe BUG from page_cache_add_speculative()
Message-ID: <20211209093016.eivzxmgr6c4twmus@black.fi.intel.com>
References: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:19:18PM -0800, Hugh Dickins wrote:
> It is not easily reproducible, but on 5.16-rc I have several times hit
> the VM_BUG_ON_PAGE(PageTail(page), page) in page_cache_add_speculative():
> usually from filemap_get_read_batch() for an ext4 read, yesterday from
> next_uptodate_page() from filemap_map_pages() for a shmem fault.
> 
> That BUG used to be placed where page_ref_add_unless() had succeeded,
> but now it is placed before folio_ref_add_unless() is attempted: that
> is not safe, since it is only the acquired reference which makes the
> page safe from racing THP collapse or split.
> 
> We could keep the BUG, checking PageTail only when folio_ref_try_add_rcu()
> has succeeded; but I don't think it adds much value - just delete it.
> 
> Fixes: 020853b6f5ea ("mm: Add folio_try_get_rcu()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
