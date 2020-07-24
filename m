Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB77922CDE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXSih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:38:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgGXSig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595615914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhEoZgTMEfNaW4xY05eYSvJfzMwJ3nSUHVBZ7Yn3xr0=;
        b=NXtIAJSm5KoIcpggqatFxzaFLwTvSFSuquc+QZ6kzJb1w4CIKlLwEduXY4seVY+v+6q0iy
        rr56+1HRYDRmX2SA4VBNugFXRegy8eTXOFckhrwJedkmkLbwhcLKT2/mxJ/0ac3A0KWIEK
        N/NsfQ1SaDFp9hGMbccW/OH4smpd4tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-PsfdSV3pOqen6ge77Q_lPg-1; Fri, 24 Jul 2020 14:38:30 -0400
X-MC-Unique: PsfdSV3pOqen6ge77Q_lPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F3919200C0;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8991A7269A;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 43FCC223D08; Fri, 24 Jul 2020 14:38:25 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH 5/5] virtiofs: Support SB_NOSEC flag to improve direct write performance
Date:   Fri, 24 Jul 2020 14:38:12 -0400
Message-Id: <20200724183812.19573-6-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-1-vgoyal@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Reported-by: "Mahalingam, Ganesh" <ganesh.mahalingam@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/inode.c     | 12 ++++++++++++
 fs/fuse/virtio_fs.c |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 113ba149e08d..412ab08607ca 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -187,6 +187,16 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_mode &= ~S_ISVTX;
 
 	fi->orig_ino = attr->ino;
+
+	/*
+	 * We are refreshing inode data and it is possible that another
+	 * client set suid/sgid or security.capability xattr. So clear
+	 * S_NOSEC. Ideally, we could have cleared it only if suid/sgid
+	 * was set or if security.capability xattr was set. But we don't
+	 * know if security.capability has been set or not. So clear it
+	 * anyway. Its less efficient but should is safe.
+	 */
+	inode->i_flags &= ~S_NOSEC;
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
@@ -1281,6 +1291,8 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	 */
 	fput(file);
 	fuse_send_init(get_fuse_conn_super(sb));
+	if (fc->handle_killpriv_v2)
+		sb->s_flags |= SB_NOSEC;
 	return 0;
 
  err_put_conn:
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4c4ef5d69298..be05e4995e60 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1126,6 +1126,9 @@ static int virtio_fs_fill_super(struct super_block *sb)
 	/* Previous unmount will stop all queues. Start these again */
 	virtio_fs_start_all_queues(fs);
 	fuse_send_init(fc);
+
+	if (fc->handle_killpriv_v2)
+		sb->s_flags |= SB_NOSEC;
 	mutex_unlock(&virtio_fs_mutex);
 	return 0;
 
-- 
2.25.4

