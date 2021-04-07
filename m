Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE20356FBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbhDGPER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353289AbhDGPEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:04:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747FC061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xP0skvSevFXPIPz7nwsCa/l4rgTsu7hcso8RBaxkAKM=; b=G65HT/hYsV2PC0JfbVcRjbrAaM
        2qnuynyb98y9h16CjkDW5FUwrfeDMjPqDLerhaFdypS0t4PMtnhgVQ2s1ERiRSRtKxCea4NypMIeN
        0MBTjwAqBYpIKaiMtQjIpApA8+tKbi832ZTZxIXpvrisYvKQq7Dhe2DWlBjjZUDvS3JxpqrrGNWI9
        +CyZ//KmXVI4Og3mlXceAvpIqVbNzSRZTvw6ZRe1EJUxCAaN2VgK0M0anqObGU58cR0yZo+C11pM6
        3s+J6oJiQLDCbP/b2gld+mVCH2qvmgnMR8ZZvQKIKICAKe6dC7rWu+L4jyR1AWHzVmLCDEygq4jHi
        IQh2zCow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lU9hn-00Edoc-Vw; Wed, 07 Apr 2021 15:03:06 +0000
Date:   Wed, 7 Apr 2021 16:02:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daeho Jeong <daehojeong@google.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Why use page_cache_ra_unbounded?
Message-ID: <20210407150255.GE2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


commit 5fdb322ff2c2b4ad519f490dcb7ebb96c5439af7
Author: Daeho Jeong <daehojeong@google.com>
Date:   Thu Dec 3 15:56:15 2020 +0900

    f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE

+       page_cache_ra_unbounded(&ractl, len, 0);

/**
 * page_cache_ra_unbounded - Start unchecked readahead.
 * @ractl: Readahead control.
 * @nr_to_read: The number of pages to read.
 * @lookahead_size: Where to start the next readahead.
 *
 * This function is for filesystems to call when they want to start
 * readahead beyond a file's stated i_size.  This is almost certainly
 * not the function you want to call.  Use page_cache_async_readahead()
 * or page_cache_sync_readahead() instead.
 *
 * Context: File is referenced by caller.  Mutexes may be held by caller.
 * May sleep, but will not reenter filesystem to reclaim memory.
 */

Why?

