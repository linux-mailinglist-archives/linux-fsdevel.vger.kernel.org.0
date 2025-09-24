Return-Path: <linux-fsdevel+bounces-62655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E4B9B66D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BB31895D46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5093314D4;
	Wed, 24 Sep 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQAWkcrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E323314A1;
	Wed, 24 Sep 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737303; cv=none; b=Kcc2bxvR8XTx68j9oI0yKNV9xpP26JSIk/+U7xddQcDufWNrYyH1mSS/cDvZufzSZp2xujee0QtU9QLiczpviYYdgYGuNU+U9oWA2ylsaAtCfQ6PEOwOuyY+02kx+aSlVDFJK3q1bZnfOVEsC0spAPzyLcRCa26SieqLgMhk99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737303; c=relaxed/simple;
	bh=fJdqNTNAGscdHrUgFR38YB3KoiSNts3lZfdfjwmtmZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXtjQ2pzEGs+RtN/ibG1h7rCZhoVzeftAz4fq8aaWHALVOOD2CnJrizrFyvLKlViuxTQvNYDZL63eo8bmz2vx6IFnEWbhy/5awaRGijxhkv/K+QkxPAWe88x9tIXzY8VJGV9jH2w/bkvs8BTcQXOmWnhWSS73lMpBGUCnTtrga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQAWkcrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F2BC4CEE7;
	Wed, 24 Sep 2025 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737303;
	bh=fJdqNTNAGscdHrUgFR38YB3KoiSNts3lZfdfjwmtmZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZQAWkcrh8Qns/qdv2vpxLOPYiEO1QnOCTmnTLlNk9h8U5ZgWJYoYwhaHdZ0x5g1sC
	 70xMmuVLaScLUOqb17KzMP0s3HFbz0NPG88qrokoFddyMwaBo0OCEM//iJAVJBZrtA
	 nw6XacS2mdvVfr0MlyXv/omePnT8zsJu4zR5ZpoqDwa4eSfgu3snoBlgZE8/kMTCS4
	 76l7+h11B37eoO7T1Xhsq5z+gcnuSlIZ86V4N8xoWfK53JujmqTh6wuK4uPfzmO55N
	 sAUkCxylPnkJoRWYV510TNvyF/GfO4GS8rovtNHoulNpxWh6cdVQW/aRSuAd4UebCx
	 slxN9YLM4dwtQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:23 -0400
Subject: [PATCH v3 37/38] nfsd: track requested dir attributes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-37-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fJdqNTNAGscdHrUgFR38YB3KoiSNts3lZfdfjwmtmZA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMSxrhOXUEdSI/8LXju4Fj3xSDD4eyP+JdCn
 S9uwBzLXp2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEgAKCRAADmhBGVaC
 FZPtD/4gr7AuLP22n5qwIuqYbbtdGaXykNZ8zSSTeGqaK+KzN5vk+fX/fkWs8yjWh4ueKX7mMbU
 48+Zy60su+9o1GUHCEHsaRjkE5mFizOCvzcnIAOwoeLr9pZKfM9EzDvwn0sx6VkNpG9n4DZqnJ6
 BEGMJRlffoah6gUYuqr4UsgJZzpWjkNoKjbivkgrnlJJsv1jHS77jLFMMfOY44RpSUO4FIPG+Ka
 InBUnJ6Y+EKoAIwbMT4BtQmoJxDJDOf/XoZyId5p2kHXX1MDJkH0aM0S2XjvQbQFcFHqv3KMaVX
 ytdP28aFkXy/P7OoGx715DV3JT2VMjceC4hcV94kgDqCDkqEtrkgI0MpRIuvSN45qzbWutMdn3o
 eFuT2YBBGLQ/PSMSDdOgHcoZG47TId/T7NddBRPbmXPrEPMl63wZ/MfsCDQiagPzlxlvmhC8OqE
 TELzwqbypt1sILvsc6e2Nl/1C7kMGuGmjaWfiVOvZEsfEJao1nREnnWIlUIhz3HrEjDxeyOSznp
 O90Bov1HlhdtFJDpZwuYFO9mOVa9E39iytwKJlYU6gP8qN+35+ILsYDtL4eUbDhp/HWkpVdyz5L
 07XkhddnUeUZIaKhnGR1yuJqmMc45423129DI0F4r3l74cMrkzK3eTK//usKy5GaLaD5pszDZSP
 Sh8OACE/YhNWEHA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Track the union of the requested and supported directory attributes in
the delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  7 ++++---
 fs/nfsd/nfs4state.c | 14 +++++++++++++-
 fs/nfsd/state.h     |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 774d18dd2f1a31d299a8426c3462847de6c88115..187daf86e62f7c94892a3b30bf2eb37bb9863595 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2335,9 +2335,10 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
-#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
-				 BIT(NOTIFY4_ADD_ENTRY) |	\
-				 BIT(NOTIFY4_RENAME_ENTRY) |	\
+#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_CHANGE_DIR_ATTRS) |	\
+				 BIT(NOTIFY4_REMOVE_ENTRY) |		\
+				 BIT(NOTIFY4_ADD_ENTRY) |		\
+				 BIT(NOTIFY4_RENAME_ENTRY) |		\
 				 BIT(NOTIFY4_GFLAG_EXTEND))
 
 static __be32
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 368face4d0b7001914b209b858dc1baa366535f6..2381dbb2e48290debf28bbd35d0b9a4bb677ac07 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9658,6 +9658,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 				 FATTR4_WORD1_TIME_MODIFY |	\
 				 FATTR4_WORD1_TIME_CREATE)
 
+#define GDD_WORD0_DIR_ATTRS	(FATTR4_WORD0_CHANGE |		\
+				 FATTR4_WORD0_SIZE)
+
+#define GDD_WORD1_DIR_ATTRS	(FATTR4_WORD1_NUMLINKS |	\
+				 FATTR4_WORD1_SPACE_USED |	\
+				 FATTR4_WORD1_TIME_ACCESS |	\
+				 FATTR4_WORD1_TIME_METADATA |	\
+				 FATTR4_WORD1_TIME_MODIFY)
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -9704,10 +9713,13 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (!dp)
 		goto out_delegees;
 
+	dp->dl_notify_mask = gdd->gddr_notification[0];
 	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
 	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+	dp->dl_dir_attrs[0] = gdd->gdda_dir_attributes[0] & GDD_WORD0_DIR_ATTRS;
+	dp->dl_dir_attrs[1] = gdd->gdda_dir_attributes[1] & GDD_WORD1_DIR_ATTRS;
 
-	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
+	fl = nfs4_alloc_init_lease(dp, dp->dl_notify_mask);
 	if (!fl)
 		goto out_put_stid;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 73869ae25bcdf63cc29f9ba49bdac20e21a812bd..946753d3ab6730892ba827151f2008afb46dcb57 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -283,7 +283,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_ctime;
 
 	/* For dir delegations */
+	uint32_t		dl_notify_mask;
 	uint32_t		dl_child_attrs[2];
+	uint32_t		dl_dir_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.51.0


