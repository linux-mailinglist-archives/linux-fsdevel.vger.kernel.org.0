Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FCD2DE72F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 17:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLRQGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 11:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgLRQGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:06:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00DC0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Dec 2020 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dA8ESgiJfd5h6aSNXxcv5RNyo86P5S/zd3P9wtA4R8c=; b=Phrmyw6mqGXFm/hbAUZxBU9FC6
        52kEJAbXS9QSndaT7D3sJmObN4V6gMToTBIQp7L4XtXJVyKIe49Udazk5hxkOto3BSzPg16HW05VA
        PjI3quq0VHET7q8fvGqaPS02Tr0ecte4FMC/v4HvziWkzn3Lqv3vqiXy9Tjyx2CeP6Vuw2TQQJOos
        J1+4xzZ41EzG2h4cBR9rJixaIZ79Y2kHs8JLkC9Q/bb+/ftY95FWcONQuncEUO9yIM+52Nzyx5igU
        AOqbgCwjsjCa1wjwHCAL983cqEAMwZYT8BT/UoKAruEOAqDgqvGHEoPGYtVWljaem8d5qGko8AmNb
        Ks1KFz/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqIG4-0003Bk-2a
        for linux-fsdevel@vger.kernel.org; Fri, 18 Dec 2020 16:05:32 +0000
Date:   Fri, 18 Dec 2020 16:05:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: set_page_dirty vs truncate
Message-ID: <20201218160531.GL15600@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A number of implementations of ->set_page_dirty check whether the page
has been truncated (ie page->mapping has become NULL since entering
set_page_dirty()).  Several other implementations assume that they can do
page->mapping->host to get to the inode.  So either some implementations
are doing unnecessary checks or others are vulnerable to a NULL pointer
dereference if truncate() races with set_page_dirty().

I'm touching ->set_page_dirty() anyway as part of the page folio
conversion.  I'm thinking about passing in the mapping so there's no
need to look at page->mapping.

The comments on set_page_dirty() and set_page_dirty_lock() suggests
there's no consistency in whether truncation is blocked or not; we're
only guaranteed that the inode itself won't go away.  But maybe the
comments are stale.


There're also some filesystems which always return false from
set_page_dirty() and others which check for PageSwapCache, which surely
can't happen.  I'm also confused by the ones which set PageUptodate.
And several should just use __set_page_dirty_no_writeback().
