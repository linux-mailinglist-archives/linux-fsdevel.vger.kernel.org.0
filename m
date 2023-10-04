Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0C7B8BD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbjJDSzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244758AbjJDSyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F81BB;
        Wed,  4 Oct 2023 11:54:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F56C433CD;
        Wed,  4 Oct 2023 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445653;
        bh=2jXhlJqEcDz9nCd85yf7zPQyE0gGNseKC4eGu/mb95k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peCDhFvyDTAEte2SI46TPQLXkwn4da+nbi+HaRdv5Pu9lPE64KPfmA542HpVG9ukD
         mro6IGhbfWHMx4w4nF52GZGxZI3XLSvImyXKWQWR6nLuDZkB4WHcBCx9/xPy6fWju3
         vjsVXpPxVW86zDNXZzK+w3lz+A35/KZaBfjYdMqLmbf+urP32NFzzDFQN7FzGmv4m7
         9AzSZjPU3XEPUd7WngjdZs4yKso3KZ1wsk+7nZppnI/iYmKdPn41vJHjKXH0xTX9sx
         a6vI2s5yHBa+hijTo3Iit7JzUiMEudxS9Slo9mJjx9o0SkHsg5yQiBxIRcTZlv+nRX
         3uoislce/m2pQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ceph-devel@vger.kernel.org
Subject: [PATCH v2 24/89] ceph: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:09 -0400
Message-ID: <20231004185347.80880-22-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c       | 10 +++----
 fs/ceph/caps.c       |  4 +--
 fs/ceph/file.c       |  2 +-
 fs/ceph/inode.c      | 64 ++++++++++++++++++++++++--------------------
 fs/ceph/mds_client.c |  8 ++++--
 fs/ceph/snap.c       |  4 +--
 6 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f4863078f7fe..936b9e0b351d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -750,7 +750,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	dout("writepage %llu~%llu (%llu bytes, %sencrypted)\n",
 	     page_off, len, wlen, IS_ENCRYPTED(inode) ? "" : "not ");
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = inode_get_mtime(inode);
 	ceph_osdc_start_request(osdc, req);
 	err = ceph_osdc_wait_request(osdc, req);
 
@@ -1327,7 +1327,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			pages = NULL;
 		}
 
-		req->r_mtime = inode->i_mtime;
+		req->r_mtime = inode_get_mtime(inode);
 		ceph_osdc_start_request(&fsc->client->osdc, req);
 		req = NULL;
 
@@ -1875,7 +1875,7 @@ int ceph_uninline_data(struct file *file)
 		goto out_unlock;
 	}
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = inode_get_mtime(inode);
 	ceph_osdc_start_request(&fsc->client->osdc, req);
 	err = ceph_osdc_wait_request(&fsc->client->osdc, req);
 	ceph_osdc_put_request(req);
@@ -1917,7 +1917,7 @@ int ceph_uninline_data(struct file *file)
 			goto out_put_req;
 	}
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = inode_get_mtime(inode);
 	ceph_osdc_start_request(&fsc->client->osdc, req);
 	err = ceph_osdc_wait_request(&fsc->client->osdc, req);
 
@@ -2092,7 +2092,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 				     0, false, true);
 	ceph_osdc_start_request(&fsc->client->osdc, rd_req);
 
-	wr_req->r_mtime = ci->netfs.inode.i_mtime;
+	wr_req->r_mtime = inode_get_mtime(&ci->netfs.inode);
 	ceph_osdc_start_request(&fsc->client->osdc, wr_req);
 
 	err = ceph_osdc_wait_request(&fsc->client->osdc, rd_req);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 14215ec646f7..a104669fcf4c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1421,8 +1421,8 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 		arg->old_xattr_buf = NULL;
 	}
 
-	arg->mtime = inode->i_mtime;
-	arg->atime = inode->i_atime;
+	arg->mtime = inode_get_mtime(inode);
+	arg->atime = inode_get_atime(inode);
 	arg->ctime = inode_get_ctime(inode);
 	arg->btime = ci->i_btime;
 	arg->change_attr = inode_peek_iversion_raw(inode);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b1da02f5dbe3..b96d4e74ae99 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2489,7 +2489,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 		goto out;
 	}
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = inode_get_mtime(inode);
 	ceph_osdc_start_request(&fsc->client->osdc, req);
 	ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
 	if (ret == -ENOENT)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 800ab7920513..e846752b9a1f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -185,9 +185,9 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	inode->i_mode = parent->i_mode;
 	inode->i_uid = parent->i_uid;
 	inode->i_gid = parent->i_gid;
-	inode->i_mtime = parent->i_mtime;
+	inode_set_mtime_to_ts(inode, inode_get_mtime(parent));
 	inode_set_ctime_to_ts(inode, inode_get_ctime(parent));
-	inode->i_atime = parent->i_atime;
+	inode_set_atime_to_ts(inode, inode_get_atime(parent));
 	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
 
@@ -837,28 +837,31 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 			/* the MDS did a utimes() */
 			dout("mtime %lld.%09ld -> %lld.%09ld "
 			     "tw %d -> %d\n",
-			     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+			     inode_get_mtime_sec(inode),
+			     inode_get_mtime_nsec(inode),
 			     mtime->tv_sec, mtime->tv_nsec,
 			     ci->i_time_warp_seq, (int)time_warp_seq);
 
-			inode->i_mtime = *mtime;
-			inode->i_atime = *atime;
+			inode_set_mtime_to_ts(inode, *mtime);
+			inode_set_atime_to_ts(inode, *atime);
 			ci->i_time_warp_seq = time_warp_seq;
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
+			struct timespec64	ts;
+
 			/* nobody did utimes(); take the max */
