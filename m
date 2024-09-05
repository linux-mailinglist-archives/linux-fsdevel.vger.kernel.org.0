Return-Path: <linux-fsdevel+bounces-28736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336496D91A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3E61C25447
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890521A2541;
	Thu,  5 Sep 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK3ZC7BJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E51A0AEC;
	Thu,  5 Sep 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540136; cv=none; b=CrSQuLDyneae/uX35y9kZp/nDqv4cQzK6dtQUu6sBFsMLT83NrCX8dp0GzOCO0chBmXKQ327ZbpAxWMz8g7ZZcYoZrh1LgMv/ADJBBlkZMPEbuMyDCfDntH+ugSkKNwEnkeXYP3X9F21m833D7iwdznHvXS0D/U/oY5vZ3HMj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540136; c=relaxed/simple;
	bh=1en6ZoS+J2BtKYvFYTFNSg/wJUd69yW/1zWBLFXUlpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJI6R8dwr4DHtwX8gSaBHd0DEmcUdhswxiSHHoeaBZEv9KpnGOHYC+PotXPFJxizj2qklPz15tDsyWKikDod2Rj98emRsv1VLyCJMuA9A/MpV3pWIhyAAtrxKnHpaMOgT5L4enAwOq/L0HINv6L369khqW+dn8lqv8kT6XkSyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK3ZC7BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A90EC4CECA;
	Thu,  5 Sep 2024 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540135;
	bh=1en6ZoS+J2BtKYvFYTFNSg/wJUd69yW/1zWBLFXUlpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UK3ZC7BJgoDoijdjpTdtfUh9bpJTWHbRd4WMJNOQj6+MgRPcVQ3xwlu6omKQ7NLgb
	 8y5FZWXK/wrWL8FaOEbpJ7yfHrzzKTimmRIX3025aM5piWbHqvpw8UqjM2wh+KMm5H
	 l9xnpLQ5VS8TPsr1U2FL8unSKhbEBm57GBLk9poNwHVAMihLalvWwPgZcFc1IGzYfP
	 PXGZJg38aZCmzP3qDpov/Xe/WsXwgt1GI8gbRT7mwG4/epOnSPyb9mkVbwaYMX3m6l
	 p5ZYP0m+mk3lNxUxQaLzW72XB3eaFLPTS9jiukU5zHKW0AmuY9hAondZiAk41Znejk
	 6R/mHH45ZteRw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:55 -0400
Subject: [PATCH v4 11/11] nfsd: handle delegated timestamps in SETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-11-d3e5fd34d107@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1en6ZoS+J2BtKYvFYTFNSg/wJUd69yW/1zWBLFXUlpU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acVXSn3MSZg8iTU1GbT8KuKUTM9fJk8cNmyR
 VdtH0Gk5yuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FSP8D/0fLtIHut1uWgzEMa5a2ixd9F+YUKgy468//gkfbbjzHGvIjr6OUTwJKIqeJnfP3+n4vTZ
 OqV5c5fkqGEp08d8YerMOmurwNrlDaoRAUhrtRJvwCUyj7b4bxqWAYZc0r55cWnpRVIjb8rpgam
 i7t/yWnDyFOaDPimzwFbWIyJKR+yZlJfH/c+Kmz3EL6LiiKBUs//T3Bbbc0RNxej2oVIih5TXJZ
 vNY6zfylLnQhy6YNGqjUoePA4g7jE2S5sdj1Otl3VecKvs/N33hrANlcAuCYC8NnalVD4jHqUw4
 0lqK1Z6hKr4NHK+2FfdAMnPBwqYQZEUNf3GAm6GdSVbwGCYlKTHsaH9XzmrQO50dTo9kQgHL1oL
 xN7w9Ipx/7RJNPc8wZzKgqJbz5cjWwN8Tf8S8EcwWSZgCFJHGHWPA6oJeKJbQJLc4XmbABFg2e5
 L8TTK7Q3G2OGT4Ab24t6X1/3ZwS3TGmmwmcPHymfpg8+FgO9yrwsMsEpHQ3r0KgCH/x6xvEXus5
 xx7/D6dyCr0FH9rN9YguUbmbDangTa5XpoIIzGn/MWWSOEq6feoyxuIRqLniJHQaeltiFUtSA1h
 zxIate65nuUL5uYn+V+xz1ukWk9GCvXwGvoN1iCTq5fDPqHrcNlbkKkztcXCNSWioy73VJ59wuI
 LDhz5kuMpvDZUVA==
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
index b5a6bf4f459f..7f874943583c 100644
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
index b11d75f483de..0dea4ee8b19e 100644
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
2.46.0


