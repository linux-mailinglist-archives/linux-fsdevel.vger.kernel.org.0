Return-Path: <linux-fsdevel+bounces-30991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09A9903DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F951F2226A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25230219492;
	Fri,  4 Oct 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJeOmtbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA75217919;
	Fri,  4 Oct 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047903; cv=none; b=iuOqIRn30vQgykfCUnqaLdXQvqHPcPs5ORYU8PNIRsY9DcZe9sPW+cSjRlGdl70+U9RxmuZwLr8IDvi3XwQccJCuh683mQGc1QnERL0wE0xJXT9hPG7vLhGP/gvLb3FekotptuS09Exyw8vY8qd7iPauWbBLsd5dsjq7Q/PDhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047903; c=relaxed/simple;
	bh=9CCT4emkgZ4aNhjimaMLoft7waX5qJm3j1Zwi+hAwSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RoTA4ChBSkpXeU0PGj72MtMljL/nsH90xVj+VEi8M8HVW4i0+KH1ZToIsKN34F9Se82A3Gz2cLLMizlNef+Pi4pAak51hUyYsZnjapyYtNav9vkI0O/17yj+75MyWU+XuET9pOmqBbFInRfo69JcujVdZtUPIOT5tmh0RK9XyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJeOmtbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFA0C4CED2;
	Fri,  4 Oct 2024 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047903;
	bh=9CCT4emkgZ4aNhjimaMLoft7waX5qJm3j1Zwi+hAwSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SJeOmtbiwFM5KNFReOpcRr58z6Vv32jKCXkme8V5nD9wRXfYUlPqZ44zfyYHt22Sn
	 FGJ5Ubj7IXI6cj+bRTwhFXtZ1xKITx1s+b3dTOVvEUYsTTZ5xygVBn6ZnvS8e0dPzQ
	 M+nx0ginjF6gVSfsh3crMvrlDm0ECoOb0e9T8EAe/Yke+x+dscjYTtGuOEuKCYknF6
	 e7+6BKUHg0dYZ5o42NZh9yqD+udz28l9wdwzpLcVTtFNc2KAGNK2AXoavaW6Z3doz8
	 Qf2jyLEopuNRQUhU77DnXZtLn6Dgxa0mDiOeJmMksURHgVkU9wQG3d32086APchGb7
	 gfeLQDqiO6glw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:52 -0400
Subject: [PATCH v4 9/9] nfsd: handle delegated timestamps in SETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-9-62ac29c49c2e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9CCT4emkgZ4aNhjimaMLoft7waX5qJm3j1Zwi+hAwSw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sOxNR5js1OIdEyD1VBjMkxCXAGZG1EmjsFO
 +rnBCNLV1GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDgAKCRAADmhBGVaC
 FS/UEADWn9vKI2kmakUnaeIm9XrD2SgscYnwNiaR7ogtsv1R1SqMwSTFrACpzpmcL8clOH42T0d
 bBOAbNMqKR3Q5J+CAh6uNzxUWMOm450tRDf14pJTI2fOVh2IqPGG3NlTJAFrpLTKxVI36Q77ycI
 Q+byF+DC0+Sl3GNeV/XVhAe2BwCiuOetx5Zi1nXZGRV13+hboIUNN0L/thANIdbxQjjg3Jg7SNm
 eJZTf8sM9yEAbFy7Fmb1S4bEHtTBgvLaa2QTAxq3gzLAm6tCVpd2IXdHBF5GpMczeYl2C5/BLUe
 garxMC4Fc9ISxLWkonuA0U6tORJpW7QDsVglUVrj7s1zlg+lKrvBRHz8zbCoS2HKbeUka3GYNdT
 8gnAjX6yI09cZH7mn322IzX+gCj06MdvNDGzvY1mQSip/9oNcxksOD++tPMptXATsAk/hT5ef+Y
 FQ40XOjy8bGnqaEklyYqABL8tB+lyV8wJGQk5QzgZW0zbUfsZLsjAp711rtetkk1oL17oOHQn80
 RVx1FRMbjUneqdMU3SQYuT1C6BEU4WI4iubfoEGKpPJ1G8djt7TXiyDLXJJU1tez8/k8+PG64zq
 vQWcTbE2PGf7Td+mxz5odPRGWfPukadhykK3SKCCwv9lFsM9fM2Fc5wxji8fturpa/MdPteBDEv
 66w8RymIK3+hhkA==
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
index b5a6bf4f459fb2309a0ccc9f585c5d6318ceedf1..7f874943583c86dcfe686d38e69949e86b2a723e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1133,18 +1133,41 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 6241e93e9e13410b4fa926c0992127b1cc757b5e..bad75451d18f6d60faf33d6317a79011247ed7e6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
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
2.46.2


