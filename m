Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1F44DA55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhKKQ25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 11:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233987AbhKKQ25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636647967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8bm581BkhHLAgHXcU5RDiPE2gfVwKDukiIT1uir51Iw=;
        b=Q3yLNQh+bjsGFPlGTBedaJsQB/aX01S8KGRHvxfYMZfAsGQUvepAXTE1bhvmQRSPZC43Vg
        tdkvMsmuQW/2XV7nS6/FqfyJb1NtB3dlt5Kq+nfkPX9Xa1a2/yRVS5NxLued/hWF1xLN88
        J7kOHjt3No1cLHqUy1JIW/pQCv/D0xE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-sDZ7WAxrN6qb7l0ozDVudQ-1; Thu, 11 Nov 2021 11:26:04 -0500
X-MC-Unique: sDZ7WAxrN6qb7l0ozDVudQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34743100C660;
        Thu, 11 Nov 2021 16:26:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BD4A5C1D5;
        Thu, 11 Nov 2021 16:25:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey E Altman <jaltman@auristor.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] netfs, 9p, afs, ceph: Use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1134870.1636647952.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 11 Nov 2021 16:25:52 +0000
Message-ID: <1134871.1636647952@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

[Apologies for the late request, but I needed to wait for folios and 9p to
be pulled into your tree so that I could get rid of the temporary merge I
was using and then I had to wait for my branch to be retested before I
could send this your way - and then Willy changed his mind about how to
handle foliation of page_endio().]

Anyway, could you consider pulling this please?  It converts netfslib, 9p
and afs to use folios.  It also partially converts ceph so that it uses
folios on the boundaries with netfslib.

To help with this, a couple of folio helper functions are added in the
first two patches.  If you don't want to take the netfs/9p/afs/ceph bits,
could you at least consider taking the folio helpers?  Then they would be
available to others.

These patches don't touch fscache and cachefiles as I intend to remove all
the code that deals with pages directly from there.  Only nfs and cifs are
using the old fscache I/O API now.  The new API uses iov_iter instead.

Thanks to Jeff Layton, Dominique Martinet and AuriStor for testing and
retesting the patches.

Thanks,
David

Changes
=3D=3D=3D=3D=3D=3D=3D
ver #5:
 - Got rid of the folio_endio bits again as Willy changed his mind and
   would rather I inlined the code directly instead.

ver #4:
 - Detached and sent the afs symlink split patch separately.
 - Handed the 9p netfslibisation patch off to Dominique Martinet.
 - Added a patch to foliate page_endio().
 - Fixed a bug in afs_redirty_page() whereby it didn't set the next page
   index in the loop and returned too early.
 - Simplified a check in v9fs_vfs_write_folio_locked()[4].
 - Undid a change to afs_symlink_readpage()[4].
 - Used offset_in_folio() in afs_write_end()[4].
 - Rebased on 9p-folio merge upstream[5].

ver #3:
 - Rebased on upstream as folios have been pulled.
 - Imported a patch to convert 9p to netfslib from my
   fscache-remove-old-api branch[3].
 - Foliated netfslib.

ver #2:
 - Reorder the patches to put both non-folio afs patches to the front.
 - Use page_offset() rather than manual calculation[1].
 - Fix folio_inode() to directly access the inode[2].

Link: https://lore.kernel.org/r/YST/0e92OdSH0zjg@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/YST8OcVNy02Rivbm@casper.infradead.org/ [2]
Link: https://lore.kernel.org/r/163551653404.1877519.12363794970541005441.=
stgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/YYKa3bfQZxK5/wDN@casper.infradead.org/ [4]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Df89ce84bc33330607a782e47a8b19406ed109b15 [5]
Link: https://lore.kernel.org/r/2408234.1628687271@warthog.procyon.org.uk/=
 # v0
Link: https://lore.kernel.org/r/162981147473.1901565.1455657509200944265.s=
tgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163005740700.2472992.12365214290752300378.=
stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163584174921.4023316.8927114426959755223.s=
tgit@warthog.procyon.org.uk>/ # v3
Link: https://lore.kernel.org/r/163649323416.309189.4637503793406396694.st=
git@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/163657847613.834781.7923681076643317435.st=
git@warthog.procyon.org.uk/ # v5

---
The following changes since commit f89ce84bc33330607a782e47a8b19406ed109b1=
5:

  Merge tag '9p-for-5.16-rc1' of git://github.com/martinetd/linux (2021-11=
-09 10:30:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/netfs-folio-20211111

for you to fetch changes up to 255ed63638da190e2485d32c0f696cd04d34fbc0:

  afs: Use folios in directory handling (2021-11-10 21:17:09 +0000)

----------------------------------------------------------------
netfs, 9p, afs and ceph (partial) foliation

----------------------------------------------------------------
David Howells (4):
      folio: Add a function to change the private data attached to a folio
      folio: Add a function to get the host inode for a folio
      netfs, 9p, afs, ceph: Use folios
      afs: Use folios in directory handling

 fs/9p/vfs_addr.c           |  83 ++++++-----
 fs/9p/vfs_file.c           |  20 +--
 fs/afs/dir.c               | 229 +++++++++++++-----------------
 fs/afs/dir_edit.c          | 154 ++++++++++----------
 fs/afs/file.c              |  70 +++++----
 fs/afs/internal.h          |  46 +++---
 fs/afs/write.c             | 347 ++++++++++++++++++++++------------------=
-----
 fs/ceph/addr.c             |  80 ++++++-----
 fs/netfs/read_helper.c     | 165 ++++++++++-----------
 include/linux/netfs.h      |  12 +-
 include/linux/pagemap.h    |  33 +++++
 include/trace/events/afs.h |  21 +--
 mm/page-writeback.c        |   2 +-
 13 files changed, 636 insertions(+), 626 deletions(-)

