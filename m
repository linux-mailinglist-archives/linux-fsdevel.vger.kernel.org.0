Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C471586AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgBKAPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:15:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4084 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBKAPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:15:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41f21c0000>; Mon, 10 Feb 2020 16:15:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 16:15:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 16:15:38 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 00:15:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Feb 2020 00:15:37 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41f2290003>; Mon, 10 Feb 2020 16:15:37 -0800
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
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v6 00/12] mm/gup: track FOLL_PIN pages
Date:   Mon, 10 Feb 2020 16:15:24 -0800
Message-ID: <20200211001536.1027652-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581380124; bh=fE97Xn2xxKSqQsPdBSSUaXOYVTqIn+ii/hEQLxsKvjA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=UemJy1oQM42wM9h1KOJ0YRtqLqLTwjltPvxvNuV6xFEN/alKCH4FVBqq/iZpjYjOU
         DoS3ThqgOHgvxjBLPgpcfd5Gw95juRNdiT9RiMz2V0pRmmNbVGJ+JAYMWkvyUNcdIW
         YwUERwve3lMcN1Q3ab0QWuE5CENvnSHZjqysU2LBc9TpuCBl1H0ZRmbmwFAfnB3bkW
         R3qEPd1D1PJaoava8LuKVeTAbeHNmHkcTFijxnBWMXZ5HRQ/OnLRrEQSv/QIIkEr3Y
         kvdP0ZiZQIRi2l1DADG2AJUt/0SPIufyM0Wswi20jqfd5wrfFI31F/4y1D0STfgkUP
         OGo4RbAE0HUdw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Jan and Kirill: I've tentatively removed your review and ACK,
respectively, for patch 12 (the last dump_page patch), because even
though they are logically the same as what you reviewed in v5, the
base is Matthew's new patch instead of my earlier patch. (Trying to err
on the side of caution with these tags.)

There is a git repo and branch, for convenience in reviewing:

    git@github.com:johnhubbard/linux.git  track_user_pages_v6

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v5:

* Rebased onto Linux 5.6.0-rc1.

* Swapped in Matthew Wilcox's more comprehensive dump_page() patch, and
  moved it later in this series so that it immediately precedes my
  subsequent dump_page() patch, for slightly easier reviews and commit
  log history.

* Fixed "the last bug!" in the /proc/vmstat patch, by moving the
  mod_node_page_state() call in put_compound_page() so that it only
  happens in the FOLL_PIN case.

* Added a couple more ACKs from Kirill.

* Tweaked the "Future steps" in this cover letter to add a little
  detail about what comes next.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v4:

* Added documentation about the huge page behavior of the new
  /proc/vmstat items.

* Added a missing mode_node_page_state() call to put_compound_head().

* Fixed a tracepoint call in page_ref_sub_return().

* Added a trailing underscore to a URL in pin_user_pages.rst, to fix
  a broken generated link.

* Added ACKs and reviewed-by's from Jan Kara and Kirill Shutemov.

* Rebased onto today's linux.git, and

* I am experimenting here with "git format-patch --base=3D<commit>".
  This generated the "base-commit:" tag you'll see at the end of this
  cover letter.  I was inspired to do so after trying out a new
  get-lore-mbox.py tool (it's very nice), mentioned in a recent LWN
  article (https://lwn.net/Articles/811528/ ). That tool relies on the
  base-commit tag for some things.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v3:

* Rebased onto latest linux.git

* Added ACKs and reviewed-by's from Kirill Shutemov and Jan Kara.

* /proc/vmstat:
    * Renamed items, after realizing that I hate the previous names:
         nr_foll_pin_requested --> nr_foll_pin_acquired
         nr_foll_pin_returned  --> nr_foll_pin_released

    * Removed the CONFIG_DEBUG_VM guard, and collapsed away a wrapper
      routine: now just calls mod_node_page_state() directly.

* Tweaked the WARN_ON_ONCE() statements in mm/hugetlb.c to be more
  informative, and added comments above them as well.

* Fixed gup_benchmark: signed int --> unsigned long.

* One or two minor formatting changes.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v2:

* Rebased onto linux.git, because the akpm tree for 5.6 has been merged.

* Split the tracking patch into even more patches, as requested.

* Merged Matthew Wilcox's dump_page() changes into mine, as part of the
  first patch.

* Renamed: page_dma_pinned() --> page_maybe_dma_pinned(), in response to
  Kirill Shutemov's review.

* Moved a WARN to the top of a routine, and fixed a typo in the commit
  description of patch #7, also as suggested by Kirill.

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
(patches 7 and 8), given that patch 7 provides tracking that has upper
limits on the number of pins that can be done with huge pages. Let me
know if anyone wants those merged, but unless there is some weird chance
of someone grabbing patch 7 and not patch 8, I don't really see the
need. Meanwhile, it's easier to review in this form.

Also, patch 3 has been revived. Earlier reviewers asked for it to be
merged into the tracking patch (one cannot please everyone, heh), but
now it's back out on it's own.

This activates tracking of FOLL_PIN pages. This is in support of fixing
the get_user_pages()+DMA problem described in [1]-[4].

FOLL_PIN support is now in the main linux tree. However, the
patch to use FOLL_PIN to track pages was *not* submitted, because Leon
saw an RDMA test suite failure that involved (I think) page refcount
overflows when huge pages were used.

This patch definitively solves that kind of overflow problem, by adding
an exact pincount, for compound pages (of order > 1), in the 3rd struct
page of a compound page. If available, that form of pincounting is used,
instead of the GUP_PIN_COUNTING_BIAS approach. Thanks again to Jan Kara
for that idea.

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
Future steps:

* Convert more subsystems from get_user_pages() to pin_user_pages().
  The first probably needs to be bio/biovecs, because any filesystem
  testing is too difficult without those in place.

* Change VFS and filesystems to respond appropriately when encountering
  dma-pinned pages.

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


John Hubbard (11):
  mm/gup: split get_user_pages_remote() into two routines
  mm/gup: pass a flags arg to __gup_device_* functions
  mm: introduce page_ref_sub_return()
  mm/gup: pass gup flags to two more routines
  mm/gup: require FOLL_GET for get_user_pages_fast()
  mm/gup: track FOLL_PIN pages
  mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages
  mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting
  mm/gup_benchmark: support pin_user_pages() and related calls
  selftests/vm: run_vmtests: invoke gup_benchmark with basic FOLL_PIN
    coverage
  mm: dump_page(): additional diagnostics for huge pinned pages

Matthew Wilcox (Oracle) (1):
  mm: Improve dump_page() for compound pages

 Documentation/core-api/pin_user_pages.rst  |  86 ++--
 include/linux/mm.h                         | 108 ++++-
 include/linux/mm_types.h                   |   7 +-
 include/linux/mmzone.h                     |   2 +
 include/linux/page_ref.h                   |   9 +
 mm/debug.c                                 |  44 +-
 mm/gup.c                                   | 451 ++++++++++++++++-----
 mm/gup_benchmark.c                         |  71 +++-
 mm/huge_memory.c                           |  29 +-
 mm/hugetlb.c                               |  60 ++-
 mm/page_alloc.c                            |   2 +
 mm/rmap.c                                  |   6 +
 mm/vmstat.c                                |   2 +
 tools/testing/selftests/vm/gup_benchmark.c |  15 +-
 tools/testing/selftests/vm/run_vmtests     |  22 +
 15 files changed, 734 insertions(+), 180 deletions(-)


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
--=20
2.25.0

