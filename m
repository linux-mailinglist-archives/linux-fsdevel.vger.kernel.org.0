Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4223646C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhDSPJi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 11:09:38 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:35606 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhDSPJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:09:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-fF-zZ_MtN7CFjoIojY9c2A-1; Mon, 19 Apr 2021 11:09:04 -0400
X-MC-Unique: fF-zZ_MtN7CFjoIojY9c2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D88311006C8D;
        Mon, 19 Apr 2021 15:09:02 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-134.ams2.redhat.com [10.36.112.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50BAF614FD;
        Mon, 19 Apr 2021 15:08:49 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Greg Kurz <groug@kaod.org>, Robert Krawitz <rlk@redhat.com>
Subject: [PATCH] virtiofs: propagate sync() to file server
Date:   Mon, 19 Apr 2021 17:08:48 +0200
Message-Id: <20210419150848.275757-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Even if POSIX doesn't mandate it, linux users legitimately expect
sync() to flush all data and metadata to physical storage when it
is located on the same system. This isn't happening with virtiofs
though : sync() inside the guest returns right away even though
data still needs to be flushed from the host page cache.

This is easily demonstrated by doing the following in the guest:

$ dd if=/dev/zero of=/mnt/foo bs=1M count=5K ; strace -T -e sync sync
5120+0 records in
5120+0 records out
5368709120 bytes (5.4 GB, 5.0 GiB) copied, 5.22224 s, 1.0 GB/s
sync()                                  = 0 <0.024068>
+++ exited with 0 +++

and start the following in the host when the 'dd' command completes
in the guest:

$ strace -T -e fsync sync virtiofs/foo
fsync(3)                                = 0 <10.371640>
+++ exited with 0 +++

There are no good reasons not to honor the expected behavior of
sync() actually : it gives an unrealistic impression that virtiofs
is super fast and that data has safely landed on HW, which isn't
the case obviously.

Implement a ->sync_fs() superblock operation that sends a new
FUSE_SYNC request type for this purpose. The FUSE_SYNC request
conveys the 'wait' argument of ->sync_fs() in case the file
server has a use for it. Like with FUSE_FSYNC and FUSE_FSYNCDIR,
lack of support for FUSE_SYNC in the file server is treated as
permanent success.

Note that such an operation allows the file server to DoS sync().
Since a typical FUSE file server is an untrusted piece of software
running in userspace, this is disabled by default.  Only enable it
with virtiofs for now since virtiofsd is supposedly trusted by the
guest kernel.

Reported-by: Robert Krawitz <rlk@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

Can be tested using the following custom QEMU with FUSE_SYNCFS support:

https://gitlab.com/gkurz/qemu/-/tree/fuse-sync

---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           | 29 +++++++++++++++++++++++++++++
 fs/fuse/virtio_fs.c       |  1 +
 include/uapi/linux/fuse.h | 11 ++++++++++-
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 63d97a15ffde..68e9ae96cbd4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -755,6 +755,9 @@ struct fuse_conn {
 	/* Auto-mount submounts announced by the server */
 	unsigned int auto_submounts:1;
 
+	/* Propagate syncfs() to server */
+	unsigned int sync_fs:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..425d567a06c5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -506,6 +506,34 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return err;
 }
 
+static int fuse_sync_fs(struct super_block *sb, int wait)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = fm->fc;
+	struct fuse_syncfs_in inarg;
+	FUSE_ARGS(args);
+	int err;
+
+	if (!fc->sync_fs)
+		return 0;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.wait = wait;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.opcode = FUSE_SYNCFS;
+	args.out_numargs = 0;
+
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS) {
+		fc->sync_fs = 0;
+		err = 0;
+	}
+
+	return err;
+}
+
 enum {
 	OPT_SOURCE,
 	OPT_SUBTYPE,
@@ -909,6 +937,7 @@ static const struct super_operations fuse_super_operations = {
 	.put_super	= fuse_put_super,
 	.umount_begin	= fuse_umount_begin,
 	.statfs		= fuse_statfs,
+	.sync_fs	= fuse_sync_fs,
 	.show_options	= fuse_show_options,
 };
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f734ba83..a3c025308743 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1441,6 +1441,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->release = fuse_free_conn;
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
+	fc->sync_fs = true;
 
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 54442612c48b..6e8c3cf3207c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -179,6 +179,9 @@
  *  7.33
  *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
  *  - add FUSE_OPEN_KILL_SUIDGID
+ *
+ *  7.34
+ *  - add FUSE_SYNCFS
  */
 
 #ifndef _LINUX_FUSE_H
@@ -214,7 +217,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 33
+#define FUSE_KERNEL_MINOR_VERSION 34
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -499,6 +502,7 @@ enum fuse_opcode {
 	FUSE_COPY_FILE_RANGE	= 47,
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
+	FUSE_SYNCFS		= 50,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -957,4 +961,9 @@ struct fuse_removemapping_one {
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
 
+struct fuse_syncfs_in {
+	/* Whether to wait for outstanding I/Os to complete */
+	uint32_t wait;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.26.3

