Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0017090DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjESHp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjESHpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5192126
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyQng7zN0KcMKuuU4UJQFoNAdqIUtbeSzOIbMt9WEc4=;
        b=a2d6JkgF0Pj+9vX0vDxYRFLU7T2uMJqdWVXQgBxApSMok3vGHQ6nKHflciYrcw+HvavLpU
        0HUB1+lK55Jv+bo7uU8jwdO3TbUSL8RDsmQTsoroYPIhS9z1BBqExlpkw9hsMWQpijiJPT
        NUP/y5AVjxmfbQaoQxc1o75a5Iu5uKA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-9SkW8NWEPuqdpOcKe74MkQ-1; Fri, 19 May 2023 03:42:16 -0400
X-MC-Unique: 9SkW8NWEPuqdpOcKe74MkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAF9738035B0;
        Fri, 19 May 2023 07:42:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E84F4492B0A;
        Fri, 19 May 2023 07:42:12 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH v20 22/32] zonefs: Provide a splice-read stub
Date:   Fri, 19 May 2023 08:40:37 +0100
Message-Id: <20230519074047.1739879-23-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read stub for zonefs.  This does some checks before
proceeding.  For buffered I/O, it locks the inode across the call to
filemap_splice_read() and does a size check in case of truncation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Darrick J. Wong <djwong@kernel.org>
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/zonefs/file.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f..a8d7bae4910d 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -752,6 +752,47 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t zonefs_file_splice_read(struct file *in, loff_t *ppos,
+				       struct pipe_inode_info *pipe,
+				       size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct zonefs_zone *z = zonefs_inode_zone(inode);
+	loff_t isize;
+	ssize_t ret = 0;
+
+	/* Offline zones cannot be read */
+	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
+		return -EPERM;
+
+	if (*ppos >= z->z_capacity)
+		return 0;
+
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+
+	inode_lock_shared(inode);
+
+	/* Limit read operations to written data */
+	mutex_lock(&zi->i_truncate_mutex);
+	isize = i_size_read(inode);
+	if (*ppos >= isize)
+		len = 0;
+	else
+		len = min_t(loff_t, len, isize - *ppos);
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	if (len > 0) {
+		ret = filemap_splice_read(in, ppos, pipe, len, flags);
+		if (ret == -EIO)
+			zonefs_io_error(inode, false);
+	}
+
+	inode_unlock_shared(inode);
+	return ret;
+}
+
 /*
  * Write open accounting is done only for sequential files.
  */
@@ -896,7 +937,7 @@ const struct file_operations zonefs_file_operations = {
 	.llseek		= zonefs_file_llseek,
 	.read_iter	= zonefs_file_read_iter,
 	.write_iter	= zonefs_file_write_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= zonefs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
 };

