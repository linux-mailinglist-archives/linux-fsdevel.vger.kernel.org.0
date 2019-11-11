Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A62F8127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKKUYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:24:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:24:22 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MybCV-1hgJG60W9l-00yzZy; Mon, 11 Nov 2019 21:16:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/19] nfs: use timespec64 in nfs_fattr
Date:   Mon, 11 Nov 2019 21:16:23 +0100
Message-Id: <20191111201639.2240623-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bTNrHmlRSCS7Q648x/nXsNVWZf0YT/n2OGvDzscLgX4gSTeyge1
 w8gtmIRNPUgf5rs+6/4kNaOmz8Uf3AdEMF6+1QNwZfINyzPK+rFsWreUzr422FFqxTy44bC
 eZyaE9JVzyc5IC43vw2m/FE4dq2PN9KwsX4W/A5g7x3gI9vMlpg+t6Vqtzlzmg7sUdo13wC
 YV/efwQJHoEty06eYF88Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tIP4F6BZVzI=:vCH++yVboML+CBdyouR+bS
 XWMX83JBpOCXkmlpQ2D2E0FXk5l4mctoJlkwzoJr2jLt1fI+h3D7iFb0ueuB0LwYTrQ3kAcsI
 BY3pUAZsGRAXlb2mLyfiGS18JANp+o6KqNq+zeqyqBLOBd6VtEAr3OskWJd+KFkeMBJznMmKR
 DqE7Qw3yawAdXTzWdfwKV3CIijDhzDVPJUWNhWdMtkBk85TY6zPKgp+R4gAaGFVM9YRrYYaIk
 i8+afFGdqYNTngoqDyqfK8VawghZaqYcqY5Iwjgc1DRpBenajC1JXwk//Sl2Zk3wQXsNwNN3L
 jjA+h8HZBli9le5VPyzkkuYpw/Hc+gcCTSDbIMDdb+rlSOs2IEOsPKOUCfMEm4bouYwkAPCVL
 EWs65dTfFScE046oVM/XuWfhMCyUgUGYGICaIRwxpZ7Ep9hyRfV1ULU+gKiAn1f0LwyOp4dwY
 QcBYp+TbxVwvFTZdAzswsNuXRT+UUsClNmxkNuyiVgn5lWqNR3VU3yO/ULKIR07O+ojtWBH1K
 ORbNu56gccrwFyQra8cyby3dB8sy8LlhHk8U1X5uvdQhkblTYnkUuf70/rGwzKpz3fuM+f82z
 jru9dmvFLQMINvJypMXKxQvJV1H1XBmQ5Tip0F07NINAQmkOvyTfoMZDyGwHLcqoRR0nx7n4g
 wyeQwVQy18EyRgzWAqNVH16zB/ODhsJQy3a8PNgexqeHtFIl1l4rdRvVtY4vdHK2YXIwWh8mN
 ol02MD+XfNCxjIsiUQfQWQmSTG4I2PR/EWv2MD3SiYfYXwZDgc6D/F3XCfch6vGliJY8yNHpF
 +7UQtBOs+WTktlV+PVbqHnkRhPohVywLUDp5gPBVH5NjacznJx2Nk9PopfdW2OKGoHlzk6OER
 1v2GAaLpHDopAyH0P5tw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Push down the use of timespec64 into NFS nfs_fattr, to avoid needless
conversions, and get closer to having 64-bit time_t support on 32-bit
NFSv4 and removing some old interfaces from the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/inode.c            | 54 +++++++++++++++++++--------------------
 fs/nfs/internal.h         |  6 ++---
 fs/nfs/nfs2xdr.c          |  2 +-
 fs/nfs/nfs3xdr.c          |  2 +-
 fs/nfs/nfs4xdr.c          | 24 ++++++++---------
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 12 ++++-----
 7 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 2a03bfeec10a..b0b4b9f303fd 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -504,15 +504,15 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		nfsi->read_cache_jiffies = fattr->time_start;
 		nfsi->attr_gencount = fattr->gencount;
 		if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-			inode->i_atime = timespec_to_timespec64(fattr->atime);
