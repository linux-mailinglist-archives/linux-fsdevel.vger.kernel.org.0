Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9121FC79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgGNTJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbgGNTJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E35C08C5DE;
        Tue, 14 Jul 2020 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OlVLWFib6FtnZCFxbnvi/3T2WDZ4jfVYULPs6vsSQuo=; b=crhQAYpsKdjX291gbV28QcA/Nx
        sJx9XT4L9omZ3HkZpZ7FtuxJZahDQv+cFISe8Nx6Zgy5qThex3aUMCjRfLw9+xw9jMcJr/kpwJpLn
        p6dhGvF1kO0hesjGm+Ke3tHJf+7ySRKJdyFkcUsIQjD5LJdNRxjOf4fAJKaBy+/BeONWT3VBmOk4Q
        +oTJpFpVPFZgAf0UKKOIOUPULCP6GEDCpx8HJVgwtzkh1P04embpPMfhGLqp0EQ5q3VOziIcPTiC3
        serKq1W7fn52fpZxZL4fYWr8nevFDvQceR5UDI3RF8/R16UBGH0wQ8VoYNyM4MgYOvJFya1P452Bu
        12M905uA==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIq-0005ui-6o; Tue, 14 Jul 2020 19:09:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/23] fs: remove ksys_fchmod
Date:   Tue, 14 Jul 2020 21:04:26 +0200
Message-Id: <20200714190427.4332-23-hch@lst.de>
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

Fold it into the only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 7 +------
 include/linux/syscalls.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index ab3671af8a9705..b316dd6a86a8b9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -608,7 +608,7 @@ int vfs_fchmod(struct file *file, umode_t mode)
 	return chmod_common(&file->f_path, mode);
 }
 
-int ksys_fchmod(unsigned int fd, umode_t mode)
+SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 {
 	struct fd f = fdget(fd);
 	int err = -EBADF;
@@ -620,11 +620,6 @@ int ksys_fchmod(unsigned int fd, umode_t mode)
 	return err;
 }
 
-SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
-{
-	return ksys_fchmod(fd, mode);
-}
-
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 {
 	struct path path;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b6d90057476260..39ff738997a172 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1240,7 +1240,6 @@ int ksys_umount(char __user *name, int flags);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
-int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
-- 
2.27.0

