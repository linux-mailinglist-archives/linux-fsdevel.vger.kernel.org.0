Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5653D48E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGXQri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGXQri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 12:47:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D640C061575;
        Sat, 24 Jul 2021 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/q2OUFHGHnNOj2YWSRkzWiiQH0hVUMtLRqj4jzPJgI=; b=gky8adROBWilg+idqPXV+hW/r0
        G/T/24vDtwXzirAYXoSMJL0OFgxbeHHb9dBijq4Hdx5aE6ruopVRBxiNXg2Ru35hosdK1HjAHxn/L
        joFlAgkSTuo3tM9QI2DL+fMGt/rqtTCt10rMHmMv2Ze0SqKAqsm66VYhMw0/sCZmm7L6yObMp6Qfr
        /GrFP39f5wcfT8XHXRgyZRasl1YekSlNMRiLjuKPKh23854ciMhfGFy+3C8SeaFYhPyWbChjaQMNY
        SfiprTA4hFxIL3DoJyBPydDPdFdnOpj5u5AXMLIbMVm50LnUiwZe204L/IG6oW/40+uEkeuSnX2gr
        rtbRNriA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7LRB-00CQK6-H6; Sat, 24 Jul 2021 17:28:00 +0000
Date:   Sat, 24 Jul 2021 18:27:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andres Freund <andres@anarazel.de>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Folios give an 80% performance win
Message-ID: <YPxNkRYMuWmuRnA5@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:46AM +0100, Matthew Wilcox (Oracle) wrote:
> Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> benefit from a larger "page size".  As an example, an earlier iteration
> of this idea which used compound pages (and wasn't particularly tuned)
> got a 7% performance boost when compiling the kernel.

I want to thank Michael Larabel for his benchmarking effort:
https://www.phoronix.com/scan.php?page=news_item&px=Folios-v14-Testing-AMD-Linux

I'm not too surprised by the lack of performance change on the majority
of benchmarks.  This patch series is only going to change things for
heavy users of the page cache (ie it'll do nothing for anon memory users),
and it's only really a benefit for programs that have good locality.

What blows me away is the 80% performance improvement for PostgreSQL.
I know they use the page cache extensively, so it's plausibly real.
I'm a bit surprised that it has such good locality, and the size of the
win far exceeds my expectations.  We should probably dive into it and
figure out exactly what's going on.

Should we accelerate inclusion of this patchset?  Right now, I have
89 mm patches queued up for the 5.15 merge window.  My plan was to get
the 17 iomap + block patches, plus another 18 page cache patches into
5.16 and then get the 14 multi-page folio patches into 5.17.  But I'm
mindful of the longterm release coming up "soon", and I'm not sure we're
best served by multiple distros trying to backport the multi-page folio
patches to either 5.15 or 5.16.