+			inode->i_atime = fattr->atime;
 		else if (nfs_server_capable(inode, NFS_CAP_ATIME))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 		if (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			inode->i_mtime = timespec_to_timespec64(fattr->mtime);
+			inode->i_mtime = fattr->mtime;
 		else if (nfs_server_capable(inode, NFS_CAP_MTIME))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = timespec_to_timespec64(fattr->ctime);
+			inode->i_ctime = fattr->ctime;
 		else if (nfs_server_capable(inode, NFS_CAP_CTIME))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
@@ -698,7 +698,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		if ((attr->ia_valid & ATTR_GID) != 0)
 			inode->i_gid = attr->ia_gid;
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = timespec_to_timespec64(fattr->ctime);
+			inode->i_ctime = fattr->ctime;
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -709,14 +709,14 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_ATIME
 				| NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-			inode->i_atime = timespec_to_timespec64(fattr->atime);
+			inode->i_atime = fattr->atime;
 		else if (attr->ia_valid & ATTR_ATIME_SET)
 			inode->i_atime = attr->ia_atime;
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = timespec_to_timespec64(fattr->ctime);
+			inode->i_ctime = fattr->ctime;
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -725,14 +725,14 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_MTIME
 				| NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			inode->i_mtime = timespec_to_timespec64(fattr->mtime);
+			inode->i_mtime = fattr->mtime;
 		else if (attr->ia_valid & ATTR_MTIME_SET)
 			inode->i_mtime = attr->ia_mtime;
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = timespec_to_timespec64(fattr->ctime);
+			inode->i_ctime = fattr->ctime;
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -1351,7 +1351,7 @@ static bool nfs_file_has_buffered_writers(struct nfs_inode *nfsi)
 
 static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECHANGE)
 			&& (fattr->valid & NFS_ATTR_FATTR_CHANGE)
@@ -1361,18 +1361,18 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
-	ts = timespec64_to_timespec(inode->i_ctime);
+	ts = inode->i_ctime;
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			&& timespec_equal(&ts, &fattr->pre_ctime)) {
-		inode->i_ctime = timespec_to_timespec64(fattr->ctime);
+			&& timespec64_equal(&ts, &fattr->pre_ctime)) {
+		inode->i_ctime = fattr->ctime;
 	}
 
-	ts = timespec64_to_timespec(inode->i_mtime);
+	ts = inode->i_mtime;
 	if ((fattr->valid & NFS_ATTR_FATTR_PREMTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			&& timespec_equal(&ts, &fattr->pre_mtime)) {
-		inode->i_mtime = timespec_to_timespec64(fattr->mtime);
+			&& timespec64_equal(&ts, &fattr->pre_mtime)) {
+		inode->i_mtime = fattr->mtime;
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 	}
@@ -1398,7 +1398,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t cur_size, new_isize;
 	unsigned long invalid = 0;
-	struct timespec ts;
+	struct timespec64 ts;
 
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		return 0;
@@ -1425,12 +1425,12 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 			invalid |= NFS_INO_INVALID_CHANGE
 				| NFS_INO_REVAL_PAGECACHE;
 
-		ts = timespec64_to_timespec(inode->i_mtime);
-		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec_equal(&ts, &fattr->mtime))
+		ts = inode->i_mtime;
+		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec64_equal(&ts, &fattr->mtime))
 			invalid |= NFS_INO_INVALID_MTIME;
 
-		ts = timespec64_to_timespec(inode->i_ctime);
-		if ((fattr->valid & NFS_ATTR_FATTR_CTIME) && !timespec_equal(&ts, &fattr->ctime))
+		ts = inode->i_ctime;
+		if ((fattr->valid & NFS_ATTR_FATTR_CTIME) && !timespec64_equal(&ts, &fattr->ctime))
 			invalid |= NFS_INO_INVALID_CTIME;
 
 		if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
@@ -1460,8 +1460,8 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if ((fattr->valid & NFS_ATTR_FATTR_NLINK) && inode->i_nlink != fattr->nlink)
 		invalid |= NFS_INO_INVALID_OTHER;
 
-	ts = timespec64_to_timespec(inode->i_atime);
-	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec_equal(&ts, &fattr->atime))
+	ts = inode->i_atime;
+	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec64_equal(&ts, &fattr->atime))
 		invalid |= NFS_INO_INVALID_ATIME;
 
 	if (invalid != 0)
