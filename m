Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BD3AE320
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 08:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUGam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 02:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFUGak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A476C061574;
        Sun, 20 Jun 2021 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ei4k0DyLSCzAsnevwVlI/kUyzDUWT9VsLrg1wN2ODxY=; b=oTbuU7g3GAS3M5t7KKjVy7z+4T
        23y/ECbpYvWr1wTJUd2+hQnIH0Mf1Aw4pTarnH/Ah0nGjnSCpIse6Ff7w6EJd3Vm8XVc88kO9I4Qm
        2Lio2ZcbVK+w/b3lczkzy3G4UDYwKAHiH2mZmrZ/skCALPnHL5cqgCPggJnlv2rkpnJ7O5kuC6c2V
        b4KS08YrqJ9KatyElQ4GY8FgeEXOSRMJX5W6nK3fjVA8H2gBgH8BM69HD5q+v2c7b2ex72ibQAUIK
        7JNkIBoxY78EF4u9f3qtRjLVQYu4M0mAE2iX8UPvUK8xk9CY+HVvAk6pDopc03YBNwLrazHIXl1mr
        Kbj0+BtQ==;
Received: from [2001:4bb8:188:3e21:8988:c934:59d4:cfe6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvDPQ-00CmrG-PE; Mon, 21 Jun 2021 06:27:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH 2/2] init: allow mounting arbitrary non-blockdevice filesystems as root
Date:   Mon, 21 Jun 2021 08:26:57 +0200
Message-Id: <20210621062657.3641879-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621062657.3641879-1-hch@lst.de>
References: <20210621062657.3641879-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the only non-blockdevice filesystems that can be used as the
initial root filesystem are NFS and CIFS, which use the magic
"root=/dev/nfs" and "root=/dev/cifs" syntax that requires the root
device file system details to come from filesystem specific kernel
command line options.

Add a little bit of new code that allows to just pass arbitrary
string mount options to any non-blockdevice filesystems so that it can
be mounted as the root file system.

For example a virtiofs root file system can be mounted using the
following syntax:

"root=myfs rootfstype=virtiofs rw"

Based on an earlier patch from Vivek Goyal <vgoyal@redhat.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index ec32de3ad52b..bdeb90b8d669 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -534,6 +534,45 @@ static int __init mount_cifs_root(void)
 }
 #endif
 
+static bool __init fs_is_nodev(char *fstype)
+{
+	struct file_system_type *fs = get_fs_type(fstype);
+	bool ret = false;
+
+	if (fs) {
+		ret = !(fs->fs_flags & FS_REQUIRES_DEV);
+		put_filesystem(fs);
+	}
+
+	return ret;
+}
+
+static int __init mount_nodev_root(void)
+{
+	char *fs_names, *fstype;
+	int err = -EINVAL;
+
+	fs_names = (void *)__get_free_page(GFP_KERNEL);
+	if (!fs_names)
+		return -EINVAL;
+	split_fs_names(fs_names, root_fs_names);
+
+	for (fstype = fs_names; *fstype; fstype += strlen(fstype) + 1) {
+		if (!fs_is_nodev(fstype))
+			continue;
+		err = do_mount_root(root_device_name, fstype, root_mountflags,
+				    root_mount_data);
+		if (!err)
+			break;
+		if (err != -EACCES && err != -EINVAL)
+			panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
+			      root_device_name, fstype, err);
+	}
+
+	free_page((unsigned long)fs_names);
+	return err;
+}
+
 void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
@@ -550,6 +589,10 @@ void __init mount_root(void)
 		return;
 	}
 #endif
+	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
+		if (mount_nodev_root() == 0)
+			return;
+	}
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
-- 
2.30.2

