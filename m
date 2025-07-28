Return-Path: <linux-fsdevel+bounces-56123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641B7B136DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF7176E46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C012397BE;
	Mon, 28 Jul 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="avRDumut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C617A2F8;
	Mon, 28 Jul 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692032; cv=none; b=q7LuxZiQ1j4LNguzxZBCrb8Hw8Kajf6kUH7N8wGONCNMxs1yTcwNefgA2FYxgMKA6/pLJD2VKMmmo+ztLD39jQSa+FHlOV3Iq2rsgBpFLtjrgZ1ffRQTG/BVcY2O6DNnfioh6hiE3+qhqAxOb8PqnoLmyit2F7Qo1+HXJPZglX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692032; c=relaxed/simple;
	bh=8KKXNW143k0p91dd9ZHSDzkjOdRShAfQ3unzS2b1pOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/LNcW3GIzQ+cLTLrLan8ugzsP9u+UDm3g1Prh+iSqPitb1qj8ZYP47kA8gAn8LQ+InJxVRc6upDsCgQs0J1/H0a5FQNuaLdr9rPD4u909moeVJBDcDhLexM4xhJfqLQU9SZteXFj54TlSIAIXaECcpJvzCytd4ttRX5UIo1qFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=avRDumut; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=f/
	UKDMw0joXHfqIOWrWMvMtfuY+C4akEWZAyWYlG4oc=; b=avRDumutFFV7+/xhP7
	lAv3mT4OTjWtezxFpYrmQJGArckPgmn+iy4Mo49wDJSbVrMnCuOlmccX3dK+vb/L
	gYXpNEcfZLPuCGqHKuaiEedsDpCdn1dhaNCcuAONs4UxYY9lDxhIPBjCGRn8tcy1
	5f3Yf8UaP+pM5zRjqclK2AwCw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAH9a9hN4doAzUWCQ--.8415S3;
	Mon, 28 Jul 2025 16:40:03 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 1/2] mm/filemap: Do not use is_partially_uptodate for entire folio
Date: Mon, 28 Jul 2025 16:39:51 +0800
Message-ID: <20250728083952.75518-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728083952.75518-1-chizhiling@163.com>
References: <20250728083952.75518-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAH9a9hN4doAzUWCQ--.8415S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4xXw1DGFyUtFy8GFWruFg_yoWftFg_Wr
	W8Zw4kGa9xCF9xAr4IvF4DJr90qw1v9rWFvFZ0qF43A345A34kZFWqvF92gr47Jr4FkFs8
	JwsFgr15Zr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8EtC7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFBSUnWiBj9Y5uAACs6

From: Chi Zhiling <chizhiling@kylinos.cn>

When a folio is marked as non-uptodate, it means the folio contains
some non-uptodate data. Therefore, calling is_partially_uptodate()
to recheck the entire folio is redundant.

If all data in a folio is actually up-to-date but the folio lacks the
uptodate flag, it will still be treated as non-uptodate in many other
places. Thus, there should be no special case handling for filemap.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0e103fc99a8e..00c30f7f7dc3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2447,6 +2447,9 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 		pos -= folio_pos(folio);
 	}
 
+	if (pos == 0 && count >= folio_size(folio))
+		return false;
+
 	return mapping->a_ops->is_partially_uptodate(folio, pos, count);
 }
 
-- 
2.43.0


