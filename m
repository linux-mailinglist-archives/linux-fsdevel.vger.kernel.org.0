Return-Path: <linux-fsdevel+bounces-56122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56771B136DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F76F175F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8B2356BA;
	Mon, 28 Jul 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZJj2Z5XR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D632D052;
	Mon, 28 Jul 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692031; cv=none; b=iPqzF2kYWJ4wGfFPyqJJkWDCcEUIxm3DQEs5uZTJII4dPIt7ciGRHyB4msZnKd7gSSVKJijd3xR005CozL8TvXPmsUJLVBmQCq7twdv1aibZSRdEAO0XQIJ+Fr5AZvBDH2bNzQQx6uib8ddeiME59Zs0g29ZSM40AM4r0BB76Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692031; c=relaxed/simple;
	bh=Moxd5+Q4pVp6nKxfze4ckE6mr4wOCiBw0hKlVBnBB6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLjrxAkVgjaO7Mwv8Xf4ChPR6NXr66IrZYa5b5WOpLSD3jYocl1TwvAZVKM7qArAKU2zQIYQXWiQyJc8OWjrwMKJQlXHmDChXXd4psnouvGcxJovO3pgGaViPkSrTzlU7gJSRvNvuwVzkm39o0HJRiuNosWG7Mt1XVCZAGRaXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZJj2Z5XR; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7b
	aTm4RT0cCPJTWk6j4MRTx8jPrvZrZ12u79os4rrsA=; b=ZJj2Z5XRWs9w7ov5HE
	xoaWDhRkHnDuC09HSoskX/XOL9KRXSm3tD5zP3qVH7rdHYncv5P3JsA73B3W1SZv
	6s3yjV6Cs+0XIamOfILcaxlcgRuyraPr1GayfqcQjLZATazvzSiFO+iiuSgrc/rI
	wJovMAn6TJ/gWZWIetBDi6pxI=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAH9a9hN4doAzUWCQ--.8415S2;
	Mon, 28 Jul 2025 16:40:02 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 0/2] Tiny optimization for large read operations
Date: Mon, 28 Jul 2025 16:39:50 +0800
Message-ID: <20250728083952.75518-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAH9a9hN4doAzUWCQ--.8415S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1UCw4fJr4fZw17GF4fAFb_yoWfCrc_ur
	WkZ34kGr42yFW3Ja1xAFZxXrZxt3yq9ryfZa40qFy3Gryjyrn7XFZ2kryfuF1UXr4xGFsx
	GanrXr93Zr17XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU83Ef5UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFBSUnWiBj9Y5uAABs5

From: Chi Zhiling <chizhiling@kylinos.cn>

This series contains two patches,

1. Skip calling is_partially_uptodate for entire folio to save time,
I have reviewed the mpage and iomap implementations and didn't spot any
issues, but this change likely needs more thorough review.

2. Skip calling filemap_uptodate if there are ready folios in the batch,
This might save a few milliseconds in practice, but I didn't observe
measurable improvements in my tests.

Changes from rfc:
- update commits
- switch to the new solution which provided by Matthew Wilcox.

rfc:
https://lore.kernel.org/linux-fsdevel/20250723101825.607184-1-chizhiling@163.com/

Chi Zhiling (2):
  mm/filemap: Do not use is_partially_uptodate for entire folio
  mm/filemap: Skip non-uptodate folio if there are available folios

 mm/filemap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0


