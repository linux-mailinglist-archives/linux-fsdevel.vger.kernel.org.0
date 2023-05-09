Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158076FC12B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjEIIFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjEIIEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 04:04:47 -0400
Received: from out-35.mta0.migadu.com (out-35.mta0.migadu.com [IPv6:2001:41d0:1004:224b::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E15AD2F7
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 01:03:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683619301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nk2dhZj27Q+MUWDaPhaCN1vyTUR8Cz9pEgpWpwiIqh4=;
        b=Iw0Qg1sVkGqzT8lCHp2CcP2M2bO7AnIss0t1x4UOFF+SrM9gu5PNTpMMruxUq3xT9059n/
        mYeX3XfAeSQqTNS9POoUdiOtrX7ntLWFekE2iIkL7cr8NH3m6YZB7hGfj68PHagoJ4PgN4
        dUjF0JqKrryMsiqptS/N0KWdV/nHbrY=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net
Subject: [RFC PATCH] fuse: invalidate page cache pages before direct write
Date:   Tue,  9 May 2023 16:01:28 +0800
Message-Id: <20230509080128.457489-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

In FOPEN_DIRECT_IO, page cache may still be there for a file, direct
write should respect that and invalidate the corresponding pages so
that page cache readers don't get stale data. Another thing this patch
does is flush related pages to avoid its loss.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---

Reference:
https://lore.kernel.org/linux-fsdevel/ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev/#:~:text=I%20think%20this%20problem%20exists%20before%20this%20patchset

 fs/fuse/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89d97f6188e0..edc84c1dfc5c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1490,7 +1490,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	int write = flags & FUSE_DIO_WRITE;
 	int cuse = flags & FUSE_DIO_CUSE;
 	struct file *file = io->iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
 	size_t nmax = write ? fc->max_write : fc->max_read;
@@ -1516,6 +1517,17 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
+	res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
+	if (res)
+		return res;
+
+	if (write) {
+		if (invalidate_inode_pages2_range(mapping,
+				idx_from, idx_to)) {
+			return -ENOTBLK;
+		}
+	}
+
 	io->should_dirty = !write && user_backed_iter(iter);
 	while (count) {
 		ssize_t nres;
-- 
2.25.1

