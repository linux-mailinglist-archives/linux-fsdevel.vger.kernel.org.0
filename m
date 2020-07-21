Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF92285B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgGUQad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgGUQ2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6CC0619DA;
        Tue, 21 Jul 2020 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CAvAtIIkzm3fHK0HKBHFJbCbWuSjjmsX8Z35+03m94I=; b=Mdh/cnjxeP+90d07hvT42e5OTb
        SJehNGJ6lRo0gUibMHZui+5L4KxWRhiKXXeDSyxnxjvjtgJufGqVpmwF0hNJKJok0txYSSY5zeSja
        BzPgZVL5goWPwRRBMneQx+hrpJ+CCcnOxv0/sXtzo7mQ5uqYsMVenTzEgVjOTPJtj1yKQvsE9nPh0
        ok9L2Qtf4ECGPe/KQwS+jHFFMPx/Ni6A4bg+7mflmvmRE4yotLpgKiQqgFviHL/Pmz8VoD7WnMMKm
        wFimCYe9PpiuQvCJmkTRLeNFihucuLCpP4RYde/WBuuDoJOa5C0BAcnHewgqtYVPDSxrIcBiR/fOH
        1nRQArcw==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv7s-0007Qw-FT; Tue, 21 Jul 2020 16:28:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 01/24] fs: refactor do_mount
Date:   Tue, 21 Jul 2020 18:27:55 +0200
Message-Id: <20200721162818.197315-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out a path_mount helper that takes a struct path * instead of the
actual file name.  This will allow to convert the init and devtmpfs code
to properly mount based on a kernel pointer instead of relying on the
implicit set_fs(KERNEL_DS) during early init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namespace.c | 67 ++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f30ed401cc6d7a..6f8234f74bed90 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3115,12 +3115,11 @@ char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-long do_mount(const char *dev_name, const char __user *dir_name,
+static int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
-	struct path path;
 	unsigned int mnt_flags = 0, sb_flags;
-	int retval = 0;
+	int ret;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -3133,19 +3132,13 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
-	/* ... and get the mountpoint */
-	retval = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
-	if (retval)
-		return retval;
-
-	retval = security_sb_mount(dev_name, &path,
-				   type_page, flags, data_page);
-	if (!retval && !may_mount())
-		retval = -EPERM;
-	if (!retval && (flags & SB_MANDLOCK) && !may_mandlock())
-		retval = -EPERM;
-	if (retval)
-		goto dput_out;
+	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
+	if (ret)
+		return ret;
+	if (!may_mount())
+		return -EPERM;
+	if ((flags & SB_MANDLOCK) && !may_mandlock())
+		return -EPERM;
 
 	/* Default to relatime unless overriden */
 	if (!(flags & MS_NOATIME))
@@ -3172,7 +3165,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	    ((flags & (MS_NOATIME | MS_NODIRATIME | MS_RELATIME |
 		       MS_STRICTATIME)) == 0)) {
 		mnt_flags &= ~MNT_ATIME_MASK;
-		mnt_flags |= path.mnt->mnt_flags & MNT_ATIME_MASK;
+		mnt_flags |= path->mnt->mnt_flags & MNT_ATIME_MASK;
 	}
 
 	sb_flags = flags & (SB_RDONLY |
@@ -3185,22 +3178,32 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 			    SB_I_VERSION);
 
 	if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
-		retval = do_reconfigure_mnt(&path, mnt_flags);
-	else if (flags & MS_REMOUNT)
-		retval = do_remount(&path, flags, sb_flags, mnt_flags,
-				    data_page);
-	else if (flags & MS_BIND)
-		retval = do_loopback(&path, dev_name, flags & MS_REC);
-	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
-		retval = do_change_type(&path, flags);
-	else if (flags & MS_MOVE)
-		retval = do_move_mount_old(&path, dev_name);
-	else
-		retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
-				      dev_name, data_page);
-dput_out:
+		return do_reconfigure_mnt(path, mnt_flags);
+	if (flags & MS_REMOUNT)
+		return do_remount(path, flags, sb_flags, mnt_flags, data_page);
+	if (flags & MS_BIND)
+		return do_loopback(path, dev_name, flags & MS_REC);
+	if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
+		return do_change_type(path, flags);
+	if (flags & MS_MOVE)
+		return do_move_mount_old(path, dev_name);
+
+	return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
+			    data_page);
+}
+
+long do_mount(const char *dev_name, const char __user *dir_name,
+		const char *type_page, unsigned long flags, void *data_page)
+{
+	struct path path;
+	int ret;
+
+	ret = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+	ret = path_mount(dev_name, &path, type_page, flags, data_page);
 	path_put(&path);
-	return retval;
+	return ret;
 }
 
 static struct ucounts *inc_mnt_namespaces(struct user_namespace *ns)
-- 
2.27.0

