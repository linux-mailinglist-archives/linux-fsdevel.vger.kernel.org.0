Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F743AB7A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhFQPkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFQPkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:40:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A9C061574;
        Thu, 17 Jun 2021 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UJ6ZxhI7pFym7PlR0u1lnYbOiSY2JPtqMcPqBO8j2q0=; b=BK05KsYHCXpeyI0F6JM/YUplQU
        wVe/HymRx2z4x4OxmQIUe+oHOroCwZcyqh5Mx/szwWxJAwZ6D7TMoGzyEAB9NFiDg5xFb8Xi2jzH/
        7RkPuGbZUIlRJeQJnowTEqkl3PWASCqw/eHsf519z9DHnHIG0FT+XiBAz6IQnoSXizvPR5KqvUAY9
        fzca3YiGLU/ELLa0NRSfV3t5JX5HQWQkmZxNTR/LUDu1jaHOKKpP/TgvYoTJP0vtv+uGnaT6MDqnA
        DjPUSREvFVqZycTWJW515GpydyhNnidvEUisHBlPV4IXjasREJaxVpOfnh0qPjtr3SE3yYTvsCixX
        fcyXeAnA==;
Received: from [2001:4bb8:19b:fdce:dccf:26cc:e207:71f6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltu4w-009Hx9-6P; Thu, 17 Jun 2021 15:37:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH 2/2] init: allow mounting arbitrary non-blockdevice filesystems as root
Date:   Thu, 17 Jun 2021 17:36:49 +0200
Message-Id: <20210617153649.1886693-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617153649.1886693-1-hch@lst.de>
References: <20210617153649.1886693-1-hch@lst.de>
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
 init/do_mounts.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index ec32de3ad52b..64c60cb72ecb 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -534,6 +534,44 @@ static int __init mount_cifs_root(void)
 }
 #endif
 
+static int __init try_mount_nodev(char *fstype)
+{
+	struct file_system_type *fs = get_fs_type(fstype);
+	int err = -EINVAL;
+
+	if (!fs)
+		return -EINVAL;
+	if (!(fs->fs_flags & (FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA)))
+		err = do_mount_root(root_device_name, fstype, root_mountflags,
+					root_mount_data);
+	put_filesystem(fs);
+
+	if (err != -EACCES && err != -EINVAL)
+		panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
+			      root_device_name, fstype, err);
+	return err;
+}
+
+static int __init mount_nodev_root(void)
+{
+	char *fs_names, *p;
+	int err = -EINVAL;
+
+	fs_names = (void *)__get_free_page(GFP_KERNEL);
+	if (!fs_names)
+		return -EINVAL;
+	split_fs_names(fs_names, root_fs_names);
+
+	for (p = fs_names; *p; p += strlen(p) + 1) {
+		err = try_mount_nodev(p);
+		if (!err)
+			break;
+	}
+
+	free_page((unsigned long)fs_names);
+	return err;
+}
+
 void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
@@ -550,6 +588,8 @@ void __init mount_root(void)
 		return;
 	}
 #endif
+	if (ROOT_DEV == 0 && mount_nodev_root() == 0)
+		return;
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
-- 
2.30.2

