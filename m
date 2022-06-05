Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1460A53DC43
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiFEOib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbiFEOi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:38:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EAAB842;
        Sun,  5 Jun 2022 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iOxPhk92n3ev2haNNYjCIoSSRP3MVk1T1zZQSDFdgow=; b=PslZ9i4ExgBUnYLYFag7GhUQOX
        LNJQcX2OKQfS+sWRbnBASViUUcCVfdt7jjFPe4K/LGN2x6amTyr+mH1f/2TFb66Gm0MTv/0wiS/6H
        HQE4TdMRJwTuW5N9kNsO4Am0pQLscNbm3HBc1J2cD1hsfteY/tFlBffCg0+vUEcRA019cWgTK+Gng
        rP1Jm9EAYcedt/ZaS8XPquia4xagoS882Ic13GRGgffpb56CTlFnnEozhJ3ZXbb303k3bTKDniqfD
        XJHH6Zm46pVbeeZas0kiGtUX+bAfu1H99TOyoWqwBnBwUKGNk093ReEdOVoVRV3DbG0St2EzxLwNd
        lHUrjmsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxrOU-009mNs-Pl; Sun, 05 Jun 2022 14:38:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] quota: Support using the page cache for quota files
Date:   Sun,  5 Jun 2022 15:38:14 +0100
Message-Id: <20220605143815.2330891-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605143815.2330891-1-willy@infradead.org>
References: <20220605143815.2330891-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quota files are usually cached in the buffer cache of the block device.
These support functions allow a filesystem to cache quota files in their
page cache instead which is more efficient.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/quota/dquot.c         | 68 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |  2 ++
 include/linux/quotaops.h |  1 +
 3 files changed, 71 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index cdb22d6d7488..ef9aeae802c7 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -59,6 +59,7 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -73,6 +74,7 @@
 #include <linux/proc_fs.h>
 #include <linux/security.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/cred.h>
 #include <linux/kmod.h>
 #include <linux/namei.h>
@@ -2161,6 +2163,72 @@ const struct dquot_operations dquot_operations = {
 };
 EXPORT_SYMBOL(dquot_operations);
 
+ssize_t generic_quota_read(struct super_block *sb, int type, char *data,
+			      size_t len, loff_t pos)
+{
+	struct inode *inode = sb_dqopt(sb)->files[type];
+	struct address_space *mapping = inode->i_mapping;
+	size_t toread;
+	pgoff_t index;
+	loff_t i_size = i_size_read(inode);
+
+	if (pos > i_size)
+		return 0;
+	if (pos + len > i_size)
+		len = i_size - pos;
+	toread = len;
+	index = pos / PAGE_SIZE;
+
+	while (toread > 0) {
+		struct folio *folio = read_mapping_folio(mapping, index, NULL);
+		size_t tocopy = min(toread, PAGE_SIZE - offset_in_page(pos));
+		void *src;
+
+		if (folio == ERR_PTR(-ENOMEM)) {
+			memalloc_retry_wait(GFP_NOFS);
+			continue;
+		} else if (IS_ERR(folio))
+			return PTR_ERR(folio);
+
+		src = kmap_local_folio(folio, offset_in_folio(folio, pos));
+		memcpy(data, src, tocopy);
+		kunmap_local(src);
+		folio_put(folio);
+
+		toread -= tocopy;
+		data += tocopy;
+		pos += tocopy;
+		index++;
+	}
+	return len;
+}
+EXPORT_SYMBOL(generic_quota_read);
+
+int generic_quota_sync(struct super_block *sb, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	int i, ret;
+
+	ret = dquot_writeback_dquots(sb, type);
+	if (ret)
+		return ret;
+	if (dqopt->flags & DQUOT_QUOTA_SYS_FILE)
+		return 0;
+
+	for (i = 0; i < MAXQUOTAS; i++) {
+		if (type != -1 && type != i)
+			continue;
+		if (!sb_has_quota_active(sb, i))
+			continue;
+		ret = write_inode_now(dqopt->files[i], true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_quota_sync);
+
 /*
  * Generic helper for ->open on filesystems supporting disk quotas.
  */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..2e798fc4c118 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2449,6 +2449,8 @@ struct super_block *sget(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
 			int flags, void *data);
+ssize_t generic_quota_read(struct super_block *sb, int type, char *data,
+		size_t len, loff_t pos);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index a0f6668924d3..fe12b04948f6 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -105,6 +105,7 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 int dquot_quota_off(struct super_block *sb, int type);
 int dquot_writeback_dquots(struct super_block *sb, int type);
 int dquot_quota_sync(struct super_block *sb, int type);
+int generic_quota_sync(struct super_block *sb, int type);
 int dquot_get_state(struct super_block *sb, struct qc_state *state);
 int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii);
 int dquot_get_dqblk(struct super_block *sb, struct kqid id,
-- 
2.35.1

