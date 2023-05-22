Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6670C067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjEVNyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjEVNxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F061733
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTrARcFdbC/vmS0maUQ9q741hTl6uEjvIQp7xTnb7lA=;
        b=aPfgCeBP0xo6ym3dEl091aaNTtT3pYyyo/lXfYEC8b9hjrYj+EYKSxCN2KshX7OXJQFW/W
        DpODYKDLdSTvibDzqfWD7qW60QFj6aw5Vi5fiTU2VAO7pWs/Rnaa3E0Kb4zh/UXRy/RnBD
        tJchsF90wjJhT2UHrMImw+L16XJVDZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-Wk6gk4jOMPyGatQd-7Opfg-1; Mon, 22 May 2023 09:51:49 -0400
X-MC-Unique: Wk6gk4jOMPyGatQd-7Opfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38C00802E58;
        Mon, 22 May 2023 13:51:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9E4200AE6F;
        Mon, 22 May 2023 13:51:44 +0000 (UTC)
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
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Subject: [PATCH v22 21/31] ntfs3: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:08 +0100
Message-Id: <20230522135018.2742245-22-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read wrapper for NTFS3 to perform various checks before
allowing the operation to proceed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
cc: ntfs3@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ntfs3/file.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 9a3d55c367d9..667c9dc68b58 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -744,6 +744,35 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return generic_file_read_iter(iocb, iter);
 }
 
+static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct inode *inode = in->f_mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (is_encrypted(ni)) {
+		ntfs_inode_warn(inode, "encrypted i/o not supported");
+		return -EOPNOTSUPP;
+	}
+
+#ifndef CONFIG_NTFS3_LZX_XPRESS
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		ntfs_inode_warn(
+			inode,
+			"activate CONFIG_NTFS3_LZX_XPRESS to read external compressed files");
+		return -EOPNOTSUPP;
+	}
+#endif
+
+	if (is_dedup(ni)) {
+		ntfs_inode_warn(inode, "read deduplicated not supported");
+		return -EOPNOTSUPP;
+	}
+
+	return generic_file_splice_read(in, ppos, pipe, len, flags);
+}
+
 /*
  * ntfs_get_frame_pages
  *
@@ -1159,7 +1188,7 @@ const struct file_operations ntfs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ntfs_compat_ioctl,
 #endif
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= ntfs_file_splice_read,
 	.mmap		= ntfs_file_mmap,
 	.open		= ntfs_file_open,
 	.fsync		= generic_file_fsync,

