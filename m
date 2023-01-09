Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1AE66293C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjAIPCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjAIPCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:02:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E39175A0;
        Mon,  9 Jan 2023 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6o3r2EMyccew4PMHM+hL8pHG/IMPNNpv5+R12jgC6lA=; b=kRYbhsmUqtz7MJELa5DMvJ4VzI
        6X90lrh3MAb0AIocQDosyWd6xWeVzvyuJrsUYMQztbBYwfsmPXDyS4olyKkeV4RTEuwcqO0Tv8eWe
        XjEPn1N0fJJo10rKVG6oL/LDCcXf/PL5DEaFhFtXgh6MueLKYg8q/zPjuZBcQVUSgel55zEIY4NYP
        lotZ+B7P0JsJ+9216Jzf6B/g0gzs+oYAoLkxUeHuwpjQDMzMlbnXhWXdt/9lvnOLcXluRjaZqa7uW
        PdLuvYrfIhjdjaLwTYqha4g23TN/WXSruYsiK5FgblOwfcP/Ugk6QM4mVBY1WHf5p2fbRCh5fDJJ+
        seAPhoAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEtft-002NKW-SN; Mon, 09 Jan 2023 15:02:57 +0000
Date:   Mon, 9 Jan 2023 15:02:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/11] filemap: Remove filemap_check_and_keep_errors()
Message-ID: <Y7wsoXOZZQo5KNQp@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
 <20230109051823.480289-3-willy@infradead.org>
 <36311b962209353333be4c8ceaf0e0823ef9f228.camel@redhat.com>
 <Y7weinAVLt0uPRa8@casper.infradead.org>
 <05df91ed071cfefa272bb8d2fb415222867bae32.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05df91ed071cfefa272bb8d2fb415222867bae32.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:31:00AM -0500, Jeff Layton wrote:
> On Mon, 2023-01-09 at 14:02 +0000, Matthew Wilcox wrote:
> > On Mon, Jan 09, 2023 at 08:48:49AM -0500, Jeff Layton wrote:
> > > On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > > > Convert both callers to use the "new" errseq infrastructure.
> > > 
> > > I looked at making this sort of change across the board alongside the
> > > original wb_err patches, but I backed off at the time.
> > > 
> > > With the above patch, this function will no longer report a writeback
> > > error that occurs before the sample. Given that writeback can happen at
> > > any time, that seemed like it might be an undesirable change, and I
> > > didn't follow through.
> > > 
> > > It is true that the existing flag-based code may miss errors too, if
> > > multiple tasks are test_and_clear'ing the bits, but I think the above is
> > > even more likely to happen, esp. under memory pressure.
> > > 
> > > To do this right, we probably need to look at these callers and have
> > > them track a long-term errseq_t "since" value before they ever dirty the
> > > pages, and then continually check-and-advance vs. that.
> > > 
> > > For instance, the main caller of the above function is jbd2. Would it be
> > > reasonable to add in a new errseq_t value to the jnode for tracking
> > > errors?
> > 
> > Doesn't b4678df184b3 address this problem?  If nobody has seen the
> > error, we return 0 instead of the current value of wb_err, ensuring
> > that somebody always sees the error.
> > 
> 
> I was originally thinking no, but now I think you're correct.
> 
> We do initialize the "since" value to 0 if an error has never been seen,
> so that (sort of) emulates the behavior of the existing AS_EIO/AS_ENOSPC
> flags.
> 
> It's still not quite as reliable as plumbing a "since" value through all
> of the callers (particularly in the case where there are multiple
> waiters), but maybe it's good enough here.

I actually think we may have the opposite problem; that for some of
these scenarios, we never mark the error as seen.  ie we always end
up calling errseq_check() and never errseq_check_and_advance().  So
every time we write something, it'll remind us that we have an error.
