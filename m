Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303EE3C438D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 07:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhGLFtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 01:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhGLFtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 01:49:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D532C0613DD;
        Sun, 11 Jul 2021 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIkXxBU1HNV+v3OiQiTyAs5WzjT0C+SmqQB/RpmsElc=; b=E4e3BtdTYiFYE88DGJiQ6Im7M/
        MkAELvomPuJ3JAYz/gvicMC9ejtEZqS2GjCh0og0BVaw8BMIHLgJLRv4Wt7dQLmquDobHF8jERFJZ
        +Rwl8hmtN444tws8aZ08oEEQ7aaI1GVSJsQ3r+wJXNz39bXwk0CuZdkOMJyrJWjxp3/Qm+2LSv2NX
        PUknx4Z9724IGaEMd5nw8gQMK98429W4eGMY6ZBxf8e1xWKe15lvx/sy4kCO8Ryq5pm625bi1a6b9
        WVmgKCSTAauYabRU8J/GZQmbfuNDQa0LNYFc7wwCfnAzv86sgpFeaZx0MjCazMqzj+RBn+o73Cq18
        WXR2ytnA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2olZ-00Gusn-72; Mon, 12 Jul 2021 05:46:07 +0000
Date:   Mon, 12 Jul 2021 06:46:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 000/137] Memory folios
Message-ID: <YOvXHZ7tCxV2Ex2m@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 04:04:44AM +0100, Matthew Wilcox (Oracle) wrote:
> Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> benefit from a larger "page size".  As an example, an earlier iteration
> of this idea which used compound pages (and wasn't particularly tuned)
> got a 7% performance boost when compiling the kernel.
> 
> Using compound pages or THPs exposes a weakness of our type system.
> Functions are often unprepared for compound pages to be passed to them,
> and may only act on PAGE_SIZE chunks.  Even functions which are aware of
> compound pages may expect a head page, and do the wrong thing if passed
> a tail page.
> 
> We also waste a lot of instructions ensuring that we're not looking at
> a tail page.  Almost every call to PageFoo() contains one or more hidden
> calls to compound_head().  This also happens for get_page(), put_page()
> and many more functions.
> 
> This patch series uses a new type, the struct folio, to manage memory.
> It converts enough of the page cache, iomap and XFS to use folios instead
> of pages, and then adds support for multi-page folios.  It passes xfstests
> (running on XFS) with no regressions compared to v5.14-rc1.

This seems to miss a changelog vs the previous version.  It also
includes a lot of the follow ups.  I think reviewing a series gets
rather hard at more than 30-ish patches, so chunking it up a little
more would be useful.
