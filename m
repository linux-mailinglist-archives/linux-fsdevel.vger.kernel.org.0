Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAD3CED34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351532AbhGSRsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382448AbhGSRjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E49C061225;
        Mon, 19 Jul 2021 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vowro5yGBW6raP/4H44k+wX5zWXpKRbu3Z3IwekcF6g=; b=Sy4gd7MoBwkmEBCRAxHi9v1KP6
        nvLic8PgYzDJ4Z27YBnQkBmwvvhPtTUId/BMzWNdVIgRU6I6gL4O8jgU5Zf3MyDsgB9D5y0nnssZl
        v1dVeYo89omfazgNgK6UOwun1kNqA6UroQ+fI17P4h6IHKiT53zAJBKr63xXYt0sF6BKtjFj86atV
        QD5JjDme6HRzaPwmscQxvt+19wGByDRHd8T5r4UXSOX0kzJaxVJaYQCEI4dfVtN4Vgl7dwP+FcDSS
        yOqYhy8yHbW/67wqKHx2ttJlv799QuAz9/7cd9s49rw/L8UfJAnWGywBDZ4fq1DVZwxGmYoQru1X5
        bg/7OtfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Xle-007Hqh-Bc; Mon, 19 Jul 2021 18:13:49 +0000
Date:   Mon, 19 Jul 2021 19:13:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] writeback, cgroup: do not reparent dax inodes
Message-ID: <YPXAxo6YzR8Mx/Bm@casper.infradead.org>
References: <20210719171350.3876830-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719171350.3876830-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:13:50AM -0700, Roman Gushchin wrote:
> The inode switching code is not suited for dax inodes. An attempt
> to switch a dax inode to a parent writeback structure (as a part
> of a writeback cleanup procedure) results in a panic like this:
[...]
> The crash happens on an attempt to iterate over attached pagecache
> pages and check the dirty flag: a dax inode's xarray contains pfn's
> instead of generic struct page pointers.

I wondered why this happens for DAX and not for other kinds of non-page
entries in the inodes.  The answer is that it's a tagged iteration, and
shadow/swap entries are never tagged; only DAX entries get tagged.

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

