Return-Path: <linux-fsdevel+bounces-74391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7BD3A07A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8285830C68E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1363382CF;
	Mon, 19 Jan 2026 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIZNovr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23392DC76D;
	Mon, 19 Jan 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808700; cv=none; b=G3mHCzgARED6tSW2txzL4b6BI0AutapzEN58eoTCBvIh+63Qtl1hZYQ4OCg0Ulv+YxHjcItUIIK2MxP26dNo6g5AxKGk2/zt0PB2eTt1r74xynPugwsJGXt6WB3LdTe17WOH0U0EiB4IUlsWXkJeEDD3EnNTFUq8b9hAP81/7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808700; c=relaxed/simple;
	bh=L+FegvGM6O+ihTj/03SvVND5RUqHMnac52E9NF5POIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIA4Y/43xJNTumwn6cutYQctfNIpY1C6AGkPGF/57EreViqJDzLsLGoO/pZ4Ig3eebK/GIW4mJxi++8jz0o0nadOZ24aDSp8RIcDjH+hEaIFSSnAQWWhG+fJtQ64eaOgdTCIKBxRuAvCNl5aXWKpUMadC3dNREkgjsfWNYB8+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WIZNovr7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S4eOyvTnCJaRomQ8TGnVU7ABROgmIIAU3ZvE2PQlUiY=; b=WIZNovr7stfj67rPpOzizRBKYd
	CiWn2bHzT+oHg2nkbJUvt62ek1kWO5saYSPmmW5XTG3OTAr1MVeSP15QMd+XffLTbm0dIYoeJqcp6
	95kt1TBg1n/mIxRnk9tttNpbQIRrJknTrE3xfssF2fHKvScYWCSxM/yeZtxHDAyzJ4RLlpfjzDCnC
	WSumsrunAVZ/o4qJR9WxBwhlA/VIAeOOKhVTDBhpN3aHW9Oy5PebozUejwqRURX2sfEAvCvmAC+Bg
	s9IeY+bGc0wa7ZX1nObrkJMywQlZwuvRzSCSZRpeTKx4GzGYmjbeCxkhQIBMbKBqMasXadO0Ma9FM
	Mh5kVxyw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwU-00000001WBn-0x5E;
	Mon, 19 Jan 2026 07:44:54 +0000
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
Subject: [PATCH 06/14] iomap: fix submission side handling of completion side errors
Date: Mon, 19 Jan 2026 08:44:13 +0100
Message-ID: <20260119074425.4005867-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
more bios when a completion already return an error.  Commit cfe057f7db1f
("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
"copied", which is very wrong given that we've already consumed that
range and submitted a bio for it.

Fixes: cfe057f7db1f ("iomap_dio_actor(): fix iov_iter bugs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4000c8596d9b..867c0ac6df8f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -443,9 +443,13 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
-		if (dio->error) {
-			iov_iter_revert(dio->submit.iter, copied);
-			copied = ret = 0;
+
+		/*
+		 * If completions already occurred and reported errors, give up now and
+		 * don't bother submitting more bios.
+		 */
+		if (unlikely(data_race(dio->error))) {
+			ret = 0;
 			goto out;
 		}
 
-- 
2.47.3


