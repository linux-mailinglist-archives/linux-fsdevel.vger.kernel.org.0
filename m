Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3182074782E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDSIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 14:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDSIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:08:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FD10C9;
        Tue,  4 Jul 2023 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/QQ+Y+14Y8wHCcIurGp5zUfHCaeH/cPOa7LyRJZnARI=; b=Uag6pglI2bOJeECLpGyALXzsbc
        Q0NaPAwHEDf7FUlP/Y++2CoZe9Cm2yM/WfzM38xyNpjxlNRthoaH+6Ace2usGLeqec1FC8j1iUoqi
        PKmLd3TiNy+i1Bvc/HhE0Dp3EKo6qISsd/heyWV/5mxMOBjFI+C9vlrpIsYCXOvVM8PNh5tNNehfn
        KxlKgqlat8ndp/Gw1F5SFOXdNoNt/0Izp1KAGsAAhqwjPt4Nf+0iDLq6mK0LzxfNvrCpBIABWINPV
        PcMg6bT9xJKvE3QNWYHvYjetkckTquJiSqb+wQH3JUVWLFSFaK0RXOeFB/rqP8IwfAygJdhyn5r0c
        L/MfWmQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGkRf-009MKK-M8; Tue, 04 Jul 2023 18:08:11 +0000
Date:   Tue, 4 Jul 2023 19:08:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
Message-ID: <ZKRgC13eMGc4DyPG@casper.infradead.org>
References: <ZJyKef22444mooNE@casper.infradead.org>
 <20230626173521.459345-1-willy@infradead.org>
 <3130123.1687863182@warthog.procyon.org.uk>
 <3697885.1687982590@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3697885.1687982590@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:03:10PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > I'm looking at afs writeback now.
> 
> :-)
> 
> >  fs/iomap/buffered-io.c    |  14 +-
> >  include/linux/pagevec.h   |  18 +++
> >  include/linux/writeback.h |  22 ++-
> >  mm/page-writeback.c       | 310 +++++++++++++++++++++-----------------
> >  4 files changed, 216 insertions(+), 148 deletions(-)
> 
> Documentation/mm/writeback.rst too please.

$ ls Documentation/mm/w*
ls: cannot access 'Documentation/mm/w*': No such file or directory

$ git grep writeback Documentation/mm
Documentation/mm/multigen_lru.rst:do not require TLB flushes; clean pages do not require writeback.
Documentation/mm/page_migration.rst:2. Ensure that writeback is complete.
Documentation/mm/page_migration.rst:15. Queued up writeback on the new page is triggered.
Documentation/mm/physical_memory.rst:``nr_writeback_throttled``
Documentation/mm/physical_memory.rst:  Number of pages written while reclaim is throttled waiting for writeback.

Or are you suggesting I write a new piece of kernel documentation?
If so, I respectfully decline.  I've updated the kernel-doc included
in Documentation/core-api/mm-api.rst and I think that's all I can
reasonably be asked to do.
