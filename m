Return-Path: <linux-fsdevel+bounces-79865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAY5O7gfr2neOAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:30:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D623FFB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F3FA302F23F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16B141325B;
	Mon,  9 Mar 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZYW1nAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0D413220;
	Mon,  9 Mar 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084324; cv=none; b=DzceP3RyBqxtXa3Ytej4X/5kxhw2yw0tXbloD/OgDgyxD4RWFQD0YtGaeGQmWLBe5Tt/LQX98Dl0zrrTfUsQ7abI6SurQ+1JytsCrSa+17e2Bym3+1yHMvPV9T8fQ9d0jEZ7/VP7QxR5gYuVv5eOcWYSNuUEAJRuhvRXZKpoAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084324; c=relaxed/simple;
	bh=q+80M4WVwB0jriNEN9Ewn5e6CqLpErMAF/cbVAJOGpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK56mmJgpIAPBjJXXqy7PIUig5oRltmJPzJpGaYt0FPDWVh51YG1xHcFGyqbUnX3++IIyHr/073yswmy9FT+2V4szePKzeBEFCbYYsZZTN5HVWfvfXSTv4ftx6bpKMgdWU8n2A+PRu+phP4O7SdzmKtR4ZVvzUGLBQ0XTKgle2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZYW1nAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE2DC4CEF7;
	Mon,  9 Mar 2026 19:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084324;
	bh=q+80M4WVwB0jriNEN9Ewn5e6CqLpErMAF/cbVAJOGpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZYW1nAmbw9jWj6fXPPX3hvrZWj8/q/sJSrRcyof83ttU4SLvmxGfjsKp0SIUsT7I
	 p4Xzr7esilW2G4EOnfqlyFqdrN9BO1qOGch7qH5QCfYfvo9ZaO8wuhAIozRVZcIxZq
	 F3EednrXH9XMoGDyKrOx3Up7dJs6wk07KklhIdF3jx07UjCUGju+u3DmRJrO/Wj5zb
	 mj0IXDDSBnnAP4x5CTonrJba7pQQAMiYnvodOwraWrQ/YK+Co/lGrkiBcPX8I7eK9Z
	 SuVAMm4blhSuvIdZJA5QJH0mnln49FuuxJLwdeWrN38SO9V2cfMzOzdzolHwdYK6Wp
	 IX6quVnylZqYg==
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
Subject: [PATCH v4 24/25] xfs: add fsverity traces
Date: Mon,  9 Mar 2026 20:23:39 +0100
Message-ID: <20260309192355.176980-25-aalbersh@kernel.org>
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
X-Rspamd-Queue-Id: 008D623FFB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79865-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Even though fsverity has traces, debugging issues with varying block
sizes could be a bit less transparent without read/write traces.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsverity.c |  6 ++++++
 fs/xfs/xfs_trace.h    | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index adc53dad174b..f18426acdafd 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -79,6 +79,8 @@ xfs_fsverity_get_descriptor(
 	uint32_t		blocksize = i_blocksize(VFS_I(ip));
 	xfs_fileoff_t		last_block_offset;
 
+	trace_xfs_fsverity_get_descriptor(ip);
+
 	ASSERT(inode->i_flags & S_VERITY);
 	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
 	if (error)
@@ -380,6 +382,7 @@ xfs_fsverity_read_merkle(
 	pgoff_t			index)
 {
 	index += xfs_fsverity_metadata_offset(XFS_I(inode)) >> PAGE_SHIFT;
+	trace_xfs_fsverity_read_merkle(XFS_I(inode), index, PAGE_SIZE);
 
 	return generic_read_merkle_tree_page(inode, index);
 }
@@ -394,6 +397,7 @@ xfs_fsverity_readahead_merkle_tree(
 	unsigned long		nr_pages)
 {
 	index += xfs_fsverity_metadata_offset(XFS_I(inode)) >> PAGE_SHIFT;
+	trace_xfs_fsverity_read_merkle(XFS_I(inode), index, PAGE_SIZE);
 
 	generic_readahead_merkle_tree(inode, index, nr_pages);
 }
@@ -417,6 +421,8 @@ xfs_fsverity_write_merkle(
 	const char		*p;
 	unsigned int		i;
 
+	trace_xfs_fsverity_write_merkle(XFS_I(inode), position, size);
+
 	if (position + size > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 813e5a9f57eb..77e1a4f27f63 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6419,6 +6419,51 @@ TRACE_EVENT(xfs_verify_media_error,
 		  __entry->error)
 );
 
+TRACE_EVENT(xfs_fsverity_get_descriptor,
+	TP_PROTO(struct xfs_inode *ip),
+	TP_ARGS(ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+	),
+	TP_printk("dev %d:%d ino 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino)
+);
+
+DECLARE_EVENT_CLASS(xfs_fsverity_class,
+	TP_PROTO(struct xfs_inode *ip, u64 pos, size_t length),
+	TP_ARGS(ip, pos, length),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(u64, pos)
+		__field(size_t, length)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->pos = pos;
+		__entry->length = length;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->length)
+)
+
+#define DEFINE_FSVERITY_EVENT(name) \
+DEFINE_EVENT(xfs_fsverity_class, name, \
+	TP_PROTO(struct xfs_inode *ip, u64 pos, size_t length), \
+	TP_ARGS(ip, pos, length))
+DEFINE_FSVERITY_EVENT(xfs_fsverity_read_merkle);
+DEFINE_FSVERITY_EVENT(xfs_fsverity_write_merkle);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.51.2


