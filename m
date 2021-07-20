Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9566C3CF8F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhGTK50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbhGTK5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:57:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FDBC061574;
        Tue, 20 Jul 2021 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=48ZoYAHxVjUR+g2Z6dUC+xAOF9LbotA5xFo5BSIxUUk=; b=IQIpktxqEtVGUTHiwSEv1nrG6X
        BV723Sv5+clirdeiwW6FCcNBVBLrqkobRbPMZRxYdgLNNEM4PoH/t98jeiB3ui2vy9hQ8ZvEIaiVJ
        S5g8rbvQJGwi5zolqSMWCwyYwDmePMhKqJUWdASTnM1iX6OM7NPzo94LbXhazyzAGw1N2lyMCsiaJ
        k1rg+ueGyMHOXT7jyNJhRfdDALoOSHvJAxFTQifHWyQJLyuhpIxWjvYeKh6Hqm8XQOM3ikY0nyxov
        9H5MnPLuKSU83z2dtUelTBXh47oC6KC+OiYpuJjM1uEP8atppAOMXFOt4YXcBqr/NrlAvPhQ31IMU
        in5vCCfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5o3V-0083QU-Ep; Tue, 20 Jul 2021 11:37:05 +0000
Date:   Tue, 20 Jul 2021 12:36:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 08/17] iomap: Pass the iomap_page into
 iomap_set_range_uptodate
Message-ID: <YPa1WT21+gi2hZT0@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-9-willy@infradead.org>
 <YPZzwkcNP0NQEv6+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZzwkcNP0NQEv6+@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:57:06AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 07:39:52PM +0100, Matthew Wilcox (Oracle) wrote:
> > All but one caller already has the iomap_page, and we can avoid getting
> > it again.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> In general reloading it from a single pointer should be faster than
> passing an extra argument.  What is the rationale here?

I'm not sure we can make that determination in general; it's going to
depend on the number of registers the CPU has, the calling conventions,
how much inlining the compiler chooses to do, etc.

The compiler is actually _forced_ to reload the iop from the page
by the test_bit() in PagePrivate() / folio_test_private().  I want
to kill off that bit, but until I have time to work on that, we
don't have a good workaround.
