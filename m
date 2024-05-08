Return-Path: <linux-fsdevel+bounces-19021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F08BF67F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9709DB20EBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C84320DCC;
	Wed,  8 May 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LwuBFwXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72C224D1
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150697; cv=none; b=c1/QBdsd526I9FfxBk9IxQppastGerivCEZ8Ltps8TssuTe+eSvxZJO6eLOTzoefZGIqSxmxX/X0ldyWbvsiIAadOpIXBg6HzRtRkYTK1wG+5UQD8MwXwjoYZWFCjmF5CUz38mP/DY3PtIee62/AlC+6080qgaslXE3W42AaxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150697; c=relaxed/simple;
	bh=ihF/CGIaemKPan1fJHM2bnLdpf497IjI1WNw6uoNPgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ciqxa0dIrzUZk4/eSwWxRR8lmKYrtIpRmEGN/KWElf1K7F69M1hXYdcvjkUu0aKDeWVzckmcQg6OdzkQWw5Hs2jB1iQ+WkqymbKkxdxWiWYVuMi/QPDVB0QmCDWI/qaTyuq7e3tIy4WMtnWvlnILP/mt1aqiffNRGuMUcZeudB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LwuBFwXt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pXC/QcREQ422O/ThGGwFbG0rlEGdpi8cRoybd6Oqy+Q=; b=LwuBFwXtdFaWI4yNjcnT2oE5PY
	bGfUr0oausMs8zZsg5zOHANqAfelwxmC3b6VAXUNgixlpE6eBHUDIKorqSESCJJ3Lo15zhASm3IXv
	vikgyyVI5PQYfo54ZGcPO8TKORWsF1Rg3V307xa5O/GqziGQ4GTF03YxQvYvWDFa26fbBmKOro84r
	apfr4g4qbPn0+Dau7P1GCvCNIY+qgFbO6D70ED+NE/rgyfOMJmHNxqS+b7Ra1dkmRFbwM6p+Hx8YE
	Xmt0dPTxc6LLbxB/YNq8p+eaER/mEiQgXmEkpnez99koWl4YQtGkorA5+z3ILNq4qpD4wpZXAUHyT
	G5MrI/Bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2s-00Fw04-0F;
	Wed, 08 May 2024 06:44:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 09/10] dasd_format(): killing the last remaining user of ->bd_inode
Date: Wed,  8 May 2024 07:44:51 +0100
Message-Id: <20240508064452.3797817-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

What happens here is almost certainly wrong.  However,
	* it's the last remaining user of ->bd_inode anywhere in the tree
	* it is *NOT* a fast path by any stretch of imagination

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/s390/block/dasd_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 7e0ed7032f76..eb5dcbe37230 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -215,7 +215,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 	 * enabling the device later.
 	 */
 	if (fdata->start_unit == 0) {
-		block->gdp->part0->bd_inode->i_blkbits =
+		block->gdp->part0->bd_mapping->host->i_blkbits =
 			blksize_bits(fdata->blksize);
 	}
 
-- 
2.39.2


