Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C94F4D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581883AbiDEXlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573592AbiDETXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687EC4C420;
        Tue,  5 Apr 2022 12:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A53618A0;
        Tue,  5 Apr 2022 19:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DECC385A3;
        Tue,  5 Apr 2022 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186473;
        bh=QuApRqh0fnTOdYhO0fpJUYwLgpx0svD4Wr/+e96NUFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V85DtXBr19bL+lTEDoSEjYy0ajvW1aTrwCTptYwEHBNr64twKPsNY58LaE9PgGkBz
         5fkatuYc5XIVY8nIkIy6NqIV3NBQrzOJ7Q3xeX7KoXb4UybNGQiYZaMRtu301iLFX2
         o21Le4mQtxYecUZoJJek9iT+fWw+/wBQCN1Qax4df0VBEIfokFhmgUfAfE4QnJYsSJ
         Rcd5EcbdYgldUTUG8p9j6NIF8g7PdJAAVe+FDbmo1rgknfaVkB0Px/Tm5QYnXpqVbf
         zMnqHiS4VVHJNkw86fLoofCyYH7QysAXVtyUnI8OF1JhKtYamVaQM3XNEDv3ZFwZwg
         +ox9LNGTbZZ6w==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 45/59] ceph: add __ceph_sync_read helper support
Date:   Tue,  5 Apr 2022 15:20:16 -0400
Message-Id: <20220405192030.178326-46-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Turn the guts of ceph_sync_read into a new helper that takes an inode
and an offset instead of a kiocb struct, and make ceph_sync_read call
the helper as a wrapper.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c  | 33 +++++++++++++++++++++------------
 fs/ceph/super.h |  2 ++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b7e2594cc296..c4300381851e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -927,22 +927,19 @@ enum {
  * If we get a short result from the OSD, check against i_size; we need to
  * only return a short read to the caller if we hit EOF.
  */
-static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
-			      int *retry_op)
+ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
+			 struct iov_iter *to, int *retry_op)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	ssize_t ret;
-	u64 off = iocb->ki_pos;
+	u64 off = *ki_pos;
 	u64 len = iov_iter_count(to);
 	u64 i_size = i_size_read(inode);
 	bool sparse = ceph_test_mount_opt(fsc, SPARSEREAD);
 
-	dout("sync_read on file %p %llu~%u %s\n", file, off, (unsigned)len,
-	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+	dout("sync_read on inode %p %llx~%llx\n", inode, *ki_pos, len);
 
 	if (!len)
 		return 0;
@@ -1061,14 +1058,14 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 			break;
 	}
 
-	if (off > iocb->ki_pos) {
+	if (off > *ki_pos) {
 		if (off >= i_size) {
 			*retry_op = CHECK_EOF;
-			ret = i_size - iocb->ki_pos;
-			iocb->ki_pos = i_size;
+			ret = i_size - *ki_pos;
+			*ki_pos = i_size;
 		} else {
-			ret = off - iocb->ki_pos;
-			iocb->ki_pos = off;
+			ret = off - *ki_pos;
+			*ki_pos = off;
 		}
 	}
 
@@ -1076,6 +1073,18 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	return ret;
 }
 
+static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
+			      int *retry_op)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+
+	dout("sync_read on file %p %llx~%zx %s\n", file, iocb->ki_pos,
+	     iov_iter_count(to), (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+
+	return __ceph_sync_read(inode, &iocb->ki_pos, to, retry_op);
+}
+
 struct ceph_aio_request {
 	struct kiocb *iocb;
 	size_t total_len;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 752bc3c820ca..d7ab820aed34 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1258,6 +1258,8 @@ extern int ceph_renew_caps(struct inode *inode, int fmode);
 extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags, umode_t mode);
+extern ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
+				struct iov_iter *to, int *retry_op);
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
-- 
2.35.1

