Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421E6B988A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 16:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjCNPIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCNPI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:08:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36211A0F1E;
        Tue, 14 Mar 2023 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678806506; x=1710342506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hamc92EMwwSNQxL+T9p74zThaNZs0lLKS/A1U9M8u4w=;
  b=nEScB8/guV+/LMdl91oBBuKMbGYWeOanCsN9hMg/wDLDDuIhh1uR/YJY
   Yd3S0ENBd311NiGnbNDnrYvQAlPbSOgsVRIaweuBWNnAIRgQW04zX/Xvr
   v9CShbvqFsaGsKZtkG5xp+oJ03B06D2sE+4/iij62OuHZcY8nff68i9Br
   EvY73p9P890++eA7ZhsSRNQauTapU/mm7keG7gnbaeoJD9rhsULZkzvSi
   s2givouoXkuDDMZppt8aeaGjvJZmFfpxzptjcdJFG+bPufIaDmkRhi70Y
   3DnlGdTFypJ8eJzlyzbbmkuQCl463L05IiqjDblcONWqqvgTWLfHUG4WS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321300284"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="321300284"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656377938"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="656377938"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2023 08:08:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0468D209; Tue, 14 Mar 2023 17:09:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fs/namespace: fnic: Switch to use %ptTd
Date:   Tue, 14 Mar 2023 17:09:06 +0200
Message-Id: <20230314150906.52318-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use %ptTd instead of open-coded variant to print contents
of time64_t type in human readable form.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d26ea0d9041f..0e7c69a2009b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2617,15 +2617,12 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
 		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
-		struct tm tm;
 
-		time64_to_tm(sb->s_time_max, 0, &tm);
-
-		pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
+		pr_warn("%s filesystem being %s at %s supports timestamps until %ptTd (0x%llx)\n",
 			sb->s_type->name,
 			is_mounted(mnt) ? "remounted" : "mounted",
-			mntpath,
-			tm.tm_year+1900, (unsigned long long)sb->s_time_max);
+			mntpath, &sb->s_time_max,
+			(unsigned long long)sb->s_time_max);
 
 		free_page((unsigned long)buf);
 		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
-- 
2.39.2

