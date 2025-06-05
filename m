Return-Path: <linux-fsdevel+bounces-50707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F0ACE976
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 07:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B108D3AACFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4331E500C;
	Thu,  5 Jun 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="odUf7l0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627792AE74;
	Thu,  5 Jun 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102673; cv=none; b=FRi9cRgfWGBlIzyrvvZDiDQZ5xH2OrSATftPdIkQjlW2MQLHfYLoC9m420ZW0h5R8/pe0BABjrN1d3mWskpe44lwGF6RtJpFFgSTjNDm4UWYX2pKTTpRsPlz6LnWINNs50gDPXrVtlBiXQ9PDUJmCZ67i+MdcBjuWqKAb2EbPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102673; c=relaxed/simple;
	bh=D4uZKuwwomr4WfuglBBZU+aqi9GkF6AI+jbE7UVDZ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGBi4Uw0kYlb8I5cSoMFCsfu5PkzkxVBAi8TEey4nrnWmjanZC8tBN3cv8L6jrspycg/rLo0qcENmpJCkFORmGECSIWcfuc3OkrtfNIwc1poZvlTF/wq6xBO3SJnHIacQ7AbRfgw5H1GVzUJDDloB1ydrZIUGIcBNs/0xdsDcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=odUf7l0g; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+c
	+mkab3kXPQMWH8vwkjAB2WGK4xCiCRJaS9X7+OGvk=; b=odUf7l0gvvsK0+2ZLb
	XqdZdVumbFfPvNwAolsB2ujT2Vd4RLZWy/518ELIMjCwztJgDbhYQY+2wTAQkro4
	EceChtPcn7HCau8jopzICHcqHiE5n3V6wrAn43p6xFCnkJs6uFrHKmgPoiCnx6M4
	fOfYk7/0ZGr92BITx7ormjdq4=
Received: from chi-Redmi-Book.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnbr8VMEFoKTpFGQ--.7585S2;
	Thu, 05 Jun 2025 13:50:13 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	josef@toxicpanda.com,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] readahead: fix return value of page_cache_next_miss() when no hole is found
Date: Thu,  5 Jun 2025 13:49:35 +0800
Message-ID: <20250605054935.2323451-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnbr8VMEFoKTpFGQ--.7585S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1rCw43Cr1fWr4fury8Zrb_yoWfZFc_Xr
	ykKw45WFsY9rZ2kr1ayFs8KrWI93Wq9rZxWF10qwsxt345Aas3WF1qvr1rtr17WrsakFZ8
	JrsFvr1Ykr1qqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8hSdDUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgAFjnWhBKYubXAABsy

From: Chi Zhiling <chizhiling@kylinos.cn>

max_scan in page_cache_next_miss always decreases to zero when no hole
is found, causing the return value to be index + 0.

Fix this by preserving the max_scan value throughout the loop.

Fixes: 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no hole found")
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b5e784f34d98..148be65be1cd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1767,8 +1767,9 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned long nr = max_scan;
 
-	while (max_scan--) {
+	while (nr--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
 			return xas.xa_index;
-- 
2.43.0


