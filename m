Return-Path: <linux-fsdevel+bounces-56338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F76B16179
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633841AA2361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676A29E118;
	Wed, 30 Jul 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji7B9p4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420A29E0F7;
	Wed, 30 Jul 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881908; cv=none; b=U8jGme4SJO3kZAQzQ5JRqq0IXIKAhiIUSAkspzF33rG6RcsX2ZfQU9KVjD7yNBNaC52fFyh0bgHp1nQzgoDKvO7DgBcwI0Poo4JsSr3puS+7o/rS9jMc5zD8g5Ag76UEnMjBteD6XRE16HEC/0jEYfoHzvmC2JbEfnNXiTfsgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881908; c=relaxed/simple;
	bh=GnTr/aETvE3ymkWSwJqsiI1LzQh8lephKpOFz0kWFvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RD1qvRnLj4swA022nvT7iAJX/9BAVAjKQ3R0SfMir8YDLdigTmwoMR9hX9qsGjDlZdAKwZWb1T5oeadfaPpfa57ofci7lzBr6Elm9mDQ2RlZ3C2Pl96adpRu2MrBXMTWEP+C7YbM9JA6hwleWEzAi/hvEYQcm3rkTNPqga/RuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji7B9p4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C32FC4CEE7;
	Wed, 30 Jul 2025 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881907;
	bh=GnTr/aETvE3ymkWSwJqsiI1LzQh8lephKpOFz0kWFvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ji7B9p4t+rBJFCqiXuNdiar/F35zfpbSET6Oa7Zhz0RITVayXdFiQv6TeeuIY4sdU
	 aBnRT+B+0HV2SFDT9Hvast4u1zM02i6SLyu4gN1Y764TbliZReruu4voAZXxo3zS0z
	 Ffa/wZRS2TvenvWa9lDRJdKgb4ljJV16IYh989kOwPgaNg/m3o/M4GL2doDH8KmwIq
	 Xk5GB2Ar8w3eJg3g3MIzK8UJG45tAMLUspdxg/M7VGqwdI1ZniTmwLGg9+fKyKDxQ6
	 MJwrN2JrxnVKJyCVSsougWMXmtdgIm+Y+oagDqRRF/8zApJiyMu8stIvNPyyFW2TFr
	 BKGcRcWX6m/ZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:35 -0400
Subject: [PATCH v4 6/8] nfsd: fix SETATTR updates for delegated timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-6-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0oR4ih+0+i9RTgUeu+qCgcrdmMhZDqLDWCR
 k+2L4fqZnKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodKAAKCRAADmhBGVaC
 FV+jD/4x2nVkGliO9+GYOIt7oHZoxKFXYsh42mw8yRFAsGsGHPrf68WILh3JcbUAxMUjjWUDs3G
 OTaSfZSVhfYa5Y7b8Yv6ImDAKnW4+Fc7lDF8MJ4F15RSgPMS7UGi9PJlHozW2S35REwOhRPAnQF
 JyElv2+5v0WyPSTXnQalqOohNLYy3vqdGnC4y6/pcnfrMb0oiE0Y34towyjKeEnBHvHkRbBHjX2
 BUT1tehoEV3BJGzH+JE5KYQcUvqli5+1KYecqr+4ITXHG01uIT7xEFY2Tcery3MI4VxSlwjXcL6
 IRdpCojvPBdty/MURNAi87d5c00o9THInOSnZj8ijtUGO56FgFM2U6n+NW8O0jlMPk12q4kZeF+
 pvR9JEVrwj2K5bq5jdi/s/r8NxEcabLC0CVS1/dqR/cYE8egOAslB0FD7wUfY66l4E4DFXX++lt
 O/F8NOO4dYNAsEBv8mBS+zlyIAHBVR7YdTJSir217EEVcXgyMB1bN+nkkfhH4jSuAu6O4RFZEs2
 WHI4A08NVDEUznhB2ghiWcPFUSfhtIXWoEvoakCKbutC1u0NCM0yIYAmF7WJ+UTXAYoVsKkDhwZ
 Rw8u8lfIKgUDuSBTc35O0bluTe9Hq702bI+QGmHZQSEic7aDk8mB45m+Ej4eskIk9aNZd8bzkPi
 3gatxFKaMTdLCpw==
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


