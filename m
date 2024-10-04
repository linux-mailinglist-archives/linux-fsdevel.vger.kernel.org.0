Return-Path: <linux-fsdevel+bounces-30983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB289903BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03071F2491E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3419212EE8;
	Fri,  4 Oct 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtG+lLgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370692101B5;
	Fri,  4 Oct 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047890; cv=none; b=ilvw4SXa9167BmOtYTD34nX5T6O2wB2x7s3/O02q/1Urey/aAsqjO+WVbzbZK569GpwYLLIHxAcykd+vMqvg7UgDQxm6ZayJ14JC16WUulYirXNi4Z7bZOO5PdegdPVnUSRfxMSIjTZREh1lY5+u/J6U/Vaw/6lhlLjioc4CIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047890; c=relaxed/simple;
	bh=NAATopYIOPduQBNTxLfi+EHB1Ci0TeOIoS56BM7/U3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWnL6y+F/VEk6A8vRKYWCiXMFxzs2tB02HDEWMjeXoEBmcTgXZTIqMsWd4DzXRWQGRp8Gns+DPBsJVGJZVjw0uL2UlJgOKP2kvHohO+FFqS8s9MjKyAy/NHatBMzxnZseMzwHOT/mhYj9orKtmwVDrNzWrEyysTtVU6Ye7IaQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtG+lLgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5919EC4CED0;
	Fri,  4 Oct 2024 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047889;
	bh=NAATopYIOPduQBNTxLfi+EHB1Ci0TeOIoS56BM7/U3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HtG+lLgo/vSP7HwPYt+5PREzSL2b3S6PYaklGd9Gkpu46i2F9JCnpQg3N5dqivlvA
	 86NOjvWNWar+jQQfvRb8G0sIxR26vMveatRCrtpfvKwgk8VWGV7IhBb5w0wjF0W1CX
	 Oc2iS99nFf9eHUXhRumDwI0M/ALmEDjtUYsFk/xCIqPMu1S/baQISt2xkl/K+zeguV
	 doTkWsoGDUIEEu6fIKFvv56Z9NDs76Bqp5TsrI7PMyGf/0M4tKaaeRUPj6BtePuQlJ
	 q2uV57MSIup2qCCiEQnmdc7+xVvpypZpNQYQoLA6pLc8UvIXExrTnfPVD/1TTHztmf
	 62eANlt4Q+0Aw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:44 -0400
Subject: [PATCH v4 1/9] nfsd: drop the ncf_cb_bmap field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-1-62ac29c49c2e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NAATopYIOPduQBNTxLfi+EHB1Ci0TeOIoS56BM7/U3k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sMVldmBO5NmkJSm+fMJElQf7itYmBKHPHJj
 PtSDbY0GfaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDAAKCRAADmhBGVaC
 FWFBD/0UgGRyM+F6eLw6mjm1bAKd9u9h2yom4ORySYtgEXDJtJ9997yqqGt6k+PiT2L9qlxGY8I
 /eFAU7C6Kw2SKYOYtf5cIAGWJULvv5fZYgD+FXpOmZTFpYXm4J3HOlRCk/av9YayBZ3Zb9gv099
 PdqNJrfKJV9fSsyx4cfRtrXKU/gHmtyNbd3aTvm+X0267bdbE3M7sV6EKsDGCfX4rCZffvbp42H
 PrwFuCjpRFsB7MNpqSNgyd7N+DuoBvjXwhEQ/6cUCAOPWfpZG392VBxRmvzb+gxIgh5AX2lGApA
 4yrRO45JV/jrDWRBKzIUHRY2BehDt/NdMzc/KpTFiys5mhfsaIC9P5thQkE2O5cGpchAMlA92L4
 xe+cPYd8Qi9VhRP5wbH9YLDCD+EiJyLfH/9UY96Lpl7Nyyv1PJcjuiT4JcThQ8BFszWcJYC7hdU
 +oq6MW+H1LazrlhPDi6WM7/q/xUzZKYpaNdfzhc+uScZnmpxoubiZ0mRcEDV3SsxC4YGjuPddvc
 XeEilVa34PgJ3+4kzamP4og0TZ41ABYy+8bB9cO7p7zrG/4Fx0TUGQ+Z7Ira3DhaVbXDrwF8Xu6
 ScalzRBP/4WcSGr62k4R7/i13oOXUC0B8Gof+d6z7Vk11cZGY+l6lTJFOHOTM+X0dDX0x3FTtGu
 J7PidrnH5kvts2g==
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
index 478b548f4147f6966aa578fca73925ee456a0cbc..f5ba9be917700b6d16aba41e70de1ddd86f09a95 100644
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
index ac1859c7cc9dc7684eb47f4ce025c3fc56e02701..1cb09daa7dc2033af37e4e5b2c6d500217d67cf3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1184,7 +1184,6 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
 			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
 	dp->dl_cb_fattr.ncf_file_modified = false;
-	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
 	return dp;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 79c743c01a47bb1d91130708b65b75b92c697aae..ac3a29224806498fb84bacf2bf046ae78cbfac82 100644
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
2.46.2


