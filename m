Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358C528427
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiEPM1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiEPM12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 08:27:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978AAD128;
        Mon, 16 May 2022 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U5VI8zXdl6DIe/OLtIvojuzmBZau1HR66LEcIOGmLYA=; b=YIN6W0RGVkGgG4jkmn82oHGcFB
        BMmgzziyDIbTfSDU1crJYgAEBlhNaPXNialMdCMRt0I+RYjZDNV/uSUpmzjK27Q8edP6X4iJKrPh0
        COD2j8ZYHjK61xZy7Q6ElO0Fc7OKs231KZ9tnXXqR+/5FZsh1N7l/QgmH7TSH09OLQ/YOSdEtDvtG
        ME6I9Y4YlsURdrUwXDhYGJTquYGYVLLjX3nZfCPEuV6T9bpX8Ct1w8E1vNrBUmDSp4R98Eeia82Kb
        A1VDAfPWTpsguruHUPHlf/oHCu19EzU+NZrbJaW7NGeYBnT0p76aePmtdqArEWs6dmYc1YEIunSYf
        iv4yMhgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqZom-009s9n-E6; Mon, 16 May 2022 12:27:20 +0000
Date:   Mon, 16 May 2022 13:27:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: don't invalidate folios after writeback errors
Message-ID: <YoJDKHczzm3dfjwG@casper.infradead.org>
References: <YoHG5cMwvx8PSddI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoHG5cMwvx8PSddI@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 15, 2022 at 08:37:09PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> XFS has the unique behavior (as compared to the other Linux filesystems)
> that on writeback errors it will completely invalidate the affected
> folio and force the page cache to reread the contents from disk.  All
> other filesystems leave the page mapped and up to date.
> 
> This is a rude awakening for user programs, since (in the case where
> write fails but reread doesn't) file contents will appear to revert to
> old disk contents with no notification other than an EIO on fsync.  This
> might have been annoying back in the days when iomap dealt with one page
> at a time, but with multipage folios, we can now throw away *megabytes*
> worth of data for a single write error.
> 
> On *most* Linux filesystems, a program can respond to an EIO on write by
> redirtying the entire file and scheduling it for writeback.  This isn't
> foolproof, since the page that failed writeback is no longer dirty and
> could be evicted, but programs that want to recover properly *also*
> have to detect XFS and regenerate every write they've made to the file.
> 
> When running xfs/314 on arm64, I noticed a UAF bug when xfs_discard_folio
> invalidates multipage folios that could be undergoing writeback.  If,
> say, we have a 256K folio caching a mix of written and unwritten
> extents, it's possible that we could start writeback of the first (say)
> 64K of the folio and then hit a writeback error on the next 64K.  We
> then free the iop attached to the folio, which is really bad because
> writeback completion on the first 64k will trip over the "blocks per
> folio > 1 && !iop" assertion.
> 
> This can't be fixed by only invalidating the folio if writeback fails at
> the start of the folio, since the folio is marked !uptodate, which trips
> other assertions elsewhere.  Get rid of the whole behavior entirely.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

