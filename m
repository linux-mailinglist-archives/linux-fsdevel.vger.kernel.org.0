Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C395226DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 00:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiEJWaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiEJWaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 18:30:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B16BFD0;
        Tue, 10 May 2022 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m8IxzcCYbau6+4M1TLsz/PQ8XysgsXWA0LXlKrdhYwg=; b=pkw1z0azOcX6iZcvHLiPHtrpAG
        J1EBb7HZRbp7W8BT6vFLOPYRxdcwHidXPb7z0vADps54pBtLfokCZstnKrNfY7yss5qEE6BSRASAY
        Md468FT/liHxESlPK/B27x1vjbBM9eFevOJ6rwtiWHD4/ong8l/29Xl0w0KLEzOADGKyfP4Sbj77C
        7bMMxtQqXWr/VCsGSWtnC9W8pObNNZ2+57bRunNcAAL9ys3Qu8A8JrsLjELfQ1vOm4L4NpAhAy9rv
        n6LmKA7GAIxO1+5y8x0IYprZtHp5WzdHGGWOmYz97iE8lnGijqT6rTaPLNL5RnJdc7mO3Fpkq3H1e
        C1FspTuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noYMk-004rYS-Hk; Tue, 10 May 2022 22:30:02 +0000
Date:   Tue, 10 May 2022 23:30:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Two folio fixes for 5.18
Message-ID: <YnrnaoCVjAZfqNvW@casper.infradead.org>
References: <YnRhFrLuRM5SY+hq@casper.infradead.org>
 <20220510151809.f06c7580af34221c16003264@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510151809.f06c7580af34221c16003264@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 03:18:09PM -0700, Andrew Morton wrote:
> On Fri, 6 May 2022 00:43:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> >  - Fix readahead creating single-page folios instead of the intended
> >    large folios when doing reads that are not a power of two in size.
> 
> I worry about the idea of using hugepages in readahead.  We're
> increasing the load on the hugepage allocator, which is already
> groaning under the load.

Well, hang on.  We're not using the hugepage allocator, we're using
the page allocator.  We're also using variable order pages, not
necessarily PMD_ORDER.  I was under the impression that we were
using GFP_TRANSHUGE_LIGHT, but I now don't see that.  So that might
be something that needs to be changed.

> The obvious risk is that handing out hugepages to a low-value consumer
> (copying around pagecache which is only ever accessed via the direct
> map) will deny their availability to high-value consumers (that
> compute-intensive task against a large dataset).
> 
> Has testing and instrumentation been used to demonstrate that this is
> not actually going to be a problem, or are we at risk of getting
> unhappy reports?

It's hard to demonstrate that it's definitely not going to cause a
problem.  But I actually believe it will help; by keeping page cache
memory in larger chunks, we make it easier to defrag memory and create
PMD-order pages when they're needed.
