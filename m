Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95E4853BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiAENm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 08:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiAENm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:42:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C884FC061761;
        Wed,  5 Jan 2022 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/NiGIN8k3RHTEUKNhysC6HL61nLsPTHTO/ZQbSmGP8A=; b=nfK7e3xawe3pZrSa+4CpkIKZWN
        es/NtLm/E1RzM6UAUqr6T751hVq0ZwyR1EfKqQXtEfsMBEFlHFVtwAO2ZN7KaYHXufgsivO+xVCFn
        BIK9h36+lccV/+e/Ci6sv/Y0pYyyXUOdxuoZ58Lh8JJHP5Q+KkeYQpDbTlC3hGmENijcsAS5Ks8pk
        5EtcYHQ0SHD6n3Fm5HtqdTS8Z5RZdtndRHZvOxeTFYpg5X52G7N8m/Zg1ssDw+81c2PAnf1jp+q/k
        djF/Bze9OIDdDpHRsMJEJo6LNCRgA0PapyeaaXyttVn470ZX6VXLdX5m3XG4e5kLFro7QmQSrynzF
        PLwXfaCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n56Yy-00EtEW-O5; Wed, 05 Jan 2022 13:42:48 +0000
Date:   Wed, 5 Jan 2022 05:42:48 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdWgWC8FDwv0z7ze@infradead.org>
References: <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104231230.GG31606@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:12:30PM -0800, Darrick J. Wong wrote:
> As I see it, the problem here is that we're spending too much time
> calling iomap_finish_page_writeback over and over and over, right?
> 
> If we have a single page with a single mapping that fits in a single
> bio, that means we call bio_add_page once, and on the other end we call
> iomap_finish_page_writeback once.

iomap_finish_page_writeback is called once per page, and the folio
equivalent will be called once per folio, yes.

But usually call bio_add_page mutliple times, due to the silly one block
at a time loop in iomap_writepage_map.  But that is someting we can
easily fix.
