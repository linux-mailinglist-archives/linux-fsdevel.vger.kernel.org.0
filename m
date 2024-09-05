Return-Path: <linux-fsdevel+bounces-28729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D096D8FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF031F2B0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57519E98F;
	Thu,  5 Sep 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyNI13fX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5D19E7FB;
	Thu,  5 Sep 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540125; cv=none; b=k5kdV8xL5NABx3b///tC1/Sj26ZtQgq9vTJ4qZrBW54W/TkGAjqTj28poLpiJJCplNQODqVSG6YqiwKzMNVGAAlHQCvkvKHqanyIv+/hVQTRxKewIHC0VkH1SWs//u2TLCc1zaOQw7J3NWIM142v4RCr/qtlNkXLm37gsP+gO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540125; c=relaxed/simple;
	bh=MaWMQrP354gSUdJLpaSky0LlkGF4b0/cV4bjc3uboH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDByds+QGwsWRyYZNfoCKtvylj12mImVQpEQKq7kcLUsV8V/f5VKD/A0q++hIecuF+hAaMA+Rj70DHIoahogEVA3HR5kMZzo9ocoyXiIwoe1M/R6byuyodbot4aAoAoFWro1iSPbUk155DRZH6cpo3q9d2aYHAIGjp2mHk3w34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyNI13fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300E2C4CEC4;
	Thu,  5 Sep 2024 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540125;
	bh=MaWMQrP354gSUdJLpaSky0LlkGF4b0/cV4bjc3uboH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KyNI13fXQtjZCPWWXW0Qzk8et/zqgQzb1i4z9IiQBmL6v0zaClOH9hDho/zFnNbHA
	 9w2r3IMMk0E4YRnIU3jJOuz69Wdw8Z8YjcCLfxXAuwLTUOwxiioDE4VMxVD4wamfcY
	 BaI8zL9Dy+X7T8QOr8JE5Mo1Nq90GuRsDI/iNPqUeucRAhkVwQB9l78GozlIG4BZvV
	 6uJLCZuAXnDJGMG+ewzhqxGI6HQAnPhNc19Jsk2AkMnjn1Pv0crl9XIAG9U6pK1joE
	 Y4lsY3nwl1wIKOEO1MrwdA2YZlxdF/dRJ+Fx+7cLSr7hlcyK3j+x+N4tec9OVcAaLn
	 ElvfT+IpdsC3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:48 -0400
Subject: [PATCH v4 04/11] nfsd: drop the nfsd4_fattr_args "size" field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-4-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
In-Reply-To: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MaWMQrP354gSUdJLpaSky0LlkGF4b0/cV4bjc3uboH8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acVCIMIGyjM1zCDK0UPnLYIyF2MWfBgDvecQ
 bjMCSfrVUiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FQufD/9gL87HUtvYMDq9H4u2zqnZH6zh3XyMFxQEd3up5FlE7V2pESURes+l8sb6x+KDK0o/Q1i
 qWzOLAowRbb+lYGQSaQvXkNEOmKFZH25nrSJax1iEuKaWV7vmVmlwCgCqSZhSOpry8tnYKnLYuX
 S56o5kqCHRJZV0D/UTdEl1nEicavWn8Ix1LujEL95vKVGD0hvilWRiQ2iNmvqD5ouaZoEzWHXmd
 B94hI69jd7Uo5EBmF5gNey9/0ARVfFAfmEEbCD6QfaED37MBookHIG7ZAHE5C8lru3S7Pa3+YcK
 Oxqdu4jzUIj7b4f1vm63vEr9hZZLd2hvqNLzbX19pdIi9HzMvv6gcWA6cPGmRNAIKFYbnS4i3lh
 d/DMpRKPBwg+XgjKMarspZ4BzW6g+axKnTfg6Sqocc0k91/2MydHXBrLB0VC8wbxxLUhqMgS6dm
 7Ag1qkUrdY6sJoi4jiBhtFzw8EZsbEwuihoLsEUcorH1F+mjHE8VfoBjzxARhKRb4LfN/8sr7w3
 6UMJdY7gN4u7vyLRWsI/DYoWBrkXWUu6B0QDPilGiNG6Kw0doV9Zk1PtY8WR2FdXIfnsxgb5BW2
 /QFQ5RVnNFiQz1cUOXJsjmnvucWmC9/GBvio11amLPzbkCWweQx/ZqbUYjvi4h9lWT7edrxug/m
 HziWpV9txlentHg==
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


