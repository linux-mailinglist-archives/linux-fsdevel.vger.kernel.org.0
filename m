Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924576307AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 01:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKSAjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 19:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiKSAib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 19:38:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A21181E0;
        Fri, 18 Nov 2022 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668815052; x=1700351052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/aFv9Wut0HiigVqkQ+St300/wGo+tKi9PfSoYzzlmA8=;
  b=NRJbx4oNX9vI6yYm5SQt8W+pHuQ3E3BOFrbRcHzE8evDph2D3qXKHA3k
   dseP38yTuG7m7i3PbltBa0SPsE9GHAxbJBenoCg5VeOhFDjqX4xzimC5N
   ZKop8c8FpTLjXbnzpnePNf9kX9xtwIPunxUC3weJdfNobLlAEeG/HdzCX
   pWY5p8HPBZcFX/9wbD5DEbfBTLgeytr9COfS9q3rEKkyBv0CEkJWuONaP
   WFcrLbEnyQUDWIaxk8RnRy0IAgK+BKUtkSOLaFXVGohLwK0PrdZ2oSdEO
   ZswnYMZv3XKQCkzpQlXRwKUShZPIhVh0ppLx/nhvTYcn98XaR3knxpIr1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="300801540"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="300801540"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 15:44:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="634598112"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="634598112"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 15:44:11 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     jlayton@kernel.org
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] Add process name to locks warning
Date:   Fri, 18 Nov 2022 15:43:57 -0800
Message-Id: <20221118234357.243926-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's fairly useless to complain about using an obsolete feature without
telling the user which process used it. My Fedora desktop randomly drops
this message, but I would really need this patch to figure out what
triggers is.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 607f94a0e789..2e45232dbeb1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2096,7 +2096,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	 * throw a warning to let people know that they don't actually work.
 	 */
 	if (cmd & LOCK_MAND) {
-		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n");
+		pr_warn_once("%s: Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n", current->comm);
 		return 0;
 	}
 
-- 
2.37.3

