Return-Path: <linux-fsdevel+bounces-78517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONKzD1teoGleiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:53:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A61A7FF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2A39308744C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E93D7D8D;
	Thu, 26 Feb 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AM5a6lH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871C3B8BAE;
	Thu, 26 Feb 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117407; cv=none; b=EvWkDOZbjvALf3uAtl18ydqvwWaHdamrcoIMEubg1+9olUU9apLSDRSyM7FExAIUVSz1jz8Vp7OZ2jpmjMtqjH0waDTMwWoRDmSLtcMlZ83z6xrRBEkFxdSBhObwon49JNDpRTT1y7sGRq6Cpz9yFc7/FBPw3GKpHVyUs8coHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117407; c=relaxed/simple;
	bh=SV8HaUQAcvAu9qeBFPo8KnSTPpo0Bul7aZT5Z2G370Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az8MFtDFHKtgJr0VVAf/Qx7JY+2eO1gSSkcp2uhdTT5DFl21lFnlcG9hAmRfvAaXOoLEmDqVZeV4sARn8zj0H8bgLTbuB+tEy3hr9aB/tFFyLtPo7tbPtci+9+5momt4XRMAfQurMlrUlHJWGL4xK93YmzEWdOlvTsW+rjGO8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AM5a6lH8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wdIEsKTzA9SnbF5IiASm761ocVgdBQM29TC5lUjPX2c=; b=AM5a6lH8QBV7r3VGXzAiWJ9gB0
	jgLPsfbFRfea51sZM7mCdiHd/UhEP0rcDgx13btlsfNyltlGpyrNMtC546mEPrU2FTEtQhgcJTfph
	M+J38sFp6s6UHxmEfI3XMyow3APfefz4SjoJLx3ANk0vfud3F4ExMi4qu2nC8g120IaQloykKA/Kx
	T5vJ8+sIDs0roUmhmJWurURtPawval24xcp30kWvFfvqAzSzxWebcdQ0ZvNw1FISH/h3l8oEfjYnV
	0dKG2ATg+R0cCvw2HoVo82/KokMlYai+gc8baTtQFYOSvdqVsX3Zvkko6Qv8Ib6OhHPHPT5b1yUQH
	72KOmYtA==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgd-00000006NaF-37tW;
	Thu, 26 Feb 2026 14:49:55 +0000
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
Subject: [PATCH 01/14] ext4: initialize the write hint in io_submit_init_bio
Date: Thu, 26 Feb 2026 06:49:21 -0800
Message-ID: <20260226144954.142278-2-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-78517-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F4A61A7FF0
X-Rspamd-Action: no action

Make io_submit_init_bio complete by also initializing the write hint.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a8c95eee91b7..a3644d6cb65f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -416,6 +416,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 }
 
 static void io_submit_init_bio(struct ext4_io_submit *io,
+			       struct inode *inode,
 			       struct buffer_head *bh)
 {
 	struct bio *bio;
@@ -430,6 +431,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
 	io->io_bio = bio;
+	io->io_bio->bi_write_hint = inode->i_write_hint;
 	io->io_next_block = bh->b_blocknr;
 	wbc_init_bio(io->io_wbc, bio);
 }
@@ -445,10 +447,8 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 submit_and_retry:
 		ext4_io_submit(io);
 	}
-	if (io->io_bio == NULL) {
-		io_submit_init_bio(io, bh);
-		io->io_bio->bi_write_hint = inode->i_write_hint;
-	}
+	if (io->io_bio == NULL)
+		io_submit_init_bio(io, inode, bh);
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, folio, bh->b_size);
-- 
2.47.3


