Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D89214C4F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 04:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgA2DYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 22:24:21 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17851 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgA2DYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:24:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e30fad50000>; Tue, 28 Jan 2020 19:24:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 19:24:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jan 2020 19:24:19 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 03:24:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 Jan 2020 03:24:18 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e30fae20002>; Tue, 28 Jan 2020 19:24:18 -0800
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
Subject: [PATCH v2 0/8] mm/gup: track FOLL_PIN pages (follow on from v12)
Date:   Tue, 28 Jan 2020 19:24:09 -0800
Message-ID: <20200129032417.3085670-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580268245; bh=zjpidrbPx+PnIV1FHICPMevFB5OE+vWeCvLn8+7o1K4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=XgY/4gkVkiE/YZoy2YUFWzjj4W3RoNmf2KvYwEvMkgO3mmk4lLK/6LVYx4mfjqV6x
         i9MDI7rsSuZvW7zSjM1hKwps9eGF5VUPiTkNRJtq8tmQRuGpVIXYQU5I1UGkE4R6m7
         +4TCANVRSedMu5FV0H+Pn00L/jIscnxTqOIeVKYh+ClTvklwEmy03URYNPEpDXT+sh
         qslEuDLo6WB0q429eF3vyy4bxLqZrXfgUSxzcjyaFlZF/G1NA42MchE/tT1HY1dk4e
         aPKrlB+JbQ9A4LXZc0Sann3wIS2O+rwYyt+6h1sDJnqpsfEcGRgK5IKzN6W1XR1ww5
         aHT/aEhm14mIg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OK, as requested, I've split the tracking patch into 6 smaller patches,
and it should be *much* easier to understand and review now.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v1:

* Split the tracking patch into 6 smaller patches

* Rebased onto today's linux-next/akpm (there weren't any conflicts).

* Fixed an "unsigned int" vs. "int" problem in gup_benchmark, reported
  by Nathan Chancellor. (I don't see it in my local builds, probably
  because they use gcc, but an LLVM test found the mismatch.)

* Fixed a huge page pincount problem (add/subtract vs.
  increment/decrement), spotted by Jan Kara.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is a reasonable case to be made for merging two of the patches
(patches 4 and 5), given that patch 4 provides tracking that has upper
limits on the number of pins that can be done with huge pages. Let me
know if anyone wants those merged, but unless there is some weird chance
of someone grabbing patch 4 and not patch 5, I don't really see the
need. Meanwhile, it's easier to review in this form.

Also, patch 3 has been revived. Earlier reviewers asked for it to be
merged into the tracking patch (one cannot please everyone, heh), but
now it's back out on it's own.

This activates tracking of FOLL_PIN pages. This is in support of fixing
the get_user_pages()+DMA problem described in [1]-[4].

It is based on today's (Jan 28) linux-next (branch: akpm),
commit 280e9cb00b41 ("drivers/media/platform/sti/delta/delta-ipc.c: fix
read buffer overflow")

There is a git repo and branch, for convenience in reviewing:

    git@github.com:johnhubbard/linux.git
            track_user_pages_v2_linux-next_akpm_28Jan2020

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

[1] Some slow progress on get_user_pages() (Apr 2, 2019):
    https://lwn.net/Articles/784574/

[2] DMA and get_user_pages() (LPC: Dec 12, 2018):
    https://lwn.net/Articles/774411/

[3] The trouble with get_user_pages() (Apr 30, 2018):
    https://lwn.net/Articles/753027/

[4] LWN kernel index: get_user_pages()
    https://lwn.net/Kernel/Index/#Memory_management-get_user_pages


John Hubbard (8):
  mm: dump_page: print head page's refcount, for compound pages
  mm/gup: split get_user_pages_remote() into two routines
  mm/gup: pass a flags arg to __gup_device_* functions
  mm/gup: track FOLL_PIN pages
  mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages
  mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting
  mm/gup_benchmark: support pin_user_pages() and related calls
  selftests/vm: run_vmtests: invoke gup_benchmark with basic FOLL_PIN
    coverage

 Documentation/core-api/pin_user_pages.rst  |  47 +--
 include/linux/mm.h                         | 109 ++++-
 include/linux/mm_types.h                   |   7 +-
 include/linux/mmzone.h                     |   2 +
 include/linux/page_ref.h                   |  10 +
 mm/debug.c                                 |  22 +-
 mm/gup.c                                   | 460 ++++++++++++++++-----
 mm/gup_benchmark.c                         |  71 +++-
 mm/huge_memory.c                           |  29 +-
 mm/hugetlb.c                               |  44 +-
 mm/page_alloc.c                            |   2 +
 mm/rmap.c                                  |   6 +
 mm/vmstat.c                                |   2 +
 tools/testing/selftests/vm/gup_benchmark.c |  15 +-
 tools/testing/selftests/vm/run_vmtests     |  22 +
 15 files changed, 681 insertions(+), 167 deletions(-)

--=20
2.25.0

