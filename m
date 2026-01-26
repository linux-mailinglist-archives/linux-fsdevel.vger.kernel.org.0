Return-Path: <linux-fsdevel+bounces-75437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG46A00Cd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0F84527
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6BB3042898
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B65237180;
	Mon, 26 Jan 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBrzqICr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF832222C5;
	Mon, 26 Jan 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406923; cv=none; b=D09TcdwYvak0tN5ONPa4r38p1+R0NyaXse6Ek9T5kUdDbOBStAPb6x4dc/g3yzONFxtrCQP9arwk4mRS82WVcTPF4mVBz9q5AJXl9kyz+Ut+kkLMKTMHQodxZEuJyfBycDg+15ysp9ShdwAOzFedLrbDF0tTcBWn7Z2rvD5blq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406923; c=relaxed/simple;
	bh=ClZPeguK/y+eOhkO2uw7JlQDKY0f3muZVrDZENExNBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6/btc1bJ7d6g4E8DkZIjN9N7OCDY8n51mw/ar7g3YOTWtvMa9BYrg4xKeTZsziVQNWYKRxBw6UfmP94LTt7cvn4On/Mc6cGnjqHWlPdNRzUqC7mjTEPIzAlpIj0HKKDLy1iBJWF6y9q8nv1/wjyQfDMHbnTZqDl+mp7NhwVpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VBrzqICr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GcNsDkaX+lcM+z3q/2wy6S3rdkfddssuzMYYjf6TTkU=; b=VBrzqICrtp7FoLrKPRdsFrvk2T
	yrTINtOGrMuuIvnFE3kN/SIEm/rftgcLz3tAFh+ylZ1NHjgbMkl3SrSH5deeOGhWGKTqRhZdsVct9
	R8RdMF8C2eBDVbiRus73vd9Tp7Yg/XTX+Bb8tDK3NxCHg4wk9GEsJ+6izDO6dzdVM6qhMHnIkAGww
	3XuacFugszgsRjbK0nUvHMkMiyW/YRMdsAQPLYky4PLIgxj/s9iT9RBNa38t3O9pCkcvgWPMj8o85
	U9VnPftD/WDV4XxvjjYNT4G7ysSUO1OQQ/gQpKGM0GJAPp8FU1xf0osfda0GCEYN3FQ1/QmAEbHqB
	4SAdk+bA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFZI-0000000BxKa-2ebb;
	Mon, 26 Jan 2026 05:55:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 13/15] iomap: support ioends for direct reads
Date: Mon, 26 Jan 2026 06:53:44 +0100
Message-ID: <20260126055406.1421026-14-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
References: <20260126055406.1421026-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75437-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,samsung.com:email]
X-Rspamd-Queue-Id: 86E0F84527
X-Rspamd-Action: no action

Support using the ioend structure to defer I/O completion for direct
reads in addition to writes.  This requires a check for the operation
to not merge reads and writes in iomap_ioend_can_merge.  This support
will be used for bounce buffered direct I/O reads that need to copy
data back to the user address space on read completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/ioend.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 86f44922ed3b..800d12f45438 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -299,6 +299,14 @@ EXPORT_SYMBOL_GPL(iomap_finish_ioends);
 static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
 		struct iomap_ioend *next)
 {
+	/*
+	 * There is no point in merging reads as there is no completion
+	 * processing that can be easily batched up for them.
+	 */
+	if (bio_op(&ioend->io_bio) == REQ_OP_READ ||
+	    bio_op(&next->io_bio) == REQ_OP_READ)
+		return false;
+
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
 	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
-- 
2.47.3


