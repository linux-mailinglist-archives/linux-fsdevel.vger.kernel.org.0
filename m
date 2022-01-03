Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC8482D79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 02:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiACBo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 20:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiACBo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:44:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C91C061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 17:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EretoXD4GqybC5UycdzZfPzyW7EOXt79C0iScoBKGbM=; b=veBBFfcnSTaRWAnthTJ9zQbSc/
        cZjpMm09Rc4iPpD1OSom6ht74duGVatK/94dfd3tjzMZ6GbKcqmeBylMGqxljL6i2ezKOSjNb5Ahq
        HMkAcl95vMZAlrYg1NPNZ4CIa3xqbcf5lqzQMnqjitshUyprjJqMrrm2q92fBs7jPpEF6JgkD3o6B
        L8GboGbDItNGUehrbEF1HixCm2rJvtu8tgq0kYGfMz3UWZF+FN4jRP8H8cHVNdXgmGO7Ig0/0nNpV
        ODH4T8h87aAlvowSjQmgDIVWDCXzOQQxA28mFlwrcUhkyKhqW8FoGqg0Gg565W7JlI0v4ZJLvavDt
        H1u5AZjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4COe-00CT9Q-Bf; Mon, 03 Jan 2022 01:44:24 +0000
Date:   Mon, 3 Jan 2022 01:44:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
Message-ID: <YdJU+Dry6L8ZXMwA@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <YdHQnSqA10iwhJ85@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdHQnSqA10iwhJ85@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 04:19:41PM +0000, Matthew Wilcox wrote:
> +++ b/include/linux/uio.h
> @@ -150,7 +150,7 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
>  static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
>  		size_t bytes, struct iov_iter *i)
>  {
> -	return copy_page_to_iter((struct page *)folio, offset, bytes, i);
> +	return copy_page_to_iter(&folio->page, offset, bytes, i);
>  }

Mmmpf.  I should have tested this more thoroughly.  Some files currently
include uio.h without including mm_types.h.  So this on top fixes
the build:

+++ b/include/linux/uio.h
@@ -7,10 +7,10 @@

 #include <linux/kernel.h>
 #include <linux/thread_info.h>
+#include <linux/mm_types.h>
 #include <uapi/linux/uio.h>

 struct page;
-struct folio;
 struct pipe_inode_info;

 struct kvec {

