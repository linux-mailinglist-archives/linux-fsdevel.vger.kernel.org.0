Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA08772F39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHGTkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjHGTkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:40:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A7219BD;
        Mon,  7 Aug 2023 12:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D536621C4;
        Mon,  7 Aug 2023 19:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CBAC433C8;
        Mon,  7 Aug 2023 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437145;
        bh=c6Pn7MHvNlpH2XYBl6Q+eSLWZltLuR1g5CejPMxJHLg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rnOlWm10rYTe6qOxo+HjOYyd53/YPygic8GIbCK0glL6lHAvDa3L+2dgg65DdEWoc
         QCvOyUM4o/KGwZka879ebiZUesSgio3+P6FBqqK3QvfZpWSgQwUnzlA61EGf/1EL5R
         p3n1XOeZB0Iid2kQfyukLgVQTc0bZr92JrZ78skB7cVDfqriJQck8t1Eyxj9uv2eoI
         POrR0jVC26utAJ97OQ1+6der5j+G+bHgervYfGOz0V5rqeAPcxj9Esf7WkP/Yet3zD
         RhnXCWKmhZa0pDQUouE77dppIHaiYE4XM0pBvN9MSSq9yeb0ehkZ9i8+Kqjk8geTx1
         MVPzlTxHB4a4A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:34 -0400
Subject: [PATCH v7 03/13] fs: drop the timespec64 arg from
 generic_update_time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-3-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8078; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c6Pn7MHvNlpH2XYBl6Q+eSLWZltLuR1g5CejPMxJHLg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug9xhyiOiJxxIfKX2c3tg98g8sSp5LQ21GSY
 mzWI+/GCS2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPQAKCRAADmhBGVaC
 FSzyD/9trWoynNfuWyY2cs6DBpaQQUV1pUEIFhN3cQn4D1Dj4pn7ZlrYbtaZoLZ00j/ocCZY8Cm
 OST1VE54JDQXwO32hBnXeM7G96Xn7zoRH+pqQYZPbR9kUjpu+aNn6ffZxRbMP9NIzQQ+N8ghne5
 Z7jufKj2R2Uw0drlgyYUcxJ65kEGr9rFzCJE/YalbmpYvHTz/ytdS17m/ehiKt8YSSFHSlH8dw2
 IMnxIjc1hTHm6Zzohb1yvcmnWCVoz+P2c4sKhLQjHhWslSapU8kYqN8GxTMaHZTfNu5fSFodfmw
 gDKWuekjA31txotjHOPG3MMTnGLmTF08E4pH6Rm05pHpkh4nB+tcB3+Un+AXQlgt32/AEWkPc77
 emLQ4B011pQb97XrODSs8U/viLyMEDTJaeml4+OXdMN/LbxDEw5SqZwVC/mRotC12Oyhq9FMvOd
 GzGdKdwcV/yxvGo+lWThX8az+eUTbFXUeUFSFAY1ba7HcCPCDTrmLAn8gSwHMDOhyn69WQnLXrg
 TiFxvFC2v9g1ufJHiN702KiosiBViIYVdYHCdtiwFjToHpTj8jbrgCWnPX6D8gnebZyjPZrsHyl
 1e14BtVt8dQL92uLDufxrU+HAvzADZHUAHd3M7wIPV+ITM0tH7b1GTiFD6Evho+3GsGmFY2iQNR
 iA6s6+xRq9xJUrg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In future patches we're going to change how the ctime is updated
to keep track of when it has been queried. The way that the update_time
operation works (and a lot of its callers) make this difficult, since
they grab a timestamp early and then pass it down to eventually be
copied into the inode.

All of the existing update_time callers pass in the result of
current_time() in some fashion. Drop the "time" parameter from
generic_update_time, and rework it to fetch its own timestamp.

This change means that an update_time could fetch a different timestamp
than was seen in inode_needs_update_time. update_time is only ever
called with one of two flag combinations: Either S_ATIME is set, or
S_MTIME|S_CTIME|S_VERSION are set.

With this change we now treat the flags argument as an indicator that
some value needed to be updated when last checked, rather than an
indication to update specific timestamps.

Rework the logic for updating the timestamps and put it in a new
inode_update_timestamps helper that other update_time routines can use.
S_ATIME is as treated as we always have, but if any of the other three
are set, then we attempt to update all three.

Also, some callers of generic_update_time need to know what timestamps
were actually updated. Change it to return an S_* flag mask to indicate
that and rework the callers to expect it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/inode.c     |  3 +-
 fs/inode.c          | 84 +++++++++++++++++++++++++++++++++++++++++------------
 fs/orangefs/inode.c |  3 +-
 fs/ubifs/file.c     |  6 ++--
 fs/xfs/xfs_iops.c   |  6 ++--
 include/linux/fs.h  |  3 +-
 6 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 200cabf3b393..f1f04557aa21 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2155,7 +2155,8 @@ static int gfs2_update_time(struct inode *inode, struct timespec64 *time,
 		if (error)
 			return error;
 	}
-	return generic_update_time(inode, time, flags);
+	generic_update_time(inode, flags);
+	return 0;
 }
 
 static const struct inode_operations gfs2_file_iops = {
diff --git a/fs/inode.c b/fs/inode.c
index 3fc251bfaf73..e07e45f6cd01 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1881,29 +1881,76 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 	return 0;
 }
 
