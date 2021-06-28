Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07803B679D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhF1RaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232458AbhF1RaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624901258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n6U6EhoWKZdEp9mqc61FtXMmGLjx92aWNUsLWc0mHMI=;
        b=HaZC2VOSrAD8hdA80is71kamRaAPiMWDI1tooh8VxlMRvpUwtz7Q9OOdDfTbmV7vCzFm7/
        OoVxfosphDggBrPPTiy32eM2/r0QiKVs7mehEWI8IiirY+OkPOM81Qhjja973jwIS5cT44
        WrUUydERil2K+jFN2tVL0O3ZXiaxKbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-2BFKXBZWPfKR6MEImYObqg-1; Mon, 28 Jun 2021 13:27:35 -0400
X-MC-Unique: 2BFKXBZWPfKR6MEImYObqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C13379F92A;
        Mon, 28 Jun 2021 17:27:33 +0000 (UTC)
Received: from max.com (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 157A75D6AD;
        Mon, 28 Jun 2021 17:27:28 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/2] iomap: small block problems
Date:   Mon, 28 Jun 2021 19:27:25 +0200
Message-Id: <20210628172727.1894503-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph and all,

the recent gfs2 switch from buffer heads to iomap for managing the
block-to-page mappings in commit 2164f9b91869 ("gfs2: use iomap for
buffered I/O in ordered and writeback mode") broke filesystems with a
block size smaller than the page size.  This haüüens when iomap_page
objects aren't attached to pages in all the right circumstances, or the
iop->upodate bitmap isn't kept in sync with the PageUptodata flag.
There are three instances of this problem:

(1) In iomap_readpage_actor, an iomap_page is attached to the page even
for inline inodes.  This is unnecessary because inline inodes don't need
iomap_page objects.  That alone wouldn't cause any real issues, but when
iomap_read_inline_data copies the inline data into the page, it sets the
PageUptodate flag without setting iop->uptodate, causing an
inconsistency between the two.  This will trigger a WARN_ON in
iomap_page_release.  The fix should be not to allocate iomap_page
objects when reading from inline inodes (patch 1).

(2) When un-inlining an inode, we must allocate a page with an attached
iomap_page object (iomap_page_create) and initialize the iop->uptodate
bitmap (iomap_set_range_uptodate).  We can't currently do that because
iomap_page_create and iomap_set_range_uptodate are not exported.  That
could be fixed by exporting those functions, or by implementing an
additional helper as in patch 2.  Which of the two would you prefer?

(3) We're not yet using iomap_page_mkwrite, so iomap_page objects don't
get created on .page_mkwrite, either.  Part of the reason is that
iomap_page_mkwrite locks the page and then calls into the filesystem for
uninlining and for allocating backing blocks.  This conflicts with the
gfs2 locking order: on gfs2, transactions must be started before locking
any pages.  We can fix that by calling iomap_page_create from
gfs2_page_mkwrite, or by doing the uninlining and allocations before
calling iomap_page_mkwrite.  I've implemented option 2 for now; see
here:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next.iomap-page-mkwrite

Any thoughts?

Thanks,
Andreas

Andreas Gruenbacher (1):
  iomap: Don't create iomap_page objects for inline files

Bob Peterson (1):
  iomap: Add helper for un-inlining an inline inode

 fs/iomap/buffered-io.c | 28 +++++++++++++++++++++++++++-
 include/linux/iomap.h  |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.26.3

