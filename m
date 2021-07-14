Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E83C9205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhGNU0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 16:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235744AbhGNU0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626294231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2gePRK85A6LvcvTNsyknMtURDmZvzCUYyYRTFLIZuI=;
        b=P73VSTHBgRxA+a33GIFsBdJiUvqqSUPZX2od5chUN6by46yUmnCqYuorQVuezXgYuPn8p/
        Zn4ggePNSFyOApBzraUno2+x4RiMhWkfGg9XHA9XJufAkNRchA5YtRpfKc9aPy56xgzonD
        0VtynSINSM810JNiEn1rcl7mRb2vaZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-n9mOPQq3OAWspcS-D5xOsQ-1; Wed, 14 Jul 2021 16:23:47 -0400
X-MC-Unique: n9mOPQq3OAWspcS-D5xOsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B612100CCE0;
        Wed, 14 Jul 2021 20:23:42 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-201.rdu2.redhat.com [10.10.114.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C938138E50;
        Wed, 14 Jul 2021 20:23:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6355A226CA5; Wed, 14 Jul 2021 16:23:40 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH v3 2/3] init: allow mounting arbitrary non-blockdevice filesystems as root
Date:   Wed, 14 Jul 2021 16:23:20 -0400
Message-Id: <20210714202321.59729-3-vgoyal@redhat.com>
In-Reply-To: <20210714202321.59729-1-vgoyal@redhat.com>
References: <20210714202321.59729-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

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
2.31.1

