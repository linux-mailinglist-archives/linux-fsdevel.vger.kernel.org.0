Return-Path: <linux-fsdevel+bounces-30984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232CB9903C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D90B22434
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C22139A6;
	Fri,  4 Oct 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzS9FIQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5E212EFC;
	Fri,  4 Oct 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047892; cv=none; b=fyCHL1aOMREGcNG83ZgqZZ3Dc9gHN+OvfS8KZc8JW2GlgSRpq2Mn0juFOzt1gQdR96MLACz+qaJduaw/lHe3JYhofBY19Os5JVWP3HiKbL4o8RlsiPnZMVPtE9/4vR50GfMAOclP62SK/gwoKCMzzprfTg1zj5PxjyuWpgASO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047892; c=relaxed/simple;
	bh=qIcIEGGQ/FpGTUfquS8hLgwdNhcUXdbN2aVRHezbZRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/CqeaBTcBecG+H1gVQ1OygwfWdnCHDkug3zDlLsh3LmnhbPxYkVwqfMZymzSmTxv4O/KJGVVAbid3mDSZ6Be/3mOUwMkldBafk7bJvpAlIppigC/pKgN2bk5C/gzKhQHcHg6Gerwhh6A1ALpKjjs+PapvyxOs69NonkqoxFA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzS9FIQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099A5C4CED3;
	Fri,  4 Oct 2024 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047891;
	bh=qIcIEGGQ/FpGTUfquS8hLgwdNhcUXdbN2aVRHezbZRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jzS9FIQcYAxMBL8nwDZTCrfXpUKlGAEplQVfHqUj+zkkDXeARo+8SXKhN8gMNhqNz
	 LfyUck5zOhQD8bl2gE+6fisRf9IIVTlsAwiASyhz6RxeLYA0inOdLKUAmLSGq1aJd8
	 8W9Mtg79ChTG+6bwDXH2LtME5fSlczkuHX+MkMSOGYR1TpBCxOSkPqIrK4WvuXfw7x
	 zcJUd+Ys5lNnE5++2Nj0Wp0mr10uF8s3qpi07oZ/WhlIpD2rC5gcxXvAKTpX5CbEJd
	 FkmDPDPT8IA8w2glKNTHBKfL4LBMpYiZ1Qv5pjb/BUpT8GFyH8rI6wpJumJRf4ycpD
	 alLhKdieOcsRA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:45 -0400
Subject: [PATCH v4 2/9] nfsd: drop the nfsd4_fattr_args "size" field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-2-62ac29c49c2e@kernel.org>
References: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
In-Reply-To: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qIcIEGGQ/FpGTUfquS8hLgwdNhcUXdbN2aVRHezbZRI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sMZ4gR1zcUzpTeD3TgT/Oj6O9ZyhZuiWsjA
 tvWwfoGPU6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDAAKCRAADmhBGVaC
 FcPLEACUvXG1+U2RC684ZlDf4RYmNSLaGfiPRnQNdy0OXqBXXwuXh2p18R5pKo2hD6XbxZmnIxK
 yVOWiDfhNHTOddaZCwzGM0yljUomtZieF53VhMTNzMNeOu5bM8LQ+63ZTQKJJBh7a3oTAzfNNPS
 j1bYiKAWEgoASK5ZI2h+Vq1E1zrz7i3T9d9N3LnooUHv606dLOOyao5bxVTDQO/002/HceeSms+
 1orqBCdhHTZYFga2KR76HkaI0qMldoebXjw9rl1EuvLYzqHkUxa2yFAFeW4mPCoAlEWWuLiEDFP
 LwZ5yepNMHlkrEPJ2yaKJumyDMIkp+/y4SjCUb9l1rd3Ru6uEGiNlw9u3GcAAqfFMqSbW4SC14n
 RDHVdz1VeUGzhDQZnDaIi0lWB+wRcV5LJRzVMju41GzN6c0yNl74Dfv61hYURgsAihDgYX+vCGr
 F2gXbtGGRgQH8xHnL6AIvzb4bWByKRRXG0RSeXmx5NTsVLIkxPRSbEC70af9J8hmksdRAXwDTch
 Wi77yaoOsr4rG9kF706m4CHqBhp+YxCS7qqraTIknvRnl/v52x5RpQZ1J/NwCuRT47HEBXw/MzE
 6bSi9VfJ6vJRiR5MEXCS3pOZiHstcDQspM/IeSXuF7u9AxeCNbZeVusAg5uVdQwiyfPzB5hLnSK
 FNQrP7qU4Cm9ZVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We already have a slot for this in the kstat structure. Just overwrite
that instead of keeping a copy.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f118921250c3163ea45b77a53dc57ef364eec32b..d028daf77549c75ba1bb5e4b7c11ffd9896ff320 100644
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
2.46.2


