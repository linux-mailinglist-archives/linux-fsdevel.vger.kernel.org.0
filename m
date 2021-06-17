Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A03AB11A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhFQKQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFQKQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:16:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E82C061574;
        Thu, 17 Jun 2021 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1rcaBiYMmxbTIzBSP4Lkyvlkc2KdB5uGKfAUxQ6B2a4=; b=nTtzOYyH5nOB+rP0PzOPnj6I+b
        Kznx/IAocBctaMmCDpRBXcNsJOFm5Rx3yGsLm+PWWxWHDhmzH2k4knlIjyqz0MxafD79FV3ZF6Dp1
        Vx2s7YvaIQb+zKW4icpwpqz9MhyVR/6AWFOkICqel2DCojYafEI3tTZadCaGq8y08Kl9ybex3TajK
        qBTiX7TxTBkTKx5ClUNwC+i5dm/NVFXzhWnmUauAfJR3DgZy4hWMn3tOFJiL/w0rLP5boCXZN9vB8
        CTEExFY0i1HAry95jafbWjRvtbwQn/snQQYYccuM4Y3dngmmwxqibc25LV8ViDP1qTT+6XSdSVZ+f
        vdNdIovw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltp28-0090SY-Ou; Thu, 17 Jun 2021 10:14:04 +0000
Date:   Thu, 17 Jun 2021 11:14:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        richard.weinberger@gmail.com, hch@infradead.org,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2 0/2] Add support to boot virtiofs and 9pfs as rootfs
Message-ID: <YMsgaPS90iKIqSvi@infradead.org>
References: <20210614174454.903555-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614174454.903555-1-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Why not something like the version below that should work for all nodev
file systems?

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 74aede860de7..3c5676603fef 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -530,6 +530,39 @@ static int __init mount_cifs_root(void)
 }
 #endif
 
+static int __init mount_nodev_root(void)
+{
+	struct file_system_type *fs = get_fs_type(root_fs_names);
+	char *fs_names, *p;
+	int err = -ENODEV;
+
+	if (!fs)
+		goto out;
+	if (fs->fs_flags & FS_REQUIRES_DEV)
+		goto out_put_filesystem;
+
+	fs_names = (void *)__get_free_page(GFP_KERNEL);
+	if (!fs_names)
+		goto out_put_filesystem;
+	get_fs_names(fs_names);
+
+	for (p = fs_names; *p; p += strlen(p) + 1) {
+		err = do_mount_root(root_device_name, p, root_mountflags,
+					root_mount_data);
+		if (!err)
+			break;
+		if (err != -EACCES && err != -EINVAL)
+			panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
+				      root_device_name, p, err);
+	}
+
+	free_page((unsigned long)fs_names);
+out_put_filesystem:
+	put_filesystem(fs);
+out:
+	return err;
+}
+
 void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
@@ -546,6 +579,8 @@ void __init mount_root(void)
 		return;
 	}
 #endif
+	if (ROOT_DEV == 0 && mount_nodev_root() == 0)
+		return;
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
