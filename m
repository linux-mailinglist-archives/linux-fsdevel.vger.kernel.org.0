Return-Path: <linux-fsdevel+bounces-27834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7A964676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD0E1F20F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAF1AED32;
	Thu, 29 Aug 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwvkorRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DE1AE86C;
	Thu, 29 Aug 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938015; cv=none; b=Oz/KS4YZefa4aWxIf87G3/Drm6UZ5OAtWqZBv5Q7quaU5GOTpebVXzzlfIwPfFnbKhBmS/Jk352UV5XxHfossxwTpbjVfhCOyCj8o3PLDaE2rLvX7voo/MmkPBfSdN46C1Aqn1fS3xGcqpyAscgaw3CW+iKtuJ3bjU/OH56Hjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938015; c=relaxed/simple;
	bh=5hx89BSkzY2v98uuzPWE6uI+Zngs30R5FeV2oiZEv7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNmms5vQBiQ5vRbVUGJzsku4jF0b9b8THM/jV1bKuwl8HWqYfhzmdgNJT7pnKUrEGKUgHmksrc7mMD1atRKhzAqguR0Yrk1A813eLf78cABI3tzGvP06ATu9KpnNelG8CuvBHyfTj3yyfP1q24YfPrPKouiNcpWOuZtD5GS/j3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwvkorRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34DAC4CEC5;
	Thu, 29 Aug 2024 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938015;
	bh=5hx89BSkzY2v98uuzPWE6uI+Zngs30R5FeV2oiZEv7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RwvkorRGd2nGVJbt21mr5+JABeiWqAnlAsybD7EfTagnYWmoXkLR8gTK8CQ6huw4k
	 k44b6mEfe9IXTzBF7Tw+EbzeV7SPSE+lhPCzErrpogK92tUO4MMxESLYoDU58y88Jn
	 uIBF3tlbKahwEGnrEzR1Si9iFMfyfFqTmY4Nm27Xa18gKsYrxtSB/xLWnAYqpiJfNu
	 +juoTFNXkjL1N0pTCv0sx3px/fs7t3aWQmRoFRyWLs5J2Zgx1SuORh33DcrGp31JsC
	 Qb6EfdfzB4ItFRSL2LYxKqGue7vcwp7zgPH7MsZnKsrW23VLno8iagMrLpeedcQYFe
	 S5WDmUEOBFA8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:41 -0400
Subject: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-3-271c60806c5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5hx89BSkzY2v98uuzPWE6uI+Zngs30R5FeV2oiZEv7M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcXgRt5iqRUFIPkDOQ/8Fb9xRa8rrTQ+nF6g
 EasIHNH6QOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FfKgD/9Zq/fe4P5KAgyafYTINIurvAhFJMg5C8DpXcAY0dt5IwqiN+MMaWK6ZMhMTLA+il1qPtz
 N/o7hfVzmmxCe3bQZj/6/gzGXkIQfeUOS6+Rq6AU/Az7PAvM9kSACADsJ9jFPnIYDFlrtr2FYQg
 g5fQtKUPq5AbVge/zmsExCujXmZp3adhm434bnRsJXWzMnwfaaZG0vv19GCYIuNyBK0uzdkUfEL
 114CR+ryL6/iKPzpEWAmrDqJgPs0u+tnAjuVTx0kehTjBrIWqLIf1lQ83HsH1T9x+QZydSmEIuR
 GLywXyP4IJha21C/18KE9cH3+cE0Qv//P/YXillEcCUuZTk5x37A63lG4ThJiM6bnjvdLicIpdg
 iNzoSP5b/vbLHHC6LDFf3HR82ZEQwrpy9276arcX/Mz4FfwSF8bRS+KUx3hq9dx/pWdJS2lscWU
 Mvb8xVjliVLx7pUzvzY93+pPfW4ZpDd+6eEaEXmS/LHh9QaWCAIyTV7N201DPZ44yN2FfsQUT9/
 UVVMGHu0YaMehGYmo9X4dGjyw1Jy+JTz9AlxZ2FBeex6wPfjBvGzmWkf3IBXy0yv+ujoomSwzwA
 P56LAFln7nXEupSxmgohWQgwm28s3M3pbduef0XXE4Q6I6uwoAw2v2SiIlW5Q7LkAJ4nhQ1UEVO
 dSU5AHKLzwhbjBg==
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
index b5b3ab9d719a..0c49e31d4350 100644
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
index 8835930ecee6..6844ae9ea350 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1183,7 +1183,6 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
 			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
 	dp->dl_cb_fattr.ncf_file_modified = false;
-	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
 	return dp;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 79c743c01a47..ac3a29224806 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -138,7 +138,6 @@ struct nfs4_cpntf_state {
 struct nfs4_cb_fattr {
 	struct nfsd4_callback ncf_getattr;
 	u32 ncf_cb_status;
-	u32 ncf_cb_bmap[1];
 
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_change;

-- 
2.46.0


