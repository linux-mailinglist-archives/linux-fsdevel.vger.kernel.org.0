Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE40921BA2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGJQBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJQBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD43C08C5CE;
        Fri, 10 Jul 2020 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sRWyr6JRHvOQ9KVgvohiV8oPDS3eCjS2RJi+7dgDmCw=; b=FO54VgP8V48D2nAylnRW29xZ5z
        IBjgWi9n1EMwL32Lpj1iBr9VRfrEvLoxJSQzHzfkDn11Aw6ML+hsF8Z9K6P4PkAdnh5t0s7+yI/eW
        Ut3kToS5064jDoJ3J5EFBSNb2u76tSSE+LIy+McLpjz2+LdseDQYE4r3O0Eu1GvzYY2QZuZNHO+ZJ
        AhwNz4q/dh7v8/ABOA3/eNpEPR2bxMA9fKRp2NFZ5JleTTEX6cOT/qWTIe0UsGYhzQzhBcMoghv5Y
        ZpL34lYVrTzF42gr5F4AqSkKJRNyCt/HyB53FdP8y7OjAmXYOmXVjT8mooeNGitYlp4kxKkOGRBGn
        vIVeS98w==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtvSN-0002da-H3; Fri, 10 Jul 2020 16:01:00 +0000
Date:   Fri, 10 Jul 2020 18:00:58 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] clean up kernel read/write helpers
Message-ID: <20200710160058.GA540798@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(note that the new WARN_ONs in combination with syzcaller already found a
missing input validation in 9p.  The fix should be on your way through
the maintainer ASAP)

The following changes since commit dcde237b9b0eb1d19306e6f48c0a4e058907619f:

  Merge tag 'perf-tools-fixes-2020-07-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (2020-07-07 15:38:53 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/misc.git tags/cleanup-kernel_read_write

for you to fetch changes up to 775802c0571fb438cd4f6548a323f9e4cb89f5aa:

  fs: remove __vfs_read (2020-07-08 08:27:57 +0200)

----------------------------------------------------------------
cleanup in-kernel read and write operations

Reshuffle the (__)kernel_read and (__)kernel_write helpers, and ensure
all users of in-kernel file I/O use them if they don't use iov_iter
based methods already.

----------------------------------------------------------------
Christoph Hellwig (11):
      cachefiles: switch to kernel_write
      autofs: switch to kernel_write
      bpfilter: switch to kernel_write
      fs: unexport __kernel_write
      fs: check FMODE_WRITE in __kernel_write
      fs: implement kernel_write using __kernel_write
      fs: remove __vfs_write
      fs: add a __kernel_read helper
      integrity/ima: switch to using __kernel_read
      fs: implement kernel_read using __kernel_read
      fs: remove __vfs_read

 fs/autofs/waitq.c            |   2 +-
 fs/cachefiles/rdwr.c         |   2 +-
 fs/read_write.c              | 131 +++++++++++++++++++++++++------------------
 include/linux/fs.h           |   2 +-
 net/bpfilter/bpfilter_kern.c |   2 +-
 security/integrity/iint.c    |  14 +----
 6 files changed, 80 insertions(+), 73 deletions(-)

