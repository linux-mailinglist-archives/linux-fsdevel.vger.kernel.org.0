Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F312B22DCAD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGZHOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGZHOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24301C0619D2;
        Sun, 26 Jul 2020 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qc5gFbdQFccEd+cLz0uivNWRHrgQ3FD/eVQ0x32NMqc=; b=KfFmGQ40tdvAftGHT/KsK8eIly
        1vMa5fXxs4MfrtYRA/ZMRPK4OXG2vRtX7yIEietcuRdVlSWNAkWNpNzZ8WPCJYjpRkVLHj5+LgrnE
        J5EFue29ymKS89U9FtVjWJbUL2gc8nKsjVEsKO81NsEQzy4/2KoKXCt5UkNOy5LLsfz6gsqucOEj7
        RREgJ7OK8Y+bQQBxGmd/RNTCM7GRXhxmoktYtQ+nAaeykqQQPtTO1B0xv3NqbzlhaziDUwGisidP+
        WqeIXTCK5xUgt/CI4F0bvo6M0QLOTBReq5IpCra6s7v+9njl/nQH6hOTEz3GNb+HAEyqQra0has9Q
        mWVdN/kw==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarr-0002Wr-7E; Sun, 26 Jul 2020 07:14:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 20/21] init: add an init_stat helper
Date:   Sun, 26 Jul 2020 09:13:55 +0200
Message-Id: <20200726071356.287160-21-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to stat with a kernel space file name and switch
the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-autodetect.c    |  3 ++-
 fs/for_init.c                 | 15 +++++++++++++++
 include/linux/init_syscalls.h |  1 +
 init/initramfs.c              |  3 ++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 14b6e86814c061..6bbec89976a748 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -5,6 +5,7 @@
 #include <linux/mount.h>
 #include <linux/major.h>
 #include <linux/delay.h>
+#include <linux/init_syscalls.h>
 #include <linux/raid/detect.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_p.h>
@@ -151,7 +152,7 @@ static void __init md_setup_drive(struct md_setup_args *args)
 		if (strncmp(devname, "/dev/", 5) == 0)
 			devname += 5;
 		snprintf(comp_name, 63, "/dev/%s", devname);
-		if (vfs_stat(comp_name, &stat) == 0 && S_ISBLK(stat.mode))
+		if (init_stat(comp_name, &stat, 0) == 0 && S_ISBLK(stat.mode))
 			dev = new_decode_dev(stat.rdev);
 		if (!dev) {
 			pr_warn("md: Unknown device name: %s\n", devname);
diff --git a/fs/for_init.c b/fs/for_init.c
index 50813d2913b57b..919a50130a5919 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -118,6 +118,21 @@ int __init init_eaccess(const char *filename)
 	return error;
 }
 
+int __init init_stat(const char *filename, struct kstat *stat, int flags)
+{
+	int lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	struct path path;
+	int error;
+
+	error = kern_path(filename, lookup_flags, &path);
+	if (error)
+		return error;
+	error = vfs_getattr(&path, stat, STATX_BASIC_STATS,
+			    flags | AT_NO_AUTOMOUNT);
+	path_put(&path);
+	return error;
+}
+
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 {
 	struct dentry *dentry;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index fa1fe7a877795f..b2fda50daca6c5 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -8,6 +8,7 @@ int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
+int __init init_stat(const char *filename, struct kstat *stat, int flags);
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev);
 int __init init_link(const char *oldname, const char *newname);
 int __init init_symlink(const char *oldname, const char *newname);
diff --git a/init/initramfs.c b/init/initramfs.c
index 9b2d93a2eb5e4b..b1be3ada3ce4b3 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -297,7 +297,8 @@ static void __init clean_path(char *path, umode_t fmode)
 {
 	struct kstat st;
 
-	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
+	if (init_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
+	    (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
 			init_rmdir(path);
 		else
-- 
2.27.0