@@ -1733,12 +1733,12 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_CTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PRECTIME) == 0) {
-		fattr->pre_ctime = timespec64_to_timespec(inode->i_ctime);
+		fattr->pre_ctime = inode->i_ctime;
 		fattr->valid |= NFS_ATTR_FATTR_PRECTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_MTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PREMTIME) == 0) {
-		fattr->pre_mtime = timespec64_to_timespec(inode->i_mtime);
+		fattr->pre_mtime = inode->i_mtime;
 		fattr->valid |= NFS_ATTR_FATTR_PREMTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_SIZE) != 0 &&
@@ -1899,7 +1899,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_MTIME) {
-		inode->i_mtime = timespec_to_timespec64(fattr->mtime);
+		inode->i_mtime = fattr->mtime;
 	} else if (server->caps & NFS_CAP_MTIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_MTIME
@@ -1908,7 +1908,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME) {
-		inode->i_ctime = timespec_to_timespec64(fattr->ctime);
+		inode->i_ctime = fattr->ctime;
 	} else if (server->caps & NFS_CAP_CTIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_CTIME
@@ -1946,7 +1946,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-		inode->i_atime = timespec_to_timespec64(fattr->atime);
+		inode->i_atime = fattr->atime;
 	else if (server->caps & NFS_CAP_ATIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_ATIME
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 447a3c17fa8e..d3d3a9a0aa72 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -706,14 +706,14 @@ unsigned int nfs_page_array_len(unsigned int base, size_t len)
 }
 
 /*
- * Convert a struct timespec into a 64-bit change attribute
+ * Convert a struct timespec64 into a 64-bit change attribute
  *
- * This does approximately the same thing as timespec_to_ns(),
+ * This does approximately the same thing as timespec64_to_ns(),
  * but for calculation efficiency, we multiply the seconds by
  * 1024*1024*1024.
  */
 static inline
-u64 nfs_timespec_to_change_attr(const struct timespec *ts)
+u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
 {
 	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
 }
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index cbc17a203248..d4e144712034 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -234,7 +234,7 @@ static __be32 *xdr_encode_current_server_time(__be32 *p,
 	return p;
 }
 
-static __be32 *xdr_decode_time(__be32 *p, struct timespec *timep)
+static __be32 *xdr_decode_time(__be32 *p, struct timespec64 *timep)
 {
 	timep->tv_sec = be32_to_cpup(p++);
 	timep->tv_nsec = be32_to_cpup(p++) * NSEC_PER_USEC;
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 602767850b36..2a16bbda3937 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -463,7 +463,7 @@ static __be32 *xdr_encode_nfstime3(__be32 *p, const struct timespec *timep)
 	return p;
 }
 
-static __be32 *xdr_decode_nfstime3(__be32 *p, struct timespec *timep)
+static __be32 *xdr_decode_nfstime3(__be32 *p, struct timespec64 *timep)
 {
 	timep->tv_sec = be32_to_cpup(p++);
 	timep->tv_nsec = be32_to_cpup(p++);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index ab07db0f07cd..c917fb24c56f 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4065,17 +4065,17 @@ static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint
 }
 
 static __be32 *
-xdr_decode_nfstime4(__be32 *p, struct timespec *t)
+xdr_decode_nfstime4(__be32 *p, struct timespec64 *t)
 {
 	__u64 sec;
 
 	p = xdr_decode_hyper(p, &sec);
-	t-> tv_sec = (time_t)sec;
+	t-> tv_sec = sec;
 	t->tv_nsec = be32_to_cpup(p++);
 	return p;
 }
 
-static int decode_attr_time(struct xdr_stream *xdr, struct timespec *time)
+static int decode_attr_time(struct xdr_stream *xdr, struct timespec64 *time)
 {
 	__be32 *p;
 
@@ -4086,7 +4086,7 @@ static int decode_attr_time(struct xdr_stream *xdr, struct timespec *time)
 	return 0;
 }
 
-static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
+static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
 {
 	int status = 0;
 
@@ -4100,11 +4100,11 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
 			status = NFS_ATTR_FATTR_ATIME;
 		bitmap[1] &= ~FATTR4_WORD1_TIME_ACCESS;
 	}
-	dprintk("%s: atime=%ld\n", __func__, (long)time->tv_sec);
+	dprintk("%s: atime=%lld\n", __func__, time->tv_sec);
 	return status;
 }
 
