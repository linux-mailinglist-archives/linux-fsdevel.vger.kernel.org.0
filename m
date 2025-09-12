Return-Path: <linux-fsdevel+bounces-60997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5223B54327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361131BC3807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680A287259;
	Fri, 12 Sep 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DS9HC4ho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83526A8D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659675; cv=none; b=kpWTx8LrUUhs5EwKMKFAlBF8r2nZ/MOTCEHHOM0XSUw7KJXsPr+8+jBCd9bPZO8/IovDsWnQMm8TH7C7RDz1Nsofye44VOmSKxKPturHJs30NBxzaYa5GAPJa/YthIsXrSYMSsNdGrY2tW6/mUavMQiK3iNd8zKyjN7iOfiY8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659675; c=relaxed/simple;
	bh=e6pzmWDlP4fU72dJlIuTmmzjA79fe/WpNQ3H4ae09Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X16d6WtREUQivEba/Cke8ItVOtOzUwIk15KwAnXChwtI7FiGZHNVJn0M/efI9C5x61UShpx17aA/S1oELWQd5k7Ve8vJ+e+u70PY70UBzuIJv1AwrjuMDCXxVKHpEyYltRKrObFlDXYSk25Ru7j8Ae0MmspgOqO5qqBkRPdtQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DS9HC4ho; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757659671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIoPd+cIAn5sRGQFNoWJdiuW0D5pltztXhc4gaFdz7Y=;
	b=DS9HC4homLiJRn3AT+Y0dC/pf2MsD5OfZxlcggOpwaFPipbRSYJ07nVbyuYrgTp51tUHTv
	GO0pAlviJyb+ZenLdmdNBmidrpjQ2JyqcksLf0HXtlndnrOscZTz7CaqxD3bJ3bmOJtEWc
	iO01UAjT0En811VM2fgI6FEqnGrnaBY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: Replace strcpy() with strscpy() in find_link()
Date: Fri, 12 Sep 2025 08:47:24 +0200
Message-ID: <20250912064724.1485947-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 097673b97784..6745e3fbc7ab 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -108,7 +108,7 @@ static char __init *find_link(int major, int minor, int ino,
 	q->minor = minor;
 	q->ino = ino;
 	q->mode = mode;
-	strcpy(q->name, name);
+	strscpy(q->name, name);
 	q->next = NULL;
 	*p = q;
 	hardlink_seen = true;
-- 
2.51.0


