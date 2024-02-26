Return-Path: <linux-fsdevel+bounces-12776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07838867038
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB41C2723C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124A6A8B0;
	Mon, 26 Feb 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="lioYz3tH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05E6A32A;
	Mon, 26 Feb 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941026; cv=none; b=SZJoHzQyFmszj29uQRFLwfaRoB0whUZuewvNEUlw03mmlTuIo/dhbrWzucpOiLC/W33hvAV3LmzMvFhw61apKj8NpRclYBO2UJ90hUinvJeSqWcF7fg6CvrXTDUtyqkOfMh0k5jzvhfT86sPzhvEOfKXshnE8Kq4aprfhXASAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941026; c=relaxed/simple;
	bh=RpGDv7xjt1Tn0NAFmnUJ4dRChi0PW0zUu2AGhx/ey2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPjqPBxIJ5p1cFzjzqy+zmx1RXKe0fFseIEJNmsa5St3wfZrpmahGSPdSUej1xrHIPdDn/WKSnncbzVo1zPq7Q0QHZ+xFiF5HywWBD+SSlwahESjf1vVyAiKFVkSbDUT/SftSnl7KQhqKS6P4R24zEP7LykgXovsQ5EOC3Aj42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=lioYz3tH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TjwpP5mYxz9sTv;
	Mon, 26 Feb 2024 10:50:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3Xg5bE7lOUEiWrLgvJkawBGempm7FqinU/8gfujPB8=;
	b=lioYz3tHK8mjB7lKM1lOktEID4fLFlKa66xI9EIqMo9+mkBUeo8GueQEQuC6zRm8ZamQP7
	YK5fiGlW4NBkooEUgInJLZGSECi/OX9C9RUl0wh7Uw+csnMhp4o1l1O/k7whwdYIjgCop2
	G84nRQMuLf03YLlcgRix64u5MIviQ4C/cbo97lzDga4/0uiYD16VdRZByvCGW9ojfUJhEw
	ZfZvn0h4fRtSSxdNeA2wX+DyJIue/KNcckCgmlUXE54kwz+qVZKW26w+EIO37eSWQ2RTTj
	VvnAkngviyrXkfpus7MhYeIbM9ltg0nQQ8kub4GjpwHQPENVApoQGJJDkw8Q4w==
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
Subject: [PATCH 09/13] mm: do not split a folio if it has minimum folio order requirement
Date: Mon, 26 Feb 2024 10:49:32 +0100
Message-ID: <20240226094936.2677493-10-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

As we don't have a way to split a folio to a any given lower folio
order yet, avoid splitting the folio in split_huge_page_to_list() if it
has a minimum folio order requirement.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 mm/huge_memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 81fd1ba57088..6ec3417638a1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3030,6 +3030,19 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			goto out;
 		}
 
+		/*
+		 * Do not split if mapping has minimum folio order
+		 * requirement.
+		 *
+		 * XXX: Once we have support for splitting to any lower
+		 * folio order, then it could be split based on the
+		 * min_folio_order.
+		 */
+		if (mapping_min_folio_order(mapping)) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-- 
2.43.0


