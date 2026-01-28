Return-Path: <linux-fsdevel+bounces-75731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIlvJ94qemmi3gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:27:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D21A3C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BCE8300D75E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA6E36C0B9;
	Wed, 28 Jan 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xWZ0Ob6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CB36BCCC;
	Wed, 28 Jan 2026 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614032; cv=none; b=X55HNfZ4blwRiaHusSoGkHrgjD1dB+mF1BIQnNynpW9OqjVVMvOy1uL8sjMUzvqIlOhLKw+tYPtZcGsizBZTmgHx5febef8vbkPwi3sUjJtW3aoG14EAn9zcXloMD7vJOeTQMOXOYmqpnXP1AdTb6NvirDRSzvP1alPq5L7WGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614032; c=relaxed/simple;
	bh=q03c+SY16ozMssnyd/WDI27hnXO1G1LvGqxgshwtktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAw270VcrnkP/TivA8ANuyCJfvAdS5J23Ea9rmWvbrZbKjJpi66rRYEMG+mzOpsp0XP1AfEkzsdIVC8ojQyztIGwYEcBiW0kEJi6A8hwdT7SG6FE2urXyy/8EiceRNkblrcxAGpKVGazjqki0FQ3Inn3A0vYaSvTe+So5nDw7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xWZ0Ob6U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0Ic6Dg2kMbDfbML3FwgTOGvJaqoJ4sjBOcPdz8pJF9g=; b=xWZ0Ob6Uwc4f4G2Brz/N7pMrg8
	QKnBg+DCe3ZSuhqviV+qcmwdg5AagT/Z/h4hZz+QI1YhT2huEuSGXZeNQiCgIl7LzEJqG7uhbjnoT
	PKWq2B6/deeNtMiwKQmPs9I/sF2J90aAtSn2qyC8/M3zZ4mvSiTlfoMAp5zs/Wh2iDLjtJLSPp+LZ
	XarLdYIi8U534G4VVt6RUrtE4Fa5tkNbRYWkugmQwoUJsb0l+Wv3InbPS21Whs+mF0IRsitQBHT0G
	LYXBRDmKEFhOj1/x/4eYUhycHwK3XVa4vwPOB1TJhjueiGE+M3t83jCio5EynrdWazsGHOD5+wlbn
	9OmJglyA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7Rg-0000000GHKF-1SPU;
	Wed, 28 Jan 2026 15:27:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 03/15] ext4: don't build the fsverity work handler for !CONFIG_FS_VERITY
Date: Wed, 28 Jan 2026 16:26:15 +0100
Message-ID: <20260128152630.627409-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
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
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75731-lists,linux-fsdevel=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,suse.cz:email,lst.de:mid,lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39D21A3C5D
X-Rspamd-Action: no action

Use IS_ENABLED to disable this code, leading to a slight size reduction:

   text	   data	    bss	    dec	    hex	filename
   4121	    376	     16	   4513	   11a1	fs/ext4/readpage.o.old
   4030	    328	     16	   4374	   1116	fs/ext4/readpage.o

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/readpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e7f2350c725b..267594ef0b2c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -130,7 +130,8 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 		ctx->cur_step++;
 		fallthrough;
 	case STEP_VERITY:
-		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
+		if (IS_ENABLED(CONFIG_FS_VERITY) &&
+		    ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
 			fsverity_enqueue_verify_work(&ctx->work);
 			return;
-- 
2.47.3


