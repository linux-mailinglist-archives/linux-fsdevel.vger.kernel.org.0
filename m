Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD43C9FA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbhGONnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhGONn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DBA02282A;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSJNYi2EjK6WpJlFRpe2IuMqHuUJYHQH+NO2vWgyFGg=;
        b=r7uAzkh/LSvTU+XWBd733PveaP53L/sk18I7vRhYd0S3xmB5TuJ7AZ0Fekgj5SXJ0B5SfA
        SJA48ivXLVn5yZKZswQfFOQhR4tLyJ7O5926UjHyDGdIe4/D7UjmMQZLQiEB29PRfktlfw
        PE4sXqT7AQoC5t17VGOWnzH6vWLrqgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSJNYi2EjK6WpJlFRpe2IuMqHuUJYHQH+NO2vWgyFGg=;
        b=cDdhW4+KKzF+Hly8A0dgozw6g2hc8xSeDQqt2K48qawD+fjxhXSZXfVot5JUTMlbo9xzjr
        2oxXXVUmB7i3sNCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3B7ECA3B9A;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0E4B81E0BFC; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
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
Date:   Thu, 15 Jul 2021 15:40:14 +0200
Message-Id: <20210715134032.24868-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; h=from:subject; bh=pxG959YMz3LFOsl9BwK2LiP5YusDSYP7NTB6LUXCXkw=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGBI+WO1nr+VnNVrxSG3uY7dEM6/6t3IXn6V6e1TJxjHcVdwm E8fZyWjMwsDIwSArpsiyOvKi9rV5Rl1bQzVkYAaxMoFMYeDiFICJlNZxMFy6VmzM/LIjtM65/7Wl4b fi+SYx4r+0rZmVOtIFYrhKml46Wr+TFtLf/MHog7Sp3I+jMoqyP+RN1kVacecHm53mbV78fcLPXfaV XaHmrTuP2yjsEopNTFHfvONLh+T0OQ455ef5W786HWLv8vzqlxeeZNJ55rfPt46uTbXMr66H15RPOa a/xVm24emjcI9brZ8TH327/uZhzbWrDtlTitlYvFzkNFgCj118LTfjWs3ymIR/8c/EahwzfzhL/Zr8 V9/i9eKEJ3u7a/SDT6nPabqZnMvBzNN9uTDhRe2hqHM/nLbZr9GLKi99w5N1/u+bvyn/Epot7z6brT 1VX/HkveR/KqlGh09zxH49u3sSAA==
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
index f7f9b87d2cd0..0fad08331cf4 100644
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

