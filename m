Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D5570B49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiGKUY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGKUY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:24:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D47E2717E;
        Mon, 11 Jul 2022 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GpUxC4xM2q0YHyxeurm32X0RDwIgOBVOHXbx9JCax3s=; b=qoM8VEm+ykd3JseVkxElopsHN0
        HDA+4r27tlPXq4X28R6Ly4e45e7EhW1MCqP3iepZXuYstAXEyCpFmQ80OhUVx0khdSKSTcB9jaCi1
        aB7U0Ona0i28+mZ5YEofqmzJoWURRdJ9WBhRcWuBs/LkTWFCmyiZXuRn72ghKOxGM4iPULOXnaF0k
        ACpyM168x8fsS2MFOOMPa37HgV48OQYc87dGxGwPcSG6rBeUaTrvn+eXYvQfxdoEiy6Uq/ETa6Rvg
        Cxwd5csG7Exks19VF1zGH68oOZB9Wr8vFp89PCKjioyC+Ueju4NRG62HlfoKZzL9bFi2n/f4lJDdQ
        rQyd9/PA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAzxd-006G6r-1S; Mon, 11 Jul 2022 20:24:53 +0000
Date:   Mon, 11 Jul 2022 21:24:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YsyHFe9wph7pmpWS@casper.infradead.org>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
 <YqnXVMtBkS2nbx70@bfoster>
 <YqnhW2CI1kbJ3NqR@casper.infradead.org>
 <YqnwFZxmiekL5ZOC@bfoster>
 <YqoJ+p83dLOcGfwX@casper.infradead.org>
 <20220628125511.s2frv6lw7zgyzou5@wittgenstein>
 <YrsV/uT2MDgNPMvR@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrsV/uT2MDgNPMvR@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:53:50AM -0400, Brian Foster wrote:
> On Tue, Jun 28, 2022 at 02:55:11PM +0200, Christian Brauner wrote:
> > On Wed, Jun 15, 2022 at 05:34:02PM +0100, Matthew Wilcox wrote:
> > > On Wed, Jun 15, 2022 at 10:43:33AM -0400, Brian Foster wrote:
> > > > Interesting, thanks. I'll have to dig more into this to grok the current
> > > > state of the radix-tree interface vs. the underlying data structure. If
> > > > I follow correctly, you're saying the radix-tree api is essentially
> > > > already a translation layer to the xarray these days, and we just need
> > > > to move legacy users off the radix-tree api so we can eventually kill it
> > > > off...
> > > 
> > > If only it were that easy ... the XArray has a whole bunch of debugging
> > > asserts to make sure the users are actually using it correctly, and a
> > > lot of radix tree users don't (they're probably not buggy, but they
> > > don't use the XArray's embedded lock).
> > > 
> > > Anyway, here's a first cut at converting the PID allocator from the IDR
> > > to the XArray API.  It boots, but I haven't tried to do anything tricky
> > > with PID namespaces or CRIU.
> > 
> > It'd be great to see that conversion done.
> > Fwiw, there's test cases for e.g. nested pid namespace creation with
> > specifically requested PIDs in
> > 
> 
> Ok, but I'm a little confused. Why open code the xarray usage as opposed
> to work the idr bits closer to being able to use the xarray api (and/or
> work the xarray to better support the idr use case)? I see 150+ callers
> of idr_init(). Is the goal to eventually open code them all? That seems
> a lot of potential api churn for something that is presumably a generic
> interface (and perhaps inconsistent with ida, which looks like it uses
> xarray directly?), but I'm probably missing details.

It's not "open coding".  It's "using the XArray API instead of the
IDR API".  The IDR API is inferior in a number of ways, and yes, I
do want to be rid of it entirely.
