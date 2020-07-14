Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7396021FC78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgGNTJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgGNTJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B7C08C5DF;
        Tue, 14 Jul 2020 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=K4dikGL6u3RwHx28hPRDI4chJ8W10j0njE5MaHZR3f8=; b=HgymRxLHxdaSCUuRhwS7AZGyDe
        WILDssGJY7BRG4JPOkLmQWKkqQiqWrB2foel/5S3TTwGG4z4jCNZBsp7QfgCVNb8efffwHLScalLX
        jwFAUQRHFo1AniHwAwnOJQu3FmQkbhxsz6U2dkQbz0zL4+Np1NbHoRRWHwGJQ8Suz9fDQJjSgmvhr
        /vnuuaZr+r5la/MS0U1YJg+qOO3f2wj3WvFoUo2u2KM9dFd3Xcri1zJEjX40G+A5bI25IaIdbCMkY
        4suFjjBUJPD4YjpHUrPA+onyOWLnTHkVJGQn2Eas+P4vng1L2oWspxAOgcALbA5ZvawxrEU+Y0gkC
        wVs7z8Lw==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIr-0005uv-LU; Tue, 14 Jul 2020 19:09:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/23] fs: remove ksys_ioctl
Date:   Tue, 14 Jul 2020 21:04:27 +0200
Message-Id: <20200714190427.4332-24-hch@lst.de>
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
 fs/ioctl.c               | 7 +------
 include/linux/syscalls.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index d69786d1dd9115..4e6cc0a7d69c9f 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -736,7 +736,7 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	return -ENOIOCTLCMD;
 }
 
-int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 {
 	struct fd f = fdget(fd);
 	int error;
@@ -757,11 +757,6 @@ int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 	return error;
 }
 
-SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
-{
-	return ksys_ioctl(fd, cmd, arg);
-}
-
 #ifdef CONFIG_COMPAT
 /**
  * compat_ptr_ioctl - generic implementation of .compat_ioctl file operation
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 39ff738997a172..5b0f1fca4cfb9d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1241,7 +1241,6 @@ int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
-int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
-- 
2.27.0

