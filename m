Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3A6A5ED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 19:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjB1Sgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Sgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:36:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9121282;
        Tue, 28 Feb 2023 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WnkMjIPZKHVLY1uhgD34GbMbIy9v1L551xmVQ313ee4=; b=iw++GEuWCS2XGqr3CPq0PLMPVo
        iOMh2QF+G1h35IYc4pfMnjBckDWHVDxDWNjefdbSel+s6TQXoIaWUxs9n2TIBQi9MyJB1qTXZXbN1
        PTIEOHrLCfC4EGtbjfeIyrE3eAQNV98g8TldY805vd6sNA9wip5JO/hyOetpFNnt62W9hpi/23qJ0
        UV61ij/+k0kXAmKx+yKxWS53c0KZ4QOv68nGo6G1h9g1HQI7QzKwG9H++SzBwNG5RPaV/EppIyqON
        WusFHQQHE3zkjQeypAQH7W/DOOGQCaseBUA8o2zFek0+AU2YoDGa6pnUaHc1Rjc9EhXOG65ViBcIu
        ISfD8/aA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX4q6-0012jE-HY; Tue, 28 Feb 2023 18:36:38 +0000
Date:   Tue, 28 Feb 2023 18:36:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 1/3] iomap: Allocate iop in ->write_begin() early
Message-ID: <Y/5Jttk0j4m6dep8@casper.infradead.org>
References: <Y/vnbc5A1InqhzWt@casper.infradead.org>
 <877cw13aib.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cw13aib.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:03:48AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Mon, Feb 27, 2023 at 01:13:30AM +0530, Ritesh Harjani (IBM) wrote:
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -535,11 +535,16 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> >>  	size_t from = offset_in_folio(folio, pos), to = from + len;
> >>  	size_t poff, plen;
> >>
> >> +	if (pos <= folio_pos(folio) &&
> >> +	    pos + len >= folio_pos(folio) + folio_size(folio))
> >> +		return 0;
> >> +
> >> +	iop = iomap_page_create(iter->inode, folio, iter->flags);
> >> +
> >>  	if (folio_test_uptodate(folio))
> >>  		return 0;
> >>  	folio_clear_error(folio);
> >>
> >> -	iop = iomap_page_create(iter->inode, folio, iter->flags);
> >>  	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
> >>  		return -EAGAIN;
> >
> > Don't you want to move the -EAGAIN check up too?  Otherwise an
> > io_uring write will dirty the entire folio rather than a block.
> 
> I am not entirely convinced whether we should move this check up
> (to put it just after the iop allocation). The reason is if the folio is
> uptodate then it is ok to return 0 rather than -EAGAIN, because we are
> anyway not going to read the folio from disk (given it is completely
> uptodate).
> 
> Thoughts? Or am I missing anything here.

But then we won't have an iop, so a write will dirty the entire folio
instead of just the blocks you want to dirty.
