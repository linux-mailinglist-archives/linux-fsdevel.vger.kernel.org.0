Return-Path: <linux-fsdevel+bounces-78044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IjQENvdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D817ED82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABBB730349BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC637E301;
	Mon, 23 Feb 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3pQ06JS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021137E2E9;
	Mon, 23 Feb 2026 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888074; cv=none; b=C8Q/YrhtnqdI5ivtmY2VqeQWGkMgsgWIi+J3ODRHLJQ4Nk4QenWlAvKvkx5N/vV4AKVFBXaE2cAqSMyehOVIVy48uk1ufkea1zXMsTOoUIGyM2N//+J/B45o6375Ruq/eV7riut2xOiqvIFoUUGkKPMfqiYOJayGQYQkgA4NaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888074; c=relaxed/simple;
	bh=c9KDfeahvAuRTlLPneYcPLJVvSvC/HLD6axIRhTRsps=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3jYWsbtWxIfJCB3Z5mXEthJIN1AbP5y6Qsi+lEoANNdxBb7aWsGozFyGlDbji2TPTOYhH409XCT3Zx9l8USJ5XvpVriVKxAeb0O11hC4TLsl/1m4vWTqH2C1AmQ3glWeq2Jg5EExidGCLVz9XJ5ttS96inbdtAuw3ie6bXZxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3pQ06JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4F0C116C6;
	Mon, 23 Feb 2026 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888073;
	bh=c9KDfeahvAuRTlLPneYcPLJVvSvC/HLD6axIRhTRsps=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e3pQ06JSvYyrYYu+AA9gq86cf5D86KKwa0aT9PIxjserp/cJmL6lh9U6Tg3AAPf6s
	 uBYynzy6s8GxhyGaUKXC6YdUGKgPEa/8yuSfLimI65GllYvn64ZqcFt01+Vk/y9apd
	 eH2O8TtAcQdZ4REK0YQw3JBMPJEb0U+RfGV6LiNxDJofnv9m9+CH2hrJcb/LA2UgkX
	 5FATEyysNjwzyGsR1H/2G4KF9rkVY7YKRGmrKXNv/VX/XvZaevX2sp7YjUEAPsCKv3
	 BPUj1Ql00C4RFt19+YvX5MEYgmXAskaBonEbthPNuI++DjE6hZ7V8i6Fr2A3WXlIe8
	 x+hVdZ442+rSw==
Date: Mon, 23 Feb 2026 15:07:53 -0800
Subject: [PATCH 1/2] iomap: allow directio callers to supply _COMP_WORK
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org
Cc: bpf@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188733463.3935463.15637212610999039409.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78044-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D69D817ED82
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Allow callers of iomap_dio_rw to specify the _COMP_WORK flag if they
require that all directio ioend completions occur in process context.
The upcoming fuse-iomap patchset needs this because fuse requests
(specifically FUSE_IOMAP_IOEND) cannot be sent from interrupt context.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/iomap.h |    3 +++
 fs/iomap/direct-io.c  |    5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)


diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 99b7209dabd77c..a47befc23a8a2d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -575,6 +575,9 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_BOUNCE		(1 << 4)
 
+/* Run IO completions from process context */
+#define IOMAP_DIO_COMP_WORK		(1 << 5)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e911daedff65ae..59e6028a37d362 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -19,7 +19,6 @@
  * iomap.h:
  */
 #define IOMAP_DIO_NO_INVALIDATE	(1U << 26)
-#define IOMAP_DIO_COMP_WORK	(1U << 27)
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
 #define IOMAP_DIO_NEED_SYNC	(1U << 29)
 #define IOMAP_DIO_WRITE		(1U << 30)
@@ -700,7 +699,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
+	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED |
+				  IOMAP_DIO_BOUNCE |
+				  IOMAP_DIO_COMP_WORK);
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;


