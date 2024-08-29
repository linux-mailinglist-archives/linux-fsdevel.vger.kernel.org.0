Return-Path: <linux-fsdevel+bounces-27835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E99646AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064AAB2B164
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185101B012C;
	Thu, 29 Aug 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb4KzafM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895C1B010C;
	Thu, 29 Aug 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938017; cv=none; b=DyAzbkax+MYpSIXMOjHhd4g1+0Y368ZwbHP7vTP5STLCJO5xTq92vvqeiLmxzZkIKohxn81VEGgT6p2pKc//3d/Owfy3iuEEU2XMd8BXiPVQQ+hJrJ/wpyzLCz4X2Qz6g0E1knZ+gjedyaohl752rSDnOnRIYJnIptAUxZFJVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938017; c=relaxed/simple;
	bh=MaWMQrP354gSUdJLpaSky0LlkGF4b0/cV4bjc3uboH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eE0/sP3hm7nFCkZ5YBgu8vJ/6xIBunmjxHPseLWDQOwmqip4rKwejSwqjy0nB9qHmiOrsUTS/dBzsOPnorPHShQRtcLu5jC5vMNwNb6HrJLLSPQto0lhe+wY5AbBwhKWMUtM5MnxRZ7p/mUK6rrx7je+LRK/pBjwiDDEb4Yk3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb4KzafM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88830C4CECA;
	Thu, 29 Aug 2024 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938017;
	bh=MaWMQrP354gSUdJLpaSky0LlkGF4b0/cV4bjc3uboH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cb4KzafM1tnmU6Ky3PFc2+nIpGAdE1MvHF2vQ+j+5WcfTWGqTAGWhWZtWowNB4Ppt
	 pkWPC6OspqF9KRBoofvpxTX9bXeipHwVGrXMa4HIU4wmMCoknZSLQZx6TuUxzSOGhG
	 uIdc4VhpK8mpM/reWzOCn9trqw18TlGyaAotYKLc/f+k2QmdLk4zv3GscCLZ9Vu71p
	 iEe5wDPW6mjIgnQD/ewbU4myD4q3x7dVjcM0LXFvieKHRgjOjYwk01vf+d1Z4hVATj
	 0bVNpaI+itQoYGgqaQk15xS4CvSKM3f6+B88llEz7C/LsHuapHQ8hLYW00/g/KHDfp
	 IGhgr47y06/qQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:42 -0400
Subject: [PATCH v3 04/13] nfsd: drop the nfsd4_fattr_args "size" field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-4-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MaWMQrP354gSUdJLpaSky0LlkGF4b0/cV4bjc3uboH8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcXp7eEVqWw9rNJfgR+aDv5hXH8B/9mDXh6+
 GpPWUAxqSKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 Fa/JD/4r7w+jyYm3ge5G+roPkaKwtSgsDJi5/mlsIaKhiNYLCHgoKaK5qC+lG2OPxwrBLUmj689
 gQHeG9BRI8bhsMw+PnMgT5DFfo3v4w2R2jZv2tKzL+fravAb8HiHWhqOmj6ZsJBEI+knRG1ZGAf
 iY2+74GUt1x1QEgg6o2WXfVY6p4GHFk6SpFaiRhKBKNiyPfyQNToRIQNi5IOkKj3W4+3s8aGHq0
 Fhy7HSgijngT+Tav/s3DcSjFojVWfCkKgikguD6Pqb4d/lMStDu/bVfH1PhnyHCDKHbZIDPKI7k
 PngKpQ/Ho08iveBrf1fc8z38vmbeIVCcuBs5d+6oqN65DFuF+OcPZRHkIWvG8qtrJqp34rON70x
 uD+emCOXX6quaB1qy6WqdR/e/lhCRB7+N7oqHmKTohNVqz9f/pNVrOr/HBoY098s6gqf93P53lH
 4aBYkQUi5sl/P9ElqBpVJM9uFI0VqzccdZxMXcOFtbzRbpeUy+4eF+k9xxWdQHQ8gaKcAiXrSte
 N3C2ob/fcWY4vkcnGInykKYtiEOlvhoYyRRArQ0bfRE5X2o3PLlNMlzs1BSDWAEBEbbFJ64wvUa
 fmQaevKnxYQhGxFkLjfmNmFj/nGKHN/Q8aNU/a70PWIDGrbyWroO7arEu5MpeZPRYkx/vIQ4xqJ
 rlm2gtkIjIuYxPQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We already have a slot for this in the kstat structure. Just overwrite
that instead of keeping a copy.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f118921250c3..d028daf77549 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2928,7 +2928,6 @@ struct nfsd4_fattr_args {
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
-	u64			size;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void			*context;
 	int			contextlen;
@@ -3047,7 +3046,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
 				       const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_uint64_t(xdr, args->size);
+	return nfsd4_encode_uint64_t(xdr, args->stat.size);
 }
 
 static __be32 nfsd4_encode_fattr4_fsid(struct xdr_stream *xdr,
@@ -3555,7 +3554,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (status)
 			goto out;
 	}
-	args.size = 0;
 	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
 		status = nfsd4_deleg_getattr_conflict(rqstp, dentry,
 					&file_modified, &size);
@@ -3569,9 +3567,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	if (err)
 		goto out_nfserr;
 	if (file_modified)
-		args.size = size;
-	else
-		args.size = args.stat.size;
+		args.stat.size = size;
 
 	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */

-- 
2.46.0


