Return-Path: <linux-fsdevel+bounces-27719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97BF96375A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E811C21FDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4094437F;
	Thu, 29 Aug 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiJguAmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909440870;
	Thu, 29 Aug 2024 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893474; cv=none; b=NzRJCVG6lB1ppA5+//T//kiyA1zB265utc8q+6HI7Thb1iYTPGj/SgXnhMkiYGnsM0V69z5py7wOYvN87N4SfvjpeLqVXtPGrtzgu9IVA0iTY7hbvNfaTKfmqqFpG4fNvx4SnSCBImucTHyV/cHByUyRwy4gap8xF7MF8pHHq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893474; c=relaxed/simple;
	bh=Dc0oJGBoYQSavsknB2y9NURE9l5qz8BzTyrkWqPgnpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHPnS/HTU+hHfRTOJcWwVbK90ehOmjEi1sH3quwGKDPeCuvkYbw3CcdNSY45d1DcYX6qWNYrbv2hLualktKt6C6qFWadBHMNpNdDAClx31gibcLL/mjENRJvkf/XRBK+nPEl3TFTNSoQhWTy47AWhkWDZxPtoU0Z+ZMNydnH9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiJguAmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E4FC4CED0;
	Thu, 29 Aug 2024 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893473;
	bh=Dc0oJGBoYQSavsknB2y9NURE9l5qz8BzTyrkWqPgnpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiJguAmMqi2BBYTKZDW3+u0/FxoL48H+zO1BkaKu9ZUp/UyB6Vc7QJEJ/c+R3lQEP
	 lCv42IoFMelceoZplGekChYmtFe7l5DrNUsyc1FHteQXUiDivgS8qTZHg7psX2B7V2
	 NqpgPpPuZbDej2j9nCrRYZo6GlaaLlND0UE09xpQQUjj4Og1PNUqbvrQBQEgi2oeJY
	 s2kNo9TT1Xrm9+OUWTuDWlfKPoaCU3pX+W5LR/uzw2p7Hgiblwhtzf0Lq2yAyPMPSR
	 F3zv52VHykw/4lUbRgXRCGMe2Z1UPY2H2cqJ6Z50E74quR6U7d1JQA+oV3M/XLeCj2
	 h6kIJMP8PbSNA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 06/25] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
Date: Wed, 28 Aug 2024 21:04:01 -0400
Message-ID: <20240829010424.83693-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Currently, fh_verify() makes some daring assumptions about which
version of file handle the caller wants, based on the things it can
find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
case sometimes has no svc_rqst context, so this logic won't work in
that case.

Instead, examine the passed-in file handle. It's .max_size field
should carry information to allow nfsd_set_fh_dentry() to initialize
the file handle appropriately.

lockd appears to be the only kernel consumer that does not set the
file handle .max_size during initialization.

write_filehandle() is the other question mark, as it looks possible
to specify a maxsize between NFS_FHSIZE and NFS3_FHSIZE here.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/lockd.c |  6 ++++--
 fs/nfsd/nfsfh.c | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e5..e636d2a1e664 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -32,8 +32,10 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	int		access;
 	struct svc_fh	fh;
 
-	/* must initialize before using! but maxsize doesn't matter */
-	fh_init(&fh,0);
+	if (rqstp->rq_vers == 4)
+		fh_init(&fh, NFS3_FHSIZE);
+	else
+		fh_init(&fh, NFS_FHSIZE);
 	fh.fh_handle.fh_size = f->size;
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export = NULL;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4b964a71a504..77acc26e8b02 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -267,25 +267,28 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
 
-	switch (rqstp->rq_vers) {
-	case 4:
+	switch (fhp->fh_maxsize) {
+	case NFS4_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
 			fhp->fh_no_atomic_attr = true;
 		fhp->fh_64bit_cookies = true;
 		break;
-	case 3:
+	case NFS3_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
 			fhp->fh_no_wcc = true;
 		fhp->fh_64bit_cookies = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
 			goto out;
 		break;
-	case 2:
+	case NFS_FHSIZE:
 		fhp->fh_no_wcc = true;
 		if (EX_WGATHER(exp))
 			fhp->fh_use_wgather = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
 			goto out;
+		break;
+	case 0:
+		WARN_ONCE(1, "Uninitialized file handle");
 	}
 
 	return 0;
-- 
2.44.0


