Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF339FAE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhFHPhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 11:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232942AbhFHPh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623166533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bdWtx07VT+5//++n9YSCOKqUGmNzYyJml6suv/kurIE=;
        b=be0Syy7Zri/y0yR+k2dQ9vpxLYTP+31IoHNuzvv+PxSiRRbzMbTKQrCadHrg+9Aqdwv6CB
        BB/R2qGmRLI8/km2WKNgsMJQgXqxztC6tCKestVAmK1yQI3RQgIyD3ZX4txzSxGons3DDS
        KaIZ9NlkrOd9fu98oSLcfMyoCEJZYEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-mWGBIhkFNuWzIaUg22N9zg-1; Tue, 08 Jun 2021 11:35:32 -0400
X-MC-Unique: mWGBIhkFNuWzIaUg22N9zg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF7A1020C37;
        Tue,  8 Jun 2021 15:35:31 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-35.rdu2.redhat.com [10.10.114.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C489610016F8;
        Tue,  8 Jun 2021 15:35:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4D70822054F; Tue,  8 Jun 2021 11:35:24 -0400 (EDT)
Date:   Tue, 8 Jun 2021 11:35:24 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        stefanha@redhat.com,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <20210608153524.GB504497@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]

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

So this patch proposes that we add a new prefix "fstag:" which specifies
that identifier which follows is filesystem specific tag and its not
a block device. Just pass this tag to filesystem and filesystem will
figure out how to mount it.

For example, "root=fstag:<tag>".

In case of virtiofs, I can specify "root=fstag:myfs rootfstype=virtiofs"
and it works.

I think this should work for 9p as well. "root=fstag:myfs rootfstype=9p".
Though I have yet to test it.

This kind of syntax should be able to address wide variety of use cases
where root device is not a block device and is simply some kind of
tag/label understood by filesystem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/linux/root_dev.h |  1 +
 init/do_mounts.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index 4e78651371ba..3fda7c5d9327 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -9,6 +9,7 @@
 enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
 	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
+	Root_FSTAG = MKDEV(UNNAMED_MAJOR, 253),
 	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
 	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
 	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..4d1df0da1ccc 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -275,6 +275,7 @@ static dev_t devt_from_devnum(const char *name)
  *	9) PARTLABEL=<name> with name being the GPT partition label.
  *	   MSDOS partitions do not support labels!
  *	10) /dev/cifs represents Root_CIFS (0xfe)
+ *	11) fstag:<tag> represents Root_FSTAG (0xfd)
  *
  *	If name doesn't have fall into the categories above, we return (0,0).
  *	block_class is used to check if something is a disk name. If the disk
@@ -287,6 +288,8 @@ dev_t name_to_dev_t(const char *name)
 		return Root_NFS;
 	if (strcmp(name, "/dev/cifs") == 0)
 		return Root_CIFS;
+	if (strncmp(name, "fstag:", 6) == 0)
+		return Root_FSTAG;
 	if (strcmp(name, "/dev/ram") == 0)
 		return Root_RAM0;
 #ifdef CONFIG_BLOCK
@@ -552,6 +555,16 @@ void __init mount_root(void)
 		return;
 	}
 #endif
+	if (ROOT_DEV == Root_FSTAG && root_fs_names) {
+		/* Skip "fstag:" prefix and point to real tag */
+		root_device_name += 6;
+		if (!do_mount_root(root_device_name, root_fs_names,
+					root_mountflags, root_mount_data))
+			return;
+		panic("VFS: Unable to mount root \"fstag:%s\" via \"%s\"\n",
+			root_device_name, root_fs_names);
+	}
+
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
-- 
2.25.4

