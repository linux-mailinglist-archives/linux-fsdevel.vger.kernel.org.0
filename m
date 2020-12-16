Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6272DC9A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgLPXeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 18:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730831AbgLPXdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608161546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uobPKuVZDbEZ19fX23VSvt5Q35SONPP7xECvb/u/H1s=;
        b=clBWycvkp+3Ay7Ialk1Rc4Z0vRAgrjQF+lF0fWfjRy7tC1U5pHASYlF6ffQdQMVmKV6VcQ
        mdIB6IoarFm8my6K1ISMilvyWsKm7hwQHCPvM2idTK+gMzMY7iwVWK5CeWJk6NHYe6KdBg
        E9eIFxeb854wIQD2w8wi6/UuwI3XIwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-UVr1GdXPOXW3R1WbGPuZ0w-1; Wed, 16 Dec 2020 18:32:22 -0500
X-MC-Unique: UVr1GdXPOXW3R1WbGPuZ0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208FA800D53;
        Wed, 16 Dec 2020 23:32:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F10E45D9C0;
        Wed, 16 Dec 2020 23:32:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 77DF5223D98; Wed, 16 Dec 2020 18:32:19 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk
Subject: [PATCH 1/3] vfs: add new f_op->syncfs vector
Date:   Wed, 16 Dec 2020 18:31:47 -0500
Message-Id: <20201216233149.39025-2-vgoyal@redhat.com>
In-Reply-To: <20201216233149.39025-1-vgoyal@redhat.com>
References: <20201216233149.39025-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current implementation of __sync_filesystem() ignores the return code
from ->sync_fs(). I am not sure why that's the case. There must have
been some historical reason for this.

Ignoring ->sync_fs() return code is problematic for overlayfs where
it can return error if sync_filesystem() on upper super block failed.
That error will simply be lost and sycnfs(overlay_fd), will get
success (despite the fact it failed).

If we modify existing implementation, there is a concern that it will
lead to user space visible behavior changes and break things. So
instead implement a new file_operations->syncfs() call which will
be called in syncfs() syscall path. Return code from this new
call will be captured. And all the writeback error detection
logic can go in there as well. Only filesystems which implement
this call get affected by this change. Others continue to fallback
to existing mechanism.

To be clear, I mean something like this (draft, untested) patch. You'd
also need to add a new ->syncfs op for overlayfs, and that could just do
a check_and_advance against the upper layer sb's errseq_t after calling
sync_filesystem.

Vivek, fixed couple of minor compile errors in original patch.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/sync.c          | 29 ++++++++++++++++++++---------
 include/linux/fs.h |  1 +
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 1373a610dc78..06caa9758d93 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -155,27 +155,38 @@ void emergency_sync(void)
 	}
 }
 
+static int generic_syncfs(struct file *file)
+{
+	int ret, ret2;
+	struct super_block *sb = file->f_path.dentry->d_sb;
+
+	down_read(&sb->s_umount);
+	ret = sync_filesystem(sb);
+	up_read(&sb->s_umount);
+
+	ret2 = errseq_check_and_advance(&sb->s_wb_err, &file->f_sb_err);
+
+	return ret ? ret : ret2;
+}
+
 /*
  * sync a single super
  */
 SYSCALL_DEFINE1(syncfs, int, fd)
 {
 	struct fd f = fdget(fd);
-	struct super_block *sb;
-	int ret, ret2;
+	int ret;
 
 	if (!f.file)
 		return -EBADF;
-	sb = f.file->f_path.dentry->d_sb;
-
-	down_read(&sb->s_umount);
-	ret = sync_filesystem(sb);
-	up_read(&sb->s_umount);
 
-	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+	if (f.file->f_op->syncfs)
+		ret = f.file->f_op->syncfs(f.file);
+	else
+		ret = generic_syncfs(f.file);
 
 	fdput(f);
-	return ret ? ret : ret2;
+	return ret;
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e..6710469b7e33 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1859,6 +1859,7 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*syncfs)(struct file *);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.25.4

