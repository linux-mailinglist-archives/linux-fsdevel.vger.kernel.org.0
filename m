Return-Path: <linux-fsdevel+bounces-78142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH7KC9LjnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B417F932
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E70730361BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4F37FF4B;
	Mon, 23 Feb 2026 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7A5uz8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14C37F8D7;
	Mon, 23 Feb 2026 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889606; cv=none; b=m0XaDN9SEY3O0JPgxmXBxfFfrpzRknkDE/R7VbOUJnpwQu/FNc2TBA0TKog3glAxwxA1lfPleXmHpIX2b6QOwTi9Sv29NBkLFaCn3KRsidNLAEd4hQkTQUVHVyffpeJYbIOvC7lP+C0Ys5i0FVoU8T5PbB0QwvCDBXHweWwR2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889606; c=relaxed/simple;
	bh=wakoDwDqWQa0GbD3ziZfD/cA59i7W2oUMtmKKGElrbk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcLBbVvDQYNJK+UzJnEOMk6Tu2zxIOlmMC6583T6fGmX6V1/AMFcYypUHG5EbNvm4mond/xeeR4sdGOcVsj8EIm8Q0L+quYQS50o5zm/dcEcGcnKig3hxf9/wC+esZAW2Lm+G7wU3Y6618UiOHfMGZ4piHfagfYBCX71i6SRdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7A5uz8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEFEC116C6;
	Mon, 23 Feb 2026 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889606;
	bh=wakoDwDqWQa0GbD3ziZfD/cA59i7W2oUMtmKKGElrbk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l7A5uz8GKb8kMmL878f6qR3VKfH2e6U8oGxe+qm/zaOH472dQmiDpr0g0Ql8bAJoD
	 JhqSgTtWZpg0qPGL6HkiNndTPfyFO+udLsqhLMlarqtOEweq76mJP70Y3+xKapQagW
	 OxN4iGk0AkqapDsFjFU4acSC00kUxRzWj4WRpQUNbrT7dO9skCi8HotlvdcC1+ce3p
	 Y9SqOy4wegrkWcOelujbAxnJaGVh1MKTLw38VOdxPJmBnVcbG4GlrsgrnWI0WwoP7O
	 CCQahLx2uAaNAZFtvjydvdIQ96JgO7+PAPK0O+GdtDtotUoClnbyZAymeNmFzba7Vq
	 tSyeGkBg38YXw==
Date: Mon, 23 Feb 2026 15:33:25 -0800
Subject: [PATCH 3/5] libfuse: allow constraining of iomap mapping cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741072.3941876.10446259921329556983.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
References: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78142-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 198B417F932
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Allow the fuse server to constrain the maximum size of each iomap
mapping cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    3 +++
 include/fuse_kernel.h   |    6 +++++-
 include/fuse_lowlevel.h |    3 ++-
 lib/fuse.c              |    2 +-
 lib/fuse_lowlevel.c     |   11 ++++++++---
 5 files changed, 19 insertions(+), 6 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 313f78c9cb6632..18c2e0e11ce8ce 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1261,6 +1261,7 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
 #define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
 #define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+#define FUSE_IOMAP_CONFIG_CACHE_MAXBYTES (1 << 6ULL)
 
 struct fuse_iomap_config{
 	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
@@ -1283,6 +1284,8 @@ struct fuse_iomap_config{
 	int64_t s_time_max;
 
 	int64_t s_maxbytes;	/* max file size */
+
+	uint32_t cache_maxbytes; /* mapping cache maximum size */
 };
 
 /* invalidate to end of file */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index f2a1e187aea3a1..8149657ac44cb9 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1425,7 +1425,9 @@ struct fuse_iomap_ioend_out {
 struct fuse_iomap_config_in {
 	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
 	int64_t maxbytes;	/* max supported file size */
-	uint64_t padding[6];	/* zero */
+	uint32_t cache_maxbytes; /* mapping cache maxbytes */
+	uint32_t zero;		/* zero */
+	uint64_t padding[5];	/* zero */
 };
 
 struct fuse_iomap_config_out {
@@ -1449,6 +1451,8 @@ struct fuse_iomap_config_out {
 	int64_t s_time_max;
 
 	int64_t s_maxbytes;	/* max file size */
+
+	uint32_t cache_maxbytes; /* mapping cache maximum size */
 };
 
 struct fuse_range {
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 67fdde0a5f49d9..77fc623386ce20 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1436,9 +1436,10 @@ struct fuse_lowlevel_ops {
 	 * @param req request handle
 	 * @param flags FUSE_IOMAP_CONFIG_* flags that can be passed back
 	 * @param maxbytes maximum supported file size
+	 * @param cache_maxbytes maximum allowed iomap cache size
 	 */
 	void (*iomap_config) (fuse_req_t req, uint64_t flags,
-			      uint64_t maxbytes);
+			      uint64_t maxbytes, uint32_t cache_maxbytes);
 
 	/**
 	 * Freeze the filesystem
diff --git a/lib/fuse.c b/lib/fuse.c
index 0fb1bc106514a1..04836044e7a25b 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -4923,7 +4923,7 @@ static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
 }
 
 static void fuse_lib_iomap_config(fuse_req_t req, uint64_t flags,
-				  uint64_t maxbytes)
+				  uint64_t maxbytes, uint32_t cache_maxbytes)
 {
 	struct fuse_iomap_config cfg = { };
 	struct fuse *f = req_fuse_prepare(req);
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ea6aba18619458..b2bf2e5345cc71 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2852,7 +2852,8 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
 			      FUSE_IOMAP_CONFIG_BLOCKSIZE | \
 			      FUSE_IOMAP_CONFIG_MAX_LINKS | \
 			      FUSE_IOMAP_CONFIG_TIME | \
-			      FUSE_IOMAP_CONFIG_MAXBYTES)
+			      FUSE_IOMAP_CONFIG_MAXBYTES | \
+			      FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
 
 #define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_V1)
 
@@ -2861,7 +2862,7 @@ static ssize_t iomap_config_reply_size(const struct fuse_iomap_config *cfg)
 	if (cfg->flags & ~FUSE_IOMAP_CONFIG_ALL)
 		return -EINVAL;
 
-	return offsetofend(struct fuse_iomap_config_out, s_maxbytes);
+	return offsetofend(struct fuse_iomap_config_out, cache_maxbytes);
 }
 
 int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
@@ -2899,6 +2900,9 @@ int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
 	if (cfg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
 		arg.s_maxbytes = cfg->s_maxbytes;
 
+	if (cfg->flags & FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
+		arg.cache_maxbytes = cfg->cache_maxbytes;
+
 	return send_reply_ok(req, &arg, reply_size);
 }
 
@@ -2912,7 +2916,8 @@ static void _do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
 	if (req->se->op.iomap_config)
 		req->se->op.iomap_config(req,
 					 arg->flags & FUSE_IOMAP_CONFIG_ALL,
-					 arg->maxbytes);
+					 arg->maxbytes,
+					 arg->cache_maxbytes);
 	else
 		fuse_reply_err(req, ENOSYS);
 }


