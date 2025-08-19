Return-Path: <linux-fsdevel+bounces-58306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CDB2C6CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F7B1889D78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A226F297;
	Tue, 19 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUgRHjhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E624BD03;
	Tue, 19 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613115; cv=none; b=t6SzpvBLcGoXYhHdPTYmURMItSnwRo+Dv1ceBU/iMV4aMXWsTMo/sOo27McqCqHo9WSwPB7IBl6XSRjmnxy2U9KPpjceZW4CPzMafYdakbaYlOzNMuyJ14p8/f3Q9MCPDbE8m4dhdjLaZJdeK9anzbs0E5hip6drCYeaOMPHU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613115; c=relaxed/simple;
	bh=VnV09UydQ8FZpWhq40PrbUarjqe+Ux7VEXN5GKBvrus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQxXvWtYvFIw+5EE3XM0QlUTlud/eeYTRRfnA/i5knxtoGSXf0enUJmoj7DFv5NmZ1/KILf9MYuqiViygIlkRmJ7tKh2+olSFbza0Shx6twxwEE2kaC+aa19IeJspcMQaTwWpWiXf4nZ+8YbHhXVkaJa4zahMYPvfiO3LYn5QlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUgRHjhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76432C116D0;
	Tue, 19 Aug 2025 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613114;
	bh=VnV09UydQ8FZpWhq40PrbUarjqe+Ux7VEXN5GKBvrus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUgRHjhzM8CrbFTNsqDjvz1ulqEwzgRcrrzJfd5XyA7NlwIQGyg4iBgGVSVlri4SE
	 4gvNMKvLIcF5svuLdmqqYxyzb0SJtGG9lQngDpodrsvTc3qLzpjWnjFi+r940QRgg5
	 kG1daCEkPAuCTUq2WJ/vI9zslvz2KRb8/iUiW+1WQ3EPA1W7Ecmqxh9X/H8xvYmMzW
	 INMZ6ee0qr1tbhhKw1In5eWYuUUEutjXtXE9UyF10vQjj927t8Z2VEzTQEJ/LUukD0
	 BKjjz2hve3I4+SEfZvuzF1meEAk2G82NV8oYFU7Tt2KJXqZKV+7S1nRuxI6bud/ILD
	 eqpLjOtBNmAOQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 1/3] filemap: Add a helper for filesystems implementing dropbehind
Date: Tue, 19 Aug 2025 07:18:30 -0700
Message-ID: <ee863d320994130efcccf132212ec0e23f4582ca.1755612705.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755612705.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a helper to allow filesystems to attempt to free the 'dropbehind'
folio.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Link: https://lore.kernel.org/all/5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com/
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/pagemap.h | 1 +
 mm/filemap.c            | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..201b7c6f6441 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..71209ebbcc36 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1608,7 +1608,7 @@ static void filemap_end_dropbehind(struct folio *folio)
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
  */
-static void filemap_end_dropbehind_write(struct folio *folio)
+void folio_end_dropbehind(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
@@ -1625,6 +1625,7 @@ static void filemap_end_dropbehind_write(struct folio *folio)
 		folio_unlock(folio);
 	}
 }
+EXPORT_SYMBOL(folio_end_dropbehind);
 
 /**
  * folio_end_writeback - End writeback against a folio.
@@ -1660,7 +1661,7 @@ void folio_end_writeback(struct folio *folio)
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 
-	filemap_end_dropbehind_write(folio);
+	folio_end_dropbehind(folio);
 	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
-- 
2.50.1


