Return-Path: <linux-fsdevel+bounces-43472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9CA57058
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 19:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AD9173FA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF3241684;
	Fri,  7 Mar 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tK00Ypc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8023F29C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371716; cv=none; b=U+fjPztWtltMGF51zwITpRDIRQoHRL2hNIvoOZDu4HV412dHj7CJwHlv1Wha4WnGZgZUiGAPVL/U0yQwXUn1u0RmDFkGlpTu1QAmUO/3kWAUL8Ii7LRanHVIEQwaRdsMYKkG2D76PGSqnuHXp8lMpOn71RUJ18Ud2u/MQWx+69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371716; c=relaxed/simple;
	bh=UcA8dQ9dN/as5K6+9kix004tEHRhWOYzqw7vVV7Fjis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGo6SRRlKiIhVCdBo9naW5WHZ6+nBndLBftapMqG2V3/2IHB5gblbwYviAf2tNIq7hOde4sxhJCOZqmdYBnJk4aBcLtvrn4vt8U5d3pvM8xyTL9UTfx2xHk4ZDV+pkzbzXhad5kN0Y4kR5g106EeKa66jhplqPWyJgKfzTMQwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tK00Ypc7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nbz+BLNYgFlD4q+RSS71Ot7C9TdXZjDl9SBqkDnbsow=; b=tK00Ypc74Cni9nRFpbdkF6I0mY
	gG1kG5+X6l9qhcDQwHtTqmS2J0+tfNsfrn2ssX2/oKLyZQiyw7Iw6uxk+7oQxNRI/PzPpaJkb4lAk
	0URRbewYsMdOh22cFk9ZlhLZBKotdYhet0hOn8lzmMu9jK+N7PEAuesr1lgAdPTVNLHqoN8K3VeNE
	4aruvX/RkRFpkhgzC9cP/S7dKcP5Uswc1UiUpAxWcL295+KjhRcggBgWUdST7BLJpjjTNv24ilQAY
	MmSlvSygH15wkX7soSE5eeu7xGpU3JGf4E40i1Xqq7wKghAOK8gZZqzbRlHgdY8ED7RuOU/Dk5qAK
	2JA28YsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqcKX-0000000EFj8-0hoo;
	Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] f2fs: Remove check for ->writepage
Date: Fri,  7 Mar 2025 18:21:47 +0000
Message-ID: <20250307182151.3397003-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're almost able to remove a_ops->writepage.  This check is unnecessary
as we'll never call into __f2fs_write_data_pages() for character
devices.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c82d949709f4..a80d5ef9acbb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3280,10 +3280,6 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	int ret;
 	bool locked = false;
 
-	/* deal with chardevs and other special file */
-	if (!mapping->a_ops->writepage)
-		return 0;
-
 	/* skip writing if there is no dirty page in this inode */
 	if (!get_dirty_pages(inode) && wbc->sync_mode == WB_SYNC_NONE)
 		return 0;
-- 
2.47.2


