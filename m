Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8460029D636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgJ1WMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730657AbgJ1WLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wnJ9W4Bo0oZ5TE1Tz8PfoRg6BvwnPupqXrG0RZliJsg=;
        b=PB89EvDMod0DxZPmvaHKAKYJoioryQ3m3Vkb+6QIKe6FnLo48LJE+LUf5feMF0wwuABL3m
        AjIe7z4ixZQ2Yu9Huahn1a/8ZnyKx2eK0pM+6wU7r0wyTZKPmN+GSoZ3+maN5W4fFqEAer
        jeU/fGlYByBU3/ANPsZGUBm8CaQChSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-bydYqqyyPIy8UI761yy8Fw-1; Wed, 28 Oct 2020 10:09:52 -0400
X-MC-Unique: bydYqqyyPIy8UI761yy8Fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE0810866A0;
        Wed, 28 Oct 2020 14:09:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEB5C5C1D7;
        Wed, 28 Oct 2020 14:09:48 +0000 (UTC)
Subject: [PATCH 00/11] AFS fixes [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nick Piggin <npiggin@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        kernel test robot <lkp@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 14:09:48 +0000
Message-ID: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of fixes for AFS:

 (1) Fix copy_file_range() to an afs file now returning EINVAL if the
     splice_write file op isn't supplied.

 (2) Fix a deref-before-check in afs_unuse_cell().

 (3) Fix a use-after-free in afs_xattr_get_acl().

 (4) Fix afs to not try to clear PG_writeback when laundering a page.

 (5) Fix afs to take a ref on a page that it sets PG_private on and to drop
     that ref when clearing PG_private.

 (6) Fix a page leak if write_begin() fails.

 (7) Fix afs_write_begin() to not alter the dirty region info stored in
     page->private, but rather do this in afs_write_end() instead when we
     know what we actually changed.

 (8) Fix afs_invalidatepage() to alter the dirty region info on a page when
     partial page invalidation occurs so that we don't inadvertantly
     include a span of zeros that will get written back if a page gets
     laundered due to a remote 3rd-party induced invalidation.

     We mustn't, however, reduce the dirty region if the page has been seen
     to be mapped (ie. we got called through the page_mkwrite vector) as
     the page might still be mapped and we might lose data if the file is
     extended again.

 (9) Fix the dirty region info to have a lower resolution if the size of
     the page is too large for this to be encoded (e.g. powerpc32 with 64K
     pages).

     Note that this might not be the ideal way to handle this, since it may
     allow some leakage of undirtied zero bytes to the server's copy in the
     case of a 3rd-party conflict.

To aid (8) and (9), two additional patches are included:

 (*) Wrap the manipulations of the dirty region info stored in
     page->private into helper functions.

 (*) Alter the encoding of the dirty region so that the region bounds can
     be stored with one fewer bit, making a bit available for the
     indication of mappedness.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David
---
Dan Carpenter (1):
      afs: Fix a use after free in afs_xattr_get_acl()

David Howells (10):
      afs: Fix copy_file_range()
      afs: Fix tracing deref-before-check
      afs: Fix afs_launder_page to not clear PG_writeback
      afs: Fix to take ref on page when PG_private is set
      afs: Fix page leak on afs_write_begin() failure
      afs: Fix where page->private is set during write
      afs: Wrap page->private manipulations in inline functions
      afs: Alter dirty range encoding in page->private
      afs: Fix afs_invalidatepage to adjust the dirty region
      afs: Fix dirty-region encoding on ppc32 with 64K pages


 fs/afs/cell.c              |   3 +-
 fs/afs/dir.c               |   3 ++
 fs/afs/dir_edit.c          |   1 +
 fs/afs/file.c              |  74 +++++++++++++++++++++++----
 fs/afs/internal.h          |  59 ++++++++++++++++++++++
 fs/afs/write.c             | 100 ++++++++++++++++++++-----------------
 fs/afs/xattr.c             |   2 +-
 include/linux/page-flags.h |   1 +
 include/trace/events/afs.h |  20 ++------
 9 files changed, 189 insertions(+), 74 deletions(-)


