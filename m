Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0703B378E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXUIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhFXUIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:08:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E4C061574;
        Thu, 24 Jun 2021 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BtxiXggwDvXrNGHd7tGUED0H/U9R7sx5bv0cWhEUZYE=; b=pbnNFprtOq0QMj47KdtCAC9lKn
        /zBFzHucRFeOVpNk+IAd/cqbp4zn6o2COCdzyHY/PDn5Bo093uI1jLcRK1bpOvonT4Id4faOJQ+BJ
        M9to8iJn9suJiSucVoX+q+vnccTGbMdOBmN0bBHl8oQ7m4aSuArwUOOG7t3N2PVdULLNq8oihFgT+
        s1ngJ/P7X+K7J8UanYE477NLmL6ki1qUdKmujR5HIPYjdFs4234FKD2qK2rVx+0/fCbyDIAh/zrx6
        YJCSvhT7tcBTUqbI4bEWez91gOfYC6KkztuHGExWrLws2uBhaZZrAKSc5kHHk5WQJSs8BDtU9v8Y0
        E5VC+6AA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwVbw-00Gwt1-94; Thu, 24 Jun 2021 20:06:07 +0000
Date:   Thu, 24 Jun 2021 21:06:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/46] mm/writeback: Add folio_account_cleaned()
Message-ID: <YNTlrBvWq+8H0FcM@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-30-willy@infradead.org>
 <YNMAju9hE/3A+6NZ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMAju9hE/3A+6NZ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:36:14AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:34PM +0100, Matthew Wilcox (Oracle) wrote:
> > Get the statistics right; compound pages were being accounted as a
> > single page.
> 
> Maybe reword this a little to document the existing function that got
> it wrong, and why it did not matter before.

Get the statistics right; compound pages were being accounted as a
single page.  This didn't matter before now as no filesystem which
supported compound pages did writeback.  Also move the declaration
to filemap.h since this is part of the page cache.  Add a wrapper for
account_page_cleaned().

