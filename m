Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A96230FBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgG1QfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbgG1QfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:35:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF2C061794;
        Tue, 28 Jul 2020 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mVzqyG22UucyWLAMOquVeAihxu6U+POnwYWEMLNy2LQ=; b=VyPDy9TOrVbt5LGHPeH2FDcJJL
        LRjnNmWVK4mOQvP17IBJ56OuScyrVB8Qiss24vYy2z0ZE1DE4sC1mbH1dw1T5OgYiT02VycRA+tT2
        dKIROjIwLsaR1IZ9eksjC59CBRRsgS0NHGKJ8yfEHkxgpPyXTjiATP0NMPgKnOlmNQRO1G4cZg2Qg
        9ZIwON9cPbakA3Jmj7Jp+r6kSbSXgx+MpLnu+x+n8YBqCz5w+dwAstn2zM117n4uWkaTFgg1gE0Bl
        Zlu+Q7OGW7uRhiOYYhSHVKkSHXw65A6V3hsRbE91GdfVB89u3WCvnmK4jwDyATuQQWG10ugET5BRC
        +xyzh08A==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SZ9-00073c-1j; Tue, 28 Jul 2020 16:35:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 21/23] init: add an init_stat helper
Date:   Tue, 28 Jul 2020 18:34:14 +0200
Message-Id: <20200728163416.556521-22-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
References: <20200728163416.556521-1-hch@lst.de>
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
 fs/init.c                     | 15 +++++++++++++++
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
diff --git a/fs/init.c b/fs/init.c
index 145fb31b7a5f2d..51646ba38099e6 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -122,6 +122,21 @@ int __init init_eaccess(const char *filename)
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
index ad5800c2d8e206..8f7e39f06547ff 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -298,7 +298,8 @@ static void __init clean_path(char *path, umode_t fmode)
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

