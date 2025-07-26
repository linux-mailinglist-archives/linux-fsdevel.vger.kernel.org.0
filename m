Return-Path: <linux-fsdevel+bounces-56082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5DB12B00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D840C1C81150
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC8288C3A;
	Sat, 26 Jul 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNnsL0Tw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2561288C15;
	Sat, 26 Jul 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540329; cv=none; b=PwO902WYw8qVrRxyzCAXXpFDoBzGY8qxZV2yYv68dGDBe8zpv2jNaANwLJO6f4umjnzFTLFrutq6JEmituBWmCOKZ4bmHT6EhP/eMkDFHagpFwaON7UFAGdNOfEYKRG5PntPVzA3Lh+KG1RdgjFftNjC1ZOhtSKPxvz4CKX790w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540329; c=relaxed/simple;
	bh=sVxn+5YLRgFl9kXsoyZz5Ry1Ns26Txub2C7tzgdd+Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+ZgqLPg44xpFWrlWIUHOXvrWh3qJNl11BsF5zn4hxGz/tyHtGw8Qr4R5gD2TDeqPSWOH7ZGTR9fmL2jKQhMQS47mO/hIUkdd3HYse0LFUnD6wb5fqcP4ACs1ye/7sXpR4x8/Nfa7z2R7H+yP+eiJgvDMGNkMjxL5QM7JWNnnr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNnsL0Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497E6C4CEED;
	Sat, 26 Jul 2025 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540329;
	bh=sVxn+5YLRgFl9kXsoyZz5Ry1Ns26Txub2C7tzgdd+Og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SNnsL0TwbBGEPlKgHdNMBcTpQokBhIggVLv6rW0mNk4OAMD/6FoKOBzU3dqUn2FJ8
	 eaVnlhBaRz0uTfJPVzorI1yw3ux1FzR+LNzedtqSk6JSk6M98DmRlruObTA+thcOIV
	 MvtldWdCQFhXdCe6Q1kyZ/AcoZOMC0eVM9Us2do9wyRzFjhcMn4aMSztrrbTa3K8E1
	 qxxmX0Npjl4ooA4V94alwureZAXB2ed+tx6OxvV2bvTxfp1Vg8M2dMiMdHskbb3YXM
	 V2U1K68JfM0MDuF7r9xYbhm95eV93VLubkQmfhll5UGF6C58RZoX543oe99/UeAiR+
	 HfqzSi7j1KH3A==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:31:59 -0400
Subject: [PATCH v2 5/7] nfsd: fix SETATTR updates for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-5-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5765; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sVxn+5YLRgFl9kXsoyZz5Ry1Ns26Txub2C7tzgdd+Og=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObfiwi1TkiOKs9YP4lEA79kqJ1CEIgvjvg75
 umSP9x4Cg6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 FcuED/4mzsJ581iSO5kNrYFAQ5mX8fxvSRNBqJFSZC1sz/kIDjCoplJkS3CH5CEm968ToV862B9
 YV8wrcePNWWm32BV4c7NGwtZmbtVM7N09hWDYp884KBdfMDL+B5CaEkZGCs674IKh+Q6KYIc4HX
 f2kkjcEHaorxIlw7xDRd1xSfqMG4+Ak/wrPAsJmaH2XNADJytSRHpYkbqjYlaThIEdL/Mb9eaCE
 wLjcOPWMHoEitUXdr14434W1k09jB7e+7m/D5d7O+vaNFoeCjdS/pCrHOYxgaU1GQ7wMV7YB72P
 LO7cs7TIhry2yEm2VPGBn78BxM5erd5lW23EoJQdKVSr9zPm2wNNUuFeWRmwlskO9TgDP9Piq7e
 SH0fuMZeoVDNP0Mv9h3DpVhIUDPpUhDyt1DNBRkOWQMHUR7lflOs6N3zfIdOm4EvQ48U1yGjTUE
 oN4ZO8GGE9uNrfGsQ9lz0sIonPd+asujWtnab2p/mfqvzjMR3x7GKFCm6vwFNoohn1NYrohgvKF
 SxWVD7taGDE5ya1HMRDgh/tNhCFnA7HcCAFKPLwGe7j4DJMSIMJ1aYzxUCIGbNGtyKmpAOPWR9S
 hMpUYpELa+K1iUcF+BilbtdmIra5Xf3x+uLMpTbModz+Y0sYSf7fs3H+2SIXKn3AvxfMK7wPPya
 arm3jRfHLuxll0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

SETATTRs containing delegated timestamp updates are currently not being
vetted properly. Since we no longer need to compare the timestamps vs.
the current timestamps, move the vetting of delegated timestamps wholly
into nfsd.

