Return-Path: <linux-fsdevel+bounces-27169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FC95F1FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3952C1C229C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649731991B5;
	Mon, 26 Aug 2024 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLBsmIgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33B1990A5;
	Mon, 26 Aug 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676407; cv=none; b=iYEoprLiKbicrInzRFF5EgBMhkw0HR4AuCD3b1f4r4IOi/bygJgNqxlmwuwjSC9W2T4w/lgWTHvDI+JO7X9p0DRtTW5/ZKXRfWHMfjkXbOz7MqzNNr/9EG2E/w2HtendwJnEfUHxWnxaGOSkl+18tx7kL+Jm4k9DF5L9CXSZYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676407; c=relaxed/simple;
	bh=yl4UFuynbiJ98Ciyso+Lbsj/YmQM0+7vnTVk3AZWOGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dENbYIyXMu+iPdFQdrINUqMi4P1Pz8z8HpWkAe45FLv2oHVR5GXIYCHBqEPbQ3CZmLLWRUiV1M7aJlCaPD8u5IcODxSbHdiEdRBYgEjFx89OPdS7KLjSrP2+BBfSrRBIEZWXtW7VoSDPby2Gz//qKtzxA0zoeCDJii3YgAlNPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLBsmIgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C503C581BE;
	Mon, 26 Aug 2024 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676407;
	bh=yl4UFuynbiJ98Ciyso+Lbsj/YmQM0+7vnTVk3AZWOGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BLBsmIgSbc2y3pU7lYPKNez6ask0MRUa8bDPzOj2BDQX11iLWEt/s/4O+ytVy+1PB
	 N21v7D+FIfKLWlF9LWcB0dAh6tLDQ1zEVgGyyun43R8t8e7nhvhpY+yK2S2TDHBT6k
	 3Uj77xuhZhVsyJ2DEjRC2jNHGqguDA8JeMYK3YzjNGeTu4gQOWnwmYRIF8D0PGV+AC
	 letGqHBRMpQSEwWoxGhM3nUcid3i2TtVbYu8pXO+ziQvzdTMQ1mekz0hTkLf3YH1tm
	 BBosRkhJ/aPwq/4MUtrmYKZTeyuMVf8oz/Ni/h0W0yqiO1xB/2Taq4VUbw0IGpVAsm
	 c/8Ln7bq+M0Jg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:16 -0400
Subject: [PATCH v2 6/7] nfsd: drop the ncf_cb_bmap field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-6-e8ab5c0e39cc@kernel.org>
References: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
In-Reply-To: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yl4UFuynbiJ98Ciyso+Lbsj/YmQM0+7vnTVk3AZWOGI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHkrsuxhyr2MFrH+pUCecIKuNzFZRj2s1RCsr
 R28DmsULE+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5KwAKCRAADmhBGVaC
 FY3MD/4kHmhHVT1T2FL/qgzN84FPawf5+TQMMDNlpiyYzi+5E9wnRzG378nSxpqyGeIWj/7iFjG
 R00h21QU5v6WMzrjZd95duOVOu5Punw2j6dOQH+RmK9mI3nG8mw6eT0JGwCXr798KGJanQTFBJG
 Bxe28+7UhnT9J+pZL/EePm0E6xadpMQw3tassGZbv+4FkVx4sO4B8xaYdlMiputqsz6qeOXO5Tu
 ZYexFGTPkTaK4BFqgVT07Zn/U0xEuQ7ADBv6+Ek0Cyc9o6HsVBOo2u3GJnbaqXkm79bVAviGllV
 WQ56rOaJl3PiIRSWEwMLL2tEuhUNvRi3NUnaIjc62irFdDZJtMuqGf/jkwx8UxR+PKCz3H7+CJ0
 +NDRGJ3Yx7kaM/PtgMahFh8WJdxvIAusliMf3Nn8m289BDHEOCkoFZ9fPsnmBz5TUuWmU2DTOzP
 qaPNennGk0FUfU26P9U/fU1tYLH9922ot+0QxO5j5POu+WKKZQxE+hqdkoQhD7tLe2jn2x88cRo
 RRKVaaAPQSG6VFhJXUiyslHv430kZKUbjgtvgl6q1CnuBefuvawR5OuXJQd59X6NEtoB9snCF6r
 rEI9GBx5KDhhw32lBUtuDOnfwy+UMoAlvQp4sjowNRX6wa9D+QFc2ZjSGGVKXB8SXmYxFvo7Tau
 wy9/9S/Pf2Cmekg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is always the same value, and in a later patch we're going to need
to set bits in WORD2. We can simplify this code and save a little space
in the delegation too. Just hardcode the bitmap in the callback encode
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 5 ++++-
 fs/nfsd/nfs4state.c    | 1 -
 fs/nfsd/state.h        | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d756f443fc44..988232086589 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -364,10 +364,13 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 	struct nfs4_delegation *dp =
 		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
+	u32 bmap[1];
+
+	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
-	encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap));
+	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
 	hdr->nops++;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b544320246bf..f353aeb4cc0a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1182,7 +1182,6 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
 			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
 	dp->dl_cb_fattr.ncf_file_modified = false;
-	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
 	return dp;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ec4559ecd193..65691457d9ba 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -137,7 +137,6 @@ struct nfs4_cpntf_state {
 struct nfs4_cb_fattr {
 	struct nfsd4_callback ncf_getattr;
 	u32 ncf_cb_status;
-	u32 ncf_cb_bmap[1];
 
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;

-- 
2.46.0


