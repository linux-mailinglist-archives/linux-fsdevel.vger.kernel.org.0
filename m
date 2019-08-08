Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 886E3867DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404294AbfHHRWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 13:22:54 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52462 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404293AbfHHRWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:22:53 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from haswell.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 17934224-1500050 
        for multiple; Thu, 08 Aug 2019 18:22:27 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
Date:   Thu,  8 Aug 2019 18:22:26 +0100
Message-Id: <20190808172226.18306-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The filesystem reconfigure API is undergoing a transition, breaking our
current code. As we only set the default options, we can simply remove
the call to s_op->remount_fs(). In the future, when HW permits, we can
try re-enabling huge page support, albeit as suggested with new per-file
controls.

Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 31 ++++++++-------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 099f3397aada..be94598cb304 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -20,31 +20,18 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 	if (!type)
 		return -ENODEV;
 
-	gemfs = kern_mount(type);
-	if (IS_ERR(gemfs))
-		return PTR_ERR(gemfs);
-
 	/*
-	 * Enable huge-pages for objects that are at least HPAGE_PMD_SIZE, most
-	 * likely 2M. Note that within_size may overallocate huge-pages, if say
-	 * we allocate an object of size 2M + 4K, we may get 2M + 2M, but under
-	 * memory pressure shmem should split any huge-pages which can be
-	 * shrunk.
+	 * By creating our own shmemfs mountpoint, we can pass in
+	 * mount flags that better match our usecase.
+	 *
+	 * One example, although it is probably better with a per-file
+	 * control, is selecting huge page allocations ("huge=within").
+	 * Currently unused due to bandwidth issues (slow reads) on Broadwell+.
 	 */
 
-	if (has_transparent_hugepage()) {
-		struct super_block *sb = gemfs->mnt_sb;
-		/* FIXME: Disabled until we get W/A for read BW issue. */
-		char options[] = "huge=never";
-		int flags = 0;
-		int err;
-
-		err = sb->s_op->remount_fs(sb, &flags, options);
-		if (err) {
-			kern_unmount(gemfs);
-			return err;
-		}
-	}
+	gemfs = kern_mount(type);
+	if (IS_ERR(gemfs))
+		return PTR_ERR(gemfs);
 
 	i915->mm.gemfs = gemfs;
 
-- 
2.23.0.rc1

