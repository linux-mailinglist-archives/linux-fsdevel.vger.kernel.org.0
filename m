Return-Path: <linux-fsdevel+bounces-30986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86EE9903C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B98C1F24972
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A35215F48;
	Fri,  4 Oct 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFVyVRXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2682141D2;
	Fri,  4 Oct 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047895; cv=none; b=AOLKAd2elgiDRdWjkCVQQWisGZ++lA36xRRXZXFlY7i3H8FZ/gnD4treMODrnEPvwjcbdUhZtYQmFCLbQbS2NHNooXblIUQip/e5goRlSVCIQ8y1NO6hLoU7JBLp/PezLdlMzFtZk7re1Wg6QUdz65fXHVkjT1tkHu9VXkbfIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047895; c=relaxed/simple;
	bh=BEaZjmZrCFn46g9RKbQEfujpsBeZomOYq1yB4uwHK68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8uEG4Lkp+MXZHQfaohlhiYFsSy8JlRmEkLqPDDr15d55JKBygxoc0ejva3nFwIk3rEoftI2O4ty2NBZN0pqaVzuKsiT/xg6JL16IRyB4+wxcvMK4fxcl6reiUEWfFJ8YEQ3sc+KHEC6ifvB5I6kFKAI7jeD6UbnSJJv9xxdqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFVyVRXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62565C4CED2;
	Fri,  4 Oct 2024 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047894;
	bh=BEaZjmZrCFn46g9RKbQEfujpsBeZomOYq1yB4uwHK68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tFVyVRXWIC5qFQa3WVmSWb0ZdW1D3aPkm+BYMJeW5pTaUeJkKCmrBA5cUkqqFzEH+
	 bhF+kkmgLicqC4xOeMmNcq/Scu/t89UdGde53Q/Wp7U/ugC8+2ULmcUUkl07T/lE6F
	 4+OO5ISiIPQN4mA3Vc1usZclHD5Hzw9FHCvLtkrEcEiRBsvVUfotlvariRnVb9uz7S
	 wiiXxf3oqxnFGUZZ7y+UWKgA+yPstKcj6CH9vWyqXawlg70Wjjb6GUFWu6E/1LJz2h
	 t1GefltaZJphucRujszur2UKAyN2Jsgop1Cz0aMIHlKaxL6gIQUvTs+zzvXrVNIPmz
	 rVN2C6IwouuTw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:47 -0400
Subject: [PATCH v4 4/9] nfsd: fix handling of delegated change attr in
 CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-4-62ac29c49c2e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3315; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BEaZjmZrCFn46g9RKbQEfujpsBeZomOYq1yB4uwHK68=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sNRkkUvwW6qB98GfYn+EhlO6olwKyXxgBrP
 uSVlBOwNsqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDQAKCRAADmhBGVaC
 Fcu1EACzsboSPSdeurjY/trrae+ybstyR25Q2mUzsNQy9nZqcG7o/O8OgTYJFucv8uPKbFQ/2do
 T1alSUz228Gnfd+vBHjAx4VXIDsBGk40I4Ik+M7ylVde64J5ZqDCZ1TPiYxcnmtD/+DDVPknoNR
 jat1bSPR7fz84N0E9Jv0ntRNw04du8gcmHBWFzohjPJWdkctV9yVfLA+LtQUWC3HKrYOEUNKMhH
 XmlWhQ1BkjZDVf1rMKdHRcEx756TUwIEzeyFZUSvPalTheiXvbbTNoJPhnUqglSW3ZE4j1uSIre
 NyimZEsn3NyfTKRjgmkUjajWE8nWo36eDrxiDLTJ6MuhXZBsp+e+bjyMIq39ees8i8CmCEUBhaF
 8njrKVRhsKsYmxMegVwsvoqCY5a7umVAFFSivMyavYChX3zitMYRc6bz5zLI379cTiJ675kB87Y
 HpTeQEBeL09viL5Lg/v6EKaIsGzzFBayWBzLpSFYkpnKgdJVLhprV2uetxxCCDEXlJEkmQJ+FWG
 5Cs/nd5Tj0ZsUZqAaZE7CW7LIlcfuKjr5zZmLigzhLStTaq0xxIaKi0JMc7qYuPC1k0+Kg+bcig
 BXB5qkeZQmKmFrSymR0ur0tZUEMzrB3+Sthc3wHfwVE+64gaKz5L+ZIrd9JyOcfv6wDEo6+O9AL
 Zs4YT4sQ+xcticQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC8881, section 10.4.3 has some specific guidance as to how the
delegated change attribute should be handled. We currently don't follow
that guidance properly.

In particular, when the file is modified, the server always reports the
initial change attribute + 1. Section 10.4.3 however indicates that it
should be incremented on every GETATTR request from other clients.

Only request the change attribute until the file has been modified. If
there is an outstanding delegation, then increment the cached change
attribute on every GETATTR.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c |  8 +++++---
 fs/nfsd/nfs4xdr.c      | 15 +++++++++------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f5ba9be917700b6d16aba41e70de1ddd86f09a95..776838bb83e6b707a4df76326cdc68f32daf1755 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -361,12 +361,14 @@ static void
 encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
 			struct nfs4_cb_fattr *fattr)
 {
-	struct nfs4_delegation *dp =
-		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
+	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
 	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
+	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 	u32 bmap[1];
 
-	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
+	bmap[0] = FATTR4_WORD0_SIZE;
+	if (!ncf->ncf_file_modified)
+		bmap[0] |= FATTR4_WORD0_CHANGE;
 
 	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
 	encode_nfs_fh4(xdr, fh);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ccaee73de72bfd85b6b1ff595708a99e9bd5b8a4..c5a716aa9f79060828eedcc41366e32970dea042 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2928,6 +2928,7 @@ struct nfsd4_fattr_args {
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
+	u64			change_attr;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	void			*context;
 	int			contextlen;
@@ -3027,7 +3028,6 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 					 const struct nfsd4_fattr_args *args)
 {
 	const struct svc_export *exp = args->exp;
-	u64 c;
 
 	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
@@ -3038,9 +3038,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 			return nfserr_resource;
 		return nfs_ok;
 	}
-
-	c = nfsd4_change_attribute(&args->stat, d_inode(args->dentry));
-	return nfsd4_encode_changeid4(xdr, c);
+	return nfsd4_encode_changeid4(xdr, args->change_attr);
 }
 
 static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
@@ -3565,11 +3563,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	if (dp) {
 		struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
 
-		if (ncf->ncf_file_modified)
+		if (ncf->ncf_file_modified) {
+			++ncf->ncf_initial_cinfo;
 			args.stat.size = ncf->ncf_cur_fsize;
-
+		}
+		args.change_attr = ncf->ncf_initial_cinfo;
 		nfs4_put_stid(&dp->dl_stid);
+	} else {
+		args.change_attr = nfsd4_change_attribute(&args.stat, d_inode(dentry));
 	}
+
 	if (err)
 		goto out_nfserr;
 

-- 
2.46.2


