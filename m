Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4C67A2ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjAXTbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjAXTbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:31:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602174FC28;
        Tue, 24 Jan 2023 11:30:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FB19B816DA;
        Tue, 24 Jan 2023 19:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C688FC433EF;
        Tue, 24 Jan 2023 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588644;
        bh=9nqi48XYUn+yKOXHj1O8QvpE4ZUaw9+QoGmKBt40oic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJmw+J66JoSDsf5zf9qb8TTgh0td9+Jv1DHxav5SFhU/LCjYpyfFvk0SdYmSQhzbK
         /cb7xs3u/lYI6aMnHiuGwpkzLM/RsINGSFS8eyxReNCzyMcwSs6Pd6NdP53CTamcvf
         /5t16SFKy+ZBEbUpCklbWIhg04OdiSxZolw5uhIyEeh89X3GjKplfwAe+vwqhozviV
         JAXZxKXYQy9gNjjaWPCR4tL2yi7mQ2r1RXPwZntvF3gYlmjakVBxZ8rh40B+4vp2Pg
         aOziKeDwvqLKr7XiIfHnH8cV/ZNvFwZ1nhotRzIXaXQYmtG8VAGLK9l/B0ZAu//jwa
         dkN5RmxQdyR6Q==
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
Subject: [PATCH v8 RESEND 7/8] nfsd: use the getattr operation to fetch i_version
Date:   Tue, 24 Jan 2023 14:30:24 -0500
Message-Id: <20230124193025.185781-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Set the STATX_CHANGE_COOKIE (and BTIME) bits in the request when we're
dealing with a v4 request. Then, instead of looking at IS_I_VERSION when
generating the change attr, look at the result mask and only use it if
STATX_CHANGE_COOKIE is set.

Change nfsd4_change_attribute to only factor in the ctime if it's a
regular file and the fs doesn't advertise STATX_ATTR_CHANGE_MONOTONIC.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c |  4 +++-
 fs/nfsd/nfsfh.c   | 54 +++++++++++++++++++++++++++++++----------------
 fs/nfsd/vfs.h     |  7 +++++-
 3 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97edb32be77f..e12e5a4ad502 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2965,7 +2965,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
+	err = vfs_getattr(&path, &stat,
+			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
+			  AT_STATX_SYNC_AS_STAT);
 	if (err)
 		goto out_nfserr;
 	if (!(stat.result_mask & STATX_BTIME))
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ac89e25e7733..3a01c8601712 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -628,6 +628,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 		stat.mtime = inode->i_mtime;
 		stat.ctime = inode->i_ctime;
 		stat.size  = inode->i_size;
+		if (v4 && IS_I_VERSION(inode)) {
+			stat.change_cookie = inode_query_iversion(inode);
+			stat.result_mask |= STATX_CHANGE_COOKIE;
+		}
 	}
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
@@ -659,6 +663,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 	if (err) {
 		fhp->fh_post_saved = false;
 		fhp->fh_post_attr.ctime = inode->i_ctime;
+		if (v4 && IS_I_VERSION(inode)) {
+			fhp->fh_post_attr.change_cookie = inode_query_iversion(inode);
+			fhp->fh_post_attr.result_mask |= STATX_CHANGE_COOKIE;
+		}
 	} else
 		fhp->fh_post_saved = true;
 	if (v4)
@@ -750,28 +758,38 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
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
+ * advertises STATX_ATTR_CHANGE_MONOTONIC, then this mitigation is not
+ * needed.
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
+	if (stat->result_mask & STATX_CHANGE_COOKIE) {
+		chattr = stat->change_cookie;
+
+		if (S_ISREG(inode->i_mode) &&
+		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
+			chattr += (u64)stat->ctime.tv_sec << 30;
+			chattr += stat->ctime.tv_nsec;
+		}
+	} else {
+		chattr = time_to_chattr(&stat->ctime);
+	}
+	return chattr;
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index dbdfef7ae85b..43fb57a301d3 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -170,9 +170,14 @@ static inline void fh_drop_write(struct svc_fh *fh)
 
 static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
+	u32 request_mask = STATX_BASIC_STATS;
 	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
 			 .dentry = fh->fh_dentry};
-	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
+
+	if (fh->fh_maxsize == NFS4_FHSIZE)
+		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+
+	return nfserrno(vfs_getattr(&p, stat, request_mask,
 				    AT_STATX_SYNC_AS_STAT));
 }
 
-- 
2.39.1

