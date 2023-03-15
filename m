Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBD6BB9D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjCOQhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCOQhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A26733BA
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mo6NWBR6hkfydtMnZeO+F5U5GhN+vbQRFCzRyccP/1I=;
        b=Ax5X/Dcy2Q7ZssjDd/P6clUV3srPYXL7uvQnCgNua452c2w9Xq3D0I9tK3Ku1wNyCeXW6j
        EmKnNWT73beFYNTXzO+uDzeN5LJRpf/ZoPDTD5MKwo03uOa9g+G+l0VUofDn1cNUucfCyS
        3BBwKQ2M/Ifp2nShRrsxCtag+Ey5Gfw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-WMsh2JaSO0acjNRTd_X4qA-1; Wed, 15 Mar 2023 12:36:11 -0400
X-MC-Unique: WMsh2JaSO0acjNRTd_X4qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9123C2807D8F;
        Wed, 15 Mar 2023 16:36:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEEBB4042AC2;
        Wed, 15 Mar 2023 16:36:05 +0000 (UTC)
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
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-unionfs@vger.kernel.org
Subject: [PATCH v19 05/15] coda: Implement splice-read
Date:   Wed, 15 Mar 2023 16:35:39 +0000
Message-Id: <20230315163549.295454-6-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
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

Implement splice-read for coda by passing the request down a layer rather
than going through generic_file_splice_read() which is going to be changed
to assume that ->read_folio() is present on buffered files.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: coda@cs.cmu.edu
cc: codalist@coda.cs.cmu.edu
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #17)
     - Use vfs_splice_read() helper rather than open-coding checks.

 fs/coda/file.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 3f3c81e6b1ab..12b26bd13564 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/splice.h>
 
 #include <linux/coda.h>
 #include "coda_psdev.h"
@@ -94,6 +95,32 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t
+coda_file_splice_read(struct file *coda_file, loff_t *ppos,
+		      struct pipe_inode_info *pipe,
+		      size_t len, unsigned int flags)
+{
+	struct inode *coda_inode = file_inode(coda_file);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
+	struct file *in = cfi->cfi_container;
+	loff_t ki_pos = *ppos;
+	ssize_t ret;
+
+	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+				  &cfi->cfi_access_intent,
+				  len, ki_pos, CODA_ACCESS_TYPE_READ);
+	if (ret)
+		goto finish_read;
+
+	ret = vfs_splice_read(in, ppos, pipe, len, flags);
+
+finish_read:
+	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
+			    &cfi->cfi_access_intent,
+			    len, ki_pos, CODA_ACCESS_TYPE_READ_FINISH);
+	return ret;
+}
+
 static void
 coda_vm_open(struct vm_area_struct *vma)
 {
@@ -302,5 +329,5 @@ const struct file_operations coda_file_operations = {
 	.open		= coda_open,
 	.release	= coda_release,
 	.fsync		= coda_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= coda_file_splice_read,
 };

