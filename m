Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44531489ED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiAJSL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiAJSL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:11:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB0C06173F;
        Mon, 10 Jan 2022 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IXDclvvGfX8g/ZBckJ/3SLWrdaDRKpz0LF1OPGXVzvI=; b=ff+m+P71beGj0MkK/YASQ9YUEQ
        6eQGd4BXDI642TW373K/AecrqG2BPxwVOprIKkkjlP70PP7awfl7CTMA6I7YbEop3wWuddvBz0Tlr
        w66cIGirclHcNqmgQiHr2CJvcJx+SKYjTSzTJjwCZFrlT0dJPsdFXvZ9CibBXuWnHcSlW+0TPBklH
        LFEAfaW63NFoBQEG9MhZCdDRHOi52p6SWuc4V79Fy+VAP1UfgAy6nQbSvuJVRFsrGrZz0NLtU07dJ
        h4lyedzaF5yBW8OA/yAvUSf/ms70Mk2agPsxwzmwOZgd1CBnmOCHG1ooJOBe3AgSZfP21flP9asVi
        3FtJ2plg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6z8Y-00Cgu5-33; Mon, 10 Jan 2022 18:11:18 +0000
Date:   Mon, 10 Jan 2022 10:11:18 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <Ydx2xtqMpGBO6vlW@infradead.org>
References: <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
 <20220105021022.GL945095@dread.disaster.area>
 <YdWjkW7hhbTl4TQa@bfoster>
 <20220105220421.GM945095@dread.disaster.area>
 <YdccZ4Ut3VlJhSMS@bfoster>
 <20220110081847.GW945095@dread.disaster.area>
 <YdxwnaT0nYHgGQZR@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxwnaT0nYHgGQZR@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:45:01PM -0500, Brian Foster wrote:
> With regard to the iterators, my understanding was that
> bio_for_each_segment_all() walks the multipage bvecs but
> bio_for_each_segment() does not, but that could certainly be wrong as I
> find the iterators a bit confusing. Either way, the most recent test
> with the ioend granular filter implies that a single ioend can still
> become a soft lockup vector from non-atomic context.

the segment iterators iterate over the pages segments, the
bvec iterators over the multi-page bvecs.  The _all suffix means
it iterates over the whole bio independent of clones and partial
submission state and is for use in the cmpletion handlers.  The
version without it are for use in the block drivers.
