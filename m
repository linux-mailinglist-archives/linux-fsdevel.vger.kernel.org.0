Return-Path: <linux-fsdevel+bounces-78131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD0tKonjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:32:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4254017F867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38BB430731A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8650A37F8BC;
	Mon, 23 Feb 2026 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojFnLY6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A237BE9E;
	Mon, 23 Feb 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889435; cv=none; b=ngrEFfdsorApvYQghjT6yYSXBqu42D9Krn6+xsPWI+t7g40uja0jil26p4vKMYZc4z17SUhLMOKYnnvpC92slt4J8pt5/fqpjwqyb2yFX7VDYvWSeH92gclimneJ38C6hZIu1V0QvULK7rWSmL//oFzCFKp9loA8HZkDFT+yPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889435; c=relaxed/simple;
	bh=8Ob4rSOeJC/BZYNGuQFHKOtdOn2PmNT7CLSPZHmMpsQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFfm6eilCTbcdPn+57OiLVxBtniJ95Kvx/qymDhiad686vlu97g01jyX3gJC1c8M4b9xqqRPAeYtkP1vOf+eSHVg64JuWkaWUI8yX4Xwf/e4vcFCc33AxWt3eArGOFFT9ctkbPBvvmkV8vjZeGX9XpW9+e8fRJtitbnpFOLalLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojFnLY6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94C9C116C6;
	Mon, 23 Feb 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889434;
	bh=8Ob4rSOeJC/BZYNGuQFHKOtdOn2PmNT7CLSPZHmMpsQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ojFnLY6pTJZsWfX6sWGVOSWo5YKBToC4Datm22Dko0p1Of3T/YfEtLRUkHH2EWBes
	 +Jaxl/ol5HlFspbFqy8eC5ki4Hfey1tKt3t6hb1D0UtqvRK8lKuCu4B+DGrDGRLnji
	 eHTLf4MGfi1Ef9rxvYnD1Q6UArFv8OnN/yaawhb4NGfC1pxTQfGXPJg3eGms09voyD
	 TWW1jRPVI3i/VW4IpXftmCwpBvkKp34+s72UlLC4j9UI2Mn8hoZp6YX+bAV6hcBNC/
	 s0wBCZvWq1sTG4S6udaXz60uIr8kdkC7/2NQtlt3Gld/5ADpXSIJhboQ6E4OsjklaC
	 8H8yVCRIrrv0A==
Date: Mon, 23 Feb 2026 15:30:34 -0800
Subject: [PATCH 20/25] libfuse: add atomic write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740292.3940670.15942150548008378091.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78131-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 4254017F867
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add the single flag that we need to turn on atomic write support in
fuse.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    4 ++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 9 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 2f6672fc14d90d..a42d70f79d57e1 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -540,6 +540,8 @@ struct fuse_loop_config_v1 {
  * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
  */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 
 /**
  * Connection information, passed to the ->init() method
@@ -1234,6 +1236,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_EXCLUSIVE		(1U << 1)
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 2)
+/* enable untorn writes */
+#define FUSE_IFLAG_ATOMIC		(1U << 3)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 1e7c9d8082cf23..71a6a92b4b4a65 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -248,6 +248,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -591,11 +592,13 @@ struct fuse_file_lock {
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
+#define FUSE_ATTR_ATOMIC	(1 << 4)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 89e26f207addbf..91aaf6a1183d30 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -168,6 +168,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_EXCLUSIVE;
 	if (iflags & FUSE_IFLAG_IOMAP)
 		attr->flags |= FUSE_ATTR_IOMAP;
+	if (iflags & FUSE_IFLAG_ATOMIC)
+		attr->flags |= FUSE_ATTR_ATOMIC;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


