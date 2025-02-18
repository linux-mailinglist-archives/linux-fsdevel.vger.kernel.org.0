Return-Path: <linux-fsdevel+bounces-41989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BFA39BB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA49176B0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5524113E;
	Tue, 18 Feb 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qb8Jbre8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198912417F5;
	Tue, 18 Feb 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880143; cv=none; b=X1LciEc7k/6Tzb+9Kj1MqDZx83zXkt/Nh4XQpTP1Zt55NS3BCOS6+I0W+woOsTBh5OFRqHYJBYLXBn+G5JoOBYqcWF1eq++X1lkyHl6E7PpQFWppuekWPRN+ZNhMXXE6wVKvn2whEbjzvqZPkb8Kqu+XVvTnSuDwMTZ1WYEDE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880143; c=relaxed/simple;
	bh=nIdJEvkyZQ7T7/5JibDOh7O052g4JLx9pmwanwQJVaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgWwSMK79yfSdOzgFywg9sGgREvkF70eQ6N/W3h9qbTcVS7OqiCUK4vR8cUf5qWAslmXoRHs/Z+O9+Qtjdwc5dDI18crlD7Xejpf8wQbw1ZNBmpfR/AGA7MwAIJnkujHMyMKhQqEnRlzfBx5AIFMuwuUr5tbbXrAwBpFVXRS5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qb8Jbre8; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739880131; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=y2bMkeNnyOpZdT1loclRjOTBfK3X6l+kij6eDknKmKE=;
	b=qb8Jbre8jrN8stePbbKnmrf/8cPIWR3UXfLBVrll6c9af9zGhKOl6dFk8WkheM3QJhfB3tLPNHWErNpozEIuY25z9QjmpZVzkLQcXot9zJamORJMhy2pd3LkhRTWPaT5qwYaGrID0TGSyNvbw0uExfHscUFAbXABwz91q6mttlw=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WPlpQxk_1739880130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 20:02:11 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 2/2] mm/truncate: don't skip dirty page in folio_unmap_invalidate()
Date: Tue, 18 Feb 2025 20:02:09 +0800
Message-Id: <20250218120209.88093-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... otherwise this is a behavior change for the previous callers of
invalidate_complete_folio2(), e.g. the page invalidation routine.

Fixes: 4a9e23159fd3 ("mm/truncate: add folio_unmap_invalidate() helper")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 mm/truncate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index e2e115adfbc5..76d8fcd89bd0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -548,8 +548,6 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
-	if (folio_test_dirty(folio))
-		return 0;
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 	BUG_ON(folio_mapped(folio));
-- 
2.19.1.6.gb485710b


