Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5B2CC907
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 22:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgLBVmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 16:42:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:34686 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgLBVmc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:42:32 -0500
IronPort-SDR: P1DQ244u4J5trZ2CW1gWIDMpwu4O1HBAn+N/OgCPi3vRqVc9Zp5fevr+bP5nMWMiGDsEhL9GkM
 hsR+2JuDLSKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152345748"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="152345748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 13:41:51 -0800
IronPort-SDR: 2QJCNzsEBVMH4I8OWQapC/iFvj9Eh/m/3JafMG46DhRJMRcKQvjYVRsFPbIOB3nqwkskPxyKne
 XmGQxAZyPAnQ==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550223437"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 13:41:50 -0800
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
Subject: [PATCH] common/rc: Fix _check_s_dax()
Date:   Wed,  2 Dec 2020 13:41:45 -0800
Message-Id: <20201202214145.1563433-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There is a conflict with the user visible statx bits 'mount root' and
'dax'.  The kernel is changing the dax bit to correct this conflict.[1]

Adjust _check_s_dax() to use the new bit.  Because DAX tests do not run
on root mounts, STATX_ATTR_MOUNT_ROOT should always be 0, therefore we
can allow either bit to indicate DAX and cover any kernel which may be
running.

[1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---

I went ahead and used Christoph's suggestion regarding using both bits.

---
 common/rc | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index b5a504e0dcb4..322e682e5239 100644
--- a/common/rc
+++ b/common/rc
@@ -3221,11 +3221,24 @@ _check_s_dax()
 	local exp_s_dax=$2
 
 	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
-	if [ $exp_s_dax -eq 0 ]; then
-		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
-	else
-		(( attributes & 0x2000 )) || echo "$target doesn't have expected S_DAX flag"
-	fi
+
+	# The attribute bit value, STATX_ATTR_DAX (0x2000), conflicted with
+	# STATX_ATTR_MOUNT_ROOT.  Therefore, STATX_ATTR_DAX was changed to
+	# 0x00200000.
+	#
+	# Because DAX tests do not run on root mounts, STATX_ATTR_MOUNT_ROOT
+	# should always be 0, therefore we can allow either bit to indicate DAX
+	# and cover any kernel which may be running.
+
+        if [ $(( attributes & 0x00200000 )) -ne 0 ] || [ $(( attributes & 0x2000 )) -ne 0 ]; then
+                if [ $exp_s_dax -eq 0 ]; then
+                        echo "$target has unexpected S_DAX flag"
+                fi
+        else
+                if [ $exp_s_dax -ne 0 ]; then
+                        echo "$target doesn't have expected S_DAX flag"
+                fi
+        fi
 }
 
 _check_xflag()
-- 
2.28.0.rc0.12.gb6a658bd00c9

