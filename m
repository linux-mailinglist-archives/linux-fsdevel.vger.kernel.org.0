Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139AE2CE55D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 02:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgLDBqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 20:46:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:48195 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDBqe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:46:34 -0500
IronPort-SDR: Nr1XHOaXJdH9XjWLkBjyTbWdoKTmf0TNK3z55S8/oD3ZbfvC3djXiDHv9E9SgGYn4yaA+5EVG5
 U3TFWdNEZwIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="191550560"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="191550560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:45:53 -0800
IronPort-SDR: pdrev79caLf9OpaDWWhlKyXnHidKdPFDKTc5unyM12YRNkHjmdcuieu7P4FJvRsIqmKWdXwZky
 1D3asWomwszw==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="550753253"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:45:52 -0800
From:   ira.weiny@intel.com
To:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Eric Sandeen <sandeen@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [PATCH V3] common/rc: Fix _check_s_dax()
Date:   Thu,  3 Dec 2020 17:45:50 -0800
Message-Id: <20201204014550.1736306-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201202214629.1563760-1-ira.weiny@intel.com>
References: <20201202214629.1563760-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There is a conflict with the user visible statx bits 'mount root' and
'dax'.  The kernel is changing the dax bit to correct this conflict.[1]

Adjust _check_s_dax() to use the new bit.  Because DAX tests do not run
on root mounts, STATX_ATTR_MOUNT_ROOT should always be 0.  Therefore,
check for the old flag and fail the test if that occurs.

[1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	As suggested by Christoph and Eric:
		Fail the test with a hint as to why the wrong bit may be set.

 common/rc | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index b5a504e0dcb4..5911a6c89a78 100644
--- a/common/rc
+++ b/common/rc
@@ -3221,10 +3221,27 @@ _check_s_dax()
 	local exp_s_dax=$2
 
 	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
+
+	# The original attribute bit value, STATX_ATTR_DAX (0x2000), conflicted
+	# with STATX_ATTR_MOUNT_ROOT.  Therefore, STATX_ATTR_DAX was changed to
+	# 0x00200000.
+	#
+	# Because DAX tests do not run on root mounts, STATX_ATTR_MOUNT_ROOT
+	# should always be 0.  Check for the old flag and fail the test if that
+	# occurs.
+
+	if [ $(( attributes & 0x2000 )) -ne 0 ]; then
+		echo "$target has an unexpected STATX_ATTR_MOUNT_ROOT flag set"
+		echo "which used to be STATX_ATTR_DAX"
+		echo "     This test should not be running on the root inode..."
+		echo "     Does the kernel have the following patch?"
+		echo "     72d1249e2ffd uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT"
+	fi
+
 	if [ $exp_s_dax -eq 0 ]; then
-		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
+		(( attributes & 0x00200000 )) && echo "$target has unexpected S_DAX flag"
 	else
-		(( attributes & 0x2000 )) || echo "$target doesn't have expected S_DAX flag"
+		(( attributes & 0x00200000 )) || echo "$target doesn't have expected S_DAX flag"
 	fi
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

