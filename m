Return-Path: <linux-fsdevel+bounces-75432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMxyEQcCd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:56:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AB844C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0F1303660A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD19233D9E;
	Mon, 26 Jan 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0cpj60tQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C52253AB;
	Mon, 26 Jan 2026 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406892; cv=none; b=t1T4+T5atvg98uOkn3OZsbSABEChbTFiAX+bt88kE9Zuv+R6IPEf286VZ1Val28q6drT1VtmYGCMPWs2zTjqARXRcpZ7QCXSoLro/G6yDbmpaIUNMddjl1mlT/ppxmaoJTldTWPL8WTPFax4xL0mwz/kv3688HOervDI6jqsKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406892; c=relaxed/simple;
	bh=az7jtSgiug4yfyUXkB503VaPe7AV/HZMek5DJTPubVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvk7PYNHx2BtwFhGyde+RawKwudeZW+w0GPOFyePGRAmcGcVdGn3AjIVol1X3OTKqj8zzzW1yTn45Zh5Wp6parYBnvJ1W67INGeeEQ8xWiXyXYjI3aEsoZrmANzQc4JwcB74yr+5QAbKBHKxE/9rOYX76zVI42HrjEgRRC6VpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0cpj60tQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6ovVtn1ysqOCqLaZwFJ69GtsRd4YhkLM6ibByNKCYX0=; b=0cpj60tQldvP5EcpX+XMCwQLUk
	3PK6NmgIlsoVLQp0OoalkgR4C9/xJa2BUiZuSNy3j2Z1NMSwGqCSkY/PcRsxhPNmmteczchwP92E7
	FS9AjelQ2U+o7TY49h0Zshko1546fZNqKBz1gtv6kD+FjH4tFl7wHq78zcr53LtXMfjm+d3obIVUz
	rOWH5aVwJSPFNO44Ql+wj2QNUwSdyzKavT46aBf+6yxRdPnsz5o/BnzIZxVq9cdKyyfsDCCBvjbpc
	XC78Qq/xmFdJUD8kez2q1OdPzyFsKXQaqoQ8mNyhWuG/nfEE9vxREU14jYUjLkqxId6Rh717MqBnu
	hfo2mrJw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFYn-0000000BxHA-3pm3;
	Mon, 26 Jan 2026 05:54:50 +0000
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
Subject: [PATCH 08/15] iomap: simplify iomap_dio_bio_iter
Date: Mon, 26 Jan 2026 06:53:39 +0100
Message-ID: <20260126055406.1421026-9-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75432-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: D82AB844C5
X-Rspamd-Action: no action

Use iov_iter_count to check if we need to continue as that just reads
a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
the actual number of vectors to allocate for the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/direct-io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 867c0ac6df8f..de03bc7cf4ed 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -312,7 +312,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	int nr_pages, ret = 0;
+	int ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 	unsigned int alignment;
@@ -440,7 +440,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
 
@@ -453,7 +452,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 		}
 
-		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
+		bio = iomap_dio_alloc_bio(iter, dio,
+				bio_iov_vecs_to_alloc(dio->submit.iter,
+						BIO_MAX_VECS), bio_opf);
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
@@ -495,16 +496,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		dio->size += n;
 		copied += n;
 
-		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_VECS);
 		/*
 		 * We can only poll for single bio I/Os.
 		 */
-		if (nr_pages)
+		if (iov_iter_count(dio->submit.iter))
 			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(iter, dio, bio, pos);
 		pos += n;
-	} while (nr_pages);
+	} while (iov_iter_count(dio->submit.iter));
 
 	/*
 	 * We need to zeroout the tail of a sub-block write if the extent type
-- 
2.47.3


