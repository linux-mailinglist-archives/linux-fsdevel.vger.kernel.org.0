Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5479495A7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378864AbiAUHQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378878AbiAUHQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:16:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F58C061574;
        Thu, 20 Jan 2022 23:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sww/wwaWy03hlZ/EaFDFfo+1Npwvs31lVzyDCnqKm+M=; b=3z9uw5j+S2pf6nD2ooQW91WtxK
        aPSDnO2M+uQJBElEk9lMsC/znXs6RQZ6CJhLkqIX0Iu9skcFdAY+ejjQCQyV/feQLF6NPePEK3nVR
        yBYKmHkRI/ytKK50oeZOBQQZJsGHb9Fyni/SDutvloNOoHUSGtQWStctL2Cmrw4ER5WnVDqZolW4G
        jDUhKW0OAwKdvwZIOp2Wlc0EK/QsfKDkbxW1gbf+VRxbSNt+YBfz54NvNhNFMzeX8OilBhT4XCMZt
        5P7RkYEOjRPDUpOG8w2WElZiTVMC9hv/8WWSQIRDecZcHs4YOP4XvDyiiTJEZSq71XQvOKhYbCfIT
        KmYItTGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAo9l-00E2By-OP; Fri, 21 Jan 2022 07:16:21 +0000
Date:   Thu, 20 Jan 2022 23:16:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, jane.chu@oracle.com
Subject: Re: [PATCH v9 10/10] fsdax: set a CoW flag when associate reflink
 mappings
Message-ID: <YepdxZ+XrAZYv1dX@infradead.org>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-11-ruansy.fnst@fujitsu.com>
 <YekkYAJ+QegoDKCJ@infradead.org>
 <70a24c20-d7ee-064c-e863-9f012422a2f5@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a24c20-d7ee-064c-e863-9f012422a2f5@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:33:58AM +0800, Shiyang Ruan wrote:
> > 
> > But different question, how does this not conflict with:
> > 
> > #define PAGE_MAPPING_ANON       0x1
> > 
> > in page-flags.h?
> 
> Now we are treating dax pages, so I think its flags should be different from
> normal page.  In another word, PAGE_MAPPING_ANON is a flag of rmap mechanism
> for normal page, it doesn't work for dax page.  And now, we have dax rmap
> for dax page.  So, I think this two kinds of flags are supposed to be used
> in different mechanisms and won't conflect.

It just needs someone to use folio_test_anon in a place where a DAX
folio can be passed.  This probably should not happen, but we need to
clearly document that.

> > Either way I think this flag should move to page-flags.h and be
> > integrated with the PAGE_MAPPING_FLAGS infrastucture.
> 
> And that's why I keep them in this dax.c file.

But that does not integrate it with the infrastructure.  For people
to debug things it needs to be next to PAGE_MAPPING_ANON and have
documentation explaining why they are exclusive.
