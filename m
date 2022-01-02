Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A603482BCF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jan 2022 17:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiABQLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiABQLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:11:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493BAC061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2H1LCqOHdwbOruEg3mEr2xyI40SX1AVjLeTz8RJHi7k=; b=rlkr+xeccVk1FJRAZqS5S6Qb6k
        B3sDhCprjAE1LY/YzCL6pE69UFOIB17uBk8arj7ByJyEjtfkXYrKIv9Lr2oesWVKVZ+PDrR1mRP71
        +3EgBUjVnglIFzvp4nu9mY+5IfecCMH8XHFvH4UV7tES+2IZaFiBZobTmoLsX1ctbj+m9aFRTMeax
        vRX7oppzAkTTmkOcHhyzPqxZRJ+8wYYfed3koBEyRQhyoD3x9WMDjjWRxFc+KODh/niRgaaBk1tI1
        Cf1XrtMGLAXm/fZfWs3mDK4oQS33kJH4W6Rt8qguNtdc3ps2nXTUJFAzr11jJZKneLlvI/eo83oYU
        9NkgO7+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n43Rs-00C9GI-4i; Sun, 02 Jan 2022 16:11:08 +0000
Date:   Sun, 2 Jan 2022 16:11:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 33/48] mm: Add unmap_mapping_folio()
Message-ID: <YdHOnKIdzKrNAHk0@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-34-willy@infradead.org>
 <YcQnDZ/Yr5L2otnX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQnDZ/Yr5L2otnX@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 08:36:45AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 08, 2021 at 04:22:41AM +0000, Matthew Wilcox (Oracle) wrote:
> > Convert both callers of unmap_mapping_page() to call unmap_mapping_folio()
> > instead.  Also move zap_details from linux/mm.h to mm/internal.h
> 
> In fact it could even move to mm/memory.c as no one needs it outside of
> that file. __oom_reap_task_mm always passes a NULL zap_details argument
> to unmap_page_range.

Umm ... no?

static inline bool
zap_skip_check_mapping(struct zap_details *details, struct page *page)
{
        if (!details || !page)
                return false;

        return details->zap_mapping &&
            (details->zap_mapping != page_rmapping(page));
}

