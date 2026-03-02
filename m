Return-Path: <linux-fsdevel+bounces-78907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEtQJBifpWmuCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:30:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5881DAD35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC783053B0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AA3FD13C;
	Mon,  2 Mar 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TApuq1k9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA83E0C74;
	Mon,  2 Mar 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461167; cv=none; b=YukEYYpyfkU8mVCVBs1MbUt+B+RflfwkJOLuqcAY4ovpEnWdGwqUkVCvepzyXS/ZWytnLWlWiEIPicRWBHHjf5s05EF/ZeWPCMnyFS1QISasUjha7xCpPhWnf6m7pomGrI6uKI93yQ+5ZmTW5KBz8tpaMFnw//k1V2j3sYdvU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461167; c=relaxed/simple;
	bh=sMj5Rrk0tnxZzVImADVa/k3m7uqKi3l93kY0BsAiUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B651zsnmz+8wBsKqvT7PmQXm3Mx3jbiy4uRen4yO/fe4fwQ1BSKxEHueHVuxaopkElcbkXUI1HUtFs1qthEK5KFZo++4LeBFhKu1YUQvLbzQEZG7KGd13MvP8JT2Ulv5xz5YBdYH9hvwlG0p/s7H3iHY8wQ18+gPctBZTgXrn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TApuq1k9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=olHs/EBkSlbRjwcneX6lFlR0i6BJlKrjnJjRCQNIpEw=; b=TApuq1k9pvOvmvL+kNfV9T5QgJ
	XYl/mRKaDOQ0/oBdffoZ4OpZIWuQ+nEvqlnRH4OU1DY6j74mQ3fOgRX3eQHSjgBulhh16geGrsUBR
	mS2ttvc3VCOIlAcuGddtd/G7E1t9UlUzzEuNyW3XZb26e8HxTZgU7F6O/A7uK4RtQU5GplPwQHcsa
	QMAcN7P2fPWVbacmYFcF8Vg4noi94rCBBCmtjZUhdRcZvgPtostYb8n8iDsCDOVEv3Rlo1VTM9enn
	CWp4kQBVZiazWIuRlqRut3PTyB0vPWrX+fyD2623ZKbtBC3YfmeAiFcsZ05Q37wQDwdF4W5DQZypk
	ly+tJ/qQ==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47J-0000000DDRg-2Ws4;
	Mon, 02 Mar 2026 14:19:25 +0000
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
Date: Mon,  2 Mar 2026 06:18:06 -0800
Message-ID: <20260302141922.370070-2-hch@lst.de>
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
X-Rspamd-Queue-Id: EC5881DAD35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78907-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Make io_submit_init_bio complete by also initializing the write hint.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index a8c95eee91b7..b8cf9f6f9e0b 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -416,6 +416,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 }
 
 static void io_submit_init_bio(struct ext4_io_submit *io,
+			       struct inode *inode,
 			       struct buffer_head *bh)
 {
 	struct bio *bio;
@@ -429,6 +430,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
+	bio->bi_write_hint = inode->i_write_hint;
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
 	wbc_init_bio(io->io_wbc, bio);
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


