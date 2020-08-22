Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B75D24E525
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgHVEVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:21:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14458 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHVEVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:21:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f409cbd0000>; Fri, 21 Aug 2020 21:19:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 21:21:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Aug 2020 21:21:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 04:21:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 22 Aug 2020 04:21:05 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.94.162]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f409d310002>; Fri, 21 Aug 2020 21:21:05 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/5] bio: Direct IO: convert to pin_user_pages_fast()
Date:   Fri, 21 Aug 2020 21:20:54 -0700
Message-ID: <20200822042059.1805541-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598069950; bh=iXBAhlDsGHGJ0BL2z0xZCdQ0KPj09q9n3S14YFuk7Lw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=CR22qrcQtjZToR+Y4AXxJBXCfRczkFv9gLGIEHhDFMLUu4lf6rgLvtPhciCvG0fvf
         8JMCctIFdDTWGAzXzUKbKnyYt6PwVt10412J6p/kV+Y0t4d87XeRWNvV7rAJ2JgP31
         d/5x/ygntRNdZv7aMmnGbKeHHcc0OCfwjSwvgZMX+1lVs78tO1hDzy8fykG7Hz3ok1
         mw6vWF1LW8LjO7d+e41OQ4iw21XaLGKwEc023ZXuR+EN1hRFez1kp1TmDXy5s91Yv8
         Yy8oSMjNVP/9FDFofUWl7D5rayjXLwB32kN+Y8cF+l0u4qTOBIqNxYvbqe1Xo9DjGq
         kGQPDLQF/puTQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This converts the Direct IO block/bio layer over to use FOLL_PIN pages
(those acquired via pin_user_pages*()). This effectively converts
several file systems (ext4, for example) that use the common Direct IO
routines. See "Remaining work", below for a bit more detail there.

Quite a few approaches have been considered over the years. This one is
inspired by Christoph Hellwig's July, 2019 observation that there are
only 5 ITER_ types, and we can simplify handling of them for Direct IO
[1]. After working through how bio submission and completion works, I
became convinced that this is the simplest and cleanest approach to
conversion.

Not content to let well enough alone, I then continued on to the
unthinkable: adding a new flag to struct bio, whose "short int" flags
field was full, thuse triggering an expansion of the field from 16, to
32 bits. This allows for a nice assertion in bio_release_pages(), that
the bio page release mechanism matches the page acquisition mechanism.
This is especially welcome for a change that affects a lot of callers
and could really make a mess if there is a bug somewhere.

I'm unable to spot any performance implications, either theoretically or
via (rather light) performance testing, from enlarging bio.bi_flags, but
I suspect that there are maybe still valid reasons for having such a
tiny bio.bi_flags field. I just have no idea what they are. (Hardware
that knows the size of a bio? No, because there would be obvious
build-time assertions, and comments about such a constraint.) Anyway, I
can drop that patch if it seems like too much cost for too little
benefit.

And finally, as long as we're all staring at the iter_iov code, I'm
including a nice easy ceph patch, that removes one more caller of
iter_iov_get_pages().

Design notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This whole approach depends on certain concepts:

1) Each struct bio instance must not mix different types of pages:
FOLL_PIN and non-FOLL_PIN pages. (By FOLL_PIN I'm referring to pages
that were acquired and pinned via pin_user_page*() routines.)
Fortunately, this is already an enforced constraint for bio's, as
evidenced by the existence and use of BIO_NO_PAGE_REF.

2) Christoph Hellwig's July, 2019 observation that there are
only 5 ITER_ types, and we can simplify handling of them for Direct IO
[1]. Accordingly, this series implements the following pseudocode:

Direct IO behavior:

    ITER_IOVEC:
        pin_user_pages_fast();
        break;

    ITER_KVEC:    // already elevated page refcount, leave alone
    ITER_BVEC:    // already elevated page refcount, leave alone
    ITER_PIPE:    // just, no :)
    ITER_DISCARD: // discard
        return -EFAULT or -ENVALID;

...which works for callers that already have sorted out which case they
are in. Such as, Direct IO in the block/bio layers.

Now, this does leave ITER_KVEC and ITER_BVEC unconverted, but on the
other hand, it's not clear that these are actually affected in the real
world, by the get_user_pages()+filesystem interaction problems of [2].
If it turns out to matter, then those can be handled too, but it's just
more refactoring and surgery to do so.

Testing
=3D=3D=3D=3D=3D=3D=3D

Performance: no obvious regressions from running fio (direct=3D1: Direct
IO) on both SSD and NVMe drives.

Functionality: selected non-destructive bare metal xfstests on xfs,
ext4, btrfs, orangefs filesystems, plus LTP tests.

Note that I have only a single x86 64-bit test machine, though.

Remaining work
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Non-converted call sites for iter_iov_get_pages*() at the
moment include: net, crypto, cifs, ceph, vhost, fuse, nfs/direct,
vhost/scsi.

About-to-be-converted sites (in a subsequent patch) are: Direct IO for
filesystems that use the generic read/write functions.

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/


John Hubbard (5):
  iov_iter: introduce iov_iter_pin_user_pages*() routines
  mm/gup: introduce pin_user_page()
  bio: convert get_user_pages_fast() --> pin_user_pages_fast()
  bio: introduce BIO_FOLL_PIN flag
  fs/ceph: use pipe_get_pages_alloc() for pipe

 block/bio.c               | 29 +++++++------
 block/blk-map.c           |  7 +--
 fs/ceph/file.c            |  3 +-
 fs/direct-io.c            | 30 ++++++-------
 fs/iomap/direct-io.c      |  2 +-
 include/linux/blk_types.h |  5 ++-
 include/linux/mm.h        |  2 +
 include/linux/uio.h       |  9 +++-
 lib/iov_iter.c            | 91 +++++++++++++++++++++++++++++++++++++--
 mm/gup.c                  | 30 +++++++++++++
 10 files changed, 169 insertions(+), 39 deletions(-)

--=20
2.28.0

