Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3462A742A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF2P4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjF2P4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAA93598
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688054124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOAbgctNJNzSTZB1BB4d4WqHvbP5DttnG4JuN21nRvU=;
        b=ZpiyOHYJXtmItHNZ+mEUOqq+ysyl0ejGuW/bL3O4vJW+k0KQ2m4wH+yNO1jEpjnW07jjHP
        q+kC65wC6y9ZAGcsRx0KcFaOPvnmgP75uIVK2/arFFHt74CHKsyoyOrpANKFDKerwM0EGK
        xyPDBMtHxrWNRUETfY62OU5GlkqBLT4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158--w3bQ03qP3q32efbcBKCww-1; Thu, 29 Jun 2023 11:55:21 -0400
X-MC-Unique: -w3bQ03qP3q32efbcBKCww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9792B1C06ED8;
        Thu, 29 Jun 2023 15:54:45 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 398D84CD0C2;
        Thu, 29 Jun 2023 15:54:44 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 4/4] splice: Record some statistics
Date:   Thu, 29 Jun 2023 16:54:33 +0100
Message-ID: <20230629155433.4170837-5-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a proc file to export some statistics for debugging purposes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Dave Chinner <david@fromorbit.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c            | 28 ++++++++++++++++++++++++++++
 include/linux/splice.h |  3 +++
 mm/filemap.c           |  6 +++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2b1f109a7d4f..831973ea6b3f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -36,10 +36,15 @@
 #include <linux/net.h>
 #include <linux/socket.h>
 #include <linux/sched/signal.h>
+#include <linux/proc_fs.h>
 
 #include "../mm/internal.h"
 #include "internal.h"
 
+atomic_t splice_stat_filemap_copied, splice_stat_filemap_moved;
+static atomic_t splice_stat_directly_copied;
+static atomic_t vmsplice_stat_copied, vmsplice_stat_stole;
+
 /*
  * Splice doesn't support FMODE_NOWAIT. Since pipes may set this flag to
  * indicate they support non-blocking reads or writes, we must clear it
@@ -276,6 +281,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 		remain -= chunk;
 	}
 
+	atomic_add(keep, &splice_stat_directly_copied);
 	kfree(bv);
 	return ret;
 }
@@ -1299,6 +1305,7 @@ static int splice_try_to_steal_page(struct pipe_inode_info *pipe,
 	unmap_mapping_folio(folio);
 	if (remove_mapping(folio->mapping, folio)) {
 		folio_clear_mappedtodisk(folio);
+		atomic_inc(&vmsplice_stat_stole);
 		flags |= PIPE_BUF_FLAG_LRU;
 		goto add_to_pipe;
 	}
@@ -1316,6 +1323,7 @@ static int splice_try_to_steal_page(struct pipe_inode_info *pipe,
 	folio_put(folio);
 	folio = copy;
 	offset = 0;
+	atomic_inc(&vmsplice_stat_copied);
 
 add_to_pipe:
 	page = folio_page(folio, offset / PAGE_SIZE);
@@ -1905,3 +1913,23 @@ SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
 
 	return error;
 }
+
+static int splice_stats_show(struct seq_file *m, void *data)
+{
+	seq_printf(m, "filemap: copied=%u moved=%u\n",
+		   atomic_read(&splice_stat_filemap_copied),
+		   atomic_read(&splice_stat_filemap_moved));
+	seq_printf(m, "direct : copied=%u\n",
+		   atomic_read(&splice_stat_directly_copied));
+	seq_printf(m, "vmsplice: copied=%u stole=%u\n",
+		   atomic_read(&vmsplice_stat_copied),
+		   atomic_read(&vmsplice_stat_stole));
+	return 0;
+}
+
+static int splice_stats_init(void)
+{
+	proc_create_single("fs/splice", S_IFREG | 0444, NULL, splice_stats_show);
+	return 0;
+}
+late_initcall(splice_stats_init);
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 3c5abbd49ff2..4f04dc338010 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -98,4 +98,7 @@ extern int splice_grow_spd(const struct pipe_inode_info *, struct splice_pipe_de
 extern void splice_shrink_spd(struct splice_pipe_desc *);
 
 extern const struct pipe_buf_operations default_pipe_buf_ops;
+
+extern atomic_t splice_stat_filemap_copied, splice_stat_filemap_moved;
+
 #endif
diff --git a/mm/filemap.c b/mm/filemap.c
index dd144b0dab69..38d38cc826fa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2872,7 +2872,8 @@ ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 	struct address_space *mapping;
 	struct folio *copy = NULL;
 	struct page *page;
-	unsigned int flags = 0;
+	unsigned int flags = 0, count = 0;
+	atomic_t *stat = &splice_stat_filemap_copied;
 	ssize_t ret;
 	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
 
@@ -2902,6 +2903,7 @@ ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 	/* If we succeed in removing the mapping, set LRU flag and add it. */
 	if (remove_mapping(mapping, folio)) {
 		folio_unlock(folio);
+		stat = &splice_stat_filemap_moved;
 		flags = PIPE_BUF_FLAG_LRU;
 		goto add_to_pipe;
 	}
@@ -2940,8 +2942,10 @@ ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 		page++;
 		spliced += part;
 		offset = 0;
+		count++;
 	}
 
+	atomic_add(count, stat);
 	if (copy)
 		folio_put(copy);
 	return spliced;

