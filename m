Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D06B0B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjCHOjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCHOjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58FC54CAB
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678286293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3Ga7BRmh73UHrzRkOWvEl7XP18FVhE2HGszQBLwN/U=;
        b=NuI0YhR73iczvCXR24sYXqwK+1mYf9QX2M5xoiqlvrFfOKFHRFfmtjdymOgelRzDd27I51
        mihT8GoUY49C/nrJZ9ZTKwuyD5l9W1sGehbb6IW8d9/LCDw+Ae33prEkEk/jgccq+Q170Z
        qfvCvh94F2D+trW/R5mrfw0V2WI7sC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-Ie2N4SlAMG22ke7XWWlVVQ-1; Wed, 08 Mar 2023 09:38:09 -0500
X-MC-Unique: Ie2N4SlAMG22ke7XWWlVVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01EBA18E0049;
        Wed,  8 Mar 2023 14:38:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E61140C83B6;
        Wed,  8 Mar 2023 14:38:05 +0000 (UTC)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v16 03/13] overlayfs: Implement splice-read
Date:   Wed,  8 Mar 2023 14:37:44 +0000
Message-Id: <20230308143754.1976726-4-dhowells@redhat.com>
In-Reply-To: <20230308143754.1976726-1-dhowells@redhat.com>
References: <20230308143754.1976726-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement splice-read for overlayfs by passing the request down a layer
rather than going through generic_file_splice_read() which is going to be
changed to assume that ->read_folio() is present on buffered files.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #15)
     - Remove redundant FMODE_CAN_ODIRECT check on real file.
     - Do rw_verify_area() on the real file, not the overlay file.
     - Fix a file leak.

 fs/overlayfs/file.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..a12919e9ccba 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -419,6 +419,37 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
+			       struct pipe_inode_info *pipe, size_t len,
+			       unsigned int flags)
+{
+	const struct cred *old_cred;
+	struct fd real;
+	ssize_t ret;
+
+	ret = ovl_real_fdget(in, &real);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	if (!real.file->f_op->splice_read)
+		goto out_fdput;
+
+	ret = rw_verify_area(READ, real.file, ppos, len);
+	if (unlikely(ret < 0))
+		goto out_fdput;
+
+	old_cred = ovl_override_creds(file_inode(in)->i_sb);
+	ret = real.file->f_op->splice_read(real.file, ppos, pipe, len, flags);
+
+	revert_creds(old_cred);
+	ovl_file_accessed(in);
+out_fdput:
+	fdput(real);
+
+	return ret;
+}
+
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
  * due to lock order inversion between pipe->mutex in iter_file_splice_write()
@@ -695,7 +726,7 @@ const struct file_operations ovl_file_operations = {
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
 	.flush		= ovl_flush,
-	.splice_read    = generic_file_splice_read,
+	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,

