Return-Path: <linux-fsdevel+bounces-50341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77087ACB08D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C465F7A80DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8122F3B0;
	Mon,  2 Jun 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk5q+lvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911822E3E0;
	Mon,  2 Jun 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872965; cv=none; b=a7+rJYYL3TBCQE8wBlMn01GoJ2vDTqVeKGWd9vVbkd136r+xvtuI00HWN1LoiSxaxDCPgdFPJ4v//Er5c5JoLR65g/h3UwngWVi9L311e1ejt9hCE1R7gRnT/rqGpIS+rL0lW6W1+IPpbONsv5UtWLzzRxPsYa87u6l+eCcHybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872965; c=relaxed/simple;
	bh=Wvyvgvm5DbaEUEvlZdhyahV78iFdXKqVNAP9xbePNLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUzEL4OSVol4K1/4ybAf0ioI3bMKStFkzEHMZkZlGxsuAaEF+Uw1jJ/SELojX9zrLC62OMg4XLwAMVTczqZTMDeGrFqV4GmBOxZECHNk8ZCzEtRKxuOqFa9YrbsgQKLD1OLg0bWNIlYLzb5o6vYHhL0RXVWuUjS000A109j78NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk5q+lvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E8C4CEEE;
	Mon,  2 Jun 2025 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872965;
	bh=Wvyvgvm5DbaEUEvlZdhyahV78iFdXKqVNAP9xbePNLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pk5q+lvcXliXhkrasbOVg0SeYu1MNGi9RtdTiwn6iPVzG9ixuzDt5bcGamrlzMfXj
	 SA3Q2UqRfNWTV2GkK3aI/O40454Wg8wbgLgorLfeTIrg4CuNcBxvsCeeKN/L/js9F2
	 gWym0goJsg+rK/vl3K/eSU5PYmw8DaopoapFxs2imBqApWtCEVIrBmNcccJpNeb1as
	 QriFr/sCRlUjE/zjAvVBG6lRkRZEj/8kxm8IvAuGGA2OLPk95i6p3Y/TupNf7Xci63
	 biA3ttj1VV4WWWvNGQl/0c/ssOVRcwuqnJrwrTUlVUV0mLEMW6bczuFZHYc4oCLNND
	 PBFWyTapMLbyg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:54 -0400
Subject: [PATCH RFC v2 11/28] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-11-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Wvyvgvm5DbaEUEvlZdhyahV78iFdXKqVNAP9xbePNLg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7miLI68gh65Xc2YZM2jK9ip/h1PbaLvR2Zu
 qmRu0wk/pOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5gAKCRAADmhBGVaC
 FRkWD/9kMkvE7E3diNqJBXsV+jj5lJbXjdESLbVzqaddlyytM8qcw7Q04w6FoKKCAljsp6U9R9z
 3tJOG5vLnfKMluvFM4ZIOafFqEqCIuT9kfGv4L4os48qgSNSeRzs9GFizPB5yAtk/3CjQd8V95y
 1KkufwFWkJtSN7Pxf2AbQA4rjsvQEtVwmE4/xScYlAK6t105Zvq9mkTqlzZToUoNoOtK+adYhiu
 dC2kdm6WCD5Qo8tY8zfZUb40JRxd888FHzb/y/giv5xBMxfkWNO1XZ6JgdQe5vK66/nO2GqxoCy
 Hej3+AflC4iFr0jZl5MeFt119P1AcbSOp59+V6et2hEsJ9BMOBa+jLbwGciCzdDN6W4g1meE8fR
 AhmYzt89M5w00C+HvWvRByjp9/nZ/ydheuHqW5Wq9kKfS9yv4lpf0KC92ckbXime7Bu6jUNB/SJ
 ViS9QsvxdVxcUxTPSSzHYCT3MuxzHXCRPdCOjye1aYJi3GfSntU94g8Vo2Zwefs7ggygTxozaf7
 nUxy1BGQ5Q42VCRYZ1Tzex7z2vUOxmpjVHYvnsEx7+IG93kYSBEptfNXL4CiqgOzWs4kl+0PnD6
 77telQY7bWAQrRYmjFaZZ8MxmuHaXKhHkwMMv7jdT6w/qhjonbnastBr02Tm7Vkzu4PvzmGXO4w
 xR6KIVoAv23VczA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond pointed out: "...provided that the presented stateid is
actually valid, it is also sufficient to uniquely identify the file to
which it is associated (see RFC8881 Section 8.2.4), so the filehandle
should be considered mostly irrelevant for operations like DELEGRETURN."

Don't ask fh_verify to filter on file type.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a0e3fa2718c7ef331925e9ba8f2a66f331c76db5..5bf12abe4778ca0a16cd68965062da25470c8a93 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7758,7 +7758,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.49.0


