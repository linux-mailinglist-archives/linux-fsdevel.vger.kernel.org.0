Return-Path: <linux-fsdevel+bounces-78511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCMyOExfoGmMiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:57:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5EF1A819F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7EE3190679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC413E9F95;
	Thu, 26 Feb 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XfcK+cvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E036CDE7;
	Thu, 26 Feb 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117405; cv=none; b=rTo5Ka81BEr2NjOVLdNZ779e4n3UMWZVZKjTnjN2bYLgTCzUQlngVDprcW3QjX9ZCS83ZN3i7zwUDoXJdOTZ0qy0D4vMHnFQ4MNWMcQv6I9iKi9/Gwc6ytTspEwkm04WxaWexvun9hDnNMbZPehawP6+huBUNuG27eukrzQp/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117405; c=relaxed/simple;
	bh=gxj7df4pLdAg3ug5PfRTsMw5sDhm6O8+97nt564Zj74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXJ5gm3S4/XMmF7/hOuHjLW8iJSeMMalWw29UHPxQHCFke3bL/CsYjW0Zs60i2Fb9ENoR3YAxybJg4zbFWSLL3NPFGFbFxrwWkKRgI46NxJtVycvVxHO0aHvnzDG5pkI4yTzNuJ01ZUSDMxqsMW7jpefkUi9NbwowQHFLX2XUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XfcK+cvI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NoVQIsbZaWVeMYaoymE6GlqeIrC54yXJhWsgztpQSEs=; b=XfcK+cvIRGZFkN/js6p1Y/xEr2
	fOzNyiA2gHBOc2SaRrSWq29L2oNzy0QiorrkW1Uwltw1ygP+aeqMzJteDZOvBxwU6l+Cri5gVL6PH
	lSBwhEPyR1xP4DAzC0Hu0C+ef43G9d/YTfMl/jqQirI6bD6SuJ2a1EFWaGdby/esytx1nbNhjxn4+
	A5MnzdhJLgy5Qj+p2JnrTRQDguN43GnqxikRjq2a06s9XufBynaiakBI2UhMzC4bjbwuSNm7pYzAb
	reTD782uj28ZnbJYgPnjb83KyUlz8j5wiWE6xLQumch6rGpmCm7VyxoJhWPhhaLtWr9iO3EVgVDty
	5gwipjxg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcge-00000006NaV-0ZWn;
	Thu, 26 Feb 2026 14:49:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/14] ext4: factor out a io_submit_need_new_bio helper
Date: Thu, 26 Feb 2026 06:49:23 -0800
Message-ID: <20260226144954.142278-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-78511-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 7A5EF1A819F
X-Rspamd-Action: no action

Factor out a helper to prepare for making this logic a bit more
complex in the next commit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 851d1267054a..88226979c503 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -440,14 +440,23 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	wbc_init_bio(io->io_wbc, bio);
 }
 
+static bool io_submit_need_new_bio(struct ext4_io_submit *io,
+				   struct buffer_head *bh)
+{
+	if (bh->b_blocknr != io->io_next_block)
+		return true;
+	if (!fscrypt_mergeable_bio_bh(io->io_bio, bh))
+		return true;
+	return false;
+}
+
 static void io_submit_add_bh(struct ext4_io_submit *io,
 			     struct inode *inode,
 			     struct folio *folio,
 			     struct folio *io_folio,
 			     struct buffer_head *bh)
 {
-	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
-			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
+	if (io->io_bio && io_submit_need_new_bio(io, bh)) {
 submit_and_retry:
 		ext4_io_submit(io);
 	}
-- 
2.47.3


