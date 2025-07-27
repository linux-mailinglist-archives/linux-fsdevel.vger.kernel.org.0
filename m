Return-Path: <linux-fsdevel+bounces-56105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C41B1314E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADF83A8469
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330E23E344;
	Sun, 27 Jul 2025 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLrXh5UD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5E23C4F8;
	Sun, 27 Jul 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641394; cv=none; b=rl0OJMQzOrOWEKR+jjtg/ney2FrUq5s3S/Dc1LTVjBbK9om/1d6O/EVN2WV6pbN/D82cDHcwsOpCBMJOnzSOO9AVJgP598CvCNMwWQ7cZCmVyS7ypXmCG2coVbzkhIdovZf3E5szUS1sheUpIhur/Yv7X4iU/usztXJAPkNExZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641394; c=relaxed/simple;
	bh=GnTr/aETvE3ymkWSwJqsiI1LzQh8lephKpOFz0kWFvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUabyc5cxmiJ4wh55MaRFyDqVsY5Lm6ZSuDvcnxunZc3ae6+H9zieCv+a4bUGrAjnO6qNaSTq4mhyaV6VZpq2UFVCLB8VrHF4xLWVsmMVN3nls5FIyqeD5Kgmh9yOoZ+69h9xgGAj+6kWt8g1egYhSj7Fct2YOxiIVJ9oqxC9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLrXh5UD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A044C4CEEB;
	Sun, 27 Jul 2025 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641393;
	bh=GnTr/aETvE3ymkWSwJqsiI1LzQh8lephKpOFz0kWFvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TLrXh5UDZA4XJYXEE6zp7lNBsoyDtoC8OBgGwIzslIiLm/Z5Cwkvhu/dKthDpKuL+
	 IvGLzxWzuYf+1niORS3o+roPvm8qsRgK36fRkzD8NQgfOJgpu0uHKPVZ8VqkKWyUkL
	 m4fLbgNlrNLY9S4HOxkryiR79kE6a9e4Cb0jvkdlm6GmScZsUYXQhbz626+UWT4YpE
	 wLTmdeRpm3etOYd5K2hfGdKhkMx1yTSDuImTBXzIZXy2JsLj/AEjTri4qAYbIoV+Pu
	 wHOxEtzvOR9V7onPmKs6ctdiZKB2QBpfnsGmivE5nliZu0NphOC7ugjRR2hailJe4l
	 z9w5AMqeeCUyA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:16 -0400
Subject: [PATCH v3 6/8] nfsd: fix SETATTR updates for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-6-8dc2aafb166d@kernel.org>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
In-Reply-To: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5835; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GnTr/aETvE3ymkWSwJqsiI1LzQh8lephKpOFz0kWFvQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGmJppesOJnJCdFhrt736m20hLkU7RtpH+nc
 3MaARWwfF6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpgAKCRAADmhBGVaC
 FWV1EAC40Zmm3SolVYnz2tGA5suFjSp6VKqhOjLYzFQKZSQRHqZxt7wfqjLRBC85/Mz3Qbth2Mf
 mauWe6AKGzcgoSPAhYyunxyNd/BNc6rMyfelFqnnDhtB8pzyjUHMCHxt1miRT1Av2WVKw3PRNMR
 saNa5dhJv1v0zazlVHiqFWbfKrxPqECkPcNtzSy6fjzroqNLYIcr0LYBWrJdjOxKjSMGrfq4bSq
 0yLZpCn1ZUBm1YY9YoXPQsWX6Vcnm3l4eIUxJ+eSRDxnznmxIixyEOQ245cYuyarpAzYna51U9N
 X19iW6aOGM4Bqmkh6HVhF1lFm284fCMUU7+NKXM6diJG3E4pNvGmY+0XuIMLC1Nqtb1Z5mw58o7
 aF+et9pslS8WIiS9Kwso6Hh62ZHpP1DewToAuA6hv0wLInEwHjbsEHKmHCiZSDa+1aSkkN1+1Gm
 Ymia4JoQBaHY8JcLXc/ND/ub9u9o+t5+pavdnDCpwyMQSi/KjSWfRDkjhaN6y3C82NQVHK5T5Wz
 4vJtALPNudxhHk1gpQsYmqRGcYu1O1ETDwJqbfEKdn7pQHMYZ6225qKbVykNjfnZQwI7WdebRw/
 fDrUc/OQUoJRfLWca7eG0W2MfdGcLQarCa9R83qIBFTnIUzoBThhAp7r7wFsPd4KvmJCzydi0Ie
 LzKsuO3fBQMeYKQ==
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

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
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


