Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B837DDF49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJTP7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 11:59:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:54570 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfJTP7y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:59:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 08:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="398438094"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 08:59:53 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] Enable per-file/directory DAX operations
Date:   Sun, 20 Oct 2019 08:59:30 -0700
Message-Id: <20191020155935.12297-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
consumption due to their inability to detect whether the kernel will
instantiate page cache for a file, and cases where a global dax enable via a
mount option is too coarse.

The following patch series enables selecting the use of DAX on individual files
and/or directories on xfs, and lays some groundwork to do so in ext4.  In this
scheme the dax mount option can be omitted to allow the per-file property to
take effect.

The insight at LSF/MM was to separate the per-mount or per-file "physical"
capability switch from an "effective" attribute for the file.

At LSF/MM we discussed the difficulties of switching the mode of a file with
active mappings / page cache. Rather than solve those races the decision was to
just limit mode flips to 0-length files.

Finally, the physical DAX flag inheritance is maintained from previous work on 
XFS but should be added for other file systems for consistence.


[1] https://lwn.net/Articles/787973/
[2] https://lwn.net/Articles/787233/

To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Ira Weiny (5):
  fs/stat: Define DAX statx attribute
  fs/xfs: Isolate the physical DAX flag from effective
  fs/xfs: Separate functionality of xfs_inode_supports_dax()
  fs/xfs: Clean up DAX support check
  fs/xfs: Allow toggle of physical DAX flag

 fs/stat.c                 |  3 +++
 fs/xfs/xfs_ioctl.c        | 32 ++++++++++++++------------------
 fs/xfs/xfs_iops.c         | 36 ++++++++++++++++++++++++++++++------
 fs/xfs/xfs_iops.h         |  2 ++
 include/uapi/linux/stat.h |  1 +
 5 files changed, 50 insertions(+), 24 deletions(-)

-- 
2.20.1

