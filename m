Return-Path: <linux-fsdevel+bounces-36719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF99E895F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 03:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C661885FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0254727;
	Mon,  9 Dec 2024 02:53:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C524C91;
	Mon,  9 Dec 2024 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712779; cv=none; b=pzNJ2W4xBH+/Qt1Z4gVey+wPgn+pD1htZD2eDmb2yMCwctDC1PlvHSXuTv+KFwKRNCsXUbq+td5JPxU2lT90U/n5prMMFYGKYlxZ7BTJQcpnO6dgLIDmXKptzh1T+oDBamm/OXi54FYXETofx+OHU+10KwwaTxpfKNtTHMkSV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712779; c=relaxed/simple;
	bh=S7e/O1+VM7AcqxItipaScll9YTgOhbRKTrr1TLJ+9ZU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aZNis3lPxT4jNr2z9TOk6IAh7G/NJCVJY3nuE618t7xsPMJq/OVHmoMQyyg3iIcuVvln9Ex1mC1JPCd5uK2bxc/aooRtPSncyBGUeNa8OWoHmR8615iAh2A98E6CJ4ec+5fwpjYivbH7wCTc0GYXNG3lsvcnQ7JyXC71AuAWj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367565b7b1f1-bda22;
	Mon, 09 Dec 2024 10:52:45 +0800 (CST)
X-RM-TRANSID:2ee367565b7b1f1-bda22
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467565b7cde7-9b8e0;
	Mon, 09 Dec 2024 10:52:45 +0800 (CST)
X-RM-TRANSID:2ee467565b7cde7-9b8e0
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: dlemoal@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] zonefs: Fix the wrong format specifier
Date: Sun,  8 Dec 2024 18:52:42 -0800
Message-Id: <20241209025242.2995-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Change f to unsigned int to resolve the mismatch in format specifiers for
snprintf(), where %u should be used for unsigned integers instead of %d

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes:
v2:
A better fix is to make f "unsigned int" as that is consistent with
g_nr_zones and the fact that up to "unsigned int" total number of zones are
allowed for a zoned device.

Can you send a v2 ? Also please add a Fixes tag.

 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb878..695da258a 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -791,7 +791,7 @@ static int zonefs_readdir_zgroup(struct file *file,
 	int fname_len;
 	char *fname;
 	ino_t ino;
-	int f;
+	unsigned int f;
 
 	/*
 	 * The size of zone group directories is equal to the number
-- 
2.17.1




