Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B22CC1AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgLBQHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 11:07:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:14731 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgLBQHr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:07:47 -0500
IronPort-SDR: od0KnZA6ZNTELs68WdKP3JbCO9skfAFWPHyR1ehAuhTPFFr1yFcH3QGbzL/eY2foMa3ps1dyN6
 ff4BXQqFzAEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257750453"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="257750453"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:07:06 -0800
IronPort-SDR: HpOfj9wkFA++K4D7uL2XV4b3y9BFx7mHOzD02qU/8agDrgvkuHlD2+psyGfoCB81ggyoGNOzr2
 juU/aRAUlXPg==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="365353177"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:07:04 -0800
From:   ira.weiny@intel.com
To:     fstests@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [RFC PATCH] common/rc: Fix _check_s_dax() for kernel 5.10
Date:   Wed,  2 Dec 2020 08:07:01 -0800
Message-Id: <20201202160701.1458658-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There is a conflict with the user visible statx bits 'mount root' and
'dax'.  The kernel is shifting the dax bit.[1]

Adjust _check_s_dax() to use the new bit.

[1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---

I'm not seeing an easy way to check for kernel version.  It seems like that is
the right thing to do.  So do I need to do that by hand or is that something
xfstests does not worry about?

Ira

---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index b5a504e0dcb4..3d45e233954f 100644
--- a/common/rc
+++ b/common/rc
@@ -3222,9 +3222,9 @@ _check_s_dax()
 
 	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
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

