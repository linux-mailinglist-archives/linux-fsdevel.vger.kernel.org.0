Return-Path: <linux-fsdevel+bounces-51899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E4ADC9F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E991899372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E762E06DA;
	Tue, 17 Jun 2025 11:51:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DA28F50F;
	Tue, 17 Jun 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161107; cv=none; b=pSagnSnjB3I4rwchB9R4TBvTxA6+UeNR86m98svtU/CFovm4m4vI2h/BLyvrHm2KeMOHxbjMcXSj0EgOC23zc0N6Cj5/lZhn6Dx6o/oUTnq0g4mfF5smtFYH44rxYlgXQK6dHYVwHnmZMZshIfFneZVJthSfqnU3eCzv1+fPIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161107; c=relaxed/simple;
	bh=Y4mjsyTP5z67FlVry+t4hTJy8smiUNYnO2n8VlzEBFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvemY2cKNgje60HAsmh+yidDwlQiB2MCX1rsGo8Ceo4LNS7hgpihIlwExg/VOx53jCba9nDnyT2fJWf/WhUEY/a9lrha3U16JtfJpCaGRX5NIHer7qY3V7S0fXgjre7UIqvN8B62upnNPrhFY3FSxgFfMJ/FGL6J7OQqZVhudE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bM4wF51tqz9tJH;
	Tue, 17 Jun 2025 13:51:41 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] fs/buffer: fix comments to reflect logical block size
Date: Tue, 17 Jun 2025 13:51:38 +0200
Message-ID: <20250617115138.101795-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bM4wF51tqz9tJH

Commit e1defc4ff0cf ("block: Do away with the notion of hardsect_size")
changed hardsect_size to logical block size. The comment on top still
says hardsect_size.

Change it to logical block size to reflect the actual code.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..e818125d5c09 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1122,7 +1122,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
 	bool blocking = gfpflags_allow_blocking(gfp);
 
-	/* Size must be multiple of hard sectorsize */
+	/* Size must be multiple of logical block size */
 	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
 			(size < 512 || size > PAGE_SIZE))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0


