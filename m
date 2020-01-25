Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3FB1492F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 03:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgAYCLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 21:11:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18989 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387680AbgAYCLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 21:11:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2ba3980000>; Fri, 24 Jan 2020 18:10:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jan 2020 18:11:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Jan 2020 18:11:18 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Jan
 2020 02:11:18 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 25 Jan 2020 02:11:17 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e2ba3c40006>; Fri, 24 Jan 2020 18:11:17 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/3] mm/gup: track FOLL_PIN pages (follow on from v12)
Date:   Fri, 24 Jan 2020 18:11:12 -0800
Message-ID: <20200125021115.731629-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579918232; bh=aO+dKw4ULAsMvC2a/2GQFL6ozh5NX13hkCczGIcsG6k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=DDxhaUomnHExWYT8pAt1yawXQXzCK4+dyix9rJsaw29IklaE1thdtA+t+zrxvKAao
         WiC+hNtu/78/C2GUytHgDZQd3P6cMMQoQy5M0U+Fa10/vJaoLn/+0YtQrtiI6ndhya
         hKV9KWr0nT0HXWA1QhzAZ/9DnC5TFk1HO5IMNOkumjxe3vCzU4GF/SNN51+9YY78JB
         0vA+obrXw31pfIAeEaQ8Jx2tPE1Yk8SWkUIwlGGG4RHjp7xmFU8AtrIEw7mwXn0zSz
         LTQEaP8HwW4vtgZnD3k4KmyJ2WhK1gymFaN+uugl5Syp5TUK422DDSBlJCDpJGnDjw
         UpDOHdvc5mCqg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Leon Romanovsky:

If you get a chance, I'd love to have this short series (or even just
the first patch; the others are just selftests) run through your test
suite that was previously choking on my earlier v11 patchset. The huge
page pincount limitations are removed, so I'm expecting a perfect test
run this time!

Everyone:

This activates tracking of FOLL_PIN pages. This is in support of fixing
the get_user_pages()+DMA problem described in [1]-[4].

It is based on today's (Jan 24) mmotm. There is a git repo and branch,
for convenience in reviewing:

    git@github.com:johnhubbard/linux.git track_user_pages_v1_mmotm_24Jan202=
0

FOLL_PIN support is (so far) in mmotm and linux-next. However, the
patch to use FOLL_PIN to track pages was *not* submitted, because Leon
saw an RDMA test suite failure that involved (I think) page refcount
overflows when huge pages were used.

This patch definitively solves that kind of overflow problem, by adding
an exact pincount, for compound pages (of order > 1), in the 3rd struct
page of a compound page. If available, that form of pincounting is used,
instead of the GUP_PIN_COUNTING_BIAS approach. Thanks again to Jan Kara
for that idea.

Here's the last reviewed version of the tracking patch (v11):

  https://lore.kernel.org/r/20191216222537.491123-1-jhubbard@nvidia.com

Jan Kara had provided a reviewed-by tag for that, but I've had to remove
it (again) here, due to having changed the patch "a little bit", in
order to add the feature described above.

Other interesting changes:

* dump_page(): added one, or two new things to report for compound
  pages: head refcount (for all compound pages), and map_pincount (for
  compound pages of order > 1).

* Documentation/core-api/pin_user_pages.rst: removed the "TODO" for the
  huge page refcount upper limit problems, and added notes about how it
  works now. Also added a note about the dump_page() enhancements.

* Added some comments in gup.c and mm.h, to explain that there are two
  ways to count pinned pages: exact (for compound pages of order > 1)
  and fuzzy (GUP_PIN_COUNTING_BIAS: for all other pages).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General notes about the tracking patch:

This is a prerequisite to solving the problem of proper interactions
between file-backed pages, and [R]DMA activities, as discussed in [1],
[2], [3], [4] and in a remarkable number of email threads since about
2017. :)

In contrast to earlier approaches, the page tracking can be
incrementally applied to the kernel call sites that, until now, have
been simply calling get_user_pages() ("gup"). In other words, opt-in by
changing from this:

    get_user_pages() (sets FOLL_GET)
    put_page()

to this:
    pin_user_pages() (sets FOLL_PIN)
    unpin_user_page()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Next steps:

* Convert more subsystems from get_user_pages() to pin_user_pages().
* Work with Ira and others to connect this all up with file system
  leases.

[1] Some slow progress on get_user_pages() (Apr 2, 2019): https://lwn.net/A=
rticles/784574/
[2] DMA and get_user_pages() (LPC: Dec 12, 2018): https://lwn.net/Articles/=
774411/
[3] The trouble with get_user_pages() (Apr 30, 2018): https://lwn.net/Artic=
les/753027/
[4] LWN kernel index: get_user_pages() https://lwn.net/Kernel/Index/#Memory=
_management-get_user_pages

John Hubbard (3):
  mm/gup: track FOLL_PIN pages
  mm/gup_benchmark: support pin_user_pages() and related calls
  selftests/vm: run_vmtests: invoke gup_benchmark with basic FOLL_PIN
    coverage

 Documentation/core-api/pin_user_pages.rst  |  48 ++-
 include/linux/mm.h                         | 109 ++++-
 include/linux/mm_types.h                   |   7 +-
 include/linux/mmzone.h                     |   2 +
 include/linux/page_ref.h                   |  10 +
 mm/debug.c                                 |  22 +-
 mm/gup.c                                   | 467 ++++++++++++++++-----
 mm/gup_benchmark.c                         |  70 ++-
 mm/huge_memory.c                           |  29 +-
 mm/hugetlb.c                               |  44 +-
 mm/page_alloc.c                            |   2 +
 mm/rmap.c                                  |   6 +
 mm/vmstat.c                                |   2 +
 tools/testing/selftests/vm/gup_benchmark.c |  15 +-
 tools/testing/selftests/vm/run_vmtests     |  22 +
 15 files changed, 678 insertions(+), 177 deletions(-)

--=20
2.25.0

