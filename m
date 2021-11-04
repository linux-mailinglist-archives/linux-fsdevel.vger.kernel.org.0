Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8283444506F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKDIji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:39:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD9C061714;
        Thu,  4 Nov 2021 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jS89Xj+VfQ9PYZIaAjq6KTeAlryQwX9opaWuKLVVCac=; b=IqyxG9qeLs4MByz0t7AcozirEk
        EYPdxz1sZhknq6KqfxeHqLeZLKUaAMkU1iiGBIGsby+JVZU5MFn8LG19RFBfo/owISGeaizOBENr0
        Pc50seqUAt4jdr7UwKiJFqyxGxyALrVnUiDLv2DNbZS3C3GZe/sylxhVxeTPWYw1ldFeGxoP/2Cnh
        3Ji5B4aqNTmk1Cs6yClxQ4D/3nX53JqFwfCdIevbq5YxOVg9Ck8OgpzNUvOyjHJ7QJWDOcdbBGdWk
        UNOi8nNIslv6Um16y8rr85cXqRpOcugjfENBy4+zc5n4GVWknCQgY7zTt0VeTjfGsz6mSi1yolDC3
        6rep/UKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYEp-008Jwb-Cd; Thu, 04 Nov 2021 08:36:47 +0000
Date:   Thu, 4 Nov 2021 01:36:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <YYObn+0juAFvH7Fk@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
 <dfca8558-ad70-41d5-1131-63db66b70542@oracle.com>
 <CAPcyv4jLn4_SYxLtp_cUT=mm6Y3An22BA+sqex1S-CBnAm6qGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jLn4_SYxLtp_cUT=mm6Y3An22BA+sqex1S-CBnAm6qGA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:21:39PM -0700, Dan Williams wrote:
> The concern I have with dax_clear_poison() is that it precludes atomic
> error clearing.

atomic as in clear poison and write the actual data?  Yes, that would
be useful, but it is not how the Intel pmem support actually works, right?

> Also, as Boris and I discussed, poisoned pages should
> be marked NP (not present) rather than UC (uncacheable) [1].

This would not really have an affect on the series, right?  But yes,
that seems like the right thing to do.

> With
> those 2 properties combined I think that wants a custom pmem fault
> handler that knows how to carefully write to pmem pages with poison
> present, rather than an additional explicit dax-operation. That also
> meets Christoph's requirement of "works with the intended direct
> memory map use case".

So we have 3 kinds of accesses to DAX memory:

 (1) user space mmap direct access. 
 (2) iov_iter based access (could be from kernel or userspace)
 (3) open coded kernel access using ->direct_access

One thing I noticed:  (2) could also work with kernel memory or pages,
but that doesn't use MC safe access.  Which seems like a major independent
of this discussion.

I suspect all kernel access could work fine with a copy_mc_to_kernel
helper as long as everyone actually uses it, which will cover the
missing required bits of (2) and (3) together with something like the
->clear_poison series from Jane. We just need to think hard what we
want to do for userspace mmap access.
