Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2749E713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiA0QIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:08:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiA0QIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:08:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF62FB8018A;
        Thu, 27 Jan 2022 16:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BCFC340E4;
        Thu, 27 Jan 2022 16:08:45 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 3/6] NFSD: COMMIT operations must not return NFS?ERR_INVAL
Date:   Thu, 27 Jan 2022 11:08:44 -0500
Message-Id:  <164329972435.5879.13150991880289153111.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5689; h=from:subject:message-id; bh=tNAgDnoTq2BU4fHER56wSNp8P3VTE6ie3pIbOrhmBvM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sOMRdtf4Q6WSvZZxV3Cu7tyJbR9xNUIZiQPnwxH ePxhd02JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDjAAKCRAzarMzb2Z/l+pLEA DCZRQpbcAAPg7o+VRdWL1BptDJJW9jNPb7KvKLDVm61ZtEM89QAF0YoDiYILlu9VliBziU23lRAS62 aFmjT5lpGB6kMqwIM09/OHtusuL0cxeRc72GE5aZPCM+QCdFX9Xlps30x7y/MPK2AQnhcIoPXrKqui qN5DZ29rTJvQBmnHGwiQwEIng7Bn0l6LMYYPG1FaHhEJkUFeaufKkYHzbm7BIZEpufBkqP3dk3rxtU LdsCp7hnMuMkzL9jCq+VAB6ULHX4/Qks6gN7gfttF/ek/qzC+NoWdM8M0X2KI6i7XpO6jrHpkpX9mn C/XFQtxWoxJGMUslyceBur54ffwaSZW/616azixoE5ebOBu9HRDZzdAR9eqv/Kdm8HKf3TOUyRMkO7 EZf1AdbZJRlIOBM8nt9sOozYQZNwcaIhNKDZaAG6qlsa1R/51u+OdXg+rWFQT1Pmmmnmdu13rbz8LB i2xoUpWZwtmlZggXYKxfejH76PY64gsRKVK4Mg9WihCrqpYVycT+/6O+5BUmbMQrf10NfzPgMUzzpu qoEL7sTAklGhf9Rdud1wCxLx3N+BiU/fboryUE1H9WTSOtr1z+7DsXyZf/5Fen7KRKl09cNrEF2gX2 YEVE1x5JcKKaJ9a8S5YfAxFHwJ8Yc5aWiD/UtPelXtX2T2XMk4qLmu9XhebA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since, well, forever, the Linux NFS server's nfsd_commit() function
has returned nfserr_inval when the passed-in byte range arguments
were non-sensical.

However, according to RFC 1813 section 3.3.21, NFSv3 COMMIT requests
are permitted to return only the following non-zero status codes:

      NFS3ERR_IO
      NFS3ERR_STALE
      NFS3ERR_BADHANDLE
      NFS3ERR_SERVERFAULT

NFS3ERR_INVAL is not included in that list. Likewise, NFS4ERR_INVAL
is not listed in the COMMIT row of Table 6 in RFC 8881.

Instead of dropping or failing a COMMIT request in a byte range that
is not supported, turn it into a valid request by treating one or
both arguments as zero. Offset zero means start-of-file, count zero
means until-end-of-file, so we only ever extend the commit range.
NFS servers are always allowed to commit more and sooner than
requested.

The range check is no longer bounded by NFS_OFFSET_MAX, but rather
by the value that is returned in the maxfilesize field of the NFSv3
FSINFO procedure or the NFSv4 maxfilesize file attribute.

Note that this change results in a new pynfs failure:

CMT4     st_commit.testCommitOverflow                             : RUNNING
CMT4     st_commit.testCommitOverflow                             : FAILURE
           COMMIT with offset + count overflow should return
           NFS4ERR_INVAL, instead got NFS4_OK

IMO the test is not correct as written: RFC 8881 does not allow the
COMMIT operation to return NFS4ERR_INVAL.

Reported-by: Dan Aloni <dan.aloni@vastdata.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    6 ------
 fs/nfsd/vfs.c      |   53 +++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/vfs.h      |    4 ++--
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index aa0f0261ddac..7bca219a8146 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -668,15 +668,9 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				argp->count,
 				(unsigned long long) argp->offset);
 
-	if (argp->offset > NFS_OFFSET_MAX) {
-		resp->status = nfserr_inval;
-		goto out;
-	}
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
 				   argp->count, resp->verf);
-out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 99c2b9dfbb10..f9f72b1ecb73 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1110,42 +1110,61 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 }
 
 #ifdef CONFIG_NFSD_V3
-/*
- * Commit all pending writes to stable storage.
+/**
+ * nfsd_commit - Commit pending writes to stable storage
+ * @rqstp: RPC request being processed
+ * @fhp: NFS filehandle
+ * @offset: raw offset from beginning of file
+ * @count: raw count of bytes to sync
+ * @verf: filled in with the server's current write verifier
  *
- * Note: we only guarantee that data that lies within the range specified
- * by the 'offset' and 'count' parameters will be synced.
+ * Note: we guarantee that data that lies within the range specified
+ * by the 'offset' and 'count' parameters will be synced. The server
+ * is permitted to sync data that lies outside this range at the
+ * same time.
  *
  * Unfortunately we cannot lock the file to make sure we return full WCC
  * data to the client, as locking happens lower down in the filesystem.
+ *
+ * Return values:
+ *   An nfsstat value in network byte order.
  */
 __be32
-nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
-               loff_t offset, unsigned long count, __be32 *verf)
+nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
+	    u32 count, __be32 *verf)
 {
+	u64			maxbytes;
+	loff_t			start, end;
 	struct nfsd_net		*nn;
 	struct nfsd_file	*nf;
-	loff_t			end = LLONG_MAX;
-	__be32			err = nfserr_inval;
-
-	if (offset < 0)
-		goto out;
-	if (count != 0) {
-		end = offset + (loff_t)count - 1;
-		if (end < offset)
-			goto out;
-	}
+	__be32			err;
 
 	err = nfsd_file_acquire(rqstp, fhp,
 			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
 	if (err)
 		goto out;
+
+	/*
+	 * Convert the client-provided (offset, count) range to a
+	 * (start, end) range. If the client-provided range falls
+	 * outside the maximum file size of the underlying FS,
+	 * clamp the sync range appropriately.
+	 */
+	start = 0;
+	end = LLONG_MAX;
+	maxbytes = (u64)fhp->fh_dentry->d_sb->s_maxbytes;
+	if (offset < maxbytes) {
+		start = offset;
+		if (count && (offset + count - 1 < maxbytes))
+			end = offset + count - 1;
+	}
+
 	nn = net_generic(nf->nf_net, nfsd_net_id);
 	if (EX_ISSYNC(fhp->fh_export)) {
 		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
 		int err2;
 
-		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
+		err2 = vfs_fsync_range(nf->nf_file, start, end, 0);
 		switch (err2) {
 		case 0:
 			nfsd_copy_write_verifier(verf, nn);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 9f56dcb22ff7..2c43d10e3cab 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -74,8 +74,8 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,
 				u32 *verifier, bool *truncp, bool *created);
-__be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
-				loff_t, unsigned long, __be32 *verf);
+__be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
+				u64 offset, u32 count, __be32 *verf);
 #endif /* CONFIG_NFSD_V3 */
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,

