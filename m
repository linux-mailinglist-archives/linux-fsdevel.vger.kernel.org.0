Return-Path: <linux-fsdevel+bounces-38885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C1A0978A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295107A0331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FA211477;
	Fri, 10 Jan 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ePKsIj26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CC1FC114
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526786; cv=none; b=T28JcYIFBfFAN3CMMClb0+uFe6JVOjEr4YRq2HMq7Yzg3IRprN8ftC+FVim3TnfMR98bEY5bQ8UTJhIAuN8UdcE4sLeQoLLxjAJIQyk6aBRx8+R8W4+2vJ0z13aUhRB6HO1Sg0RY9BrNgfGDS5cxJAhzVK+Z8BwFsI8+jln3Tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526786; c=relaxed/simple;
	bh=EGbTOStDpMPosC8iUMFj4zzZcT4coPickjx/yttDsqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myi+W9LwD5Ynm7jnuyKjjsR5Ez0USN7KY1fu6o9FSeS0cTl+zEEVVDg8vYEc55VqjdeDmluqxDp0SFbS9j4ZuIidPC7iWUDKPD/0DWlAb/aMFAyjDbiR+thJ3JuSKh7hA9OBPuHVVfYarVoIXnR9YVjif69iOPlsz0NO6KJQF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ePKsIj26; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=m6Bun1CPydSCXcEYLw8nRgLr5kgwzReIIu7xc3wV6j0=; b=ePKsIj26Sv78SsRSF/7lp4syKG
	ZA3LIIuT/cPSkx4FB3+pHi+bIxezX5z1oe7nYUuL+7BzRBUd8npUmaLQUweAwji9333wwEKTYhLTk
	3VKjPYbSrY/rNOZCit4u8hlLG4OZle13gAFRwWlSn1vy7DK72m6blWgDpbGBR7yJpCnc6v/bpdV2n
	d5gobM/Vjr1C80uCLWjhM8MLLudSDNic6hXQLhr4CFuSBrx5nGPmEwuvZfVe/cKSpder/1Vvsvixy
	WP6dMAceDOI1oWDtX3E275lX1FBoGSrF0bcUo08CEFPUneYyVNOLO4h9cV9lZskrW7ivf/xKP/VB4
	kW88swlA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHwU-0000000E2XG-0rOl;
	Fri, 10 Jan 2025 16:33:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	squashfs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] mm: Fix assertion in folio_end_read()
Date: Fri, 10 Jan 2025 16:32:57 +0000
Message-ID: <20250110163300.3346321-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only need to assert that the uptodate flag is clear if we're going
to set it.  This hasn't been a problem before now because we have only
used folio_end_read() when completing with an error, but it's convenient
to use it in squashfs if we discover the folio is already uptodate.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 12ba297bb85e..3b1eefa9aab8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1505,7 +1505,7 @@ void folio_end_read(struct folio *folio, bool success)
 	/* Must be in bottom byte for x86 to work */
 	BUILD_BUG_ON(PG_uptodate > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
+	VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);
 
 	if (likely(success))
 		mask |= 1 << PG_uptodate;
-- 
2.45.2


