Return-Path: <linux-fsdevel+bounces-78114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIhYGzfinGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:26:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0A17F5C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76BAF308C77D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128337F8A2;
	Mon, 23 Feb 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M66xCcve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A936334C35;
	Mon, 23 Feb 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889169; cv=none; b=Z0DsvQ6uBaSdG3TcYgeBbARFGbal+im2elICR1dbO4IxFKkXJTNhTnq9hNZdPVJYyPvHVTnb3Nmx6MThwSi46l7A7Eka5P92Fxwf8PyR8r8pigQDPx78spPq4s8Mub0gIubAnEP9dCt/nj14xUocavlw+j0JMymqxf2jtVBGfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889169; c=relaxed/simple;
	bh=OCnuwgrlgRu4WxNbNZ4YPew8T7b0+vCWsVKhdzb9NtQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTAAesZfBVGzEOiJ+O7piMPi8act81OHcbl7+x060bTPyY53O+lptCKKUMnvd58jYzrmv90pW6pG2Bo23Z99m5f/JkE93YNTqG6/GrS7ua+aRxBy7/pTgYZKzT+ZVAXmY0e/dUvAvV6fVWbU//9x80rFW9+L1K1JGTenT6kIkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M66xCcve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B14C116C6;
	Mon, 23 Feb 2026 23:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889169;
	bh=OCnuwgrlgRu4WxNbNZ4YPew8T7b0+vCWsVKhdzb9NtQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=M66xCcved+brKarGkTuWOdbuQ16buQTdcfn1Snd6cmDm6R0Qvc6FkawdGF688AInJ
	 kOGumzNs3lc3Q4BSGE3AzMoJDbUzEa4sUiIbtH5t51Xmrvx4chcG9aUvEpSol92TOV
	 O6GaKZIzwKb2C7tC3XpE3jEdGwaZI9AnAYFbTw18KZeTzFKOI7j6CkScVt1W+/NAZu
	 Fj60y7p61bXYtD1jfVXT27TFHkgIRxQSbB+fEVxFcQPgiJi++lf93qB1bioyPwaxP6
	 34bmih7vBnI0FRY6JHDyFC46bRWPZJe9Qu3TV3bRy0PsIXI83LN9wMDbMAOU0T12+N
	 7r5SdKLf91CCg==
Date: Mon, 23 Feb 2026 15:26:08 -0800
Subject: [PATCH 03/25] libfuse: add kernel gates for FUSE_IOMAP
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188739992.3940670.1306861107291789968.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78114-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DC0A17F5C2
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add some flags to query and request kernel support for filesystem iomap
for regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |   12 +++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 041188ec7fa732..9d53354de78868 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_OVER_IO_URING (1UL << 31)
 
+/**
+ * Client supports using iomap for regular file operations
+ */
+#define FUSE_CAP_IOMAP (1ULL << 32)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 842cc08a083a6f..354a6da01c2ecc 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -243,6 +243,7 @@
  *
  *  7.99
  *  - XXX magic minor revision to make experimental code really obvious
+ *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  */
 
 #ifndef _LINUX_FUSE_H
@@ -451,6 +452,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_IOMAP: Client supports iomap for regular file operations
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -498,6 +500,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_IOMAP		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index c3d57f5c5b104c..237c02c6dce7d5 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2817,7 +2817,10 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
-
+		if (inargflags & FUSE_IOMAP)
+			se->conn.capable_ext |= FUSE_CAP_IOMAP;
+		/* Don't let anyone touch iomap until the end of the patchset. */
+		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2863,6 +2866,9 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		       FUSE_CAP_READDIRPLUS_AUTO);
 	LL_SET_DEFAULT(1, FUSE_CAP_OVER_IO_URING);
 
+	/* servers need to opt-in to iomap explicitly */
+	LL_SET_DEFAULT(0, FUSE_CAP_IOMAP);
+
 	/* This could safely become default, but libfuse needs an API extension
 	 * to support it
 	 * LL_SET_DEFAULT(1, FUSE_CAP_SETXATTR_EXT);
@@ -2980,6 +2986,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_IOMAP)
+		outargflags |= FUSE_IOMAP;
 
 	outarg.max_readahead = se->conn.max_readahead;
 	outarg.max_write = se->conn.max_write;
@@ -3014,6 +3022,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		if (se->conn.want_ext & FUSE_CAP_PASSTHROUGH)
 			fuse_log(FUSE_LOG_DEBUG, "   max_stack_depth=%u\n",
 				outarg.max_stack_depth);
+		if (se->conn.want_ext & FUSE_CAP_IOMAP)
+			fuse_log(FUSE_LOG_DEBUG, "   iomap=1\n");
 	}
 	if (arg->minor < 5)
 		outargsize = FUSE_COMPAT_INIT_OUT_SIZE;


