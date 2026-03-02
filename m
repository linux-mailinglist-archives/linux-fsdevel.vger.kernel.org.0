Return-Path: <linux-fsdevel+bounces-78909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBqdCo2cpWk+FwYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:19:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A11DA9A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A482630219E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFF23FFAA8;
	Mon,  2 Mar 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TWuabgNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896A3FB060;
	Mon,  2 Mar 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461169; cv=none; b=GdD73F/7sIx8qQ+kBDb32YFydUGNM2N3tW+k3GgqJCYCGqASGejiaR+1E/2vQ0kahHbSt0mSyfYoR1YmN+e+0fpNbNuoCR7dzT8stcXxtz15w1yrv48BpBR03byX/apm+mofaPdHKBSdq2tg+NJUQ9oiR37/cIHpCYxEMy2wux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461169; c=relaxed/simple;
	bh=VNePzfeVd8btvndt8gE5rlVw3FdQT6PAfCrUZmRmhOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt3z8C431jIkoWqyzXbCrhaVaXx0EQL1PRQr+2fieGt80eBzkzdkrRhYBVRnt2aq5KeT/u+vcz3tLgf1C6B+2pq+bpCXwj1K/B+yHbEFOcicNu4afU7hBgBH1C22Vyw+RQI2DG/ag8nORwA3vkA5BRCTndfaQaD6/e8+pL0FEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TWuabgNQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dyk1509rfcvr1/bUzEnCUHnbGvw79uAFdkbY5OpbSbc=; b=TWuabgNQod72mWav+2HeM7yr6b
	CcOnMnWbgXwPCiQ20aPDsL46Z+u5obJZ1kIMxJcrRpUY/VFtyj3WkJcngxlFYn66cHbqY6MdvNHnh
	Ty5rAiD9jZmMr7gsh7biJUDFKHZuUTeIN6+tRKSwY8act3tsPU/9kTWfCSBGWuX9vnhWW14UrayJx
	hjXTDqLORZvwD2TVe9FzerBcjeA9mwNVbkZ70GY5ZtJc/fJrmj7ZOCysD10ykjFSXxkXfe/eE/3Q6
	QfMhvT11RegxHWOzUmkx6wuYapTsMjtaf1QYlORVRZwLCCFsd5/GS52IdzqCP/1LdkVCM/CKVx5Oj
	7kPpnEZg==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47L-0000000DDRy-2fEm;
	Mon, 02 Mar 2026 14:19:27 +0000
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
Date: Mon,  2 Mar 2026 06:18:08 -0800
Message-ID: <20260302141922.370070-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
References: <20260302141922.370070-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78909-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 949A11DA9A3
X-Rspamd-Action: no action

Factor out a helper to prepare for making this logic a bit more
complex in the next commit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index c5ca99b33c26..58cdbd836fd6 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -439,14 +439,23 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
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


