Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACF696B0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBNRPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjBNROv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE259E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVjIujk8d1N0k6RGniY3UP+0o4vFHY30HdwwNIbIhak=;
        b=MzQXq0Hcn9zk7fYzmmMIFmOdoxNVOU5quaHFl8Hwtxwc6VYPO1x0BcjZLzmJALMuDVwpxL
        vFcS1KCerQRXXyi98xpb0mgwDxTadB1lyn2CxlZJ+n9Q/G+dDo9qaNZlcADQ7YRA34IHSJ
        G/axAs/97zMslte+v5xC2VxF9xWBouE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-VwTllVNdOty5IfHcJbDwmw-1; Tue, 14 Feb 2023 12:14:00 -0500
X-MC-Unique: VwTllVNdOty5IfHcJbDwmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BBF285CCE0;
        Tue, 14 Feb 2023 17:13:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0784C40C10FA;
        Tue, 14 Feb 2023 17:13:46 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v14 05/17] overlayfs: Implement splice-read
Date:   Tue, 14 Feb 2023 17:13:18 +0000
Message-Id: <20230214171330.2722188-6-dhowells@redhat.com>
In-Reply-To: <20230214171330.2722188-1-dhowells@redhat.com>
References: <20230214171330.2722188-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
 fs/overlayfs/file.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c9d0c362c7ef..267b61df6fcd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -419,6 +419,40 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
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
+	if (in->f_flags & O_DIRECT &&
+	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
+		goto out_fdput;
+	if (!real.file->f_op->splice_read)
+		goto out_fdput;
+
+	ret = rw_verify_area(READ, in, ppos, len);
+	if (unlikely(ret < 0))
+		return ret;
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
@@ -695,7 +729,7 @@ const struct file_operations ovl_file_operations = {
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
 	.flush		= ovl_flush,
-	.splice_read    = generic_file_splice_read,
+	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,

