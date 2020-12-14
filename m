Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF952DA324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbgLNWPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408312AbgLNWPG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:15:06 -0500
From:   Jeff Layton <jlayton@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v2 2/2] overlayfs: propagate errors from upper to overlay sb in sync_fs
Date:   Mon, 14 Dec 2020 17:14:21 -0500
Message-Id: <20201214221421.1127423-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214221421.1127423-1-jlayton@kernel.org>
References: <20201214221421.1127423-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peek at the upper layer's errseq_t at mount time for volatile mounts,
and record it in the per-sb info. In sync_fs, check for an error since
the recorded point and set it in the overlayfs superblock if there was
one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/super.c     | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..f4285da50525 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,7 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	errseq_t errseq;
 };
 
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..3f0cb91915ff 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -264,8 +264,16 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	if (!ovl_upper_mnt(ofs))
 		return 0;
 
-	if (!ovl_should_sync(ofs))
-		return 0;
+	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
+
+	if (!ovl_should_sync(ofs)) {
+		/* Propagate errors from upper to overlayfs */
+		ret = errseq_check(&upper_sb->s_wb_err, ofs->errseq);
+		if (ret)
+			errseq_set(&sb->s_wb_err, ret);
+		return ret;
+	}
+
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
@@ -277,8 +285,6 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	if (!wait)
 		return 0;
 
-	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
-
 	down_read(&upper_sb->s_umount);
 	ret = sync_filesystem(upper_sb);
 	up_read(&upper_sb->s_umount);
@@ -1945,8 +1951,11 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 
 		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
 		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
 	}
+
+	if (ofs->config.ovl_volatile)
+		ofs->errseq = errseq_peek(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
+
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
-- 
2.29.2

