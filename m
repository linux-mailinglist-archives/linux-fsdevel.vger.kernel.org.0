Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC574E8BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 04:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiC1CHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 22:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiC1CHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:07:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086D3584B
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Mar 2022 19:05:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0E0871F42F39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648433119;
        bh=ZuYFeCaQsdCLMnheFQIhRwZM/6Dp8P5T0ofZ9ffnljU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpKlwQbUsbiGz9srskJ/3nqOzIbZXlgHVztihj0ecgMDmeNf62bcnUSwIWus9YmDZ
         To17IlqTy2bhlznE9VMfT0H+wpFrfh8f8116L5F+hLN9T7TSYHYJSOnijb+bh72GaH
         l80SSkUdHf9TB+yQxW8m2dkjwaf1AaE0u4PoXcmMY9JLOszwwCyvEAQ0SYIhka5bwK
         /cMdEdFTgmOSsuVR8XKJEeO+BQN2n8/98cYtP1E/qahVAwXFF7sfJ1v2ngf3tyW5kC
         les9PY7NXk2BA4yGUzqD09dPkbuj2OVc0hbRpXGm9WeTQdmxu+XBsTrUvk87QGHu/O
         +VHbSv40Q1Piw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 3/3] shmem: Expose space and accounting error count
Date:   Sun, 27 Mar 2022 22:04:43 -0400
Message-Id: <20220328020443.820797-4-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328020443.820797-1-krisman@collabora.com>
References: <20220328020443.820797-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Exposing these shmem counters through sysfs is particularly useful for
container provisioning, to allow administrators to differentiate between
insufficiently provisioned fs size vs. running out of memory.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Suggested-by: Khazhy Kumykov <khazhy@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 Documentation/ABI/testing/sysfs-fs-tmpfs | 13 ++++++++++++
 mm/shmem.c                               | 25 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-tmpfs

diff --git a/Documentation/ABI/testing/sysfs-fs-tmpfs b/Documentation/ABI/testing/sysfs-fs-tmpfs
new file mode 100644
index 000000000000..d32b90949710
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-tmpfs
@@ -0,0 +1,13 @@
+What:		/sys/fs/tmpfs/<disk>/acct_errors
+Date:		March 2022
+Contact:	"Gabriel Krisman Bertazi" <krisman@collabora.com>
+Description:
+		Track the number of IO errors caused by lack of memory to
+		perform the allocation of a tmpfs block.
+
+What:		/sys/fs/tmpfs/<disk>/space_errors
+Date:		March 2022
+Contact:	"Gabriel Krisman Bertazi" <krisman@collabora.com>
+Description:
+		Track the number of IO errors caused by lack of space
+		in the filesystem to perform the allocation of a tmpfs block.
diff --git a/mm/shmem.c b/mm/shmem.c
index 665d417ba8a8..50d22449d99e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -214,6 +214,7 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 
 	if (shmem_acct_block(info->flags, pages)) {
 		sbinfo->acct_errors += 1;
+		sysfs_notify(&sbinfo->s_kobj, NULL, "acct_errors");
 		return false;
 	}
 
@@ -228,6 +229,7 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 
 unacct:
 	sbinfo->space_errors += 1;
+	sysfs_notify(&sbinfo->s_kobj, NULL, "space_errors");
 	shmem_unacct_blocks(info->flags, pages);
 	return false;
 }
@@ -3586,10 +3588,33 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 #endif /* CONFIG_TMPFS */
 
 #if defined(CONFIG_TMPFS) && defined(CONFIG_SYSFS)
+static ssize_t acct_errors_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *page)
+{
+	struct shmem_sb_info *sbinfo =
+		container_of(kobj, struct shmem_sb_info, s_kobj);
+
+	return sysfs_emit(page, "%lu\n", sbinfo->acct_errors);
+}
+
+static ssize_t space_errors_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *page)
+{
+	struct shmem_sb_info *sbinfo =
+		container_of(kobj, struct shmem_sb_info, s_kobj);
+
+	return sysfs_emit(page, "%lu\n", sbinfo->space_errors);
+}
+
 #define TMPFS_SB_ATTR_RO(name)	\
 	static struct kobj_attribute tmpfs_sb_attr_##name = __ATTR_RO(name)
 
+TMPFS_SB_ATTR_RO(acct_errors);
+TMPFS_SB_ATTR_RO(space_errors);
+
 static struct attribute *tmpfs_attrs[] = {
+	&tmpfs_sb_attr_acct_errors.attr,
+	&tmpfs_sb_attr_space_errors.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(tmpfs);
-- 
2.35.1

