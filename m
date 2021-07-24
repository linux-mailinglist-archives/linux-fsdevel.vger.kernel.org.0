Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581FE3D4444
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhGXBLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 21:11:46 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52980 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhGXBLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 21:11:45 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m76pi-003LlQ-MZ; Sat, 24 Jul 2021 01:52:06 +0000
Date:   Sat, 24 Jul 2021 01:52:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
Message-ID: <YPtyRgyGqJX4Ya/R@zeniv-ca.linux.org.uk>
References: <20210723205840.299280-1-agruenba@redhat.com>
 <20210723205840.299280-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723205840.299280-2-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 23, 2021 at 10:58:34PM +0200, Andreas Gruenbacher wrote:
> Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> Other than fault_in_pages_writeable(), this function is non-destructive.
> 
> We'll use fault_in_iov_iter in gfs2 once we've determined that the iterator
> passed to .read_iter or .write_iter isn't in memory.

Hmm...  I suspect that this is going to be much heavier for read access
than the existing variant.  Do we ever want it for anything other than
writes?
