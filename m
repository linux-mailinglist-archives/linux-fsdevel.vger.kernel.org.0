Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307D514FB51
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 04:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBBDey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 22:34:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39663 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgBBDey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 22:34:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id 4so5842261pgd.6;
        Sat, 01 Feb 2020 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Un97QVjjkKz5RYqKD+8syS/5qdIxvzeivXj5BxZyhxA=;
        b=njCjYDWlLN/2aDGYbXpl8lEiyKRxphgrBmGsspXsHoqtvbaXvdFsCfAGYrNU5jBbvg
         ZvGshXAKB/eqXXXq/7YHcN/DWsAMWew1KxQSQG7nM1hD4zHW7AY+W7AR5exkx+k8BES1
         /402oeBlTjh/7vEHsCyOCY9lSSxwZNt5Rtp38y9Id/lChQ6ZNDZZ1r2FTHYbMGK/O1av
         5regFILDlPNqt0i7YNOt8tm7Xk5QGb+dmkx5GOCkT0izlsY0i/qbjo8si4zafuYJgNBJ
         ujPWFqqiMQWHCBoIGclEA9L3TzoHeSGJp5LQgmsCvTJcO8WX4A/XPFj9mH9absOqXXnO
         y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Un97QVjjkKz5RYqKD+8syS/5qdIxvzeivXj5BxZyhxA=;
        b=qhVXQfSQjMwf6vEHYEwxshE6LDU/HAXnAWvIeSvvI/PhzK7wx5oRLTITHEJD5GU0Wl
         Ix/985kPEGmfVIyX+kWyk3yKxBxLzH7F7hFpWMZHpzkbjfBeJfNwSKDHPeFAzSFz0tSW
         3K9jeG1rwhMsguCaVmD8HPwsQiBYAfnzl/2LOsaBwJMTnmPxE3tYjcoEsLG56AHzJeGK
         h7xQ4KMy+lPeSTmAiVb5SIfq/XoH1gEyNW4TLRw+xRKUFBIAvCrfCW4wi9DWcDuCFq+f
         DUwwx2LoX92nuaIap2/RjVn6JozXQ1UHhoZV1iM0cONOv3ZrnYOwPMs81H4xPmf5iFWR
         2nTw==
X-Gm-Message-State: APjAAAXGT+R+tYPgRF7lpeQklVMBUK3erZcVFCZoaHlxcu4CR3w02Hhz
        al1eLfdHgvW+N5NxO8hUDKI=
X-Google-Smtp-Source: APXvYqwsO1BQlRlzQYMCtzDAz32S8KXf6zpDyI2RbDHQil+Jw2Y2zIJ8I1t7gisnpyTU3JkrKfrgeg==
X-Received: by 2002:a63:3154:: with SMTP id x81mr7536795pgx.32.1580614493415;
        Sat, 01 Feb 2020 19:34:53 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id f43sm15572800pje.23.2020.02.01.19.34.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Feb 2020 19:34:52 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] fuse: Allow parallel DIO reads and check NOWAIT case for DIO writes
Date:   Sun,  2 Feb 2020 11:34:47 +0800
Message-Id: <1580614487-1341-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Earlier there was no shared lock in DIO read path. But this patch
(16c54688592ce: ext4: Allow parallel DIO reads)
simplified some of the locking mechanism while still allowing for
parallel DIO reads by adding shared lock in inode DIO read path.

Add NOWAIT check at the start of cache writes, because an aio request
with IOCB_NOWAIT could block when we call inode_lock(), which is not
allowed.

Change current rwsem code of direct write to do the trylock for the
IOCB_NOWAIT case, otherwise lock for real scheme.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/fuse/file.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ce71538..4fcf492 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1263,6 +1263,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	loff_t endbyte = 0;
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
 	if (get_fuse_conn(inode)->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, file);
@@ -1432,11 +1435,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 
 	ia->io = io;
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
-		if (!write)
-			inode_lock(inode);
 		fuse_sync_writes(inode);
-		if (!write)
-			inode_unlock(inode);
 	}
 
 	io->should_dirty = !write && iter_is_iovec(iter);
@@ -1510,6 +1509,14 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t res;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
 
 	if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 		res = fuse_direct_IO(iocb, to);
@@ -1518,6 +1525,9 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		res = __fuse_direct_read(&io, to, &iocb->ki_pos);
 	}
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
 
 	return res;
 }
@@ -1529,7 +1539,13 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t res;
 
 	/* Don't allow parallel writes to the same file */
-	inode_lock(inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-- 
1.9.1