-static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
+static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
 {
 	int status = 0;
 
@@ -4118,12 +4118,12 @@ static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *bitmap, s
 			status = NFS_ATTR_FATTR_CTIME;
 		bitmap[1] &= ~FATTR4_WORD1_TIME_METADATA;
 	}
-	dprintk("%s: ctime=%ld\n", __func__, (long)time->tv_sec);
+	dprintk("%s: ctime=%lld\n", __func__, time->tv_sec);
 	return status;
 }
 
 static int decode_attr_time_delta(struct xdr_stream *xdr, uint32_t *bitmap,
-				  struct timespec *time)
+				  struct timespec64 *time)
 {
 	int status = 0;
 
@@ -4135,8 +4135,8 @@ static int decode_attr_time_delta(struct xdr_stream *xdr, uint32_t *bitmap,
 		status = decode_attr_time(xdr, time);
 		bitmap[1] &= ~FATTR4_WORD1_TIME_DELTA;
 	}
-	dprintk("%s: time_delta=%ld %ld\n", __func__, (long)time->tv_sec,
-		(long)time->tv_nsec);
+	dprintk("%s: time_delta=%lld %ld\n", __func__, time->tv_sec,
+		time->tv_nsec);
 	return status;
 }
 
@@ -4186,7 +4186,7 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 	return status;
 }
 
-static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
+static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
 {
 	int status = 0;
 
@@ -4200,7 +4200,7 @@ static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, str
 			status = NFS_ATTR_FATTR_MTIME;
 		bitmap[1] &= ~FATTR4_WORD1_TIME_MODIFY;
 	}
-	dprintk("%s: mtime=%ld\n", __func__, (long)time->tv_sec);
+	dprintk("%s: mtime=%lld\n", __func__, time->tv_sec);
 	return status;
 }
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a87fe854f008..47266870a235 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -171,7 +171,7 @@ struct nfs_server {
 
 	struct nfs_fsid		fsid;
 	__u64			maxfilesize;	/* maximum file size */
-	struct timespec		time_delta;	/* smallest time granularity */
+	struct timespec64	time_delta;	/* smallest time granularity */
 	unsigned long		mount_time;	/* when this fs was mounted */
 	struct super_block	*super;		/* VFS super block */
 	dev_t			s_dev;		/* superblock dev numbers */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9b8324ec08f3..db5c01001937 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -62,14 +62,14 @@ struct nfs_fattr {
 	struct nfs_fsid		fsid;
 	__u64			fileid;
 	__u64			mounted_on_fileid;
-	struct timespec		atime;
-	struct timespec		mtime;
-	struct timespec		ctime;
+	struct timespec64	atime;
+	struct timespec64	mtime;
+	struct timespec64	ctime;
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
 	__u64			pre_size;	/* pre_op_attr.size	  */
-	struct timespec		pre_mtime;	/* pre_op_attr.mtime	  */
-	struct timespec		pre_ctime;	/* pre_op_attr.ctime	  */
+	struct timespec64	pre_mtime;	/* pre_op_attr.mtime	  */
+	struct timespec64	pre_ctime;	/* pre_op_attr.ctime	  */
 	unsigned long		time_start;
 	unsigned long		gencount;
 	struct nfs4_string	*owner_name;
@@ -143,7 +143,7 @@ struct nfs_fsinfo {
 	__u32			wtmult;	/* writes should be multiple of this */
 	__u32			dtpref;	/* pref. readdir transfer size */
 	__u64			maxfilesize;
-	struct timespec		time_delta; /* server time granularity */
+	struct timespec64	time_delta; /* server time granularity */
 	__u32			lease_time; /* in seconds */
 	__u32			nlayouttypes; /* number of layouttypes */
 	__u32			layouttype[NFS_MAX_LAYOUT_TYPES]; /* supported pnfs layout driver */
-- 
2.20.0

