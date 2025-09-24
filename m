Return-Path: <linux-fsdevel+bounces-62654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06128B9B643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50511BC1A23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E331D748;
	Wed, 24 Sep 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj785LvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A433086B;
	Wed, 24 Sep 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737300; cv=none; b=fsDT3zEXj7gckTa29KNb/pIryZq5Z0YQEw5DbgNdNK4DgW3zvRsVCfDk9Q46dslPsXLpsR54JtfTmShhIYMM2JcoDD8mDlWSaHr3Lbh2Fa8A3tSlmEcy5JT+0O88JA5kN8X3k50G0r98ckIfJz8sO5L1Lu7X+S5zzp0t9jXGqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737300; c=relaxed/simple;
	bh=PazxF+TT5c/ZpvyMrYcDvw1SQIk4JaxhRj1B/Dqx47A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hi0TSJKfSg87GOTNkbL++dCBbB2wiNNxQPGHJEvzmIGIH5ml+b/Th0H2WQkU36/5ZEiYYWHVdG6r+nqcQ3N4Bp8YmZH6TgS6tXXT3VRJ0U1JbPKjJY5S12fhiIw+h43dEj1R7YRNsbvceZxpHAlKxJLzIzofYcBNQ/1ms/dF7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj785LvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B499EC116D0;
	Wed, 24 Sep 2025 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737300;
	bh=PazxF+TT5c/ZpvyMrYcDvw1SQIk4JaxhRj1B/Dqx47A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gj785LvZuNBC0Dw85VzIe5n0WYV+/9dqpYb/q318uSILCjLnH/I+H1I5L+tkrz/tq
	 fhofYBsoqXODwOHdXmJE+SJbGE5Aj9nblpefUbAYNEc6Kk6kJdH7sLg1RCDdV69jUa
	 /OWFGhNM/IHOFPvvJQDPrlOxnRrjpTLqVPBRv4n800RU443UTEa9cgtQVzWvXcvyqk
	 JWkn25bmv0N674fx8IhL57CUwkvahEE8+UclGVXueUMON7XRk9IKvx0bUwQdUGRKeB
	 gqGodGLSE2CJKyhFXsh2UzjPb56O2FVC4JRuw9g8yleWh35Skq6Fkionjt6BA/2OwG
	 +1p8ewd1gEOyQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:22 -0400
Subject: [PATCH v3 36/38] nfsd: properly track requested child attributes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-36-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4000; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PazxF+TT5c/ZpvyMrYcDvw1SQIk4JaxhRj1B/Dqx47A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMSK863743hpQkBbcB0AJIav7LBX+sYqX9Md
 kRHSb1SibGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEgAKCRAADmhBGVaC
 FatWD/4zLT/pxdhTwtIbbW3AFWJaRgFy86zENA5i7aitOruIobpNXlZt6HAxZY6BJfY+sqiKoD/
 kYKdm1IzeV51xlf627iGviGiN5EWAPkIjs26RN+K9mio0bCzrUKGuXdjhLoJIEYe3rbK4JfLK/g
 f1FSUlu9UXI8s9uInRPE+cT8v4AtaMOTeX4XwKsyIgYB4EtPfKGD7n/Nfudv87GaJ53pSgleP5D
 WaLctTt0ilotxJvODkM5VCf6MsqQjBjWDqbcPPr/47Mdfrr8MPnrfemUuXDCx5NBr8Z0L7gGA3n
 sjWIUFiXnY1EkeoKhUfqZk8Uq1ovQCstWgcheWCUn90SiQPDfLdZhiqPRJ93lr7GerFfuh/PHL/
 yr7kh2ZUerUNOwjZqqeHUhajKImS2/yWYs+36IYzmhiB01F3BQZY2/NSV5CasuI8VqSiN++qXK4
 xVMT+c9ihvgTAKQ+gJRx3wbRZ9CHM0AAYINz5xhfBBTsRm2iY87udwnLl2vrw4OIWyYiXt6pNd2
 Uw/o5Pd0HZuCoaRsQHVC50jcn3v9pK2dUylA64bRoe95pf2EpJ89rsvruejfSWmZyiLNM02jisX
 Ag9BDmKlqk64nCW8js8u/pqi2oukYap87WKODZkPhaa4UGDOAPQJclnVF0hARovtHudUN02a9+F
 Ni+vt7/Kjwpwozg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Track the union of requested and supported child attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  2 ++
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 15 ++++++---------
 fs/nfsd/state.h     |  3 +++
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 220fc873db8f08a90ac74e51ac9d931fe7edb9e4..774d18dd2f1a31d299a8426c3462847de6c88115 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2385,6 +2385,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
+	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9b5f559ff6125a551f73ac103f8af2e3763dc3e6..368face4d0b7001914b209b858dc1baa366535f6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9643,6 +9643,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	return status;
 }
 
+#define GDD_WORD0_CHILD_ATTRS	(FATTR4_WORD0_TYPE |		\
+				 FATTR4_WORD0_CHANGE |		\
+				 FATTR4_WORD0_SIZE |		\
+				 FATTR4_WORD0_FILEID |		\
+				 FATTR4_WORD0_FILEHANDLE)
+
+#define GDD_WORD1_CHILD_ATTRS	(FATTR4_WORD1_MODE |		\
+				 FATTR4_WORD1_NUMLINKS |	\
+				 FATTR4_WORD1_RAWDEV |		\
+				 FATTR4_WORD1_SPACE_USED |	\
+				 FATTR4_WORD1_TIME_ACCESS |	\
+				 FATTR4_WORD1_TIME_METADATA |	\
+				 FATTR4_WORD1_TIME_MODIFY |	\
+				 FATTR4_WORD1_TIME_CREATE)
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -9689,6 +9704,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (!dp)
 		goto out_delegees;
 
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+
 	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 11b622aca5111502b483f269b1fce6a684804645..0c411c758279177837c078d393048aaebf31d46f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3837,18 +3837,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
-		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
-	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
-		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
-		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[0] = dp->dl_child_attrs[0];
+	attrmask[1] = dp->dl_child_attrs[1];
 	attrmask[2] = 0;
 
-	if (setup_notify_fhandle(dentry, fi, &args))
-		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+	if (!setup_notify_fhandle(dentry, fi, &args))
+		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (args.stat.result_mask & STATX_BTIME)
-		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (!(args.stat.result_mask & STATX_BTIME))
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6e066f0721e6a48394e182b3c273a44d2fbb652d..73869ae25bcdf63cc29f9ba49bdac20e21a812bd 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -281,6 +281,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_atime;
 	struct timespec64	dl_mtime;
 	struct timespec64	dl_ctime;
+
+	/* For dir delegations */
+	uint32_t		dl_child_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.51.0


