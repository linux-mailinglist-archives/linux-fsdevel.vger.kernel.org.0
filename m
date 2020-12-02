Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD032CC912
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 22:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgLBVrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 16:47:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:35055 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgLBVrM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:47:12 -0500
IronPort-SDR: d5tK3cdokoC6yc2tGvy2mpAu6eMaUmzsPGvCwwxn+BY+eInw+2mikHo9PWv8IxtsIYRZm0j/Zh
 jytjM1UMS7HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152346583"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="152346583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 13:46:32 -0800
IronPort-SDR: 63r2hOH28lGBrb5+aNs8JtEfc3rF5jVDNVCmUbmcxKHQ/Cjrr2iCKMsMUYShTiJvbihV7WLpvX
 lZxC9VHeIrSw==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="481714327"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 13:46:31 -0800
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
Subject: [PATCH V2] common/rc: Fix _check_s_dax()
Date:   Wed,  2 Dec 2020 13:46:29 -0800
Message-Id: <20201202214629.1563760-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201202214145.1563433-1-ira.weiny@intel.com>
References: <20201202214145.1563433-1-ira.weiny@intel.com>
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

Changes for V2:
	Fix bad indentation whitespace.

 common/rc | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index b5a504e0dcb4..9418f7bc8dab 100644
--- a/common/rc
+++ b/common/rc
@@ -3221,10 +3221,23 @@ _check_s_dax()
 	local exp_s_dax=$2
 
 	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
-	if [ $exp_s_dax -eq 0 ]; then
-		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
+
+	# The attribute bit value, STATX_ATTR_DAX (0x2000), conflicted with
+	# STATX_ATTR_MOUNT_ROOT.  Therefore, STATX_ATTR_DAX was changed to
+	# 0x00200000.
+	#
+	# Because DAX tests do not run on root mounts, STATX_ATTR_MOUNT_ROOT
+	# should always be 0, therefore we can allow either bit to indicate DAX
+	# and cover any kernel which may be running.
+
+	if [ $(( attributes & 0x00200000 )) -ne 0 ] || [ $(( attributes & 0x2000 )) -ne 0 ]; then
+		if [ $exp_s_dax -eq 0 ]; then
+			echo "$target has unexpected S_DAX flag"
+		fi
 	else
-		(( attributes & 0x2000 )) || echo "$target doesn't have expected S_DAX flag"
+		if [ $exp_s_dax -ne 0 ]; then
+			echo "$target doesn't have expected S_DAX flag"
+		fi
 	fi
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

