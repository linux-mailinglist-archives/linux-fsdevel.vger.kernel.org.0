Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA82DA29F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 22:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406764AbgLNVkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 16:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729890AbgLNVkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607981928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WR+RyLQ7QZDrTrU3w6RGuPv+flEY6ZP3IN3AdHw7u8o=;
        b=I/OSKhYe9SdP2R3yCHiyjMMNUH3ErmWvw0cgLmqDGtImGJqQD2rCayFXDYoEKOk5fcn3U8
        T2+vXJY7ow2biPD06v/Ff6Ad/7/b0YE6T2NeZNDPpTcbHqpeLrZtv7yaYqmobakcM1WXQ+
        Jai6adlmrmffUhcj4j5JjE0EJwd2o9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-EgKEIIDfNkOxTyBCXwdYlQ-1; Mon, 14 Dec 2020 16:38:46 -0500
X-MC-Unique: EgKEIIDfNkOxTyBCXwdYlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456C16D531;
        Mon, 14 Dec 2020 21:38:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-168.rdu2.redhat.com [10.10.114.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3D718A9E;
        Mon, 14 Dec 2020 21:38:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E0784220BCF; Mon, 14 Dec 2020 16:38:43 -0500 (EST)
Date:   Mon, 14 Dec 2020 16:38:43 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
Message-ID: <20201214213843.GA3453@redhat.com>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213132713.66864-3-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 08:27:13AM -0500, Jeff Layton wrote:
> Peek at the upper layer's errseq_t at mount time for volatile mounts,
> and record it in the per-sb info. In sync_fs, check for an error since
> the recorded point and set it in the overlayfs superblock if there was
> one.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

While we are solving problem for non-volatile overlay mount, I also
started thinking, what about non-volatile overlay syncfs() writeback errors.
Looks like these will not be reported to user space at all as of now
(because we never update overlay_sb->s_wb_err ever).

A patch like this might fix it. (compile tested only).

overlayfs: Report syncfs() errors to user space

Currently, syncfs(), calls filesystem ->sync_fs() method but ignores the
return code. But certain writeback errors can still be reported on 
syncfs() by checking errors on super block.

ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);

For the case of overlayfs, we never set overlayfs super block s_wb_err. That
means sync() will never report writeback errors on overlayfs uppon syncfs().

Fix this by updating overlay sb->sb_wb_err upon ->sync_fs() call. And that
should mean that user space syncfs() call should see writeback errors.

ovl_fsync() does not need anything special because if there are writeback
errors underlying filesystem will report it through vfs_fsync_range() return
code and user space will see it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/overlayfs/ovl_entry.h |    1 +
 fs/overlayfs/super.c     |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

Index: redhat-linux/fs/overlayfs/super.c
===================================================================
--- redhat-linux.orig/fs/overlayfs/super.c	2020-12-14 15:33:43.934400880 -0500
+++ redhat-linux/fs/overlayfs/super.c	2020-12-14 16:15:07.127400880 -0500
@@ -259,7 +259,7 @@ static int ovl_sync_fs(struct super_bloc
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct super_block *upper_sb;
-	int ret;
+	int ret, ret2;
 
 	if (!ovl_upper_mnt(ofs))
 		return 0;
@@ -283,7 +283,14 @@ static int ovl_sync_fs(struct super_bloc
 	ret = sync_filesystem(upper_sb);
 	up_read(&upper_sb->s_umount);
 
-	return ret;
+	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
+		/* Upper sb has errors since last time */
+		spin_lock(&ofs->errseq_lock);
+		ret2 = errseq_check_and_advance(&upper_sb->s_wb_err,
+						&sb->s_wb_err);
+		spin_unlock(&ofs->errseq_lock);
+	}
+	return ret ? ret : ret2;
 }
 
 /**
@@ -1873,6 +1880,7 @@ static int ovl_fill_super(struct super_b
 	if (!cred)
 		goto out_err;
 
+	spin_lock_init(&ofs->errseq_lock);
 	/* Is there a reason anyone would want not to share whiteouts? */
 	ofs->share_whiteout = true;
 
@@ -1945,7 +1953,7 @@ static int ovl_fill_super(struct super_b
 
 		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
 		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
+		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
Index: redhat-linux/fs/overlayfs/ovl_entry.h
===================================================================
--- redhat-linux.orig/fs/overlayfs/ovl_entry.h	2020-12-14 15:33:43.934400880 -0500
+++ redhat-linux/fs/overlayfs/ovl_entry.h	2020-12-14 15:34:13.509400880 -0500
@@ -79,6 +79,7 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	spinlock_t errseq_lock;
 };
 
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)

