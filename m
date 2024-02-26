Return-Path: <linux-fsdevel+bounces-12773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400586702B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BEA1F28E17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32F692E5;
	Mon, 26 Feb 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="UvS4naGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61F67E79;
	Mon, 26 Feb 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941007; cv=none; b=sHXCN9ojiCJvPN+/yCONfkPT23/WX+T/82RyTRoO/+u7zWxTvrhBE9kr0+/Q0gv3/NR9sNXmVZrdcedHHROILHbeUl28TSZfA6etVXSwx3TItk5BRuJ7G5TmpUf5uJ1c+LtWihPD7RhS/CIr9dQEM0u7kIRcMLgp08HdsshUZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941007; c=relaxed/simple;
	bh=8T+7Tu933UIoxtI2pqlAuNX1DDPj7iQH+uJWQ1Gysvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo3NIsTmeC5uNVj6NQynaW7UQ8Nr9kyCRSlEobSnRU9zDY9iS6mOj6oE6zwxJbDAcMUdWtGhaocOjMEwjveycaTySiXSyMcucy9ACN5liAaSsR4j97aeOAf6vnlQnGKPdvCwQDm0HbzKCjq3XqZ122qpzMtL9vgt1LHfSt40Im8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=UvS4naGN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tjwp22M3Bz9sTN;
	Mon, 26 Feb 2024 10:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1njdQFWaR2BtfAMszTyy2iO3Y5kDTGCSewwBty7+2Kw=;
	b=UvS4naGN4B56NJsI1HXSdud2G5jomcFJ6pR8o51SW+VBhDFliKwBLh4YZFda4FACselOUk
	sr4+d8VOS/b+sN0XHZQ6vaUSG3xl6nmuAanTZxrifjgawftiv6ksfHNzhwGDNJf6w42bDq
	lmZGaWCeBHrP8LsXhFaYvtWRjZpr6UlNDGjI7mlb47aYk7yS02GDIhAfcwoWIGEpMwbP2y
	TD3mOqA99RywbbiYZMURMmzzCB8mckCp+XBDQmQZmvggaMnvwZEK0aKR1RuwYYdM4qnyBj
	WJ8s1ztuAJLE9Fm/QlnPXMTzGrmXUvfuxF5DfPZIOnX717VcvRq0XaL7/vXmgA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 05/13] readahead: set file_ra_state->ra_pages to be at least mapping_min_order
Date: Mon, 26 Feb 2024 10:49:28 +0100
Message-ID: <20240226094936.2677493-6-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tjwp22M3Bz9sTN

From: Luis Chamberlain <mcgrof@kernel.org>

Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
mapping_min_order of pages if the bdi->ra_pages is less than that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 369c70e2be42..8a610b78d94b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -138,7 +138,11 @@
 void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+
 	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+	if (ra->ra_pages < min_nrpages)
+		ra->ra_pages = min_nrpages;
 	ra->prev_pos = -1;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
-- 
2.43.0


