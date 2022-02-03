Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4E4A84ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350723AbiBCNOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiBCNOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4EC061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 05:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86E63B83402
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE70C340F0;
        Thu,  3 Feb 2022 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894087;
        bh=PZFEvSeWqtjZgQHKPH3SNY8goi8KJHMMMUNAANt6D/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGrjdSy8DfJaPMYYPh29irTJDyUHPM9ywqbiD7RAIn5PMwJD0sq400vIRkPpi76gs
         Zs5wB0kzBeAqk6iqKc2986GcyTNQJ+lvvGD1REFu2zp8+OxmDtLDek6cF+0K7D0JPt
         FbY95wi4as7a7Cnd8Cd2hcTon729yURGt9xxRfZEPV+X+GdnrTKU+QmC8bitU6ZjeK
         oStlIEp3GAY48ugtq1ul7/PZ1/uYJFZ6vvoJR32s+g1yhRtDKixT+fVOzhNPXAqvy8
         zPa0Rt9k6ckOP1dyE7CFSx6yZqzrMTmi7jXp/fcLAcaaE+Mhvygt+/WNq9HgAg4Hde
         iNg4bZYw4j/Pg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 4/7] fs: add mnt_allow_writers() and simplify mount_setattr_prepare()
Date:   Thu,  3 Feb 2022 14:14:08 +0100
Message-Id: <20220203131411.3093040-5-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; h=from:subject; bh=PZFEvSeWqtjZgQHKPH3SNY8goi8KJHMMMUNAANt6D/s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsqUkiTe8V/ohMi0v6l7U+OlhIoFL82676jX0bPoz6rA TDnpjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkujMyfDH52Xtg04r5bkKs/Dt978 m4sf24tv3XU+t57/799f84S4eRYbMpT9xP1oU9aZsLWNXfXdZOOy0Wa/PGejlP7CxxlS/C3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tiny helper that lets us simplify the control-flow and can be used
in the next patch to avoid adding another condition open-coded into
mount_setattr_prepare(). Instead we can add it into the new helper.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index de6fae84f1a1..7e5535ed155d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3998,6 +3998,22 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	return 0;
 }
 
+/**
+ * mnt_allow_writers() - check whether the attribute change allows writers
+ * @kattr: the new mount attributes
+ * @mnt: the mount to which @kattr will be applied
+ *
+ * Check whether thew new mount attributes in @kattr allow concurrent writers.
+ *
+ * Return: true if writers need to be held, false if not
+ */
+static inline bool mnt_allow_writers(const struct mount_kattr *kattr,
+				     const struct mount *mnt)
+{
+	return !(kattr->attr_set & MNT_READONLY) ||
+	       (mnt->mnt.mnt_flags & MNT_READONLY);
+}
+
 static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 					   struct mount *mnt, int *err)
 {
@@ -4028,12 +4044,12 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 
 		last = m;
 
-		if ((kattr->attr_set & MNT_READONLY) &&
-		    !(m->mnt.mnt_flags & MNT_READONLY)) {
-			*err = mnt_hold_writers(m);
-			if (*err)
-				goto out;
-		}
+		if (mnt_allow_writers(kattr, m))
+			continue;
+
+		*err = mnt_hold_writers(m);
+		if (*err)
+			goto out;
 	} while (kattr->recurse && (m = next_mnt(m, mnt)));
 
 out:
-- 
2.32.0

