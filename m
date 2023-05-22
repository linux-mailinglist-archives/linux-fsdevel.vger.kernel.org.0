Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578570C050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjEVNyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjEVNws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83218C
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEAwo5lhibqbQfXFUjxcLaBP2Klj7e0s52wWHDT+nWc=;
        b=BF2wlHFdPVc8EwbdBbDQF+mN4fcmmDtghV8E+SuvW88zy3A76KsVeIFi/jivxeTCBhHRyc
        eJ/oRwARwq18PIvuXbc1ghfe8C4+OmWG5244JjhdF47AcSBJ7DMhGY/PDT/24i7L3tzdz5
        yye1HlqPR5D96PAcx6vSepM86XnbCP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86--zVkVRXFMQ6pt9ZQdRmXYQ-1; Mon, 22 May 2023 09:51:25 -0400
X-MC-Unique: -zVkVRXFMQ6pt9ZQdRmXYQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42835811E86;
        Mon, 22 May 2023 13:51:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81FC1492B0B;
        Mon, 22 May 2023 13:51:21 +0000 (UTC)
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
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v22 15/31] afs: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:02 +0100
Message-Id: <20230522135018.2742245-16-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
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

Provide a splice_read wrapper for AFS to call afs_validate() before going
into generic_file_splice_read() so that we're likely to have a callback
promise from the server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/afs/file.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 719b31374879..d8a6b09dadf7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -25,6 +25,9 @@ static void afs_invalidate_folio(struct folio *folio, size_t offset,
 static bool afs_release_folio(struct folio *folio, gfp_t gfp_flags);
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
+				    struct pipe_inode_info *pipe,
+				    size_t len, unsigned int flags);
 static void afs_vm_open(struct vm_area_struct *area);
 static void afs_vm_close(struct vm_area_struct *area);
 static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff);
@@ -36,7 +39,7 @@ const struct file_operations afs_file_operations = {
 	.read_iter	= afs_file_read_iter,
 	.write_iter	= afs_file_write,
 	.mmap		= afs_file_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= afs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fsync		= afs_fsync,
 	.lock		= afs_lock,
@@ -587,3 +590,18 @@ static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	return generic_file_read_iter(iocb, iter);
 }
+
+static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
+				    struct pipe_inode_info *pipe,
+				    size_t len, unsigned int flags)
+{
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(in));
+	struct afs_file *af = in->private_data;
+	int ret;
+
+	ret = afs_validate(vnode, af->key);
+	if (ret < 0)
+		return ret;
+
+	return generic_file_splice_read(in, ppos, pipe, len, flags);
+}

