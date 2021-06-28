Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBC3B67F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhF1RwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhF1RwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:52:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30574C061574;
        Mon, 28 Jun 2021 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mDBIauar2PxoMy+0IcBQYTD9SLe4F7JSYi4nF5w5zm0=; b=vm8/tqXunhaEKniQbJdensDDFm
        1iuEwgemiNALdzbViu3jLECNuPA+btNq3w64ju3Ug32RPtkAmslpPQEI7vjeHk2NN7gbcDpqDu7Nu
        eN/rmPusTbIp5hr0/hZBItXy9dSWvFzyEN79eYZGero7p21TqIolYRHebjT10O7aAYu3tmzsch9xv
        DSfJcp1Cj7K1lS9y32E9xCiyxXs/ECxCMrjUsY/0lvXBkYnKYbsHsTqYbibyDery3Xlii/DGZxEQs
        itAK6h4zI4I6dG7mEZJNlMQUu5/cUX9Um7qbMva5bMIwcZjVKmBhdU+QhEdSw4rasVoBNqQRJbi9L
        SINKGgLw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxvMU-003J0p-Q2; Mon, 28 Jun 2021 17:48:10 +0000
Date:   Mon, 28 Jun 2021 18:47:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YNoLTl602RrckQND@infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
 <YNoJPZ4NWiqok/by@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNoJPZ4NWiqok/by@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 06:39:09PM +0100, Matthew Wilcox wrote:
> Not hugely happy with either of these options, tbh.  I'd rather we apply
> a patch akin to this one (plucked from the folio tree), so won't apply:

> so permit pages without an iop to enter writeback and create an iop
> *then*.  Would that solve your problem?

It is the right thing to do, especially when combined with a feature
patch to not bother to create the iomap_page structure on small
block size file systems when the extent covers the whole page.

> 
> > (3) We're not yet using iomap_page_mkwrite, so iomap_page objects don't
> > get created on .page_mkwrite, either.  Part of the reason is that
> > iomap_page_mkwrite locks the page and then calls into the filesystem for
> > uninlining and for allocating backing blocks.  This conflicts with the
> > gfs2 locking order: on gfs2, transactions must be started before locking
> > any pages.  We can fix that by calling iomap_page_create from
> > gfs2_page_mkwrite, or by doing the uninlining and allocations before
> > calling iomap_page_mkwrite.  I've implemented option 2 for now; see
> > here:
> 
> I think this might also solve this problem?

We'll still need to create the iomap_page structure for page_mkwrite
if there is an extent boundary inside the page.
