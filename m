Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501A724921
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjFFQaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbjFFQ3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:29:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62499E5E;
        Tue,  6 Jun 2023 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BvT/eNxg/5rjPa2sOC3D8I0JHHVxlfloKt+kx0Z0/Mg=; b=OXQzQXBNXqC3aUCfMVIrhM57wc
        NVQX94KnQJHD9z69uCJKNIFag6ewR2R2FIc7R46MZ4HZbzaTgb8h+xDj0VCw9T9jPlKkSNu4yvak5
        btloZldACsspTZultlkQa+a3ps5SLTAIu7ShkG4OxE1+OzIVA5aompKIOH3bTuh8MXbMQLBdOaCuC
        mzcpP9wLMshu94TZCmVWldiAOR2DAHy2RDhmx8qCOfAUhfWkXU232pO72BX0iAd2YZV0uwC7wFvlf
        7HFM0uXBlVyLL+SwKSqUmssgZSGnL2VPEZY8pHuV2/Yu/ARlOuO6CbEefX1NmjQucZXWyrhwqA8H3
        JzlUk3dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6ZZ6-00DJsL-UA; Tue, 06 Jun 2023 16:29:48 +0000
Date:   Tue, 6 Jun 2023 17:29:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
Message-ID: <ZH9e/GpsIR6FnXWM@casper.infradead.org>
References: <20230605225434.GF1325469@frogsfrogsfrogs>
 <87jzwhjwmz.fsf@doe.com>
 <20230606160317.GA72224@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606160317.GA72224@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:03:17AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 06, 2023 at 05:21:32AM +0530, Ritesh Harjani wrote:
> > So, I do have a confusion in __folio_mark_dirty() function...
> > 
> > i.e. __folio_mark_dirty checks whether folio->mapping is not NULL.
> > That means for marking range of blocks dirty within iop from
> > ->dirty_folio(), we can't use folio->mapping->host is it?
> > We have to use inode from mapping->host (mapping is passed as a
> > parameter in ->dirty_folio).

It probably helps to read the commentary above filemap_dirty_folio().

 * The caller must ensure this doesn't race with truncation.  Most will
 * simply hold the folio lock, but e.g. zap_pte_range() calls with the
 * folio mapped and the pte lock held, which also locks out truncation.

But __folio_mark_dirty() can't rely on that!  Again, see the commentary:

 * This can also be called from mark_buffer_dirty(), which I
 * cannot prove is always protected against truncate.

iomap doesn't do bottom-up dirtying, only top-down.  So it absolutely
can rely on the VFS having taken the appropriate locks.

> Ah, yeah.  folio->mapping can become NULL if truncate races with us in
> removing the folio from the foliocache.
> 
> For regular reads and writes this is a nonissue because those paths all
> take i_rwsem and will block truncate.  However, for page_mkwrite, xfs
> doesn't take mmap_invalidate_lock until after the vm_fault has been
> given a folio to play with.

invalidate_lock isn't needed here.  You take the folio_lock, then you
call folio_mkwrite_check_truncate() to make sure it wasn't truncated
before you took the folio_lock.  Truncation will block on the folio_lock,
so you're good unless you release the folio_lock (which you don't,
you return it to the MM locked).

