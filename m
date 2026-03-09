Return-Path: <linux-fsdevel+bounces-79858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4cXsNacgr2myOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:33:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF8240135
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB980317F9EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E83F23C5;
	Mon,  9 Mar 2026 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ8loh5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7823644CA;
	Mon,  9 Mar 2026 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084305; cv=none; b=b5YDGWJybAJ5mq+ISROPgfhLhIl6l9BKRQCank1SsJKAvKjmIQgtRSHrGNWup2LsvDn3V5OOAVi1/AZ4UkrESXQItqxVRDbElpdgucxv50SQE6H4MNqWX6O0hg1G561ICpU9iNNpALBxjzoDyl4a2Y1NcqttnUjG3X/8MA/rxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084305; c=relaxed/simple;
	bh=DQEndQAoCf4m7MpL7bFjS6WxNU6FZTJxhh7cr9rbp4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2uSYAwBlkF7/4FtpnTo0JmopLo1Myq/xvQotUCQQsbs1DNCPgnZn4IvsY3Fa28k1t9mWIusPGoGIlvOnaFaFXum9ZGLNhV9Sy8vR7hq4aDoq6mTyAfKMKuL5OJ64BYNAZpl4HowDuSHDxsITBQly4CdQwLv8HU73p7dJc5S8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ8loh5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193FDC2BC87;
	Mon,  9 Mar 2026 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084305;
	bh=DQEndQAoCf4m7MpL7bFjS6WxNU6FZTJxhh7cr9rbp4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZ8loh5yiEln8MnOXzxFPXsyLzdOqdAPPxDPvqQfBPM0kaGIA4plWk/5Nl9gUrusg
	 f807JKb6uY2uWuqNFjCkgOyXd+8XC5pLOL9F9+HiF6UI8X0JyB/Jk+2QCXGCzc+ebC
	 2amzox4KAXV7s1ONFIBZ4auZ8/S2eqo+RTByF8MZG7Ib/uR70OI69jGUwOGwYonlXI
	 FUdHjwt1HkYoLotMTcLXzmuF3yY1u/DKbZpEonqU8ROElijcR/8N32A9Qp6lDuF4MP
	 T0fC9KpP+wAH5yY6UMpiHBCv6/5UJxmqj5H4ngoGc4OZxy6/KS/xWzS79XzV1fWuxU
	 wXZTpjzjS0F0A==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	djwong@kernel.org
Subject: [PATCH v4 17/25] xfs: use read ioend for fsverity data verification
Date: Mon,  9 Mar 2026 20:23:32 +0100
Message-ID: <20260309192355.176980-18-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260309192355.176980-1-aalbersh@kernel.org>
References: <20260309192355.176980-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74EF8240135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79858-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use read ioends for fsverity verification. Do not issues fsverity
metadata I/O through the same workqueue due to risk of a deadlock by a
filled workqueue.

Pass fsverity_info from iomap context down to the ioend as hashtable
lookups are expensive.

Add a simple helper to check that this is not fsverity metadata but file
data that needs verification.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_aops.c     | 32 ++++++++++++++++++++++++--------
 fs/xfs/xfs_fsverity.c | 11 +++++++++++
 fs/xfs/xfs_fsverity.h |  6 ++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9503252a0fa4..4e3dcc4a321d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -24,6 +24,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_fsverity.h"
 #include <linux/bio-integrity.h>
+#include <linux/fsverity.h>
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -204,11 +205,15 @@ xfs_end_io(
 			io_list))) {
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
-		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
+		if (bio_op(&ioend->io_bio) == REQ_OP_READ) {
+			if (xfs_fsverity_is_file_data(ip, ioend->io_offset))
+				fsverity_verify_bio(ioend->io_vi,
+						    &ioend->io_bio);
 			iomap_finish_ioends(ioend,
 				blk_status_to_errno(ioend->io_bio.bi_status));
-		else
+		} else {
 			xfs_end_ioend_write(ioend);
+		}
 		cond_resched();
 	}
 }
