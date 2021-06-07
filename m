Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869CB39DF49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFGOyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFGOya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 819DE21A68;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhH8fZvd6Tom4nBiYNHBFCVmcJF6aY93XCBQD2IK7mE=;
        b=sTYyrBrhmcoYH4Pc6qGpefCJy5Sux5PJVReKTeUz6gUVd74lV8PShJvlmgXRUYi7K78zGY
        d4J3ry2lEKY4SEj8ooKRSfsxNwMcXt1Hj4nLWK6IcMLWMM+R6InO8T8IFySZfCpG7xy0Kk
        TEFjqGOekbxuEn9tycM3YhzJbNJncoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhH8fZvd6Tom4nBiYNHBFCVmcJF6aY93XCBQD2IK7mE=;
        b=DwFAqfCR7Wr+2ACyXhre2GSoLv5DOgFn+ENsakIV7+3dRNt9fpuZ6AfKNeT4x7NlOGqZpl
        fOCS0M97+XnF36Bg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B8DC1A3B98;
        Mon,  7 Jun 2021 14:52:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 91DF31F2CB3; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/14] mm: Add functions to lock invalidate_lock for two mappings
Date:   Mon,  7 Jun 2021 16:52:14 +0200
Message-Id: <20210607145236.31852-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; h=from:subject; bh=feuIxLKoHMpqfTsHSNzx+Llrxfh/M4pQHEj3mln4fkU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgvjKf4qNEt/Jyz8s3OnJ3hXcO5MHT6Xe5BiU0vi7v Yg+bSvWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYL4ynwAKCRCcnaoHP2RA2chHB/ wKYys4WnIBaTn+iTmcDwD76cwJNj9fNUmSIB5g6n0gtAP4/BnjWvcBbmQla0RGUYJvtO/9VQX1/DPE RdysgXZVUQqMFjHYjWjBwkkpPWcvdHvIW+9KXp0iJzLJkqUV8p8ZfByoP2JTRzDN82Rte87GtnN2Sp L0xIljcsn5jrH8Ww2o3Twm5GXBaCRdS8AVgRk1xEBgsw9Tm6VEqipm87uxNWlHgaU4THjuXQviA32K qTmxhDoIUFvd+7DyJIQyVFx8U2bwkAdQVm20zTZnZAZepHKSgapRODGbx6Yqk1g6ob+l9hmvzMz/zA Y3rmXXMf7ydvJe7qAvc8CkddqajivD
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some operations such as reflinking blocks among files will need to lock
invalidate_lock for two mappings. Add helper functions to do that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h |  6 ++++++
 mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d8afbc9661d7..ddc11bafc183 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -849,6 +849,12 @@ static inline void filemap_invalidate_unlock_shared(
 void lock_two_nondirectories(struct inode *, struct inode*);
 void unlock_two_nondirectories(struct inode *, struct inode*);
 
+void filemap_invalidate_lock_two(struct address_space *mapping1,
+				 struct address_space *mapping2);
+void filemap_invalidate_unlock_two(struct address_space *mapping1,
+				   struct address_space *mapping2);
+
+
 /*
  * NOTE: in a 32bit arch with a preemptable kernel and
  * an UP compile the i_size_read/write must be atomic
diff --git a/mm/filemap.c b/mm/filemap.c
index c8e7e451d81e..b8e9bccecd9f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1009,6 +1009,44 @@ struct page *__page_cache_alloc(gfp_t gfp)
 EXPORT_SYMBOL(__page_cache_alloc);
 #endif
 
+/*
+ * filemap_invalidate_lock_two - lock invalidate_lock for two mappings
+ *
+ * Lock exclusively invalidate_lock of any passed mapping that is not NULL.
+ *
+ * @mapping1: the first mapping to lock
+ * @mapping2: the second mapping to lock
+ */
+void filemap_invalidate_lock_two(struct address_space *mapping1,
+				 struct address_space *mapping2)
+{
+	if (mapping1 > mapping2)
+		swap(mapping1, mapping2);
+	if (mapping1)
+		down_write(&mapping1->invalidate_lock);
+	if (mapping2 && mapping1 != mapping2)
+		down_write_nested(&mapping2->invalidate_lock, 1);
+}
+EXPORT_SYMBOL(filemap_invalidate_lock_two);
+
+/*
+ * filemap_invalidate_unlock_two - unlock invalidate_lock for two mappings
+ *
+ * Unlock exclusive invalidate_lock of any passed mapping that is not NULL.
+ *
+ * @mapping1: the first mapping to unlock
+ * @mapping2: the second mapping to unlock
+ */
+void filemap_invalidate_unlock_two(struct address_space *mapping1,
+				   struct address_space *mapping2)
+{
+	if (mapping1)
+		up_write(&mapping1->invalidate_lock);
+	if (mapping2 && mapping1 != mapping2)
+		up_write(&mapping2->invalidate_lock);
+}
+EXPORT_SYMBOL(filemap_invalidate_unlock_two);
+
 /*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of
-- 
2.26.2

