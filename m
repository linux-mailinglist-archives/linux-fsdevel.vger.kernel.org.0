Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472AA98181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfHURiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbfHURiV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C0FC2A09CC;
        Wed, 21 Aug 2019 17:38:21 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 475505C21A;
        Wed, 21 Aug 2019 17:38:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E04DC223D09; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH 13/13] init/do_mounts.c: add virtio_fs root fs support
Date:   Wed, 21 Aug 2019 13:37:42 -0400
Message-Id: <20190821173742.24574-14-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 21 Aug 2019 17:38:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is useful to mount the root file system via virtio_fs.  During
testing a monolithic kernel is more convenient than an initramfs but
we'll need to teach the kernel how to boot directly from virtio_fs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 init/do_mounts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 53cb37b66227..d7e7bb83f85b 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -554,6 +554,16 @@ void __init mount_root(void)
 			change_floppy("root floppy");
 	}
 #endif
+#ifdef CONFIG_VIRTIO_FS
+	if (root_fs_names && !strcmp(root_fs_names, "virtio_fs")) {
+		if (!do_mount_root(root_device_name, "virtio_fs",
+				   root_mountflags, root_mount_data))
+			return;
+
+		panic("VFS: Unable to mount root fs \"%s\" from virtio_fs",
+		      root_device_name);
+	}
+#endif
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
-- 
2.20.1

