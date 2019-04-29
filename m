Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3BDB59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfD2EyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:28440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfD2EyE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566238"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:03 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 00/10] RDMA/FS DAX "LONGTERM" lease proposal
Date:   Sun, 28 Apr 2019 21:53:49 -0700
Message-Id: <20190429045359.8923-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order to support RDMA to File system pages[*] without On Demand Paging a
number of things need to be done.

1) GUP "longterm"[1] users need to inform the other subsystems that they have
   taken a pin on a page which may remain pinned for a very "long time".[1]

2) Any page which is "controlled" by a file system such needs to have special
   handling.  The details of the handling depends on if the page is page cache
   backed or not.

   2a) A page cache backed page which has been pinned by GUP Longterm can use a
   bounce buffer to allow the file system to write back snap shots of the page.
   This is handled by the FS recognizing the GUP longterm pin and making a copy
   of the page to be written back.
   	NOTE: this patch set does not address this path.

   2b) A FS "controlled" page which is not page cache backed is either easier
   to deal with or harder depending on the operation the filesystem is trying
   to do.
   
	2ba) [Hard case] If the FS operation _is_ a truncate or hole punch the
	FS can no longer use the pages in question until the pin has been
	removed.  This patch set presents a solution to this by introducing
	some reasonable restrictions on user space applications.

	2bb) [Easy case] If the FS operation is _not_ a truncate or hole punch
	then there is nothing which need be done.  Data is Read or Written
	directly to the page.  This is an easy case which would currently work
	if not for GUP longterm pins being disabled.  Therefore this patch set
	need not change access to the file data but does allow for GUP pins
	after 2ba above is dealt with.


The architecture of this series is to introduce a F_LONGTERM file lease
mechanism which applications use in one of 2 ways.

1) Applications which may require hole punch or truncation operations on files
   they intend to mmmapping and pinning for long periods.  Can take a
   F_LONGTERM lease on the file.  When a file system operation needs truncate
   access to this file the lease is broken and the application gets a SIGIO.
   Upon catching SIGIO the application can un-pin (note munmap is not required)
   the memory associated with that file.  At that point the truncating user can
   proceed.  Re-pinning the memory is entirely left up to the application.  In
   some cases a new mmap will be required (as with a truncation) or a SIGBUS
   would be experienced anyway.

   Failure to respond to a SIGIO lease break within the system configured
   lease-break-time will result in a SIGBUS.

   WIP: SIGBUS could be caught and ignored...  what danger does this present...
   should this be SIGKILL  or should we wait another lease-break-time and then
   send SIGKILL?

2) Applications which don't require hold punch or truncate operations can use
   pinning without taking a F_LONGTERM lease.  However, applications such as
   this are expected to have considered the access to the files they are
   mmaping and are expected to be controlling them in a way that other users on
   a system can't truncate a file and cause a DOS on the application.  These
   applications will be sent a SIGBUS if someone attempts to truncate or hole
   punch a file.

	ALTERNATIVE WIP patch in series: If the F_LONGTERM lease is not taken
	fail the GUP.

The patches compile and have been tested to a first degree.

NOTES:
Can we deal with the lease/pin at the VFS layer?  or for all FSs?
LONGTERM seems like a bad name.  Suggestions?

[1] The definition of long time is debatable but it has been established
that RDMAs use of pages, minutes or hours after the pin is the extreme case
which makes this problem most severe.

[*] Not all file system pages are Page Cache pages.  FS DAX bypasses the page
cache.


Ira Weiny (10):
  fs/locks: Add trace_leases_conflict
  fs/locks: Introduce FL_LONGTERM file lease
  mm/gup: Pass flags down to __gup_device_huge* calls
  WIP: mm/gup: Ensure F_LONGTERM lease is held on GUP pages
  mm/gup: Take FL_LONGTERM lease if not set by user
  fs/locks: Add longterm lease traces
  fs/dax: Create function dax_mapping_is_dax()
  mm/gup: fs: Send SIGBUS on truncate of active file
  fs/locks: Add tracepoint for SIGBUS on LONGTERM expiration
  mm/gup: Remove FOLL_LONGTERM DAX exclusion

 fs/dax.c                         |  23 ++-
 fs/ext4/inode.c                  |   4 +
 fs/locks.c                       | 301 +++++++++++++++++++++++++++++--
 fs/xfs/xfs_file.c                |   4 +
 include/linux/dax.h              |   6 +
 include/linux/fs.h               |  18 ++
 include/linux/mm.h               |   2 +
 include/trace/events/filelock.h  |  74 +++++++-
 include/uapi/asm-generic/fcntl.h |   2 +
 mm/gup.c                         | 107 ++++-------
 mm/huge_memory.c                 |  18 ++
 11 files changed, 468 insertions(+), 91 deletions(-)

-- 
2.20.1

