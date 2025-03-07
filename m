Return-Path: <linux-fsdevel+bounces-43436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204FA56997
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9088B189B1DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F8021CA17;
	Fri,  7 Mar 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XY7U93Dx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BE21C184
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355661; cv=none; b=WWifcSBOEn5GNv8gZi/oufyS+MVRcT7Q3Ajg4cQSN/94pWbDmnnDUBqkcbS+cr0LAseehigulESWBAjgkWuM54DsJzeIxMYOowcBwgiTf3gI9+tDwU9QF2g16JbUWY6VjrRE3POL7FP+X/3xFqQJns/p1cf4oTeeKCjDQ+dyd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355661; c=relaxed/simple;
	bh=UcA8dQ9dN/as5K6+9kix004tEHRhWOYzqw7vVV7Fjis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4E5+1e80N73qgWID7pramownsyZ/Sv1G6onOcmr8H1yXHctOkvTkBUd3yRm7AsVk3kMmYd6npSmz5EDFTCov4ps24uaoAXzk75EQFN8BMFApx0GX+vl0HjS9sgFqeMgRMEX/r8MmDTkvUce3LULxsM9gju8d4JyZDKTaiFD258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XY7U93Dx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nbz+BLNYgFlD4q+RSS71Ot7C9TdXZjDl9SBqkDnbsow=; b=XY7U93DxQ+cGHvN+aCVMwhd7bD
	Q5omSA/aDlZZUo4fX5k0l7Bt7oZCdWZFxn3uYSrmnYsV+05wv3PbwCywdxZM18Sbk0MwOcLQWaWIK
	jKYjpk2VpjpmGP7AC7Z4KtBd4OE8uUFu1LVAs78sznRKKHgeC2KI5uPo6riG9jppW70Zfw1HDACxB
	zk3tAtFduAuGZ+lMVcXsHpAbD9dU+69tKdaGcCcUAOKATP3I/UZogeaTFNZZQLxYF8VYQ+QBwnzKx
	727elCnkPaDIaHy3WvwUUkIBt3aQh6YLeCVtLpZK5MWWOWijpRqVdUkyPZwR/Ml0adWX/Bn9Hud/f
	/BzBL14g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9X-0000000CXFr-2KOb;
	Fri, 07 Mar 2025 13:54:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] f2fs: Remove check for ->writepage
Date: Fri,  7 Mar 2025 13:54:01 +0000
Message-ID: <20250307135414.2987755-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
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


