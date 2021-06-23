Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D1B3B20AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFWSx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFWSx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:53:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742CC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0VM9Vb+7yiaC15aeJZQ2as92Y4o/n6/N9D+u37acwiI=; b=WKiIxpahdonWx5gHcD591g6LWb
        aEaX8JYEyadZvmGWLgrvWWYHWRYospGy3SB7iMvsbOBAnnzky/KZtg6dTTwnMGysmaDQK1cZdvfjw
        5iyfDgAkpEEAVVN3EWYq2NfUoyw36Tf/UhIzMepBHcSenGQL2w06qiP5ojT2wGXtWUWm2JLODFl8X
        0Dd3llPxEzSZsUt11FwgHavl+fXYuBf5IwdOPfXnOq/8qT6plm7iiF7rDLcu2Wa9ZQckRPfpJhWfi
        pp11UDuz09y9sCnYBiEsYBsiXWXJ91djHfYl6f3mMJtBIFjeuqiBhUNg+blLHQ3SyQfoMqiX+e5Kv
        NPbBtUpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw7y2-00FlUu-IH
        for linux-fsdevel@vger.kernel.org; Wed, 23 Jun 2021 18:51:27 +0000
Date:   Wed, 23 Jun 2021 19:51:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: page split failures in truncate_inode_pages_range
Message-ID: <YNOCpu3ooDo39Z4F@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we have large pages in the page cache, we can end up in
truncate_inode_pages_range() with an 'lstart' that is in the middle of
a tail page.  My approach has generally been to split the large page,
and that works except when split_huge_page() fails, which it can do at
random due to a racing access having the page refcount elevated.

I've been simulating split_huge_page() failures, and found a problem
I don't know how to solve.  truncate_inode_pages_range() is called
by COLLAPSE_RANGE in order to evict the part of the page cache after
the start of the range being collapsed (any part of the page cache
remaining would now have data for the wrong part of the file in it).
xfs_flush_unmap_range() (and I presume the other filesystems which
support COLLAPSE_RANGE) calls filemap_write_and_wait_range() first,
so we can just drop the partial large page if split doesn't succeed.

But truncate_inode_pages_range() is also called by, for example,
truncate().  In that case, nobody calls filemap_write_and_wait_range(),
so we can't discard the page because it might still be dirty.
Is that an acceptable way to choose behaviour -- if the split fails,
discard the page if it's clean and keep it if it's dirty?  I'll
put a great big comment on it, because it's not entirely obvious.