@@ -232,9 +237,14 @@ xfs_end_bio(
 	}
 
 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
-	if (list_empty(&ip->i_ioend_list))
-		WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
+	if (list_empty(&ip->i_ioend_list)) {
+		if (IS_ENABLED(CONFIG_FS_VERITY) && ioend->io_vi &&
+		    ioend->io_offset < xfs_fsverity_metadata_offset(ip))
+			fsverity_enqueue_verify_work(&ip->i_ioend_work);
+		else
+			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
 					 &ip->i_ioend_work));
+	}
 	list_add_tail(&ioend->io_list, &ip->i_ioend_list);
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 }
@@ -764,9 +774,12 @@ xfs_bio_submit_read(
 	struct iomap_read_folio_ctx	*ctx)
 {
 	struct bio			*bio = ctx->read_ctx;
+	struct iomap_ioend		*ioend;
 
 	/* defer read completions to the ioend workqueue */
-	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	ioend = iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	ioend->io_vi = ctx->vi;
+
 	bio->bi_end_io = xfs_end_bio;
 	submit_bio(bio);
 }
@@ -779,12 +792,15 @@ static const struct iomap_read_ops xfs_iomap_read_ops = {
 
 static inline const struct iomap_read_ops *
 xfs_get_iomap_read_ops(
-	const struct address_space	*mapping)
+	const struct address_space	*mapping,
+	loff_t				position)
 {
 	struct xfs_inode		*ip = XFS_I(mapping->host);
 
 	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
 		return &xfs_iomap_read_ops;
+	if (xfs_fsverity_is_file_data(ip, position))
+		return &xfs_iomap_read_ops;
 	return &iomap_bio_read_ops;
 }
 
@@ -795,7 +811,7 @@ xfs_vm_read_folio(
 {
 	struct iomap_read_folio_ctx	ctx = { .cur_folio = folio };
 
-	ctx.ops = xfs_get_iomap_read_ops(folio->mapping);
+	ctx.ops = xfs_get_iomap_read_ops(folio->mapping, folio_pos(folio));
 	iomap_read_folio(&xfs_read_iomap_ops, &ctx, NULL);
 	return 0;
 }
@@ -806,7 +822,7 @@ xfs_vm_readahead(
 {
 	struct iomap_read_folio_ctx	ctx = { .rac = rac };
 
-	ctx.ops = xfs_get_iomap_read_ops(rac->mapping),
+	ctx.ops = xfs_get_iomap_read_ops(rac->mapping, readahead_pos(rac));
 	iomap_readahead(&xfs_read_iomap_ops, &ctx, NULL);
 }
 
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index bc6020cc6e41..dc66ffb7d132 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -32,3 +32,14 @@ xfs_fsverity_metadata_offset(
 {
 	return round_up(i_size_read(VFS_IC(ip)), 65536);
 }
+
+bool
+xfs_fsverity_is_file_data(
+	const struct xfs_inode	*ip,
+	loff_t			offset)
+{
+	const struct inode	*inode = VFS_IC(ip);
+
+	return fsverity_active(inode) &&
+	       offset < xfs_fsverity_metadata_offset(ip);
+}
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
index 5771db2cd797..ec77ba571106 100644
--- a/fs/xfs/xfs_fsverity.h
+++ b/fs/xfs/xfs_fsverity.h
@@ -9,12 +9,18 @@
 
 #ifdef CONFIG_FS_VERITY
 loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip);
+bool xfs_fsverity_is_file_data(const struct xfs_inode *ip, loff_t offset);
 #else
 static inline loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip)
 {
 	WARN_ON_ONCE(1);
 	return ULLONG_MAX;
 }
+static inline bool xfs_fsverity_is_file_data(const struct xfs_inode *ip,
+					    loff_t offset)
+{
+	return false;
+}
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_FSVERITY_H__ */
-- 
2.51.2


