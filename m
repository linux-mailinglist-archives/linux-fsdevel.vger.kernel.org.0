Return-Path: <linux-fsdevel+bounces-34180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318879C37E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1FE281136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641E14D439;
	Mon, 11 Nov 2024 05:41:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30BD54738;
	Mon, 11 Nov 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303697; cv=none; b=I5UgcnPLRom9ehEoZ7dSD3GCIFURS9DgRSP16eHHzZR45l1jiVuHPN5Fxoe2yP5VST9tFT274ObNG2eUQu1/GcXBWRfJvWemvJrzoyom/MZhfw53UCzHd1Rq9SQXFl0ENRU89YnaEfh+dZR4rRGvIqyFpg19rIY+mbeSEdvBxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303697; c=relaxed/simple;
	bh=k7worZ/KrNKeQXWdkl4iPOPrckHYnDmn+Gpf3mAS0wM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o4YlDk3bsW1lKICRiX8o/Tz6lLv+R8juSFvr/MPGanVPsoy04+3T0xxdFVfNVlEk+YHbp3g9iQ8pHHHjx20jaSAFG0438bBnqE90267QpV8cCuIaVk/QpMzwKH+wzxUu6TGnJpfow1d7RO+siUjiaGF5AiJOKb0pkRt3hkkXfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee767319904fd0-01fec;
	Mon, 11 Nov 2024 13:41:29 +0800 (CST)
X-RM-TRANSID:2ee767319904fd0-01fec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7673199068ac-1c94b;
	Mon, 11 Nov 2024 13:41:28 +0800 (CST)
X-RM-TRANSID:2ee7673199068ac-1c94b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: dlemoal@kernel.org
Cc: naohiro.aota@wdc.com,
	jth@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] zonefs: Fix the wrong format specifier
Date: Sun, 10 Nov 2024 21:41:26 -0800
Message-Id: <20241111054126.2929-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The format specifier of "signed int" in snprintf() should be "%d", not
"%u".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..43c2f4a59b50 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -811,7 +811,7 @@ static int zonefs_readdir_zgroup(struct file *file,
 	for (f = ctx->pos - 2; f < zgroup->g_nr_zones; f++) {
 		z = &zgroup->g_zones[f];
 		ino = z->z_sector >> sbi->s_zone_sectors_shift;
-		fname_len = snprintf(fname, ZONEFS_NAME_MAX - 1, "%u", f);
+		fname_len = snprintf(fname, ZONEFS_NAME_MAX - 1, "%d", f);
 		if (!dir_emit(ctx, fname, fname_len, ino, DT_REG))
 			break;
 		ctx->pos++;
-- 
2.17.1




