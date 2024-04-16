Return-Path: <linux-fsdevel+bounces-17059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9508A724F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316CB1F23175
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAF13440C;
	Tue, 16 Apr 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uiCh4Pph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BD1332A0;
	Tue, 16 Apr 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288551; cv=none; b=dDouXG1SjxI7NEXD1nAxbf9IkKkw+/15OXbO/+WmjuB9D/VW6gVGU6/4rF88GpbBer8A36UGQ51jXd0vLowF+t5Eh0MQaqc3ztcbHlih7loTk5K0BJq7igXImtSj725sNJ+cwpKt+6ktJlci77+0l6vk/wLMmADOOTxfc2zRaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288551; c=relaxed/simple;
	bh=H574Zsr0MZosOT6hyKFGR5bSMswexcNmBemC6uLNAkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHSHjqvBlVuv0d4vJ2pt2S4cSGeCVJpzayXXTMi+e9aoSYc+MFVZwV0Ol0wpDMHUFU5yHZWnDRRY6h3vvxbNpnJ0B711zL5AQJZdit7aTpd/Fj+HoDnbOWDFYwcPawUlmcPurQYL6kw5DBflnOpczeWyChYnB6/CDV/JqsvVBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uiCh4Pph; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=58GZ0UFMSEj04qfovRQSksm+sDW121lz+7cFxd0L12g=; b=uiCh4PphS3OTuRcYqUwkUz8BZO
	d8CjYcUicmgKH1gihu1HeMLy214H0JwZc2bTl9kQICy2Szd+7Tj8guxzIWRTa6cTjKy0IYIOcLyfc
	QMQ6bOfUDuBjBHHsfgvw9YjG/V7aPgIXEKEvNQ+8AX4sGTt6du3YzhriLeQ05HC+nNzpDuuOynXV/
	bgKakbLQHIQqoSfqtv0xQBflyx/anGSoDwdqTvekmXq2d+g+LhscEEnT/zdlZ5suv3KKIOl1211hz
	8FrZumXy4u/XWD4hu+CZK4UIon78Iw+WYrMuJIPAqu0dyp2Ng+hLpYTYCyzLEWhdRFNiHt7Jta6Wd
	j6ubyYwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmcF-000000011ea-0Wlq;
	Tue, 16 Apr 2024 17:29:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] ext4: Convert ac_buddy_page to ac_buddy_folio
Date: Tue, 16 Apr 2024 18:28:58 +0100
Message-ID: <20240416172900.244637-6-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416172900.244637-1-willy@infradead.org>
References: <20240416172900.244637-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just carries around the bd_buddy_folio so should also be a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/mballoc.c | 8 ++++----
 fs/ext4/mballoc.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b2ea016f259d..e63f7365ede3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2155,8 +2155,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 */
 	ac->ac_bitmap_folio = e4b->bd_bitmap_folio;
 	folio_get(ac->ac_bitmap_folio);
-	ac->ac_buddy_page = &e4b->bd_buddy_folio->page;
-	get_page(ac->ac_buddy_page);
+	ac->ac_buddy_folio = e4b->bd_buddy_folio;
+	folio_get(ac->ac_buddy_folio);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
 		spin_lock(&sbi->s_md_lock);
@@ -5995,8 +5995,8 @@ static void ext4_mb_release_context(struct ext4_allocation_context *ac)
 	}
 	if (ac->ac_bitmap_folio)
 		folio_put(ac->ac_bitmap_folio);
-	if (ac->ac_buddy_page)
-		put_page(ac->ac_buddy_page);
+	if (ac->ac_buddy_folio)
+		folio_put(ac->ac_buddy_folio);
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
 		mutex_unlock(&ac->ac_lg->lg_mutex);
 	ext4_mb_collect_stats(ac);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index ec1348fe1c04..728b2d77b03f 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -205,7 +205,7 @@ struct ext4_allocation_context {
 				 * N > 0, the field stores N, otherwise 0 */
 	__u8 ac_op;		/* operation, for history only */
 	struct folio *ac_bitmap_folio;
-	struct page *ac_buddy_page;
+	struct folio *ac_buddy_folio;
 	struct ext4_prealloc_space *ac_pa;
 	struct ext4_locality_group *ac_lg;
 };
-- 
2.43.0


