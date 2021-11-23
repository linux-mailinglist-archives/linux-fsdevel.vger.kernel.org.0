Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3045AA18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhKWRcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 12:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233491AbhKWRcc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:32:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F54460551;
        Tue, 23 Nov 2021 17:29:22 +0000 (UTC)
Date:   Tue, 23 Nov 2021 17:29:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/iomap: Fix write path page prefaulting
Message-ID: <YZ0k7ivc6slfSB7F@arm.com>
References: <20211123151812.361624-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151812.361624-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:18:12PM +0100, Andreas Gruenbacher wrote:
> When part of the user buffer passed to generic_perform_write() or
> iomap_file_buffered_write() cannot be faulted in for reading, the entire
> write currently fails.
> 
> The correct behavior would be to write all the data that can be written,
> up to the point of failure.  Since commit a6294593e8a1 ("iov_iter: Turn
> iov_iter_fault_in_readable into fault_in_iov_iter_readable"), we have
> enough information to implement that, so change the code to do that.
> 
> We already take into account that pages faulted in may no longer be
> resident by the time they are accessed, so the code will also behave
> correctly when part of the buffer isn't faulted in in the first place.
> 
> This leads to an intentional user-visible change when the buffer passed
> to write calls contains unmapped or poisoned pages.
> 
> (This change obsoletes commit 554c577cee95 ("gfs2: Prevent endless loops
> in gfs2_file_buffered_write").)
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

This would be more consistent as in my tests on a vanilla kernel ext4
and btrfs fail with EFAULT while gfs2 copies as much as it can before
hitting the fault.

-- 
Catalin
