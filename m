Return-Path: <linux-fsdevel+bounces-28116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471A9673A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C98B21CD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CED17CA1F;
	Sat, 31 Aug 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRWxvwyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111E17B519;
	Sat, 31 Aug 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143884; cv=none; b=t0whsuvOdlM9Lf2H46fTwt45yxSWQ3f0FdqYpn2lKsI2Czpva/fQ4TMDng/O49M2p+8bzsznWJaT4E9sfFm21JmzUKkEYwQAnDgVOlBkppnS3++6fD0eenERzsFMrLknhBlfCYrDF6GpoMCx5MyPZ8FWFPaJCfaXAKlx7uiEg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143884; c=relaxed/simple;
	bh=hk6mjosm3ciKUwEMdJLeRW78KGkToFOd8ck8wtX+LqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5ZXOSKALarXfcnT7gkGpvid7zM94RB+h9Ry8u4+VigzC1Vqz+V8XmeIXzJEgCFcDozM6yC4ClrqjyNcZtDXdZuWE9O83QQpbNWDz5e3be9OXqZHjCZEPkdTuGtaHWN77Qy7pP4//AYK2s3fJ1zBRw1ufhfPfI30MUnFRH2U4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRWxvwyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F5C4CEC0;
	Sat, 31 Aug 2024 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143884;
	bh=hk6mjosm3ciKUwEMdJLeRW78KGkToFOd8ck8wtX+LqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRWxvwynK4YW8eSuiWFLq5Me1E2KCwcLviyVOOOEYiu/XCZaGX4dSlE5zuE8tQy15
	 jrR/EidZBafe9rXL3Sak4UBDxQfd4wXzg9DDntOARO89oZDsz2xaDmW8PXYHEH25Cq
	 IUlkAwq6rFERWHJo9Wb/GhElrAYFbLwieZZJB3f2ldF/HzsDr/+SsA9e15HrPSOGzf
	 OX+Pg4aHba1YrOElDih2ggRBAxEY59fzPccajV73Dza6o0zXKzCyXumrteZ2Y0+I6l
	 z+4mKNJegAJsVZPDLaNs1SzcOmtk3Cis6ymKUk+MuEjB6cK1N2hw2J89gEY9tu8ii9
	 FfCSitAfaVa6g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 06/26] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
Date: Sat, 31 Aug 2024 18:37:26 -0400
Message-ID: <20240831223755.8569-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
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

The file handle used by lockd and the one created by write_filehandle
never need any of the version-specific fields (which affect things
like write and getattr requests and pre/post attributes).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4b964a71a504..60c2395d7af7 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -267,20 +267,20 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
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
-- 
2.44.0


