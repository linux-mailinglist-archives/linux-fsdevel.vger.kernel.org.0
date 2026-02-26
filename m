Return-Path: <linux-fsdevel+bounces-78508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLfaLwteoGleiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:51:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF91A7F89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D392C3072C3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A83D9033;
	Thu, 26 Feb 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejAnnMwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8457242D98;
	Thu, 26 Feb 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117405; cv=none; b=MI8Mhq0rrQ0/z27kjt9tdKVju1FZd1KZVeOrELWet2qzBC6JjY96GUubN+Hu0OZRkiSX0PwP9HKnDmGVVjf+ldYj40E8ax20+S2d4SEzbE+S7J1/DTaYi7mka+g9pSiWDY6rhFb0Lbulv3GmSSv6nT4uSv7UBg0y85kXTHswxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117405; c=relaxed/simple;
	bh=q6Ny4UXogxNsin9XQcEyQM5dJ1Chl2JOQ+D92ijIYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKVJ3clX30eL+4P5dqbqoJvPlmDoCGVL6Y8A7DkOv6fmq0I08AcTd5OMoh1ec6yzTcERe7Vmt8kBtLX3Z5CHIf08LHVEJ91pXjwBsCr4vuUKOMJnbrMQSDeHRPeFIj5pl9wQID6gE0+hX++zz7vp1muViXfylSqnStnO4qJ0QBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejAnnMwR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yBnfuv1eK/qR7jtdeboy/reS0RE7q6bJCLLGY3znk6c=; b=ejAnnMwRPu51TGDaedPXz6zDKU
	EIS8mfe5UxmmBMA2XbTdHyxrxKfIpG2VAJvNJbsiVeZkrvBVRpVdsizqABYL4cKo+u5+0DujePM7m
	qHsC+c1rix4It2qae/RT3KTDlqd3BYM2AkQzR7aF3henuabzt9m3vJLC2Hnl2c3PdPPFZaR6fqT8P
	Xy2aDeO9/GG5WXreDzcZ1+g7F7dQXKOdRlUKZHLYBLNa4Xret7CJp9bu948pOysElZ0vsITsZ3MbB
	cXh4ELaMLOLzrIStqt5fR06NGEp7hxV3pTN/l0po7c/zodHTieXUPqMnByv0h7qJaRulqn6ft1SvE
	ySOL2RRw==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgd-00000006NaI-3yRu;
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
Subject: [PATCH 02/14] ext4: open code fscrypt_set_bio_crypt_ctx_bh
Date: Thu, 26 Feb 2026 06:49:22 -0800
Message-ID: <20260226144954.142278-3-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78508-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 84AF91A7F89
X-Rspamd-Action: no action

io_submit_init_bio already has or can easily get at most information
needed to set the crypto context.  Open code fscrypt_set_bio_crypt_ctx_bh
based on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a3644d6cb65f..851d1267054a 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -417,6 +417,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 
 static void io_submit_init_bio(struct ext4_io_submit *io,
 			       struct inode *inode,
+			       struct folio *io_folio,
 			       struct buffer_head *bh)
 {
 	struct bio *bio;
@@ -426,7 +427,10 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
 	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
-	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+			(folio_pos(io_folio) + bh_offset(bh)) >>
+				inode->i_blkbits,
+			GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
@@ -448,7 +452,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 		ext4_io_submit(io);
 	}
 	if (io->io_bio == NULL)
-		io_submit_init_bio(io, inode, bh);
+		io_submit_init_bio(io, inode, io_folio, bh);
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, folio, bh->b_size);
-- 
2.47.3


