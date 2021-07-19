Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139173CEF47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389856AbhGSVhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:37:04 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:50868 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349392AbhGSTiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:38:54 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Zee-0027j9-PG; Mon, 19 Jul 2021 20:14:20 +0000
Date:   Mon, 19 Jul 2021 20:14:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v2 0/6] gfs2: Fix mmap + page fault deadlocks
Message-ID: <YPXdHGAH7FbXnAj6@zeniv-ca.linux.org.uk>
References: <20210718223932.2703330-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:39:26AM +0200, Andreas Gruenbacher wrote:
> Hi Linus et al.,
> 
> here's an update to the gfs2 mmap + page faults fix that implements
> Linus's suggestion of disabling page faults while we're holding the
> inode glock.
> 
> This passes fstests except for test generic/095, which fails due to an
> independent bug in the iov_iter code.  I'm currently trying to get
> initial feedback from Al and Christoph on that.
> 
> Any feedback would be welcome.

What tree is that against?  Because in mainline your #5 sure as hell
won't apply...

There uio.h has
enum iter_type {
        /* iter types */
        ITER_IOVEC,
        ITER_KVEC,
        ITER_BVEC,
        ITER_PIPE,
        ITER_XARRAY,
        ITER_DISCARD,
};

and your series assumes

enum iter_type {
        /* iter types */
        ITER_IOVEC = 4,
        ITER_KVEC = 8,
        ITER_BVEC = 16,
        ITER_PIPE = 32,
        ITER_DISCARD = 64,
};

What had that been tested with?
