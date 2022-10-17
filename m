Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE02600D24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiJQK6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJQK5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:57:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B361D4C;
        Mon, 17 Oct 2022 03:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABDFB812AC;
        Mon, 17 Oct 2022 10:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FBEC433D7;
        Mon, 17 Oct 2022 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666004249;
        bh=ETm0SfdogARXRGGJXl+FyttQWaCVWogaX3LXDgrfYj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIvU0EyCOy6DbQPAmG4LnwHl9cRWX/adB+EWpr5MTgOi6HJ6qeYLhbROlgZqOxc9y
         yG2lImQEsERZI0jAlukm5WsIHCI0j4uJEpO2tOSo6yezl/SAKUR4AYSXn/IXT6zEe1
         4Pijv+YSfHHocsBOHKBTsauMGovbSGYWZFpovSPQUztsR+qekfuuoO/hvW3II1kXOo
         +qehy8Al5tmwnNIoBVkeZ+kh2G82Zw7BZKSQqxsvZWhmDvxOdtnU2yJRHVKmv5175/
         q+4ECQ+cUNfHzulE+Ge79dPHx9QJHQAqAjItxI10GzfWOh1HSz5W75OopaxbyYY4N7
         UewcH/P4Dhubg==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 7/9] nfsd: use the getattr operation to fetch i_version
Date:   Mon, 17 Oct 2022 06:57:07 -0400
Message-Id: <20221017105709.10830-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017105709.10830-1-jlayton@kernel.org>
References: <20221017105709.10830-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we can call into vfs_getattr to get the i_version field, use
that facility to fetch it instead of doing it in nfsd4_change_attribute.

Neil also pointed out recently that IS_I_VERSION directory operations
are always logged, and so we only need to mitigate the rollback problem
on regular files. Also, we don't need to factor in the ctime when
reexporting NFS or Ceph.

Set the STATX_VERSION (and BTIME) bits in the request when we're dealing
with a v4 request. Then, instead of looking at IS_I_VERSION when
generating the change attr, look at the result mask and only use it if
STATX_VERSION is set.

Change nfsd4_change_attribute to only factor in the ctime if it's a regular
file and the fs doesn't advertise STATX_ATTR_VERSION_MONOTONIC.

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c |  4 +++-
 fs/nfsd/nfsfh.c   | 53 +++++++++++++++++++++++++++++++----------------
 fs/nfsd/vfs.h     |  7 ++++++-
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bcfeb1a922c0..c19b6b00b620 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2906,7 +2906,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
+	err = vfs_getattr(&path, &stat,
+			  STATX_BASIC_STATS | STATX_BTIME | STATX_VERSION,
+			  AT_STATX_SYNC_AS_STAT);
 	if (err)
 		goto out_nfserr;
 	if (!(stat.result_mask & STATX_BTIME))
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 7030d9209903..21b64ac97a06 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -628,6 +628,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 		stat.mtime = inode->i_mtime;
 		stat.ctime = inode->i_ctime;
 		stat.size  = inode->i_size;
+		if (v4 && IS_I_VERSION(inode)) {
+			stat.version = inode_query_iversion(inode);
+			stat.result_mask |= STATX_VERSION;
+		}
 	}
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
@@ -659,6 +663,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 	if (err) {
 		fhp->fh_post_saved = false;
 		fhp->fh_post_attr.ctime = inode->i_ctime;
+		if (v4 && IS_I_VERSION(inode)) {
+			fhp->fh_post_attr.version = inode_query_iversion(inode);
+			fhp->fh_post_attr.result_mask |= STATX_VERSION;
+		}
 	} else
 		fhp->fh_post_saved = true;
 	if (v4)
@@ -750,28 +758,37 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
 }
 
 /*
- * We could use i_version alone as the change attribute.  However,
- * i_version can go backwards after a reboot.  On its own that doesn't
- * necessarily cause a problem, but if i_version goes backwards and then
- * is incremented again it could reuse a value that was previously used
- * before boot, and a client who queried the two values might
- * incorrectly assume nothing changed.
+ * We could use i_version alone as the change attribute.  However, i_version
+ * can go backwards on a regular file after an unclean shutdown.  On its own
+ * that doesn't necessarily cause a problem, but if i_version goes backwards
+ * and then is incremented again it could reuse a value that was previously
+ * used before boot, and a client who queried the two values might incorrectly
+ * assume nothing changed.
+ *
+ * By using both ctime and the i_version counter we guarantee that as long as
+ * time doesn't go backwards we never reuse an old value. If the filesystem
+ * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation is not needed.
  *
- * By using both ctime and the i_version counter we guarantee that as
- * long as time doesn't go backwards we never reuse an old value.
+ * We only need to do this for regular files as well. For directories, we
+ * assume that the new change attr is always logged to stable storage in some
+ * fashion before the results can be seen.
  */
 u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
 {
+	u64 chattr;
+
 	if (inode->i_sb->s_export_op->fetch_iversion)
 		return inode->i_sb->s_export_op->fetch_iversion(inode);
-	else if (IS_I_VERSION(inode)) {
-		u64 chattr;
-
-		chattr =  stat->ctime.tv_sec;
-		chattr <<= 30;
-		chattr += stat->ctime.tv_nsec;
-		chattr += inode_query_iversion(inode);
-		return chattr;
-	} else
-		return time_to_chattr(&stat->ctime);
+	if (stat->result_mask & STATX_VERSION) {
+		chattr = stat->version;
+
+		if (S_ISREG(inode->i_mode) &&
+		    !(stat->attributes & STATX_ATTR_VERSION_MONOTONIC)) {
+			chattr += (u64)stat->ctime.tv_sec << 30;
+			chattr += stat->ctime.tv_nsec;
+		}
+	} else {
+		chattr = time_to_chattr(&stat->ctime);
+	}
+	return chattr;
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 120521bc7b24..c98e13ec37b2 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -168,9 +168,14 @@ static inline void fh_drop_write(struct svc_fh *fh)
 
 static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
+	u32 request_mask = STATX_BASIC_STATS;
 	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
 			 .dentry = fh->fh_dentry};
-	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
+
+	if (fh->fh_maxsize == NFS4_FHSIZE)
+		request_mask |= (STATX_BTIME | STATX_VERSION);
+
+	return nfserrno(vfs_getattr(&p, stat, request_mask,
 				    AT_STATX_SYNC_AS_STAT));
 }
 
-- 
2.37.3

