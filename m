Return-Path: <linux-fsdevel+bounces-51200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9AAD4441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856233A574B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA0267B9D;
	Tue, 10 Jun 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maO8fFPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAB266EFE;
	Tue, 10 Jun 2025 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589067; cv=none; b=Ug2cUehiYrTPBnfLuMByiIf/ae9M3o3hgEw8hSA7LAeh986+QdiRpzb3EtSnx4OvGrxtoTzXAs0VAlCJLRuRiLl/JRXnrpaVA3Lim8HD87pFMKpL7oHZucQF9zDN+rgZrsuXWq2kMY80MAD1ECWhmieyNt2NjQC2Q3Q41vyT3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589067; c=relaxed/simple;
	bh=L4inXQyjYY89XK7jUp9uIXvRl4Ssi1rNEyggopiuO44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1rQA/ckQTsbwzJUA2nmMLjKKSSaCH4OZxKn55GYMts1vz4cpTbcoB+DdRsQXISf8IkjDCLkLdZg1PwFN1Y7rc3o7H8OuEt5H0v/r1a2kfgiDfjmvN6yVFniLn0MdVese3a93VIOU0WBGLbg8vh2AXbYuAvHR2laCslLfO/ylyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maO8fFPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B4C4CEF3;
	Tue, 10 Jun 2025 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589065;
	bh=L4inXQyjYY89XK7jUp9uIXvRl4Ssi1rNEyggopiuO44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maO8fFPl9QHEKcLshvm56jaLvejkzV/9e4ZNL5JFoIAa/JrrVJe6b/vYPmq9FO1JL
	 iNVmyXq268J46EH2fxXsSWAHOMySY9ptIyyGFb0HOZuRBbJ0Pn/QP/UBIeV2hJ/h+m
	 A6170LaEKZIEBDsMBh49m8EVrhoId1CI6H+x160yIMXpX4g67OgwKdsbDfZZ/K3ek6
	 ea6vT3yqgiRWYAmrlTA+kbfqmHOFPM0OspHLKoHVMSjCcij6BJE+VJxiYlTUtG5BNF
	 4iLFvVtJkd8pyx9uU4rcw6B8QDKWB3e8OQ7c7n1dTUit7ZXgstEbevGS/jk+4o4S/t
	 HUQjT6JhHLxXg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue O_DIRECT reads and writes
Date: Tue, 10 Jun 2025 16:57:36 -0400
Message-ID: <20250610205737.63343-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250610205737.63343-1-snitzer@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IO must be aligned, otherwise it falls back to using buffered IO.

RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
nfsd/enable-dontcache=1) because it works against us (due to RMW
needing to read without benefit of cache), whereas buffered IO enables
misaligned IO to be more performant.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e7cc8c6dfbad..a942609e3ab9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1064,6 +1064,22 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
+static bool is_dio_aligned(const struct iov_iter *iter, loff_t offset,
+			   const u32 blocksize)
+{
+	u32 blocksize_mask;
+
+	if (!blocksize)
+		return false;
+
+	blocksize_mask = blocksize - 1;
+	if ((offset & blocksize_mask) ||
+	    (iov_iter_alignment(iter) & blocksize_mask))
+		return false;
+
+	return true;
+}
+
 /**
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
@@ -1107,8 +1123,16 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
 
-	if (nfsd_enable_dontcache)
-		flags |= RWF_DONTCACHE;
+	if (nfsd_enable_dontcache) {
+		if (is_dio_aligned(&iter, offset, nf->nf_dio_read_offset_align))
+			flags |= RWF_DIRECT;
+		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
+		 * against us (due to RMW needing to read without benefit of cache),
+		 * whereas buffered IO enables misaligned IO to be more performant.
+		 */
+		//else
+		//	flags |= RWF_DONTCACHE;
+	}
 
 	host_err = vfs_iter_read(file, &iter, &ppos, flags);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
@@ -1217,8 +1241,16 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 
-	if (nfsd_enable_dontcache)
-		flags |= RWF_DONTCACHE;
+	if (nfsd_enable_dontcache) {
+		if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align))
+			flags |= RWF_DIRECT;
+		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
+		 * against us (due to RMW needing to read without benefit of cache),
+		 * whereas buffered IO enables misaligned IO to be more performant.
+		 */
+		//else
+		//	flags |= RWF_DONTCACHE;
+	}
 
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
-- 
2.44.0


