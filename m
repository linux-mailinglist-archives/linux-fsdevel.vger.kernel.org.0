Return-Path: <linux-fsdevel+bounces-8919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56F83C356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5458528D117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4C4F88D;
	Thu, 25 Jan 2024 13:10:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046C50A69;
	Thu, 25 Jan 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188214; cv=none; b=D2CTQTHDePRvsFyGKBjvlP7YP5p0SWvbt9x93dg0QKQf8uKTOjMr4YyrUXdaBpKi5bqS4Fb546cma1fUG8iBo2sYsVSdi9fqR8zWqaxzRnYssnog6CXXLikysL6GRIdy9htIOo9NBNYQfyk7GaXcWB5pV1b/yfbkGQE3gsYvs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188214; c=relaxed/simple;
	bh=G+SorOQyVXGSLU3lvgxZF9vBzsclkwPlb4aBm0LiHQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B8hu7tBvo9kWjgQuOL0ddWwHC8Qiqm6rutH0W13kZtm5v1jYpvO0MTI0fGj4xzzpMpa0dAH2FlQ4/BvjpJfjZ1XZAZV2c4gJhFptYVMxMnkpNa5176Q/Pc1GqA99Cha+jw6OQq8rWaHmHZ7/D0P/CV++nqjm7fszhE1q7yrV1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 25 Jan
 2024 16:10:00 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey
 Khoroshilov <khoroshilov@ispras.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <lvc-project@linuxtesting.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in ext4_set_page_dirty()
Date: Thu, 25 Jan 2024 13:09:46 +0000
Message-ID: <20240125130947.600632-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/25/2024 12:50:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182932 [Jan 25 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;omp.ru:7.1.1;elixir.bootlin.com:7.1.1;127.0.0.199:7.1.2;r.smirnovsmtp.omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/25/2024 12:53:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/25/2024 10:40:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Syzkaller reports warning in ext4_set_page_dirty() in 5.10 and 5.15
stable releases. It happens because invalidate_inode_page() frees pages
that are needed for the system. To fix this we need to add additional
checks to the function. page_mapped() checks if a page exists in the 
page tables, but this is not enough. The page can be used in other places:
https://elixir.bootlin.com/linux/v6.8-rc1/source/include/linux/page_ref.h#L71

Kernel outputs an error line related to direct I/O:
https://syzkaller.appspot.com/text?tag=CrashLog&x=14ab52dac80000

The problem can be fixed in 5.10 and 5.15 stable releases by the 
following patch.

The patch replaces page_mapped() call with check that finds additional
references to the page excluding page cache and filesystem private data.
If additional references exist, the page cannot be freed.

This version does not include the first patch from the first version.
The problem can be fixed without it. 

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Link: https://syzkaller.appspot.com/bug?extid=02f21431b65c214aa1d6

Matthew Wilcox (Oracle) (1):
  mm/truncate: Replace page_mapped() call in invalidate_inode_page()

 mm/truncate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1


