Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58993AFED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVIOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 04:14:35 -0400
Received: from verein.lst.de ([213.95.11.211]:45606 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhFVIOe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:14:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F31167373; Tue, 22 Jun 2021 10:12:17 +0200 (CEST)
Date:   Tue, 22 Jun 2021 10:12:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH 3/2] fs: simplify get_filesystem_list / get_all_fs_names
Message-ID: <20210622081217.GA2975@lst.de>
References: <20210621062657.3641879-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621062657.3641879-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just output the '\0' separate list of supported file systems for block
devices directly rather than going through a pointless round of string
manipulation.

Based on an earlier patch from Al Viro <viro@zeniv.linux.org.uk>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/filesystems.c   | 24 ++++++++++++++----------
 include/linux/fs.h |  2 +-
 init/do_mounts.c   | 20 +-------------------
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 90b8d879fbaf..7c136251607a 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -209,21 +209,25 @@ SYSCALL_DEFINE3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
 }
 #endif
 
-int __init get_filesystem_list(char *buf)
+void __init list_bdev_fs_names(char *buf, size_t size)
 {
-	int len = 0;
-	struct file_system_type * tmp;
+	struct file_system_type *p;
+	size_t len;
 
 	read_lock(&file_systems_lock);
-	tmp = file_systems;
-	while (tmp && len < PAGE_SIZE - 80) {
-		len += sprintf(buf+len, "%s\t%s\n",
-			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
-			tmp->name);
-		tmp = tmp->next;
+	for (p = file_systems; p; p = p->next) {
+		if (!(p->fs_flags & FS_REQUIRES_DEV))
+			continue;
+		len = strlen(p->name) + 1;
+		if (len > size) {
+			pr_warn("%s: truncating file system list\n", __func__);
+			break;
+		}
+		memcpy(buf, p->name, len);
+		buf += len;
+		size -= len;
 	}
 	read_unlock(&file_systems_lock);
-	return len;
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f4ed7bf1130d..cdcd7f2a2c3f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3624,7 +3624,7 @@ int proc_nr_dentry(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos);
 int proc_nr_inodes(struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos);
-int __init get_filesystem_list(char *buf);
+void __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
 #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index bdeb90b8d669..ffbe4deeb274 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -348,24 +348,6 @@ static void __init split_fs_names(char *page, char *names)
 	*page = '\0';
 }
 
-static void __init get_all_fs_names(char *page)
-{
-	int len = get_filesystem_list(page);
-	char *s = page, *p, *next;
-
-	page[len] = '\0';
-	for (p = page - 1; p; p = next) {
-		next = strchr(++p, '\n');
-		if (*p++ != '\t')
-			continue;
-		while ((*s++ = *p++) != '\n')
-			;
-		s[-1] = '\0';
-	}
-
-	*s = '\0';
-}
-
 static int __init do_mount_root(const char *name, const char *fs,
 				 const int flags, const void *data)
 {
@@ -415,7 +397,7 @@ void __init mount_block_root(char *name, int flags)
 	if (root_fs_names)
 		split_fs_names(fs_names, root_fs_names);
 	else
-		get_all_fs_names(fs_names);
+		list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
-- 
2.30.2

