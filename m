Return-Path: <linux-fsdevel+bounces-23740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17793225E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F291C21E6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B11195807;
	Tue, 16 Jul 2024 09:02:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F795FEE6;
	Tue, 16 Jul 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120555; cv=none; b=DT33MGqlEztxM6gcnLXKrDzF1CTsF342vJkG9M36lWrCZ3qn25llv3VdoNN3qBm7vGE47SxC031lD/WDTdYwHKZKOVhUaI3SCRKENoDD5ySib3jGL09QGyRh51ksHf8mT1avMZ7wWmN3G6+9aWApIflarAVIrT9meUKXlUzpBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120555; c=relaxed/simple;
	bh=efPYcMbxvqv2EHFjE7NEeoWio7WLi1HA9h1XdzjOFZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lu/ynBdE+84Y8Y0EzgzQYKlFknjYQtROWQaYgSY93QjnVw7wuRoTHOUyTAF222bXqWtp554Rj3hUuV33BVEFRldtIEc62gn2RvzC7TrJ4VZVH+tco8jfuWEkLZjnwn9Oy0nu4Dtn1fLwfqhpi2EDITp2o8786hqLe2zbxlImFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Jul
 2024 12:02:16 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] fs: buffer: set the expression type to unsigned long in folio_create_buffers()
Date: Tue, 16 Jul 2024 12:01:05 +0300
Message-ID: <20240716090105.72179-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/16/2024 08:16:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186531 [Jul 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;inp1wst083.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/16/2024 08:23:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/16/2024 7:02:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Shift without specifying the type casts the expression to int,
which is then passed as an unsigned long argument. It is necessary
to use 1UL instead.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8c19e705b9c3..40dc18f1cba5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1782,7 +1782,7 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
 	bh = folio_buffers(folio);
 	if (!bh)
 		bh = create_empty_buffers(folio,
-				1 << READ_ONCE(inode->i_blkbits), b_state);
+				1UL << READ_ONCE(inode->i_blkbits), b_state);
 	return bh;
 }
 
-- 
2.34.1


