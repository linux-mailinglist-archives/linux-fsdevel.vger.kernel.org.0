Return-Path: <linux-fsdevel+bounces-77446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C1ZFSn4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA8151D8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066B53067053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10B221FCF;
	Tue, 17 Feb 2026 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUDfuFpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6E2BD030;
	Tue, 17 Feb 2026 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370452; cv=none; b=WZJ6vg5pnV3COFmynJ+7pA1+aLCmb8pb5aTtZ6zcCxg8mEp01ccKziZ1pw6SdeUuaEFLb2OVWkI6QdH+xIVQTRiVIHQRqXDawRVYhZeOHa0qHTOCWRM9Do+t/X1HFK8esBwPVw9arFeEtcx1AaJtZE7JBjqkyuznIx1xC5siAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370452; c=relaxed/simple;
	bh=qx/Df8sJORJf1IIwmJBS0Qqb/MSX7Vd0kYOYy6tQZQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuIcZlXaq040AhIMHdhVu8bDwBuZfzQV4DdKESv3jjzK2ZQY7v2S1tHM6AmHhvNtHbr6+lsTZQp/cs5C6mk5V+9swDmVUhnfzwtPf+M+seC9n0wTiu8gDabHlAb451mf6epyliirESH22MJvZX2woOSgrOABEtc+6/5SnNWa+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUDfuFpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27202C4CEF7;
	Tue, 17 Feb 2026 23:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370452;
	bh=qx/Df8sJORJf1IIwmJBS0Qqb/MSX7Vd0kYOYy6tQZQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUDfuFpqp3J+MYRAuIMVjjGyg1YggvG9LETkgJkMqDsqhBHl/SHD0ByRwNmOMlyiz
	 o3k/fH2TMDgiYgYjfpsii0VAG/d6UC7oTnNvuBTSABplHfu00pOWq+jtCu3iw2LZD+
	 dH1ZCsGL/z8YzQxJzSL4jjCmJbg+o1A5GXkG8swGT7qGEWtr3/1v7m14G9J0k9F/DR
	 0GFXTKZQppkG+UW4ZidFrg/2yyE0kf50v6QYjCK2fS+KgPTmfT3PlGzuXVBQhdKZKA
	 ZaAbJ3vSco/aY38f83jqAnElcr4FJ4eNxOBFTmSHpNIuRnar9T5GPTeLtqH8dUCl08
	 cFXn0BDB2oT+A==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 09/35] iomap: obtain fsverity info for read path
Date: Wed, 18 Feb 2026 00:19:09 +0100
Message-ID: <20260217231937.1183679-10-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77446-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBDA8151D8E
X-Rspamd-Action: no action

The fsverity info would be used in subsequent patch to synthesize merkle
blocks full of hashes of zeroed data blocks, to detect that iomap is
reading fsverity descriptor, and passed down to ioend for filesystem to
initiate fsverity bio verification.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 7 +++++++
 include/linux/iomap.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a95f87b4efe1..cd74a15411cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -8,6 +8,7 @@
 #include <linux/writeback.h>
 #include <linux/swap.h>
 #include <linux/migrate.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -569,6 +570,9 @@ void iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
+	if (fsverity_active(iter.inode))
+		ctx->vi = fsverity_get_info(iter.inode);
+
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&bytes_submitted);
@@ -633,6 +637,9 @@ void iomap_readahead(const struct iomap_ops *ops,
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
+	if (fsverity_active(iter.inode))
+		ctx->vi = fsverity_get_info(iter.inode);
+
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_submitted);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 94cf6241b37f..771962549d74 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -428,6 +428,7 @@ struct iomap_ioend {
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
 	void			*io_private;	/* file system private data */
+	struct fsverity_info	*io_vi;		/* fsverity info */
 	struct bio		io_bio;		/* MUST BE LAST! */
 };
 
@@ -502,6 +503,7 @@ struct iomap_read_folio_ctx {
 	struct readahead_control *rac;
 	void			*read_ctx;
 	loff_t			read_ctx_file_offset;
+	struct fsverity_info	*vi;
 };
 
 struct iomap_read_ops {
-- 
2.51.2


