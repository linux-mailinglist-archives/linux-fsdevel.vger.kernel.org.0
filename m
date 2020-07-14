Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAEB21FC85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgGNTJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgGNTJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3CC08C5C1;
        Tue, 14 Jul 2020 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8TOhkMP63y+WabUPsTk9ObOGsvlUh0ZRK3HKBndfJis=; b=jJBrjBTfdvVPgj6+yqGcHSSakf
        5+TrHG/bucDNpVb2YrcUsuXEZF1Dfb7zz+C47qPMImrm/0GmZzDVOv4cWSmLo7oU2CZLru4YVns4P
        V/cwAerJP9AG7akpxjDKcZJ44bc2+5JeEsxovVtdhGm/XiG/l55jClKUzQIoTFAMlGD1PVz/r0ZOY
        JFFTrFWdy/vWH2ekghqXzOu05o9owHT2wyDxqcrMJxKfUdkPKZVJftAnhOde2SEcj6XPrZNl11tb+
        2n+nGAZKIr7zKiviG3sY+M3AS8dmC3yVkmucMKRlewQ3GKpZk6ecr4OexuH2Tq7P20WK9Z9eMGNSi
        Q5xHocEQ==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIl-0005to-Ps; Tue, 14 Jul 2020 19:09:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/23] fs: remove ksys_getdents64
Date:   Tue, 14 Jul 2020 21:04:23 +0200
Message-Id: <20200714190427.4332-20-hch@lst.de>
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

Just open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/readdir.c             | 11 ++---------
 include/linux/syscalls.h |  2 --
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index a49f07c11cfbd0..19434b3c982cd3 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -348,8 +348,8 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	return -EFAULT;
 }
 
-int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
-		    unsigned int count)
+SYSCALL_DEFINE3(getdents64, unsigned int, fd,
+		struct linux_dirent64 __user *, dirent, unsigned int, count)
 {
 	struct fd f;
 	struct getdents_callback64 buf = {
@@ -380,13 +380,6 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 	return error;
 }
 
-
-SYSCALL_DEFINE3(getdents64, unsigned int, fd,
-		struct linux_dirent64 __user *, dirent, unsigned int, count)
-{
-	return ksys_getdents64(fd, dirent, count);
-}
-
 #ifdef CONFIG_COMPAT
 struct compat_old_linux_dirent {
 	compat_ulong_t	d_ino;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 10843a6adb770d..a998651629c71b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1243,8 +1243,6 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
 int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
-int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
-		    unsigned int count);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
-- 
2.27.0

