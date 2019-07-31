Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548A77C002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfGaLck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 07:32:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfGaLcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UBmJR5zweJmbyxzgPM4EX3clHHa7sH38d5P57nUcKTc=; b=YMOvsFC4AP/jXLYB3P4JjOlOq
        wkafVCBzpXR/1dsglZwKBYrDvkk0nQCHFOsIEJwJt8ECIgcRv20gyK4w0yfv1zKR2MUnIXp/eiwAc
        A578VmoZuy99oHmsTorQc5DxjM+GxHfElwrIOyV8KSETO1bc7Fu//KDuJyqWQpsgWtk0pusToFZl5
        PCMIvccTiP+xc6WLSWwCTk1XlnzrlhjC7xxByj+65xatNSj5KLh8Gb3cCXlhpz4o3X3RfMK2GFp3U
        4RlVbA53/IfbkZ0+HE8B8dH5VYcITL3YJRZzWhR0YbrHzYBjZjZosaAoaGCGqA8aJgwCJBOArUxP5
        OGx+lYw9w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsmqD-0005hK-DX; Wed, 31 Jul 2019 11:32:21 +0000
Date:   Wed, 31 Jul 2019 04:32:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
Message-ID: <20190731113221.GE4700@bombadil.infradead.org>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <20190731102053.GZ7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731102053.GZ7689@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 08:20:53PM +1000, Dave Chinner wrote:
> On Wed, Jul 31, 2019 at 02:25:11AM -0600, William Kucharski wrote:
> > This set of patches is the first step towards a mechanism for automatically
> > mapping read-only text areas of appropriate size and alignment to THPs
> > whenever possible.
> > 
> > For now, the central routine, filemap_huge_fault(), amd various support
> > routines are only included if the experimental kernel configuration option
> > 
> > 	RO_EXEC_FILEMAP_HUGE_FAULT_THP
> > 
> > is enabled.
> > 
> > This is because filemap_huge_fault() is dependent upon the
> > address_space_operations vector readpage() pointing to a routine that will
> > read and fill an entire large page at a time without poulluting the page
> > cache with PAGESIZE entries
> 
> How is the readpage code supposed to stuff a THP page into a bio?
> 
> i.e. Do bio's support huge pages, and if not, what is needed to
> stuff a huge page in a bio chain?

I believe that the current BIO code (after Ming Lei's multipage patches
from late last year / earlier this year) is capable of handling a
PMD-sized page.

> Once you can answer that question, you should be able to easily
> convert the iomap_readpage/iomap_readpage_actor code to support THP
> pages without having to care about much else as iomap_readpage()
> is already coded in a way that will iterate IO over the entire THP
> for you....

Christoph drafted a patch which illustrates the changes needed to the
iomap code.  The biggest problem is:

struct iomap_page {
        atomic_t                read_count;
        atomic_t                write_count;
        DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
};

All of a sudden that needs to go from a single unsigned long bitmap (or
two on 64kB page size machines) to 512 bytes on x86 and even larger on,
eg, POWER.

It's egregious because no sane filesystem is going to fragment a PMD
sized page into that number of discontiguous blocks, so we never need
to allocate the 520 byte data structure this suddenly becomes.  It'd be
nice to have a more efficient data structure (maybe that tracks uptodate
by extent instead of by individual sector?)  But I don't understand the
iomap layer at all, and I never understood buggerheads, so I don't have
a useful contribution here.
