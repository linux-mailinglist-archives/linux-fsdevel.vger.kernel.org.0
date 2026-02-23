Return-Path: <linux-fsdevel+bounces-78139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB0TAaHjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:32:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B817F8A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F687305BFD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A29737F8CC;
	Mon, 23 Feb 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBsrdQvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E836B054;
	Mon, 23 Feb 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889560; cv=none; b=FzdbejtblbU4mtfQ4ZfriaTof7GEPKIw7VfiY+uErJIUwR0rKloICwVwECtIHrW0s09KhlptKfHf7+xKIgrANC/m+Pn+OQZvfQZo4AGWGhEmetlFuxouok8Y7bFIgyF8X77ncOgIH9BEM5tv3kIvTjD8KDqwBIbYku6fKHl4x9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889560; c=relaxed/simple;
	bh=K32OCWitPVfFFZQUmaLqurP2mPvgEvRO8HwQB5M4wyQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3vWIT8sL7ilNk9UFJ8jHLy2VlF38Ut0fJksal9gWUnercW8KL92QBcMhe79vMvwB7MtL4EDw99dW/3Fvx/KHwrHp3fRm18uTU2xmKYm0jbSW4KqNAg8AV/S8LSajA2WZfYZIHdmQopXfZT/LUsqbAbdaSlzv/aKcrCH6/9nXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBsrdQvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97680C116C6;
	Mon, 23 Feb 2026 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889559;
	bh=K32OCWitPVfFFZQUmaLqurP2mPvgEvRO8HwQB5M4wyQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OBsrdQvuaVd14YM81/21WcI42Xb9eekC4SJV0zQnAQsMzkxMLwtfQN10N8CRrABvE
	 62b8P20ptbQtaWlnS0KIMF5HBMVez/l3peX+7RUJWfsTjbnWi4aanyOfur+HteIiTX
	 7su/SbrXsrIorYxTpFPEx8Z9WBK2IBvdzZ53z+n4MLe9FwBwBWCD70fXcQohdbQshV
	 HMWn+km3fmdxbeu7APEn1Nl260Z/29o/+bKm/vMSYM0CWEJZuoqkfJ1Y8rcbA5rt/O
	 YU17HipsfM0yP3RI3JevJAPtCFYtnsqBE6W01h2zuN89e8xOjPdrVrqnhnxbdVOPFN
	 Mum4zDdHfqdQg==
Date: Mon, 23 Feb 2026 15:32:39 -0800
Subject: [PATCH 2/2] libfuse: set sync, immutable,
 and append when loading files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740809.3941738.14644457167260941533.stgit@frogsfrogsfrogs>
In-Reply-To: <177188740769.3941738.15253689862800289077.stgit@frogsfrogsfrogs>
References: <177188740769.3941738.15253689862800289077.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78139-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A7B817F8A7
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add these three fuse_attr::flags bits so that servers can mark a file as
immutable or append-only and have the kernel advertise and enforce that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    6 ++++++
 include/fuse_kernel.h |    8 ++++++++
 lib/fuse_lowlevel.c   |    6 ++++++
 3 files changed, 20 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index a8aec81ec123a2..d1bd783cd667c7 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1243,6 +1243,12 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_IOMAP		(1U << 2)
 /* enable untorn writes */
 #define FUSE_IFLAG_ATOMIC		(1U << 3)
+/* file writes are synchronous */
+#define FUSE_IFLAG_SYNC			(1U << 4)
+/* file is immutable */
+#define FUSE_IFLAG_IMMUTABLE		(1U << 5)
+/* file is append only */
+#define FUSE_IFLAG_APPEND		(1U << 6)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index ff21973e1c88f7..bee825a6d17ad5 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -249,6 +249,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -593,12 +595,18 @@ struct fuse_file_lock {
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
  * FUSE_ATTR_ATOMIC: Enable untorn writes
+ * FUSE_ATTR_SYNC: File writes are always synchronous
+ * FUSE_ATTR_IMMUTABLE: File is immutable
+ * FUSE_ATTR_APPEND: File is append-only
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
 #define FUSE_ATTR_ATOMIC	(1 << 4)
+#define FUSE_ATTR_SYNC		(1 << 5)
+#define FUSE_ATTR_IMMUTABLE	(1 << 6)
+#define FUSE_ATTR_APPEND	(1 << 7)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 18503a1fa64d88..7b501e2f3ef047 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -170,6 +170,12 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_IOMAP;
 	if (iflags & FUSE_IFLAG_ATOMIC)
 		attr->flags |= FUSE_ATTR_ATOMIC;
+	if (iflags & FUSE_IFLAG_SYNC)
+		attr->flags |= FUSE_ATTR_SYNC;
+	if (iflags & FUSE_IFLAG_IMMUTABLE)
+		attr->flags |= FUSE_ATTR_IMMUTABLE;
+	if (iflags & FUSE_IFLAG_APPEND)
+		attr->flags |= FUSE_ATTR_APPEND;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


