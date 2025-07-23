Return-Path: <linux-fsdevel+bounces-55797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45899B0EF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E0F7B5CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409128C033;
	Wed, 23 Jul 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EEwBwJhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE0285CAA;
	Wed, 23 Jul 2025 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265994; cv=none; b=CSQG+QJI1hPEd5yLMg3A0KWre4jmf6h59ZI9Gkx2fuzk6BLOEQBJxGrnYSuMWV9Umz6gGkdbg8g3f7SeBcnvrt7us1zpfLID1fDmYrnNRdRCX2pV8cVPemfKiAmopYGRTRcnrgS9/GCj75GOj0zKrAL3aHEoGNvzVnv7hCU8+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265994; c=relaxed/simple;
	bh=bTEhTuLg1fOkAjI4hXSNAcm3i/uDDaWh55x6naaOxGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrILSbTvnHghW1UkWhJZt5ze+2a7hVQu7BHM+pfIxGqHoB9B4X4AkRpImFhcbz5RVLYRLt3DPVGamDpN+0EtRDSP9EW8//i7UlEY0Wd6WD5fqu9i1KuLhEnkPaHEgCnNZ9YoR+IV3IR0fDv1EqMVTU65r/nxxeylL8mY/xPmBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EEwBwJhz; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kq
	4/IE5TxPSa3+Zo+mp95KpeFojZt3lfQEaMXcQST4c=; b=EEwBwJhzi6cOySsl8y
	Vmat0Ph57DWpeiV6hLeNR0Yser4O3qQH2be8w1Hn6a5Z+oKvX9YwuCNbaBIk9A+n
	GkNulyH6+leqToZ4fT8SSoXAqCgT/y5yRA12crDl+mfWyv9nUAdgE1l24jOV2qsZ
	aEN0BJqDM+Op0U1LDvIPzBpt0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXpNEAt4BoaJF8HA--.11729S3;
	Wed, 23 Jul 2025 18:18:41 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 1/3] mm/filemap: Do not use is_partially_uptodate for entire folio
Date: Wed, 23 Jul 2025 18:18:23 +0800
Message-ID: <20250723101825.607184-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723101825.607184-1-chizhiling@163.com>
References: <20250723101825.607184-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXpNEAt4BoaJF8HA--.11729S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4kur4rWr1xCr4xArWUArb_yoWkXwc_Wr
	Z7Zw48W343GFWxArW0yFW7Jryqq348CrZYvasFqF13A34UC397XryqyFykWrs5G3yIkFZ8
	JrZIgryfZry3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8u6wJUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFBWTnWiAtsIFNQABsi

From: Chi Zhiling <chizhiling@kylinos.cn>

When reading the entire folio, we should not use is_partially_uptodate()
to determine if the folio is up-to-date. If the folio is not marked as
uptodate, then it is not safe to treat the entire folio as up-to-date,
even if the partial check returns true.

If all data in a folio is actually up-to-date but the folio lacks the
uptodate flag, this could cause issues during pipe reads

This change adds a condition to skip the partial check for the entire folio
case, ensuring that we only consider a folio as up-to-date for the entire
range if it is marked as uptodate.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index bada249b9fb7..af12d1cecc7d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2446,6 +2446,9 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 		pos -= folio_pos(folio);
 	}
 
+	if (pos == 0 && count >= folio_size(folio))
+		return false;
+
 	return mapping->a_ops->is_partially_uptodate(folio, pos, count);
 }
 
-- 
2.43.0


