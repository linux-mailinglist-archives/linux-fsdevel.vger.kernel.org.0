Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B417068FD52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 03:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBICsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 21:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjBICrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:47:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C863EB5E;
        Wed,  8 Feb 2023 18:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VBRf3kzezRGAcEqaQ6FqqxXIsPA/O+8ixt4Mt6EZ1iE=; b=Tr2Y/7RFlxGZWNQeZTUv4kN+Wb
        /Fg0Wmke6hO89KsqNkjQgdkSCyzYuXQzbJ6N3A+Wl8Q4GSlr+S8uujRVcWZaoZiyxRC+bP2rGC6hW
        VqsD2KZONdU6/BHyHQvgePlgXveJmGJkekvQueBRszL67cAr7dxW6vJKExw+NKQAxdIhuDh5UKXfI
        mQQaQpz04gMPZerXq9H0bl+t18EDrgTskDBdThVYBCDSW1CeGr+tO4Zf+oJ3o9362h6MLs3SYsZRE
        boyRUfBpDGh8BtFU+ZmGdxX3jsYwQ7UwplcmKo0F2cWMG/G5gTIpFvhbRZyC4SrjFPmtvpory64EX
        hyhYTQCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPwv6-001kY4-Av; Thu, 09 Feb 2023 02:44:20 +0000
Date:   Thu, 9 Feb 2023 02:44:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <Y+ReBH8DFxf+Iab4@casper.infradead.org>
References: <20230208145335.307287-1-willy@infradead.org>
 <20230208145335.307287-2-willy@infradead.org>
 <Y+PQN8cLdOXST20D@magnolia>
 <Y+PX5tPyOP2KQqoD@casper.infradead.org>
 <20230208215311.GC360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208215311.GC360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:53:11AM +1100, Dave Chinner wrote:
> > If XFS really needs it,
> > it can trylock the semaphore and return 0 if it fails, falling back to
> > the ->fault path.  But I don't think XFS actually needs it.
> >
> > The ->map_pages path trylocks the folio, checks the folio->mapping,
> > checks uptodate, then checks beyond EOF (not relevant to hole punch).
> > Then it takes the page table lock and puts the page(s) into the page
> > tables, unlocks the folio and moves on to the next folio.
> > 
> > The hole-punch path, like the truncate path, takes the folio lock,
> > unmaps the folio (which will take the page table lock) and removes
> > it from the page cache.
> > 
> > So what's the race?
> 
> Hole punch is a multi-folio operation, so while we are operating on
> invalidating one folio, another folio in the range we've already
> invalidated could be instantiated and mapped, leaving mapped
> up-to-date pages over a range we *require* the page cache to empty.

Nope.  ->map_pages is defined to _not_ instantiate new pages.
If there are uptodate pages in the page cache, they can be mapped, but
missing pages will be skipped, and left to ->fault to bring in.