-			if (timespec64_compare(mtime, &inode->i_mtime) > 0) {
+			ts = inode_get_mtime(inode);
+			if (timespec64_compare(mtime, &ts) > 0) {
 				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
-				     inode->i_mtime.tv_sec,
-				     inode->i_mtime.tv_nsec,
+				     ts.tv_sec, ts.tv_nsec,
 				     mtime->tv_sec, mtime->tv_nsec);
-				inode->i_mtime = *mtime;
+				inode_set_mtime_to_ts(inode, *mtime);
 			}
-			if (timespec64_compare(atime, &inode->i_atime) > 0) {
+			ts = inode_get_atime(inode);
+			if (timespec64_compare(atime, &ts) > 0) {
 				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
-				     inode->i_atime.tv_sec,
-				     inode->i_atime.tv_nsec,
+				     ts.tv_sec, ts.tv_nsec,
 				     atime->tv_sec, atime->tv_nsec);
-				inode->i_atime = *atime;
+				inode_set_atime_to_ts(inode, *atime);
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
 			/* we did a utimes(); ignore mds values */
@@ -869,8 +872,8 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		/* we have no write|excl caps; whatever the MDS says is true */
 		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) >= 0) {
 			inode_set_ctime_to_ts(inode, *ctime);
-			inode->i_mtime = *mtime;
-			inode->i_atime = *atime;
+			inode_set_mtime_to_ts(inode, *mtime);
+			inode_set_atime_to_ts(inode, *atime);
 			ci->i_time_warp_seq = time_warp_seq;
 		} else {
 			warn = 1;
@@ -2553,20 +2556,22 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 	}
 
 	if (ia_valid & ATTR_ATIME) {
+		struct timespec64 atime = inode_get_atime(inode);
+
 		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
-		     inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
+		     atime.tv_sec, atime.tv_nsec,
 		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
-			inode->i_atime = attr->ia_atime;
+			inode_set_atime_to_ts(inode, attr->ia_atime);
 			dirtied |= CEPH_CAP_FILE_EXCL;
 		} else if ((issued & CEPH_CAP_FILE_WR) &&
-			   timespec64_compare(&inode->i_atime,
-					    &attr->ia_atime) < 0) {
-			inode->i_atime = attr->ia_atime;
+			   timespec64_compare(&atime,
+					      &attr->ia_atime) < 0) {
+			inode_set_atime_to_ts(inode, attr->ia_atime);
 			dirtied |= CEPH_CAP_FILE_WR;
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
-			   !timespec64_equal(&inode->i_atime, &attr->ia_atime)) {
+			   !timespec64_equal(&atime, &attr->ia_atime)) {
 			ceph_encode_timespec64(&req->r_args.setattr.atime,
 					       &attr->ia_atime);
 			mask |= CEPH_SETATTR_ATIME;
@@ -2626,20 +2631,21 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 	if (ia_valid & ATTR_MTIME) {
+		struct timespec64 mtime = inode_get_mtime(inode);
+
 		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
-		     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+		     mtime.tv_sec, mtime.tv_nsec,
 		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
-			inode->i_mtime = attr->ia_mtime;
+			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 			dirtied |= CEPH_CAP_FILE_EXCL;
 		} else if ((issued & CEPH_CAP_FILE_WR) &&
-			   timespec64_compare(&inode->i_mtime,
-					    &attr->ia_mtime) < 0) {
-			inode->i_mtime = attr->ia_mtime;
+			   timespec64_compare(&mtime, &attr->ia_mtime) < 0) {
+			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 			dirtied |= CEPH_CAP_FILE_WR;
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
-			   !timespec64_equal(&inode->i_mtime, &attr->ia_mtime)) {
+			   !timespec64_equal(&mtime, &attr->ia_mtime)) {
 			ceph_encode_timespec64(&req->r_args.setattr.mtime,
 					       &attr->ia_mtime);
 			mask |= CEPH_SETATTR_MTIME;
@@ -2653,8 +2659,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
 		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
-		     inode_get_ctime(inode).tv_sec,
-		     inode_get_ctime(inode).tv_nsec,
+		     inode_get_ctime_sec(inode),
+		     inode_get_ctime_nsec(inode),
 		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
 		     only ? "ctime only" : "ignored");
 		if (only) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 615db141b6c4..e4cfa3b02187 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4353,12 +4353,16 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.flock_len = (__force __le32)
 			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
 	} else {
+		struct timespec64 ts;
+
 		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
 		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
 		rec.v1.issued = cpu_to_le32(cap->issued);
 		rec.v1.size = cpu_to_le64(i_size_read(inode));
-		ceph_encode_timespec64(&rec.v1.mtime, &inode->i_mtime);
-		ceph_encode_timespec64(&rec.v1.atime, &inode->i_atime);
+		ts = inode_get_mtime(inode);
+		ceph_encode_timespec64(&rec.v1.mtime, &ts);
+		ts = inode_get_atime(inode);
+		ceph_encode_timespec64(&rec.v1.atime, &ts);
 		rec.v1.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v1.pathbase = cpu_to_le64(pathbase);
 	}
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 813f21add992..6732e1ea97d9 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -658,8 +658,8 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 
 	BUG_ON(capsnap->writing);
 	capsnap->size = i_size_read(inode);
-	capsnap->mtime = inode->i_mtime;
-	capsnap->atime = inode->i_atime;
+	capsnap->mtime = inode_get_mtime(inode);
+	capsnap->atime = inode_get_atime(inode);
 	capsnap->ctime = inode_get_ctime(inode);
 	capsnap->btime = ci->i_btime;
 	capsnap->change_attr = inode_peek_iversion_raw(inode);
-- 
2.41.0

