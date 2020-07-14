Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71B21FCA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgGNTI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbgGNTIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:08:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915AC061755;
        Tue, 14 Jul 2020 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SfNmnpeIaLgqLHElMoiTdMHjuz+bhccYioCzBmt8Vg0=; b=DqW4FLzTD57cZNh10SjFknXCtC
        Mow05kCJ7Q/oZx3rGuN9I6SEx6li24QLIAE1xENr/zk9CRUI6iz4sASvq7zTG0ogSZNxgT/Espl9a
        g9/6+KSWPSOZ+w543FqtOfDsK+dJvdFJXQKFNsQq5SQqWou1MA0MLXlAq0Lxie7T82TGd3C/nsPhk
        zknezzp02cXSyZO0Sw1eSvA2GAvs7ULLHpfxBhTvgEYlh8AIMl4iYPiLbXouw7KkVO/KPU/JzE1hZ
        bTzzNK8weW1KPOFzo9M5OQuGG/9I5Z90bvSUTYx3E4i4Y/73nZzw9MbrjcvRBtjDKVRTRE77NDRDw
        4ck54ujg==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIM-0005pB-0o; Tue, 14 Jul 2020 19:08:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/23] fs: add a vfs_fchown helper
Date:   Tue, 14 Jul 2020 21:04:05 +0200
Message-Id: <20200714190427.4332-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper for struct file based chown operations.  To be used by
the initramfs code soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c          | 29 +++++++++++++++++------------
 include/linux/fs.h |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 6cd48a61cda3b9..103c66309bee67 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -740,23 +740,28 @@ SYSCALL_DEFINE3(lchown, const char __user *, filename, uid_t, user, gid_t, group
 			   AT_SYMLINK_NOFOLLOW);
 }
 
+int vfs_fchown(struct file *file, uid_t user, gid_t group)
+{
+	int error;
+
+	error = mnt_want_write_file(file);
+	if (error)
+		return error;
+	audit_file(file);
+	error = chown_common(&file->f_path, user, group);
+	mnt_drop_write_file(file);
+	return error;
+}
+
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
 
-	if (!f.file)
-		goto out;
-
-	error = mnt_want_write_file(f.file);
-	if (error)
-		goto out_fput;
-	audit_file(f.file);
-	error = chown_common(&f.file->f_path, user, group);
-	mnt_drop_write_file(f.file);
-out_fput:
-	fdput(f);
-out:
+	if (f.file) {
+		error = vfs_fchown(f.file, user, group);
+		fdput(f);
+	}
 	return error;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d86..0ddd64ca0b45c0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1744,6 +1744,8 @@ int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
 		void *);
 
+int vfs_fchown(struct file *file, uid_t user, gid_t group);
+
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 #ifdef CONFIG_COMPAT
-- 
2.27.0

