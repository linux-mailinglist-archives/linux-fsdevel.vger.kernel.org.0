Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD0937A899
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhEKOMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhEKOMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 10:12:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A9C061574;
        Tue, 11 May 2021 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ns8g+nbJuyOh7gET8cGtylgrkk3eWd9nQ8qX/kCPn/g=; b=OwhXZQ5On+tzASMhUb2984kocS
        1Frf3mPfcEpNd55eNxRrmNjwPhGF7elCZstOL2y+a1YvHvfNj/1c3cM1PL27yCVgV3zQmpuHYAGrd
        XAGS1wSxtU8NW+O3rQfhSHkWK5SHoJqfzodt4BuARecYiQWd3pVF1EYXknqsoE/0DXASJ7Oatycb7
        nJXL1d1eYjPmh/ebfV+LVQZKScTgfbI+IthIciBMJ50mpO4XFxUvuQ54zVrcZpZyTJwZHtKkVOneY
        mnmE5GZCh3Xw6WC+7iVDwTXiY9UprnqEnfDP0ufc6Bfu0o4UYUst1u1xunaIwpbWuph0RQkXUAjLl
        xIuqA6Dw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgT6C-007LRP-4h; Tue, 11 May 2021 14:11:04 +0000
Date:   Tue, 11 May 2021 15:11:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] [RFC] Trigger retry from fault vm operation
Message-ID: <YJqQdKmBHz6oEqD1@casper.infradead.org>
References: <20210511140113.1225981-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511140113.1225981-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 04:01:13PM +0200, Andreas Gruenbacher wrote:
> we have a locking problem in gfs2 that I don't have a proper solution for, so
> I'm looking for suggestions.
> 
> What's happening is that a page fault triggers during a read or write
> operation, while we're holding a glock (the cluster-wide gfs2 inode
> lock), and the page fault requires another glock.  We can recognize and
> handle the case when both glocks are the same, but when the page fault requires
> another glock, there is a chance that taking that other glock would deadlock.

So we're looking at something like one file on a gfs2 filesystem being
mmaped() and then doing read() or write() to another gfs2 file with the
mmaped address being the passed to read()/write()?

Have you looked at iov_iter_fault_in_readable() as a solution to
your locking order?  That way, you bring the mmaped page in first
(see generic_perform_write()).

> When we realize that we may not be able to take the other glock in gfs2_fault,
> we need to communicate that to the read or write operation, which will then
> drop and re-acquire the "outer" glock and retry.  However, there doesn't seem
> to be a good way to do that; we can only indicate that a page fault should fail
> by returning VM_FAULT_SIGBUS or similar; that will then be mapped to -EFAULT.
> We'd need something like VM_FAULT_RESTART that can be mapped to -EBUSY so that
> we can tell the retry case apart from genuine -EFAULT errors.

We do have VM_FAULT_RETRY ... does that retry at the wrong level?

