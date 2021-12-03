Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590BD46760A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380291AbhLCLVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47670 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhLCLVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77E9EB826A4
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE722C53FAD;
        Fri,  3 Dec 2021 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530256;
        bh=EKrvyg/w9g6YhI0wzQQbYVWP5s6lm2VZrgQ3lEH8bf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmbObHponmqGHbqWW0789zaRj++rPY9P96r/7Uwg2jU9vASPtTE9k1xLrv8BGFi1s
         1teB2KjJNbq5/b418KNq+DQZm9sMcUttGzvB0VjcfpNyhnQi4AzfYKHm7NFIGTphOP
         D9efQYFPasTPsGqpHXdfpqgMJ1v9qDS6uRZTBigtr4aqQUVCpgkRPSx8yYdJVpQ64Q
         Ricy4igZC/nVpBwQcx5fTvzBkFR6el/xkbcHWG0uKiK9JkzJY/n3EezJte2LkBlSm6
         cnrBR7RXKk+meMbsFZMG5HfKx90I03Uz5wrbTfAt0K8XC5VxLEfUDD3ERZAFsneOZx
         RS0BAr8SykmEw==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 03/10] fs: tweak fsuidgid_has_mapping()
Date:   Fri,  3 Dec 2021 12:17:00 +0100
Message-Id: <20211203111707.3901969-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; h=from:subject; bh=AVNkP4rC0RwIdt+LD8I/FXs7PujWGyQfqmpeHlB/lXQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DNty8opO/rPHr46cVuz7qKUpUbPVO+Jy8tet1xRYCsb njeluKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiar8YGSZ7suc8LlAsb3k+f3f4hI Cpi3h6w1dkFf/sXiBxSrXw+nKGvyLKfszFgTlMGg5LuRatles1Fl5+Z2ezxzLzWbuVdh94xAYA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If the caller's fs{g,u}id aren't mapped in the mount's idmapping we can
return early and skip the check whether the mapped fs{g,u}id also have a
mapping in the filesystem's idmapping. If the fs{g,u}id aren't mapped in
the mount's idmapping they consequently can't be mapped in the
filesystem's idmapping. So there's no point in checking that.

Link: https://lore.kernel.org/r/20211123114227.3124056-4-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-4-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 include/linux/fs.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b3bcb2129699..db5ee15e36b1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1695,10 +1695,18 @@ static inline void inode_fsgid_set(struct inode *inode,
 static inline bool fsuidgid_has_mapping(struct super_block *sb,
 					struct user_namespace *mnt_userns)
 {
-	struct user_namespace *s_user_ns = sb->s_user_ns;
+	struct user_namespace *fs_userns = sb->s_user_ns;
+	kuid_t kuid;
+	kgid_t kgid;
 
-	return kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) &&
-	       kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns));
+	kuid = mapped_fsuid(mnt_userns);
+	if (!uid_valid(kuid))
+		return false;
+	kgid = mapped_fsgid(mnt_userns);
+	if (!gid_valid(kgid))
+		return false;
+	return kuid_has_mapping(fs_userns, kuid) &&
+	       kgid_has_mapping(fs_userns, kgid);
 }
 
 extern struct timespec64 current_time(struct inode *inode);
-- 
2.30.2

