Return-Path: <linux-fsdevel+bounces-27744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CCB9637EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D12856BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755622EE8;
	Thu, 29 Aug 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB/ZMyMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958918814;
	Thu, 29 Aug 2024 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895952; cv=none; b=sb5Ml3ppeEmHhP91tn9wzbY9VC08zj67BZfN+/LsLP+oZl5YQhufbU1KnmHTBlsbbm+zbUWZFTPiSHJOGq1kxgZTjJmJbc9Z2YG965YEqtqSpzqY8i7Z75ddVhDQLOHL8kV/+yRTsEDfowvy69QRHbL0IqpuKr0eqnTNnNIfbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895952; c=relaxed/simple;
	bh=3FN+xuCvc7oAb/hr/1VW8Ba4X/7xAn/7Y4bWZkEhxxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCM8iWN3tfb3oxwBC/Pkl1L78HoeA6cowJ8At9J7aqDjCDb/cqe0MGcbfDYq+hypYqDuJW3O8l8SmaV0rrDU3joiROl47CzU6mh4tAIKjGdt+Akljf2MUNteIzxUK6byXrnHdmEeC27V5L0VMxSqGoHfSU8Nr3i5hJ8+PW8flAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB/ZMyMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDD1C4CEC0;
	Thu, 29 Aug 2024 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895952;
	bh=3FN+xuCvc7oAb/hr/1VW8Ba4X/7xAn/7Y4bWZkEhxxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AB/ZMyMHhskXSJu+gPQsMYB3hAXB2C5foos1XDia4RcDInSdDBmBjtg4eh2xpBORK
	 cOR9RmMYUktMISIYQT9RYDwRTXAe2ey60Zqhj16+gZiYzi2imIDxROfe/WNwU/Q2Cx
	 v2RcPoILQV6571Ve8ml+3V3BsI0aPShcxUTvIuR9UaF8I12hndd8/iS2Ds7tgEhME5
	 g7kKCjlql71yAAM0ti2fzGsqzRIwjjqAfWgZR8QDPoZpm2rU2F1dIn74WkdyK0jpJL
	 zk2kcdnXZfnPnbVHTAoB5t65Lia7rrFHjRlMiiZ2kt7CIEtBDAzAC3Khr3jWrStafy
	 iC2vCPt8Gl4Lg==
Date: Wed, 28 Aug 2024 21:45:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14.5 06/25] NFSD: Avoid using rqstp->rq_vers in
 nfsd_set_fh_dentry()
Message-ID: <Zs_Szu3RF5UpVXm6@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-7-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010424.83693-7-snitzer@kernel.org>

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


