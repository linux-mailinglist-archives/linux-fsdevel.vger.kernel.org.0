Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156E54A84EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350715AbiBCNOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55338 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiBCNOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00817617FE
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CE3C340EF;
        Thu,  3 Feb 2022 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894081;
        bh=HBVtq9mPXrIsA+URtlvbHEEm8yANYFgBIPPy0Zbl3qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfcjDE8fRXhTs2M5bksSU4I0Du8FgmVGzq96+PMYEJWVk8Oxrtvdn22fs8phsqHMC
         /r9/WHeRRPQUvXU+xcnMSLuHkD1XY7LZAtgzk4luJ15jNzLQLUtYItRH1UfjaTKMxi
         o1KIB4ZZyz8dD824qTDcxJL51U91jFo/tw8gZNiLZlJ3FCCmDEDxinkFgbAtg7TOuD
         03DGIHVAsRqxjdgHZPHoALpVMIAvYzw8hbIM9abDyAri4RCjOc722ZkTOb8Mz9BGF4
         shGgAMM4hejURsjErH+fdrNYz2XNdzCE4KV5GOiWkskcvL9xItrhAMcKSKkjQEPNuX
         50aVL/MBDewOw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/7] tests: fix idmapped mount_setattr test
Date:   Thu,  3 Feb 2022 14:14:05 +0100
Message-Id: <20220203131411.3093040-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; h=from:subject; bh=HBVtq9mPXrIsA+URtlvbHEEm8yANYFgBIPPy0Zbl3qE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsq4SivTcKfw8u0HpLYkx8Wdc9QS0jvrkqDoJVW09qjM 0/tPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS+4zhr4SInIJQP+PC1Yd2HOOtZ2 Y/+zjDheODS/j2OVxZ5vyfWxn+R6nnrNl81X1OHafav71PWe3VAxt6Tu/h4tuwKlTW2mA2FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test treated zero as a successful run when it really should treat
non-zero as a successful run. A mount's idmapping can't change once it
has been attached to the filesystem.

Fixes: 01eadc8dd96d ("tests: add mount_setattr() selftests")
Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index f31205f04ee0..8c5fea68ae67 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1236,7 +1236,7 @@ static int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long
 }
 
 /**
- * Validate that an attached mount in our mount namespace can be idmapped.
+ * Validate that an attached mount in our mount namespace cannot be idmapped.
  * (The kernel enforces that the mount's mount namespace and the caller's mount
  *  namespace match.)
  */
@@ -1259,7 +1259,7 @@ TEST_F(mount_setattr_idmapped, attached_mount_inside_current_mount_namespace)
 
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	ASSERT_GE(attr.userns_fd, 0);
-	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
 	ASSERT_EQ(close(attr.userns_fd), 0);
 	ASSERT_EQ(close(open_tree_fd), 0);
 }
-- 
2.32.0

