Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CDF1A7215
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDNEAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:00:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:28534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgDNEAo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:44 -0400
IronPort-SDR: CfP8XdVa/CouJCM9TyOAvBdCUeYY7Qg3UsatnpdJwcrk4/TU8DLPv4PXZVurvX9Vn0gQ61ovch
 upN7dwiL4wpQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:43 -0700
IronPort-SDR: ac5JXNdae/2dlz5ZobRke4va6g04z64miNSjEFZk8tw3JwyRgewl6ftq6a23jBhVJldqOhhxVS
 jhfgUcsf976A==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="253076242"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:43 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH RFC 0/8] Enable ext4 support for per-file/directory DAX operations
Date:   Mon, 13 Apr 2020 21:00:22 -0700
Message-Id: <20200414040030.1802884-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Enable the same per file DAX support to ext4 as was done for xfs.  This series
builds and depends on the V7 series for xfs.[1]

To summarize:

 1. There exists an in-kernel access mode flag S_DAX that is set when
    file accesses go directly to persistent memory, bypassing the page
    cache.  Applications must call statx to discover the current S_DAX
    state (STATX_ATTR_DAX).

 2. There exists an advisory file inode flag FS_XFLAG_DAX that is
    inherited from the parent directory FS_XFLAG_DAX inode flag at file
    creation time.  This advisory flag can be set or cleared at any
    time, but doing so does not immediately affect the S_DAX state.

    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
    and the fs is on pmem then it will enable S_DAX at inode load time;
    if FS_XFLAG_DAX is not set, it will not enable S_DAX.

 3. There exists a dax= mount option.

    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."

    "-o dax=always" means "always set S_DAX (at least on pmem),
                    and ignore FS_XFLAG_DAX."

    "-o dax"        is an alias for "dax=always".

    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.

 4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
    be set or cleared at any time.  The flag state is inherited by any files or
    subdirectories when they are created within that directory.

 5. Programs that require a specific file access mode (DAX or not DAX)
    can do one of the following:

    (a) Create files in directories that the FS_XFLAG_DAX flag set as
        needed; or

    (b) Have the administrator set an override via mount option; or

    (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
        must then cause the kernel to evict the inode from memory.  This
        can be done by:

        i>  Closing the file and re-opening the file and using statx to
            see if the fs has changed the S_DAX flag; and

        ii> If the file still does not have the desired S_DAX access
            mode, either unmount and remount the filesystem, or close
            the file and use drop_caches.

 6. It is expected that users who want to squeeze every last bit of performance
    out of the particular rough and tumble bits of their storage will also be
    exposed to the difficulties of what happens when the operating system can't
    totally virtualize those hardware capabilities.  DAX is such a feature.


[1] https://lore.kernel.org/lkml/20200407182958.568475-1-ira.weiny@intel.com/

To: linux-kernel@vger.kernel.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org


Ira Weiny (8):
  fs/ext4: Narrow scope of DAX check in setflags
  fs/ext4: Disallow verity if inode is DAX
  fs/ext4: Disallow encryption if inode is DAX
  fs/ext4: Introduce DAX inode flag
  fs/ext4: Make DAX mount option a tri-state
  fs/ext4: Update ext4_should_use_dax()
  fs/ext4: Only change S_DAX on inode load
  Documentation/dax: Update DAX enablement for ext4

 Documentation/filesystems/dax.txt | 13 +------
 fs/ext4/ext4.h                    | 16 ++++++---
 fs/ext4/ialloc.c                  |  2 +-
 fs/ext4/inode.c                   | 22 ++++++++----
 fs/ext4/ioctl.c                   | 28 ++++++++++++---
 fs/ext4/super.c                   | 57 +++++++++++++++++++++++--------
 fs/ext4/verity.c                  |  5 ++-
 7 files changed, 99 insertions(+), 44 deletions(-)

-- 
2.25.1