-int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
+/**
+ * inode_update_timestamps - update the timestamps on the inode
+ * @inode: inode to be updated
+ * @flags: S_* flags that needed to be updated
+ *
+ * The update_time function is called when an inode's timestamps need to be
+ * updated for a read or write operation. This function handles updating the
+ * actual timestamps. It's up to the caller to ensure that the inode is marked
+ * dirty appropriately.
+ *
+ * In the case where any of S_MTIME, S_CTIME, or S_VERSION need to be updated,
+ * attempt to update all three of them. S_ATIME updates can be handled
+ * independently of the rest.
+ *
+ * Returns a set of S_* flags indicating which values changed.
+ */
+int inode_update_timestamps(struct inode *inode, int flags)
 {
-	int dirty_flags = 0;
+	int updated = 0;
+	struct timespec64 now;
+
+	if (flags & (S_MTIME|S_CTIME|S_VERSION)) {
+		struct timespec64 ctime = inode_get_ctime(inode);
 
-	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
-		if (flags & S_ATIME)
-			inode->i_atime = *time;
-		if (flags & S_CTIME)
-			inode_set_ctime_to_ts(inode, *time);
-		if (flags & S_MTIME)
-			inode->i_mtime = *time;
-
-		if (inode->i_sb->s_flags & SB_LAZYTIME)
-			dirty_flags |= I_DIRTY_TIME;
-		else
-			dirty_flags |= I_DIRTY_SYNC;
+		now = inode_set_ctime_current(inode);
+		if (!timespec64_equal(&now, &ctime))
+			updated |= S_CTIME;
+		if (!timespec64_equal(&now, &inode->i_mtime)) {
+			inode->i_mtime = now;
+			updated |= S_MTIME;
+		}
+		if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode, updated))
+			updated |= S_VERSION;
+	} else {
+		now = current_time(inode);
 	}
 
-	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
-		dirty_flags |= I_DIRTY_SYNC;
+	if (flags & S_ATIME) {
+		if (!timespec64_equal(&now, &inode->i_atime)) {
+			inode->i_atime = now;
+			updated |= S_ATIME;
+		}
+	}
+	return updated;
+}
+EXPORT_SYMBOL(inode_update_timestamps);
+
+/**
+ * generic_update_time - update the timestamps on the inode
+ * @inode: inode to be updated
+ * @flags: S_* flags that needed to be updated
+ *
+ * The update_time function is called when an inode's timestamps need to be
+ * updated for a read or write operation. In the case where any of S_MTIME, S_CTIME,
+ * or S_VERSION need to be updated we attempt to update all three of them. S_ATIME
+ * updates can be handled done independently of the rest.
+ *
+ * Returns a S_* mask indicating which fields were updated.
+ */
+int generic_update_time(struct inode *inode, int flags)
+{
+	int updated = inode_update_timestamps(inode, flags);
+	int dirty_flags = 0;
 
+	if (updated & (S_ATIME|S_MTIME|S_CTIME))
+		dirty_flags = inode->i_sb->s_flags & SB_LAZYTIME ? I_DIRTY_TIME : I_DIRTY_SYNC;
+	if (updated & S_VERSION)
+		dirty_flags |= I_DIRTY_SYNC;
 	__mark_inode_dirty(inode, dirty_flags);
-	return 0;
+	return updated;
 }
 EXPORT_SYMBOL(generic_update_time);
 
@@ -1915,7 +1962,8 @@ int inode_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
 	if (inode->i_op->update_time)
 		return inode->i_op->update_time(inode, time, flags);
-	return generic_update_time(inode, time, flags);
+	generic_update_time(inode, flags);
+	return 0;
 }
 EXPORT_SYMBOL(inode_update_time);
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index a52c30e80f45..3afa2a69bc63 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -903,9 +903,10 @@ int orangefs_permission(struct mnt_idmap *idmap,
 int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
 	struct iattr iattr;
+
 	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_update_time: %pU\n",
 	    get_khandle_from_ino(inode));
-	generic_update_time(inode, time, flags);
+	flags = generic_update_time(inode, flags);
 	memset(&iattr, 0, sizeof iattr);
         if (flags & S_ATIME)
 		iattr.ia_valid |= ATTR_ATIME;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 436b27d7c58f..df9086b19cd0 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1387,8 +1387,10 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
 	int err, release;
 
-	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
-		return generic_update_time(inode, time, flags);
+	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT)) {
+		generic_update_time(inode, flags);
+		return 0;
+	}
 
 	err = ubifs_budget_space(c, &req);
 	if (err)
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 3a9363953ef2..731f45391baa 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1042,8 +1042,10 @@ xfs_vn_update_time(
 
 	if (inode->i_sb->s_flags & SB_LAZYTIME) {
 		if (!((flags & S_VERSION) &&
-		      inode_maybe_inc_iversion(inode, false)))
-			return generic_update_time(inode, now, flags);
+		      inode_maybe_inc_iversion(inode, false))) {
+			generic_update_time(inode, flags);
+			return 0;
+		}
 
 		/* Capture the iversion update that just occurred */
 		log_flags |= XFS_ILOG_CORE;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 85977cdeda94..bb3c2c4f871f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2343,7 +2343,8 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
-extern int generic_update_time(struct inode *, struct timespec64 *, int);
+int inode_update_timestamps(struct inode *inode, int flags);
+int generic_update_time(struct inode *, int);
 
 /* /sys/fs */
 extern struct kobject *fs_kobj;

-- 
2.41.0

