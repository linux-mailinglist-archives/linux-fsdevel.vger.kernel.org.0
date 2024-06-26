Return-Path: <linux-fsdevel+bounces-22466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E298C917661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 04:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D07B2844B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0934CB36;
	Wed, 26 Jun 2024 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TZ6yf5S8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422D61FEA;
	Wed, 26 Jun 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370271; cv=none; b=SYznjipwyHnP4q2pv/S4TNFOz1p708gYCGIaaQA5Yg4QM2rfiURk8+q1oIC2sNwWFsr98ag6rBvrKSnXksa65aGwl1985Nz5dIMYrUsIcjR10WMtmF8RPcG5st1+CZGBqQQO82hKQGWcLx8HM89ZD8zX6OMgy9F4tkLNnRyGrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370271; c=relaxed/simple;
	bh=/5cAxMS0zmwZ3u43nrJI4+ak0vUk7GAEvG8iuXIvbuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YI8iXKqa8FA8IaQhTpmE976o8VFCOGGgn+sjkMx90s/isNIGWfXwmsH4hG2JvGAwEVUkbH8TfEB5qU23u3DWbZsu4xxWwxp5t8pd3ieQ9ytwPFqObe3MzU+jv9SmV6V2oHd60vVXh43A7xEXt/mpAi35A70L2O5Ox3dVcZwp100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TZ6yf5S8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wo14P
	WeIUY9EYOh0eaVerCi6XcBJRd3XZw/te6DPwYs=; b=TZ6yf5S8wc7BKoK/5Szih
	NRYHE961BDZepEeW6lqkF5QSzp1ILsFM2nIKaAMff2ZhVyrARdq3bQSBnV1YNnmP
	5H8QsUvnne04DejIazZ/motEPBgQiOBZ2zMEoW2MjSsBqRd6o4Pbbr0dgvYXK7bM
	sPRtpv75zUunjNnq2ZTye8=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXT0W6gXtm8PInAg--.40265S5;
	Wed, 26 Jun 2024 10:49:36 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: vbabka@suse.cz,
	svetly.todorov@memverge.com,
	ran.xiaokai@zte.com.cn,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] mm: Constify folio_order()/folio_test_pmd_mappable()
Date: Wed, 26 Jun 2024 02:49:23 +0000
Message-Id: <20240626024924.1155558-2-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626024924.1155558-1-ranxiaokai627@163.com>
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXT0W6gXtm8PInAg--.40265S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13ZF4rZrW7Kr48JryfXrb_yoW8GrW3pF
	WDCFn7KrW0yFy5CrykGa17Ary5X39rWFy2yFyag3W7Jas8t3s29w4v9w1YyF1fGrW8AF4x
	Za17WFWF9FyUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMwQKTGXAmE8lKgAAsM

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Constify folio_order()/folio_test_pmd_mappable().
No functional changes, just a preparation for the next patch.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/huge_mm.h | 2 +-
 include/linux/mm.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2aa986a5cd1b..8d66e4eaa1bc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -377,7 +377,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
  * folio_test_pmd_mappable - Can we map this folio with a PMD?
  * @folio: The folio to test
  */
-static inline bool folio_test_pmd_mappable(struct folio *folio)
+static inline bool folio_test_pmd_mappable(const struct folio *folio)
 {
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9a5652c5fadd..b1c11371a2a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1105,7 +1105,7 @@ static inline unsigned int compound_order(struct page *page)
  *
  * Return: The order of the folio.
  */
-static inline unsigned int folio_order(struct folio *folio)
+static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-- 
2.15.2



