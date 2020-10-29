Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140AC29EDDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 15:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgJ2OHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 10:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgJ2OHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603980456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=38p3DYjN7fRQhwjUaQMRHrg7udOdPR5P6db8OyFZbuI=;
        b=IAPG8IJdarjNxwKcEB1tKQL9dSVnJkWDPihCgaMG+xWVhWfP5jHInuw3hzbWaN3EupBxwY
        dyOlIUuOmBiTT3MASDW9AlWizMioKE865NsyC5Fh2y7GQaA5ypPwLGFqHmjSYyto+B92ml
        CT3hspiXf8HpSDA1rT++Gl0JSunkYMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-HuA97b2DNqWJtVO3luztWQ-1; Thu, 29 Oct 2020 10:07:32 -0400
X-MC-Unique: HuA97b2DNqWJtVO3luztWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EB276415A;
        Thu, 29 Oct 2020 14:07:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9B67610AF;
        Thu, 29 Oct 2020 14:07:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nick Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        kernel test robot <lkp@intel.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1130575.1603980446.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 29 Oct 2020 14:07:26 +0000
Message-ID: <1130576.1603980446@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these afs fixes, please?  They include the following:

 (1) Fix copy_file_range() to an afs file now returning EINVAL if the
     splice_write file op isn't supplied.

 (2) Fix a deref-before-check in afs_unuse_cell().

 (3) Fix a use-after-free in afs_xattr_get_acl().

 (4) Fix afs to not try to clear PG_writeback when laundering a page.

 (5) Fix afs to take a ref on a page that it sets PG_private on and to dro=
p
     that ref when clearing PG_private.  This is done through recently
     added helpers.

 (6) Fix a page leak if write_begin() fails.

 (7) Fix afs_write_begin() to not alter the dirty region info stored in
     page->private, but rather do this in afs_write_end() instead when we
     know what we actually changed.

 (8) Fix afs_invalidatepage() to alter the dirty region info on a page whe=
n
     partial page invalidation occurs so that we don't inadvertantly
     include a span of zeros that will get written back if a page gets
     laundered due to a remote 3rd-party induced invalidation.

     We mustn't, however, reduce the dirty region if the page has been see=
n
     to be mapped (ie. we got called through the page_mkwrite vector) as
     the page might still be mapped and we might lose data if the file is
     extended again.

 (9) Fix the dirty region info to have a lower resolution if the size of
     the page is too large for this to be encoded (e.g. powerpc32 with 64K
     pages).

     Note that this might not be the ideal way to handle this, since it ma=
y
     allow some leakage of undirtied zero bytes to the server's copy in th=
e
     case of a 3rd-party conflict.

To aid (8) and (9), two additional patches are included:

 (*) Wrap the manipulations of the dirty region info stored in
     page->private into helper functions.

 (*) Alter the encoding of the dirty region so that the region bounds can
     be stored with one fewer bit, making a bit available for the
     indication of mappedness.

Thanks,
David
---
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9e=
c:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20201029

for you to fetch changes up to 2d9900f26ad61e63a34f239bc76c80d2f8a6ff41:

  afs: Fix dirty-region encoding on ppc32 with 64K pages (2020-10-29 13:53=
:04 +0000)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
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
 fs/afs/dir.c               |  12 ++----
 fs/afs/dir_edit.c          |   6 +--
 fs/afs/file.c              |  78 ++++++++++++++++++++++++++-------
 fs/afs/internal.h          |  57 ++++++++++++++++++++++++
 fs/afs/write.c             | 105 ++++++++++++++++++++++++----------------=
-----
 fs/afs/xattr.c             |   2 +-
 include/trace/events/afs.h |  20 ++-------
 8 files changed, 188 insertions(+), 95 deletions(-)

