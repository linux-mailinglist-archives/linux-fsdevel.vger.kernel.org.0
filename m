Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0FAB547
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfIFKDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfIFKDb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7A11315C010;
        Fri,  6 Sep 2019 10:03:31 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3BBC5C1D4;
        Fri,  6 Sep 2019 10:03:25 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtio-fs@redhat.com
Cc:     mszeredi@redhat.com, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] init/do_mounts.c: add virtiofs root fs support
Date:   Fri,  6 Sep 2019 11:03:24 +0100
Message-Id: <20190906100324.8492-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 06 Sep 2019 10:03:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make it possible to boot directly from a virtiofs file system with tag
'myfs' using the following kernel parameters:

  rootfstype=virtiofs root=myfs rw

Booting directly from virtiofs makes it possible to use a directory on
the host as the root file system.  This is convenient for testing and
situations where manipulating disk image files is cumbersome.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This patch is based on linux-next (next-20190904) but should apply
cleanly to other virtiofs trees.

 init/do_mounts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 9634ecf3743d..030be2f1999a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -554,6 +554,16 @@ void __init mount_root(void)
 			change_floppy("root floppy");
 	}
 #endif
+#ifdef CONFIG_VIRTIO_FS
+	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
+		if (!do_mount_root(root_device_name, "virtiofs",
+				   root_mountflags, root_mount_data))
+			return;
+
+		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
+		      root_device_name);
+	}
+#endif
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
-- 
2.21.0

