Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE22DC99F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 00:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgLPXd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 18:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730830AbgLPXdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608161546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iyvu3tczAymPkwWycdPC/BAXXExR62UHIGSUwLXdNqs=;
        b=GATxJoVUWJWG8NY/0HNJrGYtwdvgP1PJEF/mYjKxrTBr15zQ1SbeexTq50SXG2fkoTRB7x
        KXN79Z3HTksxGMBrJxeJQZvAWMzz//aJwYtIaH5HV8TX9pzHVyMYVqpdc0UIH0YoTUkW3g
        mtg/rBen9MrNU5+g8PJuydVhInNuCEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-5DZe-w98PwK_bJ9o0z2SMw-1; Wed, 16 Dec 2020 18:32:22 -0500
X-MC-Unique: 5DZe-w98PwK_bJ9o0z2SMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F3C21842142;
        Wed, 16 Dec 2020 23:32:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09B795D9D2;
        Wed, 16 Dec 2020 23:32:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8098A225FCD; Wed, 16 Dec 2020 18:32:19 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk
Subject: [PATCH 3/3] overlayfs: Check writeback errors w.r.t upper in ->syncfs()
Date:   Wed, 16 Dec 2020 18:31:49 -0500
Message-Id: <20201216233149.39025-4-vgoyal@redhat.com>
In-Reply-To: <20201216233149.39025-1-vgoyal@redhat.com>
References: <20201216233149.39025-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check for writeback error on overlay super block w.r.t "struct file"
passed in ->syncfs().

As of now real error happens on upper sb. So this patch first propagates
error from upper sb to overlay sb and then checks error w.r.t struct
file passed in.

Jeff, I know you prefer that I should rather file upper file and check
error directly on on upper sb w.r.t this real upper file.  While I was
implementing that I thought what if file is on lower (and has not been
copied up yet). In that case shall we not check writeback errors and
return back to user space? That does not sound right though because,
we are not checking for writeback errors on this file. Rather we
are checking for any error on superblock. Upper might have an error
and we should report it to user even if file in question is a lower
file. And that's why I fell back to this approach. But I am open to
change it if there are issues in this method.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/super.c     | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..a08fd719ee7b 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,8 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	/* Protects multiple sb->s_wb_err update from upper_sb . */
+	spinlock_t errseq_lock;
 };
 
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b4d92e6fa5ce..e7bc4492205e 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -291,7 +291,7 @@ int ovl_syncfs(struct file *file)
 	struct super_block *sb = file->f_path.dentry->d_sb;
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct super_block *upper_sb;
-	int ret;
+	int ret, ret2;
 
 	ret = 0;
 	down_read(&sb->s_umount);
@@ -310,10 +310,18 @@ int ovl_syncfs(struct file *file)
 	ret = sync_filesystem(upper_sb);
 	up_read(&upper_sb->s_umount);
 
+	/* Update overlay sb->s_wb_err */
+	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
+		/* Upper sb has errors since last time */
+		spin_lock(&ofs->errseq_lock);
+		errseq_check_and_advance(&upper_sb->s_wb_err, &sb->s_wb_err);
+		spin_unlock(&ofs->errseq_lock);
+	}
 
+	ret2 = errseq_check_and_advance(&sb->s_wb_err, &file->f_sb_err);
 out:
 	up_read(&sb->s_umount);
-	return ret;
+	return ret ? ret : ret2;
 }
 
 /**
@@ -1903,6 +1911,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	if (!cred)
 		goto out_err;
 
+	spin_lock_init(&ofs->errseq_lock);
 	/* Is there a reason anyone would want not to share whiteouts? */
 	ofs->share_whiteout = true;
 
@@ -1975,7 +1984,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 
 		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
 		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
+		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
-- 
2.25.4

