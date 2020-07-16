Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF32225FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGPOlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 10:41:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24471 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728415AbgGPOlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594910462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TxPXuYkJ63lkkARjVvXzEpBHdic5AB0/s2us98gYrgA=;
        b=cmYItR+v4GpSsMN8bGuHxqOC7Qx3YnvNtLh6qNmPK9ZHuQ1ZP32LN7BOUWjzvjyqcouUc+
        h92jnaFxtJwjihtU6g2ZCV5i3Uuw7Pnrg19Xt/wzpGo3XJ0VVEyWg5MFSqK69ZhFXK13f9
        PMySUb/pH/XUAvpQuy7PY/iaPJ9Tr+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-mYyFwuq9NeyCuP_z_MtthA-1; Thu, 16 Jul 2020 10:40:37 -0400
X-MC-Unique: mYyFwuq9NeyCuP_z_MtthA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D316100AA21;
        Thu, 16 Jul 2020 14:40:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-241.rdu2.redhat.com [10.10.114.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72B4F5C5FA;
        Thu, 16 Jul 2020 14:40:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0480C225777; Thu, 16 Jul 2020 10:40:32 -0400 (EDT)
Date:   Thu, 16 Jul 2020 10:40:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     virtio-fs-list <virtio-fs@redhat.com>, ganesh.mahalingam@intel.com
Subject: [PATCH] virtiofs: Enable SB_NOSEC flag to improve small write
 performance
Message-ID: <20200716144032.GC422759@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ganesh Mahalingam reported that virtiofs is slow with small direct random
writes when virtiofsd is run with cache=always.

https://github.com/kata-containers/runtime/issues/2815

Little debugging showed that that file_remove_privs() is called in cached
write path on every write. And everytime it calls
security_inode_need_killpriv() which results in call to
__vfs_getxattr(XATTR_NAME_CAPS). And this goes to file server to fetch
xattr. This extra round trip for every write slows down writes a lot.

Normally to avoid paying this penalty on every write, vfs has the
notion of caching this information in inode (S_NOSEC). So vfs
sets S_NOSEC, if filesystem opted for it using super block flag
SB_NOSEC. And S_NOSEC is cleared when setuid/setgid bit is set or
when security xattr is set on inode so that next time a write
happens, we check inode again for clearing setuid/setgid bits as well
clear any security.capability xattr.

This seems to work well for local file systems but for remote file
systems it is possible that VFS does not have full picture and a
different client sets setuid/setgid bit or security.capability xattr
on file and that means VFS information about S_NOSEC on another client
will be stale. So for remote filesystems SB_NOSEC was disabled by
default.

commit 9e1f1de02c2275d7172e18dc4e7c2065777611bf
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Jun 3 18:24:58 2011 -0400

    more conservative S_NOSEC handling

That commit mentioned that these filesystems can still make use of
SB_NOSEC as long as they clear S_NOSEC when they are refreshing inode
attriutes from server.

So this patch tries to enable SB_NOSEC on fuse (regular fuse as well
as virtiofs). And clear SB_NOSEC when we are refreshing inode attributes.

We need to clear SB_NOSEC either when inode has setuid/setgid bit set
or security.capability xattr has been set. We have the first piece of
information available in FUSE_GETATTR response. But we don't know if
security.capability has been set on file or not. Question is, do we
really need to know about security.capability. file_remove_privs()
always removes security.capability if a file is being written to. That
means when server writes to file, security.capability should be removed
without guest having to tell anything to it.

That means we don't have to worry about knowing if security.capability
was set or not as long as writes by client don't get cached and go to
server always. And server write should clear security.capability. Hence,
I clear SB_NOSEC when writeback cache is enabled.

This change improves random write performance very significantly. I
am running virtiofsd with cache=auto and following fio command.

fio --ioengine=libaio --direct=1  --name=test --filename=/mnt/virtiofs/random_read_write.fio --bs=4k --iodepth=64 --size=4G --readwrite=randwrite

Before this patch I get around 40MB/s and after the patch I get around
300MB/s bandwidth. So improvement is very significant.

Note: We probably could do this change for regular fuse filesystems
      as well. But I don't know all the possible configurations supported
      so I am limiting it to virtiofs.

Reported-by: "Mahalingam, Ganesh" <ganesh.mahalingam@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/inode.c     | 7 +++++++
 fs/fuse/virtio_fs.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5b4aebf5821f..5e74c818b2aa 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -185,6 +185,13 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_mode &= ~S_ISVTX;
 
 	fi->orig_ino = attr->ino;
+
+	/*
+	 * File server see setuid/setgid bit set. Maybe another client did
+	 * it. Reset S_NOSEC.
+	 */
+	if (IS_NOSEC(inode) && is_sxid(inode->i_mode))
+		inode->i_flags &= ~S_NOSEC;
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4c4ef5d69298..e89628163ec4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1126,6 +1126,10 @@ static int virtio_fs_fill_super(struct super_block *sb)
 	/* Previous unmount will stop all queues. Start these again */
 	virtio_fs_start_all_queues(fs);
 	fuse_send_init(fc);
+
+	if (!fc->writeback_cache)
+		sb->s_flags |= SB_NOSEC;
+
 	mutex_unlock(&virtio_fs_mutex);
 	return 0;
 
-- 
2.25.4

