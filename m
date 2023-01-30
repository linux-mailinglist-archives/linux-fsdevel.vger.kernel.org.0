Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF768181F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbjA3SBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 13:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjA3SBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:01:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FE3BDB4;
        Mon, 30 Jan 2023 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tEQK6TYUqdhgyxrUYxHzxIKC2nZ/8V1ocG4mWrhysMY=; b=StqTM3BuwbivdSPdmgA6aLBoqc
        D2MvDuyKvrGPgr6S+9LzKsp1w6ISXT5yc8ANf08lLkM2Oru3S7U2SX9hib6viBj8MvbWW/jeXX0zF
        9TFLBZd4rExY7x0VUPA7rc867hpV6If/vYJKGAp8xrch1aujmAaudOSSD6AWFS/EaHEq9/PfZAGXk
        ezJaoH3mOCUZGJT0e9BZMVuwufLvk9JwmFP0/5L6ETJ4MrtaYfMlurJ4BHdZ7l57U71ntJL1byJHi
        rq0a4ajv8EA8jG+wru6CprwoszHtfvCcdmVkskVN8M35xG89Uue6Dxv2V+dXXC+enW9U+DNvC6UEo
        4v5hDhLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMYSw-00AZF9-0x; Mon, 30 Jan 2023 18:01:14 +0000
Date:   Mon, 30 Jan 2023 18:01:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <Y9gF6RVxDkvEgQoG@casper.infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
 <Y9f7cZxnXbL7x0p+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9f7cZxnXbL7x0p+@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:16:33AM -0800, Christoph Hellwig wrote:
> > +		if (from_writeback && folio_test_uptodate(folio))
> > +			bitmap_fill(iop->state, 2 * nr_blocks);
> > +		else if (folio_test_uptodate(folio)) {
> 
> This code is very confusing.  First please only check
> folio_test_uptodate one, and then check the from_writeback flag
> inside the branch.  And as mentioned last time I think you really
> need some symbolic constants for dealing with dirty vs uptodate
> state and not just do a single fill for them.

And I don't think this 'from_writeback' argument is well-named.
Presumably it's needed because folio_test_dirty() will be false
at this point in the writeback path because it got cleared by the VFS?
But in any case, it should be called 'dirty' or something, not tell me
where the function was called from.  I think what this should really
do is:

		if (dirty)
			iop_set_dirty(iop, 0, nr_blocks);
		if (folio_test_uptodate(folio))
			iop_set_uptodate(iop, 0, nr_blocks);

> > +			unsigned start = offset_in_folio(folio,
> > +					folio_pos(folio)) >> inode->i_blkbits;
> > +			bitmap_set(iop->state, start, nr_blocks);
> 
> Also this code leaves my head scratching.  Unless I'm missing something
> important
> 
> 	 offset_in_folio(folio, folio_pos(folio))
> 
> must always return 0.

You are not missing anything.  I don't understand the mental process
that gets someone to writing that.  It should logically be 0.

> Also the from_writeback logic is weird.  I'd rather have a
> "bool is_dirty" argument and then pass true for writeback beause
> we know the folio is dirty, false where we know it can't be
> dirty and do the folio_test_dirty in the caller where we don't
> know the state.

hahaha, you think the same.  ok, i'm leaving my above comment though ;-)

