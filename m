Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6265F2565D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgH2IJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 04:09:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6665 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgH2II4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:08:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4a0c9b0001>; Sat, 29 Aug 2020 01:06:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 01:08:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 29 Aug 2020 01:08:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 08:08:54 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 29 Aug 2020 08:08:54 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.252]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4a0d160000>; Sat, 29 Aug 2020 01:08:54 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/3] bio: Direct IO: convert to pin_user_pages_fast()
Date:   Sat, 29 Aug 2020 01:08:50 -0700
Message-ID: <20200829080853.20337-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598688411; bh=f29+8U51sN7xD9DRBLq2nw+qMqJ1oMDZgC0r44yrcd4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=YgiZCIp71QQJea8/vSz5N0nHpsgBzIi0hXzOJenMST3nt/uuXRZZSpoJHi9YtQct2
         ezsZJUW49zUEDtxWGF0BDcHrlMkY5InjJbmU5P6x2EZcxc5VsRDP6RGKVWOPKj3w3w
         VvUaB/dBj0biYcaDSOqpPt7WUX6t/U7UEhLGAb+aM+5NsqAjnTRDIV1Q4TlwnruzD5
         gaqWuWNVmyXMTI1YwrQORDgbYm7ROAvIH/Bm9+oVAo27XBmbLOrZrj/bb0bFrLG43I
         RrgkJsGFTbBX9G2561TGfdgMRKGid0ReqWDUxnaTvLzHDOJahcILSK6BkyOfTkVY07
         KNzSt1O5kalQA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Changes since v1:

* Now handles ITER_PIPE, by appying pin_user_page() to ITER_PIPE pages,
on the Direct IO path. Thanks to Al Viro for pointing me in the right
direction there.

* Removed the ceph and BIO_FOLL_PIN patches: the ceph improvements were
handled separately as a different patch entirely, by Jeff Layton. And
the BIO_FOLL_PIN idea turned out to be completely undesirable here.

Original cover letter, updated for v2:

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

    ITER_PIPE:
        for each page:
             pin_user_page();
        break;

    ITER_KVEC:    // already elevated page refcount, leave alone
    ITER_BVEC:    // already elevated page refcount, leave alone
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
vhost/scsi. However, it's not clear which of those really have to be
converted, because some of them probably use ITER_BVEC or ITER_KVEC.

About-to-be-converted sites (in a subsequent patch) are: Direct IO for
filesystems that use the generic read/write functions.

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/


John Hubbard (3):
  mm/gup: introduce pin_user_page()
  iov_iter: introduce iov_iter_pin_user_pages*() routines
  bio: convert get_user_pages_fast() --> pin_user_pages_fast()

 block/bio.c          |  24 +++++-----
 block/blk-map.c      |   6 +--
 fs/direct-io.c       |  28 +++++------
 fs/iomap/direct-io.c |   2 +-
 include/linux/mm.h   |   2 +
 include/linux/uio.h  |   5 ++
 lib/iov_iter.c       | 110 +++++++++++++++++++++++++++++++++++++++----
 mm/gup.c             |  30 ++++++++++++
 8 files changed, 169 insertions(+), 38 deletions(-)

--=20
2.28.0

