Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D77772CD47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjFLRys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjFLRyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:54:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883810DC;
        Mon, 12 Jun 2023 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S/s1ddqePgmoNMOZAfQC+8K1eX2Z30E6NVOtj66/zlo=; b=MHiF2ewOZEuR78oa4hF5HFGKCU
        dcrCGvnZ1MrUq+buk8tANPC646jzSeC0xcitH5ILj6IfEbbCLkTAlUiiyRMSHuy0FaSSIyWjM7WBy
        7kvyNpwzfA7+7hkrcbXrZU4DegCM1T8gDabuBRQrdAIaAm3iR8yym5zZWmZgjxQYhv75LROxOUSfK
        71AV9I9f4oRNXSpDAHQcBdEF7RtYYUvHPQ4+J8L6rEt/rjFmQmQs71W+Og88LRLuGGU+GGFOYcKgT
        mHOf4/fe4SC42naoTPXDFu2wawH7G8yBhygdRvFbVf/6wZGgUeuM3Y0p+QCY0P2DYtIOIJX0M+hPO
        8XuOHMnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8lkT-002tdI-AX; Mon, 12 Jun 2023 17:54:37 +0000
Date:   Mon, 12 Jun 2023 18:54:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and
 others
Message-ID: <ZIdb3TrwnhcQ3ULw@casper.infradead.org>
References: <20230612155911.GC11441@frogsfrogsfrogs>
 <87ttvcpodt.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttvcpodt.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:13:42PM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> > Ritesh: Please pick whichever variant you like, and that's it, no more
> > discussion.
> 
> static inline struct iomap_folio_state *to_folio_state(struct folio *folio)
> {
>     return folio->private;
> }
> 
> Sure this looks fine to me. So, I am hoping that there is no need to check
> folio_test_private(folio) PG_private flag here before returning
> folio->private (which was the case in original code to_iomap_page())
> 
> I did take a cursory look and didn't find any reason to test for doing
> folio_test_private(folio) here. It should always remain set between
> iomap_ifs_alloc() and iomap_ifs_free().
> 
> - IIUC, it is mostly for MM subsystem to see whether there is a
> private FS data attached to a folio for which they think we might have
> to call FS callback. for e.g. .is_dirty_writeback callback.
> - Or like FS can use it within it's own subsystem to say whether a
> folio is being associated with an in-progress read or write request. (e.g. NFS?)

The PG_private flag is being obsoleted in favour of just testing
folio->private for being NULL.  It's still in widespread use, but I'm
removing it as I change code.  I think we'll probably get rid of PG_error
first, but the more page flags we free up the better.  PG_hwpoison is
also scheduled for removal, but that requires folios to be dynamically
allocated first, so freeing that bit probably comes third.
