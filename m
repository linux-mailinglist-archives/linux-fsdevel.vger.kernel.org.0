Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADC53CDD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiFCRL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiFCRL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:11:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F26D31D;
        Fri,  3 Jun 2022 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654276315; x=1685812315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zo6YQ9IdWIOXgcCc9f+nONd+0knf9UreZRGv23diN2E=;
  b=bSLIaFdiHqTwK+uDeSvVUTbaZTuemn1JccaVUzPY+36hD+vJk4OGYQzH
   Z+rRhkwjKSLQaZf+7LfS74Suzgpluca7/tlJyeK+Wk31LXJ+glGYB+UPs
   0jvaLPl7JHpv0vyQqHTxkZTSXKgjuO+/7X46arq/bLRla1QEJ4a1ELsJS
   mU1pg2fA/AaFbaSsQoQS6cJVfmYzKY1dfWp0lxFrT5BlYN/ayRnVF6wM6
   EzlSz42IcON7qLKuYr86m3HdUnvkBBfyCnoKBbBwH7Xf75gMQXQLwswTj
   bamUMQGjCWff7rFAhYCbrepsjQWkQZPGUlkFlgO6oe7AFC+hlytCDPXpW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="263956486"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="263956486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="824812029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2022 10:11:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7414F8; Fri,  3 Jun 2022 20:11:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] xarray: Replace kernel.h with the necessary inclusions
Date:   Fri,  3 Jun 2022 20:11:53 +0300
Message-Id: <20220603171153.48928-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/xarray.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 72feab5ea8d4..e9fedaa3498a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -12,13 +12,18 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kconfig.h>
-#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/lockdep.h>
+#include <linux/math.h>
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include <asm/bitsperlong.h>
+
 /*
  * The bottom two bits of the entry determine how the XArray interprets
  * the contents:
-- 
2.35.1

