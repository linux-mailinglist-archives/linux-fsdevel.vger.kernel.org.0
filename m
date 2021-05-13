Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB59137FA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhEMOzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhEMOwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 10:52:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50993C061346;
        Thu, 13 May 2021 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1NmysONfH93wRxMzbKIRXMjO3sQy9N1aOQConHhku0=; b=j0U7U0KxCjG8TbXLUokLW8ygK4
        unQ5UMYf+It+N2ARfOjZrJUGd7raTpl84OmLbbydENw/nOS6I/ySHPrIBlTK86QPnCnT94yZL6lSY
        VCTmecp5NB+CiHdvaxcktwj55f2yaubMcP/6DD/23YUZ6z4xyk5FthNt7tHt6Skbas0IcEdD6D9fX
        WoxcuTkvUkO3e+w3qCeEqpHjXGt+X/OLX1t9sHVC9286L4izzDh1/EGdDGLQKESrIVIQ5Swz1T6TZ
        /RdWq8rD4m7LYJ5mwp1sRhlEPvk6v9rPITP6/Ch/Qn1NQ7q8FwC0xZAJhkTzR+lfcNx0H3oEMM+ip
        i/bpWC5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhCfh-009W9H-1T; Thu, 13 May 2021 14:50:52 +0000
Date:   Thu, 13 May 2021 15:50:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/33] Memory folios
Message-ID: <YJ08wac4hCHraFOe@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:02PM +0100, Matthew Wilcox (Oracle) wrote:
> We also waste a lot of instructions ensuring that we're not looking at
> a tail page.  Almost every call to PageFoo() contains one or more hidden
> calls to compound_head().  This also happens for get_page(), put_page()
> and many more functions.  There does not appear to be a way to tell gcc
> that it can cache the result of compound_head(), nor is there a way to
> tell it that compound_head() is idempotent.

I instrumented _compound_head() on a test VM:

+++ b/include/linux/page-flags.h
@@ -179,10 +179,13 @@ enum pageflags {

 #ifndef __GENERATING_BOUNDS_H

+extern atomic_t chcc;
+
 static inline unsigned long _compound_head(const struct page *page)
 {
        unsigned long head = READ_ONCE(page->compound_head);

+       atomic_inc(&chcc);
        if (unlikely(head & 1))
                return head - 1;
        return (unsigned long)page;

which means it catches both calls to compound_head() and page_folio().
Between patch 8/96 in folio_v9 and patch 96/96, the number of calls in
an idle VM went down from almost 7k/s to just over 5k/s; about 25%.
