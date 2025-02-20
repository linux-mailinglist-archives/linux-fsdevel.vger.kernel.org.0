Return-Path: <linux-fsdevel+bounces-42190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC85A3E5FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 21:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1379A42121E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748AC214210;
	Thu, 20 Feb 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rj1G3BIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4D1E9B29
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084047; cv=none; b=kG1QO6us/R7YXstbqmUJi3b8N9QohD+t1a4xz396MUkhK50s7Rt0viL11UyEl7A3SvYgGWdH+ziJbb5H/60viSJ/6481slkGgxoAOHOCsv7JXVR0IG7nQ9SJOolNKm7PC3hqp+skULrcaCaIoaROtdv+uu1ts/ZwOe/7OauVWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084047; c=relaxed/simple;
	bh=9FHq+GDU9t+r6oITaqFnTNBtlrNr3YbbGi3z0tPjF68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1mg2/1ZZtTXcxE3PBAAOGxLsvmNQxEWrikys7zjbUkzhowi9rvxi7EqqU0nxIIDcJZoLUMwWXGrHvdfA/rdGKIgdqAUzM2BiHtBTX0NgMsJ8NUzT8SSevhCVTt0C5x+a2gYr0VyhnQ9x1BcL9RnoYxmbx0ot+wFZh60IKZ6ces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rj1G3BIK; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740084044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+BdU8iHDc+F+ztey7pqA/i1BlKa0qTDlmiWS7YoGoBU=;
	b=rj1G3BIK5eDaH2zCjrjyAX4D1+NPdjDKvYO3IjjAzbQaiIoi83pQ1/K9NBJXbm+/ENatOi
	ZE0PZTVJtyz8dGSymzvHUDcUQdl39ZWkrmkbf8kJ4x9GIBYJmYAOBYNqHjq7unUY54pR92
	u1qSjj632iNMUVG7sCSU6ymzPMMJQfs=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] filemap: check for folio order < mapping min order
Date: Thu, 20 Feb 2025 15:40:33 -0500
Message-ID: <20250220204033.284730-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

accidentally inserting a folio < mapping min order causes the readahead
code to go into an infinite loop, which is unpleasant.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/filemap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..b88bed922fff 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -973,6 +973,11 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	void *shadow = NULL;
 	int ret;
 
+	if (WARN(folio_order(folio) < mapping_min_folio_order(mapping),
+		 "folio order %u < mapping min order %u\n",
+		 folio_order(folio), mapping_min_folio_order(mapping)))
+		return -EINVAL;
+
 	ret = mem_cgroup_charge(folio, NULL, gfp);
 	if (ret)
 		return ret;
-- 
2.47.2


