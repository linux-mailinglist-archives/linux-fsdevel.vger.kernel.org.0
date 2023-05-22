Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB30570C059
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjEVNyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjEVNwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9967132
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/c+R+8s2k3pMmNtZ3aOuXJCBbwfObn3G1z9h41bJkI=;
        b=Mz9CpPpbd8NCuQZhBopgS6JY7f5cIZyrsEEA7DuucmJ1oTQkW9+2AuC0+wQGeQ6F+GeZYZ
        O9AOSdxTvCHuNHxN+usAkTlgQ6xTUJGtlywXU5cNxa4h/4ItqoGmREhvJ3d+2hdd0OU4DQ
        xmL14R6qmAc7eHJXugffnhd7dKUDssc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-NgNsZyJqPjue_3wdjfNq9A-1; Mon, 22 May 2023 09:51:37 -0400
X-MC-Unique: NgNsZyJqPjue_3wdjfNq9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86DD7281294A;
        Mon, 22 May 2023 13:51:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B290540CFD47;
        Mon, 22 May 2023 13:51:33 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v22 18/31] ext4: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:05 +0100
Message-Id: <20230522135018.2742245-19-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read wrapper for Ext4.  This does the inode shutdown check
before proceeding.  Splicing from DAX files and O_DIRECT fds is handled by
the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Theodore Ts'o <tytso@mit.edu>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Andreas Dilger <adilger.kernel@dilger.ca>
cc: linux-ext4@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ext4/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d101b3b0c7da..9f8bbd9d131c 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -147,6 +147,17 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return generic_file_read_iter(iocb, to);
 }
 
+static ssize_t ext4_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+		return -EIO;
+	return generic_file_splice_read(in, ppos, pipe, len, flags);
+}
+
 /*
  * Called when an inode is released. Note that this is different
  * from ext4_file_open: open gets called at every open, but release
@@ -957,7 +968,7 @@ const struct file_operations ext4_file_operations = {
 	.release	= ext4_release_file,
 	.fsync		= ext4_sync_file,
 	.get_unmapped_area = thp_get_unmapped_area,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= ext4_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
 };

