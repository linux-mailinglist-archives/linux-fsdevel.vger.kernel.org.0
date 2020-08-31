Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8D25742C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 09:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHaHPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 03:15:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1358 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgHaHOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:14:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ca3380001>; Mon, 31 Aug 2020 00:14:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 00:14:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 00:14:46 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 07:14:45 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 07:14:45 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.61.194]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4ca3640001>; Mon, 31 Aug 2020 00:14:45 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/3] bio: Direct IO: convert to pin_user_pages_fast()
Date:   Mon, 31 Aug 2020 00:14:36 -0700
Message-ID: <20200831071439.1014766-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598858041; bh=lyrZ2gUylyRDxgfVzrsrWPEjnlS8I/rM0/dBNY/ekqg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=AgIKKxMPpvPxMJX1X6WknDKq7jsksqwEJe5FEcBiW0igy4qyYjQ84yGeMTbtq+TWF
         zTn6BBJbfbTKPXo+7YWdA+YA2fCiYofpXzPA9gyg3abtY4Py9wyzm65QkQvH5d0MgM
         J35idY/iyfHlBPCGXm/0LYqqmhTzoehWr/2E9D9cnf4LcDr0rP9ocdqym538+ZwzhN
         OA/mVZs5qZg+OwrNX+rebHjMGMVXa0lrHflwoEV3kbh6gRVMa0DEb7fuowvO2JeBJR
         hxflPqdMFfa4mjGIpQMOdgm2ZwdC6ypG/z9nDW+l1P6WsXJaoNzBUNJGM8kf/6Uh3m
         g7wtUVLD5D+6g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio: convert get_user_pages_fast() --> pin_user_pages_fast()

Change generic block/bio Direct IO routines, to acquire FOLL_PIN user
pages via the recently added routines:

    iov_iter_pin_pages()
    iov_iter_pin_pages_alloc()
    pin_page()

This effectively converts several file systems (ext4, for example) that
use the common Direct IO routines.

Change the corresponding page release calls from put_page() to
unpin_user_page().

Change bio_release_pages() to handle FOLL_PIN pages. In fact, after this
patch, that is the *only* type of pages that bio_release_pages()
handles.

Design notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Quite a few approaches have been considered over the years. This one is
inspired by Christoph Hellwig's July, 2019 observation that there are
only 5 ITER_ types, and we can simplify handling of them for Direct IO
[1]. Accordingly, this patch implements the following pseudocode:

Direct IO behavior:

    ITER_IOVEC:
        pin_user_pages_fast();
        break;

    ITER_PIPE:
        for each page:
             pin_page();
        break;

    ITER_KVEC:    // already elevated page refcount, leave alone
    ITER_BVEC:    // already elevated page refcount, leave alone
    ITER_DISCARD: // discard
        return -EFAULT or -ENVALID;

...which works for callers that already have sorted out which case they
are in. Such as, Direct IO in the block/bio layers.

Note that this does leave ITER_KVEC and ITER_BVEC unconverted, for now.

Page acquisition: The iov_iter_get_pages*() routines above are at just
the right level in the call stack: the callers already know which system
to use, and so it's a small change to just drop in the replacement
routines. And it's a fan-in/fan-out point: block/bio call sites for
Direct IO funnel their page acquisitions through the
iov_iter_get_pages*() routines, and there are many other callers of
those. And we can't convert all of the callers at once--too many
subsystems are involved, and it would be a too large and too risky
patch.

Page release: there are already separate release routines: put_page()
vs. unpin_user_page(), so it's already done there.

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/



John Hubbard (3):
  mm/gup: introduce pin_page()
  iov_iter: introduce iov_iter_pin_pages*() routines
  bio: convert get_user_pages_fast() --> pin_user_pages_fast()

 block/bio.c          |  24 ++++-----
 block/blk-map.c      |   6 +--
 fs/direct-io.c       |  28 +++++------
 fs/iomap/direct-io.c |   2 +-
 include/linux/mm.h   |   2 +
 include/linux/uio.h  |   5 ++
 lib/iov_iter.c       | 113 ++++++++++++++++++++++++++++++++++++++++---
 mm/gup.c             |  33 +++++++++++++
 8 files changed, 175 insertions(+), 38 deletions(-)

--=20
2.28.0

