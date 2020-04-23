Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589FF1B5F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgDWPcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 11:32:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:44822 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbgDWPcS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:32:18 -0400
IronPort-SDR: wGpumx6aAVtdNwY7GVG1VfUmcwdVeLluBx86/AWP6ixeRzZx6WnS/3DmGB1zyRSzR21/Ap5hbe
 SiXOfYolh2HA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 08:32:17 -0700
IronPort-SDR: XrHw8gpSJ9gzIHLjmItp/h+zc1p9bjoGVh+Zkzv0k4Qk/sA7OcL2RW+qIfKI2TD67lisEWx7vp
 ibzO/GNRtNgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="291217883"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2020 08:32:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 70CCE402; Thu, 23 Apr 2020 18:32:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-fsdevel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
Date:   Thu, 23 Apr 2020 18:32:11 +0300
Message-Id: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a specific API to treat raw data as UUID, i.e. import_uuid().
Use it instead of uuid_copy() with explicit casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index dba874a61fc5c3..82af1f2bd8c85b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1266,7 +1266,7 @@ static int zonefs_read_super(struct super_block *sb)
 		goto unmap;
 	}
 
-	uuid_copy(&sbi->s_uuid, (uuid_t *)super->s_uuid);
+	import_uuid(&sbi->s_uuid, super->s_uuid);
 	ret = 0;
 
 unmap:
-- 
2.26.1

