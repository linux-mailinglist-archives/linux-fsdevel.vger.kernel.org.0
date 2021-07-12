Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B883C613F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhGLQ7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhGLQ7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 041921FFD3;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmszcyVRNOfyO141lqkqYDkpw92FHsSdEmKvmGCXqh4=;
        b=br6SCOFvzzW3pse2tlfBcXfiJwYYASdQGNFHn10uHXfn62xKZgpAD7QX02nANqnSiuUOvX
        fn8G4O1ygsjDUHl0obCsuYJEI5APpOMnpDfJU9+la6QDeRO9Gg2JWYPWHP7068mACqWOgb
        j94z/hCi/UmN83myK39qKuF+xK+79eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmszcyVRNOfyO141lqkqYDkpw92FHsSdEmKvmGCXqh4=;
        b=KItbtZFlBxJGcjExKeGtIesWGb0cegzWvtdtM3y5rEbnfAkLk1+qlIK1F3Y68HSy03wePF
        IFpQQiNSwcVyfdAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id DCA44A3B8B;
        Mon, 12 Jul 2021 16:56:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C2A441F2CD2; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/14] mm: Add functions to lock invalidate_lock for two mappings
Date:   Mon, 12 Jul 2021 18:55:55 +0200
Message-Id: <20210712165609.13215-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; h=from:subject; bh=n/id7CdzTitim6/Q4kdGwpm6fQ2I7WpUBKplzIVZqrg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQck5dmKlHI2ci2Ul08y1JbXiN8coVEfYq6hR7g S9CBeRmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0HAAKCRCcnaoHP2RA2cMMCA CBmLq4KWHGN4/73gYb+7lHTa7VRBTjJoZ+Oi50OoiHFqE5iGdPJ6T/3YBw8b1cSr5n4umcQf1wPy9Q ON0qo8Nxoz35wNwkzBnNNoGE7KytVDwMowWJTXaHzYwQ6gU0H4EzBM3E3/v2xCWZqNJfrvTVXf1qdr WT+MaP9r5rmMOKBO/rb7avUZkrQ91g6dItPcmEI72JnsF5JmMmTyIRLsbIR7+Y3+mvYS0+EMLVvUKy 52eXgZU3YjlB1w294ho4lmA9TeZI36AQxyIN74pwEWnHhY3+8vAuABIGttpjnw8gWE504G8hIS3Xbq qLtj/sXf/MlNFF2m7jQf7ohsJzj1Sn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some operations such as reflinking blocks among files will need to lock
invalidate_lock for two mappings. Add helper functions to do that.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h |  6 ++++++
 mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 90a80de37ad4..894ff2451793 100644
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
index 56988c4e655d..fd3f94d36c49 100644
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

