Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8081D6DAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgEQVyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgEQVyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:54:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBCC061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4wE6HZyn5NHMAEjBe+RVfS16/Kx8mk+DDuFTZkI9/DM=; b=l+uDP7uTzyCZ2yFxJ0O31i6ERC
        MnJVn9H34+4v8Uh1lHf9bsFDx5FuMIJlu7nce7iZm8sBHC2KbZWJuzxbYkmr48Selad9ZgERuT8iI
        3WYiHsUlqwQ34aWeH45FsSl/TTpWRSkDwvDHexvDV8iUdifFhMnG8GXfmCZdNCXzfgHKawEjo1XHa
        ZEvhBm/B6aDM01wpW1yi4DMmORVSQO3XjaxbB3L9QUkdHhK4dbDxmrPmxQBtdlbLQ/vBZo/uJhO2c
        d/s3QJbHNxtmxJEX6UgIOhfMq3kZGWgtpWDxkNMZjknILdZEbLn8Eg9qzFU3TXZOJ3mMVSfhxuFks
        8rEI2gwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaREV-00068P-4C; Sun, 17 May 2020 21:54:07 +0000
Date:   Sun, 17 May 2020 14:54:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: truncate for block size > page size
Message-ID: <20200517215407.GS16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm currently looking at the truncate path for large pages and I suspect
you have thought about the situation with block size > page size more
than I have.

Let's say you have a fs with 8kB blocks and a CPU with 4kB PAGE_SIZE.
If you have a 32kB file with all its pages in the cache, and the user
truncates it down to 10kB, should we leave three pages in the page cache
or four?

Three pages means (if the last page of the file is dirty) we'd need to
add in either a freshly allocated zero page or the generic zero page to
the bio when writing back the last page.

Four pages mean we'll need to teach the truncate code to use the larger
of page size and block size when deciding the boundary to truncate the
page cache to, and zero the last page(s) of the file if needed.

Depending on your answer, I may have some follow-up questions about how
we handle reading a 10kB file with an 8kB block size on a 4kB PAGE SIZE
machine (whether we allocate 3 or 4 pages, and what we do about the
extra known-to-be-zero bytes that will come from the device).
