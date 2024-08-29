Return-Path: <linux-fsdevel+bounces-27844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A9C96469B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53721F2214E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38D1B5332;
	Thu, 29 Aug 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpjaACkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525F1B5319;
	Thu, 29 Aug 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938032; cv=none; b=kKEKrmTPgSwjXR7KMR64MyMyfhYrioXmQpNBOa7gR30ruQSCXiurl/teZVgDooBPWGl2rmjqZYYmWyVNvwcwYTfgThN4m0nW1UY3Ova5gbS4woIzT6AcwkDGoI2ilb/bwzisHlrLLH11Gbvf3XHihgQKiJxZHwGUcktOngSmXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938032; c=relaxed/simple;
	bh=a/6GHoinSuuHqpamKEatlNRJQO7PI65R0nWt2LL7iyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qf6fVMutOVgGGte76VoPKKRWDaLyKf1PjH341Zn7q3tPnPs2eFx2TS8/KPGuDF9UDxLpjHjdY73V9N6CQH4yg6py4Ag1YA8ULQixSXAmyuUCiJRBZyem9IDqqk1o4lfnA44BnLeS2+LiRiZPgPRgO5u27WvdbwSfFKDONX/bmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpjaACkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A6C4CEC9;
	Thu, 29 Aug 2024 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938032;
	bh=a/6GHoinSuuHqpamKEatlNRJQO7PI65R0nWt2LL7iyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HpjaACkc603d9161YTH7Z8dnRAdC6Vz2cZaoqyMJIrDkuypGWGW2FXPU0avcY1qkF
	 cq2r4vIBSpH5+fPg4A8r0bNI+POc1st5LY/BFFo3Ya3hMdlCYS3iSs+Hy0JHjsOkTb
	 8dBqrlQMVaG3BUJFjbE1LdITL35+7H8fV0hbFMx/vCveKsbJteyaX9YJlVyBQ9ebfs
	 H9mt7jdUfe8u3uR6aFhix+qRymJcXr3mk27NDMM9NyzkTcX+rQt1LUFm59fEFB3ccB
	 iAIBCOkAVOoY5TTW1TPAUww4sHHirYBjbJv1rK4BhY01NYvqc/2drZO79J2Ba4TZ7C
	 IA9rODlr45Gcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:51 -0400
Subject: [PATCH v3 13/13] nfsd: handle delegated timestamps in SETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-13-271c60806c5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=a/6GHoinSuuHqpamKEatlNRJQO7PI65R0nWt2LL7iyQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcY9eVwk975rjF/C75K4qCFyhZtQjmbn7Zpo
 8QiJ5ZX9bGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3GAAKCRAADmhBGVaC
 FbUWEAC55y2Xah4VYLt/PzlskKD9lXUM+0OdWE1lc2rFqtFHwRZUfLHWtB4rqsmu4YhCCvW0SFi
 cLgA3NFhXBfSuOC4mJ8643YAQ45qR3+klyBeaAICoOatoO8Hjfx1XxtsV/dvTt6a+wZzwp1pngt
 zGyV3dSL1ZDCEbspBu1PfB3nzI0sMZEZ33nU5+0vqE7Lv0ug/GK34sVST+BmZhCgFCXdy2UTwC9
 eocPmpO5ou/DfocbXSg0wJ1DqrsYqpZedL3Pkw5Hbxg1JNp6ZEzW4gLhjJz5SoAFuaT2s+Z2Mgq
 +62EqImb/bGPefUK1fxa5lX/M96/dKV5/OKUGtwej0ZGBip6aQtWkg6L3jQxQjaE2ajW5QchSHC
 jaDbaiWd9bcYIbK9/vpvnsiLA61q/JtlR0wWwSN8noqci4ElAf1jSZSBuQaVY9vhj2Id53hYk12
 nI1HPvBLgaH3EemJUEIhZ9VKC8nJiLu2RAurJYePAJWi5CQjInY/jJ58+ZlGzUgFbrMGnsfSzs9
 aCcUPF60OKT7ZFMSZu3YqSKBihyFgr2bFiZHUu7IzDNWVj016AE/1ch5BA7GY/lQRIvJ9JXIEmx
 C0vQ1E9tiRZT1khgp+QwF5+bksFbeeKy6t9XDnty+xB1EnX84Tj8rEznyjzsc7bZqjtYexCAmam
 DaYhyt7l8/GmCJA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow SETATTR to handle delegated timestamps. This patch assumes that
only the delegation holder has the ability to set the timestamps in this
way, so we only allow this if the SETATTR stateid refers to the
delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 29 ++++++++++++++++++++++++++---
 fs/nfsd/nfs4xdr.c  | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 963a02e179a0..f715dd29de60 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1142,18 +1142,41 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		.na_iattr	= &setattr->sa_iattr,
 		.na_seclabel	= &setattr->sa_label,
 	};
+	struct nfs4_stid *st = NULL;
 	struct inode *inode;
 	__be32 status = nfs_ok;
-	bool save_no_wcc;
+	bool save_no_wcc, deleg_attrs;
 	int err;
 
-	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
+	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
+					      FATTR4_WORD2_TIME_DELEG_MODIFY);
+
+	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, NULL);
+				WR_STATE, NULL, &st);
 		if (status)
 			return status;
 	}
+
+	/*
+	 * If client is trying to set delegated timestamps, ensure that the
+	 * stateid refers to a write delegation.
+	 */
+	if (deleg_attrs) {
+		status = nfserr_bad_stateid;
+		if (st->sc_type & SC_TYPE_DELEG) {
+			struct nfs4_delegation *dp = delegstateid(st);
+
+			if (dp->dl_type == NFS4_OPEN_DELEGATE_WRITE)
+				status = nfs_ok;
+		}
+	}
+	if (st)
+		nfs4_put_stid(st);
+	if (status)
+		return status;
+
 	err = fh_want_write(&cstate->current_fh);
 	if (err)
 		return nfserrno(err);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 557f4c8767ff..3b46014f911b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -520,6 +520,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		*umask = mask & S_IRWXUGO;
 		iattr->ia_valid |= ATTR_MODE;
 	}
+	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
+		fattr4_time_deleg_access access;
+
+		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
+			return nfserr_bad_xdr;
+		iattr->ia_atime.tv_sec = access.seconds;
+		iattr->ia_atime.tv_nsec = access.nseconds;
+		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
+	}
+	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
+		fattr4_time_deleg_modify modify;
+
+		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
+			return nfserr_bad_xdr;
+		iattr->ia_mtime.tv_sec = modify.seconds;
+		iattr->ia_mtime.tv_nsec = modify.nseconds;
+		iattr->ia_ctime.tv_sec = modify.seconds;
+		iattr->ia_ctime.tv_nsec = modify.seconds;
+		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
+	}
 
 	/* request sanity: did attrlist4 contain the expected number of words? */
 	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)

-- 
2.46.0


