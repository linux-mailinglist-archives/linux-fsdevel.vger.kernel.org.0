Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13048B71D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350900AbiAKTRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350653AbiAKTRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51EBC061759;
        Tue, 11 Jan 2022 11:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F880B81D2A;
        Tue, 11 Jan 2022 19:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C922EC36AE3;
        Tue, 11 Jan 2022 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928594;
        bh=pUjzVc6qsEE/G5nhdfyBWk2Q3jPftIom1jL2bQTs9wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgfpH3GrsrhDXWW14dktSTKCxpbiA63OelrI5kQ6MnIJYfCnf4dJRJ0x5KhNJXQj+
         +sedxz3yneHOkghjidQTUxvokjKgA+vtjZcnk5byrBh7Km2fj2Rb2lwIa8TO+LwRaK
         +AJKybd8rMzaYBgu06QduLtC3I/oYEIq0KXjenD3OfkQ/wimsQvKrzORARAeZm1OjF
         cMWWhNPlxN0/PXQ165AcTM9xcwDqGaR6I5jHgqamshJ020D1uDRs/oGhYBwrGmCMx1
         YAtaoNvY+bNbhRUF8uEaKQ9RSNSSuIdkwxcWuNF2jDGvXARgv7gKFFCx5RprAZspmz
         DnpZEQsj+u6bw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com,
        Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH v10 33/48] ceph: add __ceph_sync_read helper support
Date:   Tue, 11 Jan 2022 14:15:53 -0500
Message-Id: <20220111191608.88762-34-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c  | 34 ++++++++++++++++++++++------------
 fs/ceph/super.h |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c65f38045f90..4309ff942943 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -883,21 +883,18 @@ enum {
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
 
-	dout("sync_read on file %p %llu~%u %s\n", file, off, (unsigned)len,
-	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+	dout("sync_read on inode %p %llu~%u\n", inode, *ki_pos, (unsigned)len);
 
 	if (!len)
 		return 0;
@@ -999,14 +996,14 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
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
 
@@ -1014,6 +1011,19 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	return ret;
 }
 
+static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
+			      int *retry_op)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+
+	dout("sync_read on file %p %llu~%u %s\n", file, iocb->ki_pos,
+	     (unsigned)iov_iter_count(to),
+	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+
+	return __ceph_sync_read(inode, &iocb->ki_pos, to, retry_op);
+}
+
 struct ceph_aio_request {
 	struct kiocb *iocb;
 	size_t total_len;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c60ff747672a..eb91586ad8f3 100644
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
2.34.1

