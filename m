Return-Path: <linux-fsdevel+bounces-78079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MKQIAThnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F217F366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B6931278BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82237F733;
	Mon, 23 Feb 2026 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEqUY34d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98212749CF;
	Mon, 23 Feb 2026 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888622; cv=none; b=KQvhaUGBbfsbcOnq/2/chYEs/WGumo2S5IHvAKZsnYkKqMkbtAlI5/vhHQdGOalbg3YKeNnlX5+yyxsUcMgV+yUfdGxvX2ASR1ofgUyxR1Sgd5p1Xs1bosIp6xVCkm4/kvFcJgm8vk9YoI+OgEbCn7+OzMkS6wg2twe/av3qwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888622; c=relaxed/simple;
	bh=TKSkugr0i2LOKBumDRGPTX0OZLv3wHzWxm3/bhGMgbQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7rXIigt6v/ikuMYDfJ9intT3+60EDUfubOVVGZkk87Q99QGHtG9foplYw0EQBS73mfvhYFAFR8BVMMd9r1c58LsKMytRH9O1ehg5EjFMIe/VqhbMEK0igkpw8G4j4+10Ye1mymlYRQ6pGl5mEtbew/hDtuT8rnw4qjJW7R1+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEqUY34d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407CEC116C6;
	Mon, 23 Feb 2026 23:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888622;
	bh=TKSkugr0i2LOKBumDRGPTX0OZLv3wHzWxm3/bhGMgbQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NEqUY34dNYh0YE9lNEgr7HsI+RPDoocbON/HCpXXY4kb5YK36k4mM/itc8K6hzPW4
	 5kEM8+7/Nc7B/h7EcaOCQHOcYLNHpBEJOR5KWSBhfK0/FPBV3b4KdKM1fUpwWwD5Xl
	 pHVfCJjPjapBFNTWJyB1jxQjifvAfwYIy4oXue2QhyMcI3UQ3nA0bu9Ps0a8lYl99B
	 kk6Nvm8lION6TfbxNIkolSftWvREir5bSaUVNkuGK+hOFJiif1Xjv4jzmUSxNr2TLd
	 cLoL37O4Xkf34f+Rp9gXS+v02kNoeV2uVlgIYlAnkhjg2frYOznWrhcokw+kyWeZg1
	 RnsOdmBBKQkaA==
Date: Mon, 23 Feb 2026 15:17:01 -0800
Subject: [PATCH 32/33] fuse: enable swapfile activation on iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734929.3935739.10961119760938017137.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78079-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 053F217F366
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

It turns out that fuse supports swapfile activation, so let's enable
that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h      |    1 +
 include/uapi/linux/fuse.h |    5 ++++
 fs/fuse/fuse_iomap.c      |   54 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index de7d483d4b0f34..63cc1496ee5ca1 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -300,6 +300,7 @@ struct iomap;
 	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
 	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
 	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }, \
+	{ FUSE_IOMAP_OP_SWAPFILE,		"swapfile" }, \
 	{ FUSE_IOMAP_OP_WRITEBACK,		"writeback" }
 
 #define FUSE_IOMAP_TYPE_STRINGS \
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 9e59fba64f48d9..5f3724f36f764a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1406,6 +1406,9 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
 /* pagecache writeback operation */
 #define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
 
@@ -1460,6 +1463,8 @@ struct fuse_iomap_end_in {
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
 
 struct fuse_iomap_ioend_in {
 	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 561b0105e6dadc..9a3703b2d65bbd 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
+#include <linux/swap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -202,13 +203,16 @@ static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_flags)
 #undef XMAP2
 #undef XMAP
 
+#define FUSE_IOMAP_PRIVATE_OPS	(FUSE_IOMAP_OP_WRITEBACK | \
+				 FUSE_IOMAP_OP_SWAPFILE)
+
 /* Convert IOMAP_* operation flags to FUSE_IOMAP_OP_* */
 #define XMAP(word) \
 	if (iomap_op_flags & IOMAP_##word) \
 		ret |= FUSE_IOMAP_OP_##word
 static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_flags)
 {
-	uint32_t ret = iomap_op_flags & FUSE_IOMAP_OP_WRITEBACK;
+	uint32_t ret = iomap_op_flags & FUSE_IOMAP_PRIVATE_OPS;
 
 	XMAP(WRITE);
 	XMAP(ZERO);
@@ -749,6 +753,13 @@ fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
 	if (inarg->error)
 		return true;
 
+	/*
+	 * Always send an ioend for swapoff to let the fuse server know the
+	 * long term layout "lease" is over.
+	 */
+	if (inarg->flags & FUSE_IOMAP_IOEND_SWAPOFF)
+		return true;
+
 	/* Send an ioend if we performed an IO involving metadata changes. */
 	return inarg->written > 0 &&
 	       (inarg->flags & (FUSE_IOMAP_IOEND_SHARED |
@@ -1792,6 +1803,43 @@ static void fuse_iomap_readahead(struct readahead_control *rac)
 	iomap_bio_readahead(rac, &fuse_iomap_ops);
 }
 
+#ifdef CONFIG_SWAP
+static int fuse_iomap_swapfile_begin(struct inode *inode, loff_t pos,
+				     loff_t count, unsigned opflags,
+				     struct iomap *iomap, struct iomap *srcmap)
+{
+	return fuse_iomap_begin(inode, pos, count,
+				FUSE_IOMAP_OP_SWAPFILE | opflags, iomap,
+				srcmap);
+}
+
+static const struct iomap_ops fuse_iomap_swapfile_ops = {
+	.iomap_begin		= fuse_iomap_swapfile_begin,
+};
+
+static int fuse_iomap_swap_activate(struct swap_info_struct *sis,
+				    struct file *swap_file, sector_t *span)
+{
+	int ret;
+
+	/* obtain the block device from the header iomapping */
+	sis->bdev = NULL;
+	ret = iomap_swapfile_activate(sis, swap_file, span,
+				      &fuse_iomap_swapfile_ops);
+	if (ret < 0)
+		fuse_iomap_ioend(file_inode(swap_file), 0, 0, ret,
+				 FUSE_IOMAP_IOEND_SWAPOFF, NULL,
+				 FUSE_IOMAP_NULL_ADDR);
+	return ret;
+}
+
+static void fuse_iomap_swap_deactivate(struct file *file)
+{
+	fuse_iomap_ioend(file_inode(file), 0, 0, 0, FUSE_IOMAP_IOEND_SWAPOFF,
+			 NULL, FUSE_IOMAP_NULL_ADDR);
+}
+#endif
+
 static const struct address_space_operations fuse_iomap_aops = {
 	.read_folio		= fuse_iomap_read_folio,
 	.readahead		= fuse_iomap_readahead,
@@ -1802,6 +1850,10 @@ static const struct address_space_operations fuse_iomap_aops = {
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
+#ifdef CONFIG_SWAP
+	.swap_activate		= fuse_iomap_swap_activate,
+	.swap_deactivate	= fuse_iomap_swap_deactivate,
+#endif
 
 	/* These aren't pagecache operations per se */
 	.bmap			= fuse_bmap,


