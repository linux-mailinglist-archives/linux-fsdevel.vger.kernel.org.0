Return-Path: <linux-fsdevel+bounces-13307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73486E632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040DD1F27847
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683F3F9FE;
	Fri,  1 Mar 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="EhcDjdG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917153E495;
	Fri,  1 Mar 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311512; cv=none; b=IYTDLinmbH3ueIGP9AzUqzDA/du4jJomd5KfF+TdVu4/TTC5YaMIr8sEsrDIelSVLudnyt13IAK8h/6Ns2xIyA+FF2sHDhR461a8+/FqwZD+qCuUf0IMusLkbBLEvxv46f2UilOh7RlGCR2AwgEHZVvjYJaFP3zD9kpOpbfMXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311512; c=relaxed/simple;
	bh=KQLxCxTm1a3G+AdJEU2l+UjiEY138yZKMq+PpqCnBQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViTLhLrxGV2bEZRVuvBiw94X/yD7ALKFCsgWympb9cDVaWdoGX113GX+pkJrpl1Qbjdjm3qNWbfe837bn/JfY5zI5h2D3jCPJjcYYB9SXoNoFSkBXwmbh5I5FLHmGLL000eLpDep3zqD0xExktEi/+LRH7dtgVDxEqrr9ksRON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=EhcDjdG9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TmYq56x6Dz9t7g;
	Fri,  1 Mar 2024 17:45:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBvRRAph/60/h4V+RTLg/hSlbvygSXk8WrjV0xu5/4g=;
	b=EhcDjdG9qiZTG+V3uYtrOsPK0UUvzb17ipja6U+/IY0HDDnkY+HkPMp6p0u2+FSKecvqMu
	iWT8AtwgnLDakHtg95b2lJHGfk+s2XyJPWYikTnuC3BK/QjQRJMmqqOAPqBWr3IoSls4mW
	q19/nic1+DfHfZHR7JZTV1HpciObH2ScYT+9tgsK2vmAPUsIfP+bPAJRYxen4YAMvdN2kC
	SIAdF3SlBhG3Mqe/v2I/i2CCBekZQdagyrgkf3dcQFHgQZK6Na1PLH3v3csGAqLmSH04IG
	9DZNFKUyvPqqe/5Ne7SHmLPq54ZL9V7gnXR0jla2EERn/u2BZBYnEczSx/YJzA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 05/13] readahead: round up file_ra_state->ra_pages to mapping_min_nrpages
Date: Fri,  1 Mar 2024 17:44:36 +0100
Message-ID: <20240301164444.3799288-6-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
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
index 369c70e2be42..6336c1736cc9 100644
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


