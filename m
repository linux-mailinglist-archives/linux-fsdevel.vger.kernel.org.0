Return-Path: <linux-fsdevel+bounces-14306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C743487AF1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F412E1C2433F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215F199191;
	Wed, 13 Mar 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="xM9JIwoX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1CF60898;
	Wed, 13 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349409; cv=none; b=OkZ5t/FYPs2MQVKmaWdfHYLmcLGbTU7BODGYkBRuwXpIIFKHrvmrAL9HeR4ZHpybp7Z00TysvXvpsvI30ub34AkqJEsa/HkWrHkeXNdlC9xh9dQ1mqtwOFJJYJkO6xfbPA0y4eMO4R3djybPO57pdxTNbULN5ryVe5YiDI85WAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349409; c=relaxed/simple;
	bh=N90HyHZVwwldCpPQycLW/AGlmNXwgHSjmbrwJecuTXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZagKc4MvAh1DEFFOpCil3XzJq3d16ipzaGYbMbU4fRr8L7bgPf38+R+jlTLmf1Daoq8OvwvrEl3CDlPxXuHt4pkY4yk/QWwpdDEdQ6W3czXODbqdn+Mwc2hQDJjSHqpILAFRkrccs7YRS5gLg3UAshdZQIzzXj3AzaIcvRvbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=xM9JIwoX; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tvxfh15bQz9sZ1;
	Wed, 13 Mar 2024 18:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHEsUd+FYkmqqyGjADf/C4ejcwO7DnLkDR82am0hB3M=;
	b=xM9JIwoX5gfosfCIgrMHHI0lYvtdu6ZSdRS8udaibXJzPgqBiMrW7zluqYyjXMsntx79E6
	2K2JqTPoFCW5ixCWR9tlqqjH1qKCyzUev3xHpZruPqOQHYPcZEKOxg8/ybdc4NAgczGzS4
	7V9rgm9sX0lxn+RJdKbJpX7veZNi8RIO2ca6Eup7OaWjYAIdQZxeGzR8cRr5aDLlx9W379
	0xvXMgN4k4w5usidPHXUIxwyv3at5dfBb6gkrUazd+wm7mrVE5lIkK4MCEp+J3yx8VzTUS
	r/b+/UPiq17+WJUtpABU496d59OseFcfLk7VMFEAyx72tw59+MsrrQajyD6jHQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 06/11] readahead: round up file_ra_state->ra_pages to mapping_min_nrpages
Date: Wed, 13 Mar 2024 18:02:48 +0100
Message-ID: <20240313170253.2324812-7-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

As we will be adding multiples of mapping_min_nrpages to the page cache,
initialize file_ra_state->ra_pages with bdi->ra_pages rounded up to the
nearest mapping_min_nrpages.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 650834c033f0..50194fddecf1 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -138,7 +138,8 @@
 void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
-	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+	ra->ra_pages = round_up(inode_to_bdi(mapping->host)->ra_pages,
+				mapping_min_folio_nrpages(mapping));
 	ra->prev_pos = -1;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
-- 
2.43.0


