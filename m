Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B3150269
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBCIUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 03:20:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgBCIUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5oSol6AJdXMbCJMDVMGUM5HRTLbTqCM84Fe095grLcs=; b=SokjtW/FezvuEupKXN2cChAqB
        oPwGX8vFXLlimpAJ5Kew9eRkIRIDyyZNXZI7gvQAQArb4sHqrZ9xxilqJy9b/HocCRafhXvGXQ+9i
        TntRLLRAn5enwp68NJjaf9UOpflGxKBVXQwrvFNs67N6K9tRY1O97fUSWCF/rzckGmjdwQeF3KYYD
        4tqL1SZXERp7lUJS0pqEZmsy2bF9qV3oopeQ29afKHF33H5/+xUU/MzeH8GyCnce4zJllOxZDRsJ0
        L+Q2yAPYydIiwg7SIVVba57iO0ZR/XHsEZOZIobNxCSq+3NgSTgdDpKRUpW9NW6twHKdAP21vwdam
        9TZKVzjyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyWy5-0004l9-4r; Mon, 03 Feb 2020 08:20:30 +0000
Date:   Mon, 3 Feb 2020 00:20:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] dax,pmem: Provide a dax operation to zero range of memory
Message-ID: <20200203082029.GA11435@infradead.org>
References: <20200123165249.GA7664@redhat.com>
 <20200123190103.GB8236@magnolia>
 <CAPcyv4jT3py4gtdJo84i8gPnJo5MO4uGaaO=+fuuAjXQ0gQsHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jT3py4gtdJo84i8gPnJo5MO4uGaaO=+fuuAjXQ0gQsHA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 03:31:58PM -0800, Dan Williams wrote:
> > Should we (XFS) make fallocate(ZERO_RANGE) detect when it's operating on
> > a written extent in a DAX file and call this instead of what it does now
> > (punch range and reallocate unwritten)?
> 
> If it eliminates more block assumptions, then yes. In general I think
> there are opportunities to use "native" direct_access instead of
> block-i/o for other areas too, like metadata i/o.

Yes, and at least for XFS there aren't too many places where we rely
on block I/O after this.  It is the buffer cache and the log code,
and I actually have a WIP conversion for the latter here:

	http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-log-dax

which I need to dust off, similar with the cache flushing changes.

But more importantly with just the patch in this thread we should be
able to stop the block device pointer in struct iomap for DAX file
systems, and thus be able to union the bdev, dax_dev and inline data
fields, which should make their usage much more clear, and reduce the
stack footprint.

> (d) dax fsync is just cache flush, so it can't fail, or are you
> talking about errors in metadata?

And based on our discussion even that cache flush sounds like a bad
idea, and might be a reason why all the file system bypass or
weirdo file systems are faster than XFS.
