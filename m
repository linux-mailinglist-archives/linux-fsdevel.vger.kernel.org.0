Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC2711C3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjEZBOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjEZBOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB20125;
        Thu, 25 May 2023 18:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC50164C27;
        Fri, 26 May 2023 01:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A44CC433D2;
        Fri, 26 May 2023 01:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063684;
        bh=UmT2/d7fXiGHMKowRj6AORgZ9sm20QvzDXjo2GVy4Eg=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=pojTnVjVvYsAtQyJp6I1cPLktA8lQtzGwg8j/UFaA4sY4Smo9KAc5V+8ntfg3rTkX
         wFNDxgKVx4MeNbexMtdLY+mdTXjMwtdBOteMS/OELPRDKWQA0OIl/ndDgb7KsF4Zv4
         UYGKcyjh9n0tpK1tvbc1FXabazJsd8HdjOMAyAn/uIG+SabQgkG5QiMAzlUyoXEKmx
         TCU5G1rZNwJl+QSZ4K5A51jMmxrD8iuZkEfBdaGWvmPWFhqGyD8l3/s9TjQKsVsnSk
         PmuLaSflwHdw+4LPl64w3igidESfPNOkAaeUXXtKQBmDqW6I6Tol01Onal0d59F4Lh
         CaJbIjfMCtJ5g==
Date:   Thu, 25 May 2023 18:14:43 -0700
Subject: [PATCH 01/25] xfs: add a libxfs header file for staging new ioctls
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506064993.3734442.7781991054085049287.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a new xfs_fs_staging.h header where we can land experimental
ioctls without committing them to any stable interfaces anywhere.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs_staging.h |   18 ++++++++++++++++++
 fs/xfs/xfs_linux.h             |    1 +
 2 files changed, 19 insertions(+)
 create mode 100644 fs/xfs/libxfs/xfs_fs_staging.h


diff --git a/fs/xfs/libxfs/xfs_fs_staging.h b/fs/xfs/libxfs/xfs_fs_staging.h
new file mode 100644
index 000000000000..bc97193dde9d
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_fs_staging.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/*
+ * Copyright (C) 2020-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_FS_STAGING_H__
+#define __XFS_FS_STAGING_H__
+
+/*
+ * Experimental system calls, ioctls and data structures supporting them.
+ * Nothing in here should be considered part of a stable interface of any kind.
+ *
+ * If you add an ioctl here, please leave a comment in xfs_fs.h marking it
+ * reserved.  If you promote anything out of this file, please leave a comment
+ * explaining where it went.
+ */
+
+#endif /* __XFS_FS_STAGING_H__ */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index b97bc12fa8b2..09f727f712fe 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -72,6 +72,7 @@ typedef __u32			xfs_nlink_t;
 #include <asm/unaligned.h>
 
 #include "xfs_fs.h"
+#include "xfs_fs_staging.h"
 #include "xfs_stats.h"
 #include "xfs_sysctl.h"
 #include "xfs_iops.h"

