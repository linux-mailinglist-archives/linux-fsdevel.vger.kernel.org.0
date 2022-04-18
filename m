Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59980505F6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 23:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiDRVkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiDRVkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:40:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC12ED63
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 14:37:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 50DD11F41A0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650317849;
        bh=GYECkxCByzaOM41HzDyvIHL8brH7A+F886nTQDaIBIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bP+AZTJ2AO1MTsrZvoI7YCLQR55xXNgN/onPzok9ZwDu3pRPGvKiTAVExakDe/H/1
         s9bHl/qImPN12s+ovALL0e5KBxnKMx0sv2ElEMxL1ICOVPicOsYqo7YVLV9hnGWf+e
         Kbr7D1JwzaKr6KTl38sJ75FLDMH0m9D1ZBo4rY0jWwiNo5MHoRDNvaEqVaaUhaW/mg
         mQUUn6Lu6tyCGEn+e6HgEyTASMHNTnu0JfeQgwqtMyybQSK4gPQmHyb3QH3j/8pmaQ
         nGdo5b943LsozlDXjsA+ugy9jf6MZv78fW8V4iQqR27B4rFG1ReyEZdUiI7KnXWGOH
         DnvGr7u2klyyg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     hughd@google.com, akpm@linux-foundation.org, amir73il@gmail.com
Cc:     viro@zeniv.linux.org.uk,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 3/3] shmem: Expose space and accounting error count
Date:   Mon, 18 Apr 2022 17:37:13 -0400
Message-Id: <20220418213713.273050-4-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418213713.273050-1-krisman@collabora.com>
References: <20220418213713.273050-1-krisman@collabora.com>
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
index 8fe4a22e83a6..5c665b955ceb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -214,6 +214,7 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 
 	if (shmem_acct_block(info->flags, pages)) {
 		sbinfo->acct_errors += 1;
+		sysfs_notify(&sbinfo->kobj, NULL, "acct_errors");
 		return false;
 	}
 
@@ -228,6 +229,7 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 
 unacct:
 	sbinfo->space_errors += 1;
+	sysfs_notify(&sbinfo->kobj, NULL, "space_errors");
 	shmem_unacct_blocks(info->flags, pages);
 	return false;
 }
@@ -3584,10 +3586,33 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 }
 
 #if defined(CONFIG_SYSFS)
+static ssize_t acct_errors_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *page)
+{
+	struct shmem_sb_info *sbinfo =
+		container_of(kobj, struct shmem_sb_info, kobj);
+
+	return sysfs_emit(page, "%lu\n", sbinfo->acct_errors);
+}
+
+static ssize_t space_errors_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *page)
+{
+	struct shmem_sb_info *sbinfo =
+		container_of(kobj, struct shmem_sb_info, kobj);
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

