Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD870A3D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 02:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjETAFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 20:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjETAEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 20:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66011BCF
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg25eeUYeYYdZ/6VEaLafGCYFAO2kBY9m762euh7YIo=;
        b=ittkGr+eqDit6O3SHoFqk8Be6YScrmwzYWPofvkZJOi0N1h8IWsCw/9RiO1ULukICqrtoj
        ll8JeBAz9Kobwc6O/h1VwuGyRPVW+lruAh+GxhHwhpS0t9ctgHs4LzsUNpx9seVb/n+JKo
        yaXuLvzMd5RNc+RZVLl6XmSTBoxam2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-C8zFKqYaNZCOViPhzBCcFA-1; Fri, 19 May 2023 20:02:12 -0400
X-MC-Unique: C8zFKqYaNZCOViPhzBCcFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 368B3800969;
        Sat, 20 May 2023 00:02:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 142E040CFD46;
        Sat, 20 May 2023 00:02:08 +0000 (UTC)
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
Subject: [PATCH v21 25/30] zonefs: Provide a splice-read stub
Date:   Sat, 20 May 2023 01:00:44 +0100
Message-Id: <20230520000049.2226926-26-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
proceeding and locks the inode across the call to filemap_splice_read() and
a size check in case of truncation.  Splicing from direct I/O is handled by
the caller.

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
 fs/zonefs/file.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f..65d4c4fe6364 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -752,6 +752,44 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -896,7 +934,7 @@ const struct file_operations zonefs_file_operations = {
 	.llseek		= zonefs_file_llseek,
 	.read_iter	= zonefs_file_read_iter,
 	.write_iter	= zonefs_file_write_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= zonefs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
 };

