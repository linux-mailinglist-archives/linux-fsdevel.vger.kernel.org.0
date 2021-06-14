Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FB93A6D66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhFNRrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233358AbhFNRrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623692717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/u5u8NMmWG95xbJKzcNnLj4Ga+C/bKhaHmGCBao+E8=;
        b=UYWaZJSVSw2vNfq1VkBr6s+r3p0EYV6LNfXdOqFA4Op5KHALV8iUCaqF2Yf6lzTUwnIkZH
        iVFir1F5bbevrGHh6mgijOopZBf3cfBu7NKgxjRbfWJjM119DA7cPFwIK1SJidD9w9vj8A
        5ZOHnrn+IS3vIlUFn8ASiwJoTc75Zv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-KFmGvsUKOueAWeKlSmITIQ-1; Mon, 14 Jun 2021 13:45:15 -0400
X-MC-Unique: KFmGvsUKOueAWeKlSmITIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 847D9801B15;
        Mon, 14 Jun 2021 17:45:14 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-174.rdu2.redhat.com [10.10.114.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE0105C1A3;
        Mon, 14 Jun 2021 17:45:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5FC26223D99; Mon, 14 Jun 2021 13:45:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        richard.weinberger@gmail.com, hch@infradead.org,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH v2 1/2] init/do_mounts.c: Add a path to boot from tag based filesystems
Date:   Mon, 14 Jun 2021 13:44:53 -0400
Message-Id: <20210614174454.903555-2-vgoyal@redhat.com>
In-Reply-To: <20210614174454.903555-1-vgoyal@redhat.com>
References: <20210614174454.903555-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to be able to mount virtiofs as rootfs and pass appropriate
kernel command line. Right now there does not seem to be a good way
to do that. If I specify "root=myfs rootfstype=virtiofs", system
panics.

virtio-fs: tag </dev/root> not found
..
..
[ end Kernel panic - not syncing: VFS: Unable to mount root fs on
+unknown-block(0,0) ]

Basic problem here is that kernel assumes that device identifier
passed in "root=" is a block device. But there are few execptions
to this rule to take care of the needs of mtd, ubi, NFS and CIFS.

For example, mtd and ubi prefix "mtd:" or "ubi:" respectively.

"root=mtd:<identifier>" or "root=ubi:<identifier>"

NFS and CIFS use "root=/dev/nfs" and CIFS passes "root=/dev/cifs" and
actual root device details come from filesystem specific kernel
command line options.

virtiofs does not seem to fit in any of the above categories. In fact
we have 9pfs which can be used to boot from but it also does not
have a proper syntax to specify rootfs and does not fit into any of
the existing syntax. They both expect a device "tag" to be passed
in a device to be mounted. And filesystem knows how to parse and
use "tag".

So there seem to be a class of filesystems which specify root device
using a "tag" which is understood by the filesystem. And filesystem
simply expects that "tag" to be passed as "source" of mount and
how to mount filesystem using that "tag" is responsibility of filesystem.

This patch proposes that we internally create a list of filesystems
which pass a "tag" in "root=<tag>" and expect that tag to be passed
as "source" of mount. With this patch I can boot into virtiofs rootfs
with following syntax.

"root=myfs rootfstype=virtiofs rw"

This patch adds support for virtiofs and next patch adds 9p to the
list.

And any other file system which is fine with these semantics,
should be able to work with it easily.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 init/do_mounts.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..2a18238f4962 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -31,6 +31,12 @@
 int root_mountflags = MS_RDONLY | MS_SILENT;
 static char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
+static char *__initdata tag_based_rootfs[] = {
+#if IS_BUILTIN(CONFIG_VIRTIO_FS)
+	"virtiofs",
+#endif
+};
+static bool __initdata tag_based_root;
 static int root_wait;
 
 dev_t ROOT_DEV;
@@ -552,6 +558,14 @@ void __init mount_root(void)
 		return;
 	}
 #endif
+	if (tag_based_root) {
+		if (!do_mount_root(root_device_name, root_fs_names,
+				   root_mountflags, root_mount_data))
+			return;
+		panic("VFS: Unable to mount root \"%s\" via \"%s\"\n",
+		      root_device_name, root_fs_names);
+	}
+
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
@@ -563,6 +577,20 @@ void __init mount_root(void)
 #endif
 }
 
+static bool is_tag_based_rootfs(char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tag_based_rootfs); i++) {
+		int name_len = strlen(tag_based_rootfs[i]) + 1;
+
+		if (!strncmp(tag_based_rootfs[i], name, name_len))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
  */
@@ -593,6 +621,10 @@ void __init prepare_namespace(void)
 			goto out;
 		}
 		ROOT_DEV = name_to_dev_t(root_device_name);
+		if (ROOT_DEV == 0 && root_fs_names) {
+			if (is_tag_based_rootfs(root_fs_names))
+				tag_based_root = true;
+		}
 		if (strncmp(root_device_name, "/dev/", 5) == 0)
 			root_device_name += 5;
 	}
-- 
2.25.4

