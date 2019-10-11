Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF1D475A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 20:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJKSSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 14:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfJKSSc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:18:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 420B77652B;
        Fri, 11 Oct 2019 18:18:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 716455DA2C;
        Fri, 11 Oct 2019 18:18:27 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E4256220B4B; Fri, 11 Oct 2019 14:18:26 -0400 (EDT)
Date:   Fri, 11 Oct 2019 14:18:26 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     virtio-fs@redhat.com, msys.mizuma@gmail.com, stefanha@redhat.com
Subject: [PATCH] virtio_fs: Change module name to virtiofs.ko
Message-ID: <20191011181826.GA13861@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 11 Oct 2019 18:18:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have been calling it virtio_fs and even file name is virtio_fs.c. Module
name is virtio_fs.ko but when registering file system user is supposed to
specify filesystem type as "virtiofs".

Masayoshi Mizuma reported that he specified filesytem type as "virtio_fs" and
got this warning on console.

  ------------[ cut here ]------------
  request_module fs-virtio_fs succeeded, but still no fs?
  WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x138
  Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
  CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1

So looks like kernel could find the module virtio_fs.ko but could not find
filesystem type after that.

It probably is better to rename module name to virtiofs.ko so that above
warning goes away in case user ends up specifying wrong fs name.

Reported-by: Masayoshi Mizuma <msys.mizuma@gmail.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: rhvgoyal-linux/fs/fuse/Makefile
===================================================================
--- rhvgoyal-linux.orig/fs/fuse/Makefile	2019-10-11 13:53:43.905757435 -0400
+++ rhvgoyal-linux/fs/fuse/Makefile	2019-10-11 13:54:24.147757435 -0400
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
-obj-$(CONFIG_VIRTIO_FS) += virtio_fs.o
+obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
+virtiofs-y += virtio_fs.o
