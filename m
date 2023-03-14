Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69E6BA1E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCNWJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCNWJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF7E570B6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678831710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mo6NWBR6hkfydtMnZeO+F5U5GhN+vbQRFCzRyccP/1I=;
        b=eEBMOerezWZxsM70FMjSbcwZb7ZdCFz0Eg2OeiIIDvWuwUnlQoRudJiYUDvR1pt8DAq7Gw
        sh1t/LkMDua91wffiKv/j+icCSHDfKwCLd73n3BkSAckPeZ1r/CssxZYvOVNUD9wGXxPH3
        fNIpxzg0BeAMkYXnbPdQw8alR+liPCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-ou2O4Fm_MEqdgyGyXimoSw-1; Tue, 14 Mar 2023 18:08:25 -0400
X-MC-Unique: ou2O4Fm_MEqdgyGyXimoSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 538CA85D060;
        Tue, 14 Mar 2023 22:08:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD5082166B26;
        Tue, 14 Mar 2023 22:08:19 +0000 (UTC)
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
Subject: [PATCH v18 05/15] coda: Implement splice-read
Date:   Tue, 14 Mar 2023 22:07:47 +0000
Message-Id: <20230314220757.3827941-6-dhowells@redhat.com>
In-Reply-To: <20230314220757.3827941-1-dhowells@redhat.com>
References: <20230314220757.3827941-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