Rename the set_cb_time() helper to nfsd4_vet_deleg_time(), and make it
non-static. Add a new vet_deleg_attrs() helper that is called from
nfsd4_setattr that uses nfsd4_vet_deleg_time() to properly validate the
all the timestamps. If the validation indicates that the update should
be skipped, unset the appropriate flags in ia_valid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c | 24 +++++++++++-------------
 fs/nfsd/state.h     |  3 +++
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7043fc475458d3b602010b47f489a3caba85e3ca..aacd912a5fbe29ba5ccac206d13243308f36b7fa 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1133,6 +1133,33 @@ nfsd4_secinfo_no_name_release(union nfsd4_op_u *u)
 		exp_put(u->secinfo_no_name.sin_exp);
 }
 
+/*
+ * Validate that the requested timestamps are within the acceptable range. If
+ * timestamp appears to be in the future, then it will be clamped to
+ * current_time().
+ */
+static void
+vet_deleg_attrs(struct nfsd4_setattr *setattr, struct nfs4_delegation *dp)
+{
+	struct timespec64 now = current_time(dp->dl_stid.sc_file->fi_inode);
+	struct iattr *iattr = &setattr->sa_iattr;
+
+	if ((setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) &&
+	    !nfsd4_vet_deleg_time(&iattr->ia_atime, &dp->dl_atime, &now))
+		iattr->ia_valid &= ~(ATTR_ATIME | ATTR_ATIME_SET);
+
+	if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
+		if (nfsd4_vet_deleg_time(&iattr->ia_mtime, &dp->dl_mtime, &now)) {
+			iattr->ia_ctime = iattr->ia_mtime;
+			if (!nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->dl_ctime, &now))
+				iattr->ia_valid &= ~(ATTR_CTIME | ATTR_CTIME_SET);
+		} else {
+			iattr->ia_valid &= ~(ATTR_CTIME | ATTR_CTIME_SET |
+					     ATTR_MTIME | ATTR_MTIME_SET);
+		}
+	}
+}
+
 static __be32
 nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
@@ -1170,8 +1197,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			struct nfs4_delegation *dp = delegstateid(st);
 
 			/* Only for *_ATTRS_DELEG flavors */
-			if (deleg_attrs_deleg(dp->dl_type))
+			if (deleg_attrs_deleg(dp->dl_type)) {
+				vet_deleg_attrs(setattr, dp);
 				status = nfs_ok;
+			}
 		}
 	}
 	if (st)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8737b721daf3433bab46065e751175a4dcdd1c89..f2fd0cbe256b9519eaa5cb0cc18872e08020edd3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9135,25 +9135,25 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 }
 
 /**
- * set_cb_time - vet and set the timespec for a cb_getattr update
- * @cb: timestamp from the CB_GETATTR response
+ * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
+ * @req: timestamp from the client
  * @orig: original timestamp in the inode
  * @now: current time
  *
- * Given a timestamp in a CB_GETATTR response, check it against the
+ * Given a timestamp from the client response, check it against the
  * current timestamp in the inode and the current time. Returns true
  * if the inode's timestamp needs to be updated, and false otherwise.
- * @cb may also be changed if the timestamp needs to be clamped.
+ * @req may also be changed if the timestamp needs to be clamped.
  */
-static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
-			const struct timespec64 *now)
+bool nfsd4_vet_deleg_time(struct timespec64 *req, const struct timespec64 *orig,
+			  const struct timespec64 *now)
 {
 
 	/*
 	 * "When the time presented is before the original time, then the
 	 *  update is ignored." Also no need to update if there is no change.
 	 */
-	if (timespec64_compare(cb, orig) <= 0)
+	if (timespec64_compare(req, orig) <= 0)
 		return false;
 
 	/*
@@ -9161,10 +9161,8 @@ static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
 	 *  clamp the new time to the current time, or it may
 	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
 	 */
-	if (timespec64_compare(cb, now) > 0) {
-		/* clamp it */
-		*cb = *now;
-	}
+	if (timespec64_compare(req, now) > 0)
+		*req = *now;
 
 	return true;
 }
@@ -9184,10 +9182,10 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 		attrs.ia_atime = ncf->ncf_cb_atime;
 		attrs.ia_mtime = ncf->ncf_cb_mtime;
 
-		if (set_cb_time(&attrs.ia_atime, &atime, &now))
+		if (nfsd4_vet_deleg_time(&attrs.ia_atime, &atime, &now))
 			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 
-		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
+		if (nfsd4_vet_deleg_time(&attrs.ia_mtime, &mtime, &now)) {
 			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
 					  ATTR_MTIME | ATTR_MTIME_SET;
 			attrs.ia_ctime = attrs.ia_mtime;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ce7c0d129ba338e1269ed163266e1ee192cd02c5..bf9436cdb93c5dd5502ecf83433ea311e3678711 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -247,6 +247,9 @@ static inline bool deleg_attrs_deleg(u32 dl_type)
 	       dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG;
 }
 
+bool nfsd4_vet_deleg_time(struct timespec64 *cb, const struct timespec64 *orig,
+			  const struct timespec64 *now);
+
 #define cb_to_delegation(cb) \
 	container_of(cb, struct nfs4_delegation, dl_recall)
 

-- 
2.50.1


