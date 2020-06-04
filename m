Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8B1EEE2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 01:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgFDXMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFDXMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:12:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C20C08C5C1;
        Thu,  4 Jun 2020 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vLkbveTzLrm+1mGeplB+ePn3QIH8H7o1DVPIYYdiRK4=; b=E9BARcPtQWALfSiXDWtgpM6WrE
        i9SCajNKsOHN3OIlAKCN8L+EXFCmTQfZFDkPB9dsuSvNB1GEuDhe2b6JMcAQs1ebIB9YC287ZeqVm
        8Mu/IN6GcVUsXXLw7ojs5NN1ckyOD5Xjk4YCEcRFM/Svsuqw2G1Bzzoe3ecj0pKqXocCzsI+tOTVh
        gx4vLL2jzB+v1k2zmSbEaZw6yfYt5NhxXANP5pAMu18eSx83Lw8LDr3lxaPO1gM4g+kSomsDyt0rc
        NrBM4jaz5upjrR+VoRbIN6nyZADbQuRT0XOgeECGztuYiBO0Adj0GqWpesV3Y7RkHm9SJJOKQUMCc
        Jmhar29Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgyvH-0006iF-G0; Thu, 04 Jun 2020 23:05:19 +0000
Date:   Thu, 4 Jun 2020 16:05:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200604230519.GW19604@bombadil.infradead.org>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604225726.GU2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 08:57:26AM +1000, Dave Chinner wrote:
> On Thu, Jun 04, 2020 at 01:23:40PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Test generic/019 often results in:
> > 
> > WARNING: at fs/iomap/buffered-io.c:1069 iomap_page_mkwrite_actor+0x57/0x70
> > 
> > Since this can happen due to a storage error, we should not WARN for it.
> > Just return -EIO, which will be converted to a SIGBUS for the hapless
> > task attempting to write to the page that we can't read.
> 
> Why didn't the "read" part of the fault which had the EIO error fail
> the page fault? i.e. why are we waiting until deep inside the write
> fault path to error out on a failed page read?

I have a hypothesis that I don't know how to verify.

First the task does a load from the page and we put a read-only PTE in
the page tables.  Then it writes to the page using write().  The page
gets written back, but hits an error in iomap_writepage_map()
which calls ClearPageUptodate().  Then the task with it mapped attempts
to store to it.

I haven't dug through what generic/019 does, so I don't know how plausible
this is.
