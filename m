Return-Path: <linux-fsdevel+bounces-77461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMR0KMv4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:24:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07728151E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66ED230A6284
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7842F363C;
	Tue, 17 Feb 2026 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lks85F+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE929D297;
	Tue, 17 Feb 2026 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370484; cv=none; b=o7qZuEHoOeT8pJDVvjnqyTrzp9qDZwtmwxYmide5s2C/BVyRilinXKX74bHDF5mSoQc+R9ibrVvLmtqTigSOYbzimXSK+dMPEozQGqcI6mshmANd10FXCd30hCyuq/oVoOBXOOZ3z+njz8uQ3MEWmQA6t4HJgMy8XGKOqw0442o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370484; c=relaxed/simple;
	bh=zg2v2JO11+Ngj5KaV5YQSJy0IZ71k+hObZNR6t4DSK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ygu4snYqmJ6qsICqsRPwO4mhVi2s+kgaTNJpNvgYOvIgSzfAr53Nptry8wkSF7LCGYHSH70mn7xJr3X9S5BS5UyvmovN7N/2FI7Qgdr3kvi+x7DaecW6G5XgH6sWG1Hz9Vd/g7M9u/q1QSNhJJKhN8uyg87On7urlzeR6wEp1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lks85F+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42C4C19421;
	Tue, 17 Feb 2026 23:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370484;
	bh=zg2v2JO11+Ngj5KaV5YQSJy0IZ71k+hObZNR6t4DSK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lks85F+eEcizqt1mM7Q5kV0QUEtBS590R9/FZNnsgGK57DfUdJGxrFRsbiFrI5Srm
	 YIljsx/4m4pdu4CytD5tIknCfqQmryu1pGVRvLgLEyHxz46vdIquSIWb1MiJU2CPhX
	 kIfpe14ASONIpv8WKWB/eUbZbQStIcH2hmYIRVpacHQyjbt3R07QDyujgWyn71KGJV
	 p5+/IZVjCFqYufwvDHBWvxOH+jXjV4yK9A2Yh1ev+/hoP+ox3tCb5KBlIipXRquayy
	 CVCTwazAcT+KvCWLfWG0jngH4pfTYf8ZjXNqUU62s1WwwF+C/95ywljhfuhnjopmwT
	 BnHvrjR212GNQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 24/35] xfs: use read ioend for fsverity data verification
Date: Wed, 18 Feb 2026 00:19:24 +0100
Message-ID: <20260217231937.1183679-25-aalbersh@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-77461-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 07728151E4B
X-Rspamd-Action: no action

The ioends are offloaded to workqueue for further processing of
completed BIOs. Use read end ioends for fsverity verification.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_aops.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f95dc51eb044..9d4fc3322ec7 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -204,11 +204,15 @@ xfs_end_io(
 			io_list))) {
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
-		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
+		if (bio_op(&ioend->io_bio) == REQ_OP_READ) {
+			if (xfs_fsverity_sealed_data(ip, ioend->io_offset))
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
@@ -766,9 +770,12 @@ xfs_bio_submit_read(
 	struct iomap_read_folio_ctx	*ctx)
 {
 	struct bio			*bio = ctx->read_ctx;
+	struct iomap_ioend		*ioend;
 
 	/* delay read completions to the ioend workqueue */
-	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	ioend = iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	ioend->io_vi = ctx->vi;
+
 	bio->bi_end_io = xfs_end_bio;
 	submit_bio(bio);
 }
@@ -781,10 +788,13 @@ static const struct iomap_read_ops xfs_bio_read_integrity_ops = {
 
 static inline const struct iomap_read_ops *
 xfs_bio_read_ops(
-	const struct xfs_inode		*ip)
+	const struct xfs_inode		*ip,
+	loff_t				offset)
 {
 	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
 		return &xfs_bio_read_integrity_ops;
+	if (xfs_fsverity_sealed_data(ip, offset))
+		return &xfs_bio_read_integrity_ops;
 	return &iomap_bio_read_ops;
 }
 
@@ -793,9 +803,11 @@ xfs_vm_read_folio(
 	struct file			*file,
 	struct folio			*folio)
 {
+	const struct iomap_read_ops	*ops = xfs_bio_read_ops(
+			XFS_I(folio->mapping->host), folio_pos(folio));
 	struct iomap_read_folio_ctx	ctx = {
 		.cur_folio	= folio,
-		.ops		= xfs_bio_read_ops(XFS_I(folio->mapping->host)),
+		.ops		= ops,
 	};
 
 	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
@@ -806,9 +818,11 @@ STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
+	const struct iomap_read_ops	*ops = xfs_bio_read_ops(
+			XFS_I(rac->mapping->host), readahead_pos(rac));
 	struct iomap_read_folio_ctx	ctx = {
 		.rac		= rac,
-		.ops		= xfs_bio_read_ops(XFS_I(rac->mapping->host)),
+		.ops		= ops,
 	};
 
 	iomap_readahead(&xfs_read_iomap_ops, &ctx);
-- 
2.51.2


