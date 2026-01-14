Return-Path: <linux-fsdevel+bounces-73634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7267ED1CEBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5DD33019B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F2837BE61;
	Wed, 14 Jan 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Px7DNZga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C937BE74;
	Wed, 14 Jan 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376581; cv=none; b=cXIsSPGog1jOxFZlLoieGtF3YkvOEA1fyCv3oFYFpwhgDfg6ZTgccHplr2+63yx+RUa7y9HXIMMLPmoybmcb5ECr8smyG55WktqYMkVQVNkyx+NtrsRO/aCXP1VkBqZU4033yePPT3qODvAYOzU9Fso+7Y5B5W6Qt0LiKgpdrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376581; c=relaxed/simple;
	bh=bkEw0DbuPdPBrFTtRtNNCBINRADDPYEk/eOL/ddU2D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW6A0vDoceiM0/YZ+328KU0HP/OMDg92JYhoozmh5Aougtz6lXnhAQ8LD8OLDgEPgCtS0WIKCJT8bQRSRs6+mP9aQVT3uFCkx494ZYTw5bD+xIQSsob789aP133AHUGXUN4PNQzQeXKQjz4YlagFZJza7QJyybx1Vf38AHXMtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Px7DNZga; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7OdUCbhwmtsiZQLirrSvG7Lhc2XM4HUQXH2nzA+LDT4=; b=Px7DNZgaRZUV5gI93XkYVZT5MR
	vbN8evdo2KpUVFKZeH6HxNG9QxZUUuntE3zSpLlgmK0z2l7Vo+j6/aZ3TZF+TwhebYBHKV2l8NtZy
	7UrW/nlG5kT3R6+YiOPyS4inYf1vHiinLJlR6sOD6mucT8FkCv8SVWmRFosLeYKxZ4ce7f7PH/3kz
	Uw63bgiIk3F9ERg8WoRQzhq5++EqySJoRRQcRwMZ82QLoBhGXWuteUa5wZfRY0SXMCe/vxSbl4Thi
	Otjffcw0KQ5eUSzT0OFZ5L1l2Y5SS929CBzAtnidmWpuC0UD1m2JvCzTlTmlG9UhKllL+MiZVF3fQ
	HbgNyntg==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWp-00000008Dzn-2TVz;
	Wed, 14 Jan 2026 07:42:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/14] iomap: support ioends for direct reads
Date: Wed, 14 Jan 2026 08:41:10 +0100
Message-ID: <20260114074145.3396036-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Support using the ioend structure to defer I/O completion for
direcvt reads in addition to writes.  This requires a check for the
operation to not merge reads and writes in iomap_ioend_can_merge.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


